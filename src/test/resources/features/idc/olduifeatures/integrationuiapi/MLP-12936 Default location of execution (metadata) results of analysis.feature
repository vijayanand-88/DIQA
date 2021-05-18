@MLP-12936
Feature: MLP-12936 Default location of execution (metadata) results of analysis

  Description:
  To Verify the Default Catalog with plugin configuration

##6783788##
  @MLP-12936 @webtest @positive
  Scenario: Run Collector Plugin to validate the new plugin status
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body                                                             | response code | response message | jsonPath                                          |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector/GitCollector                              | idc/IDX_PluginPayloads/MLP-14104_GitCollector_Plugin_Config.json | 204           |                  |                                                   |
      |                  |       |       | Get          | settings/analyzers/GitCollector/GitCollector                              |                                                                  | 200           | GitCollector   |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  |                                                                  | 200           | IDLE             |                                                   |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the header
      | actionType | actionItem         |
      | click      | Global Search Icon |
    And user select "Default" catalog and search "Default" items at top end
    And user selects the "Analysis" from the Type
    Then user clicks on first item on the item list page
    And METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 1                 |
