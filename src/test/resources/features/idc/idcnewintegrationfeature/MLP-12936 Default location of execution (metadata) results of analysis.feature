@MLP-12936
Feature: MLP-12936 Default location of execution (metadata) results of analysis

  Description:
  To Verify the Default Catalog with plugin configuration

  @git @precondition
  Scenario: Update Git Cataloger with
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                       | username    | password    |
      | idc/IDX_Integration_Payloads/MLP_12936_Credentials_Config.json | $..userName | $..password |

##6783788##
  @MLP-12936 @webtest @positive
  Scenario: Run Collector Plugin to validate the new plugin status
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollectorDataSource/AutoQADataSource3"
    And user makes a REST Call for DELETE request with url "settings/credentials/AutoTestCredential2"
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP_12936_Credentials_Config.json"
    When user makes a REST Call for PUT request with url "settings/credentials/AutoTestCredential2" with the following query param
      | raw | false |
    And Status code 200 must be returned
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP_12936_DataSource_Config.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/GitCollectorDataSource/AutoQADataSource3" with the following query param
      | raw | false |
    And Status code 204 must be returned
    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollector/DefaultCatalog"
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                         | body                                                     | response code | response message | jsonPath                                            |
      |        | raw   | false | Put          | settings/analyzers/GitCollector/DefaultCatalog                              | idc/IDX_PluginPayloads/git_collector_Default_config.json | 204           |                  |                                                     |
      |        |       |       | Get          | settings/analyzers/GitCollector/DefaultCatalog                              |                                                          | 200           | DefaultCatalog   |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/DefaultCatalog |                                                          | 200           | IDLE             | $.[?(@.configurationName=='DefaultCatalog')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/DefaultCatalog  |                                                          | 200           | IDLE             |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/DefaultCatalog |                                                          | 200           | IDLE             | $.[?(@.configurationName=='DefaultCatalog')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user selects the "Analysis" from the Type
    And user performs "dynamic item click" on "DefaultCatalog" item from search results
    Then user "verify metadata property values" with following expected parameters for item "DefaultCatalog"
      | Number of errors |
      | 0                |
