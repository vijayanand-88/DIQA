@MLP-13724
Feature:MLP-13724: This feature is to verify whether as As an IDA ADMIN I want to monitor the status of all levels including; IDA deployments (Deployments), and plugins so that I can have a single view of the state of my IDA ECO system

  @git @precondition
  Scenario: Update Git Cataloger with
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                      | username    | password    |
      | idc/IDX_PluginPayloads/MLP-12926_Credentials_ValidConfig.json | $..userName | $..password |

  ##6820197##6820198##6820199##
  @MLP-13724 @regression @positive
  Scenario:MLP-13724: Verification of Node level and plugin level status for all node
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "extensions/analyzers/all/pluginconfigs"
    And Status code 200 must be returned
    And user verifies whether the value is present in response using json path "$..['nodeName']"
      | jsonValues   |
      | InternalNode |
      | LocalNode    |
    And user verifies whether the value is present in response using json path "$..['nodeStatus']"
      | jsonValues |
      | UP         |
      | UP         |
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes a REST Call for DELETE request with url "settings/credentials/gitcred"
    And supply payload with file name "/idc/IDX_PluginPayloads/MLP-12926_Credentials_ValidConfig.json"
    When user makes a REST Call for PUT request with url "settings/credentials/gitcred" with the following query param
      | raw | false |
    And Status code 200 must be returned
    And supply payload with file name "/idc/IDX_PluginPayloads/MLP-12926_DataSource_ValidConfig.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/GitCollectorDataSource/GitDs" with the following query param
      | raw | false |
    And Status code 204 must be returned
    And supply payload with file name "idc/IDX_PluginPayloads/MLP-12926_ValidConfig.json"
    And user makes a REST Call for PUT request with url "settings/analyzers/GitCollector/GitCollector"
    And Status code 204 must be returned
    And user waits for the final status to be reflected after "5000" milliseconds

  ##6820199##
  @MLP-13724 @regression @positive
  Scenario Outline: Verification of plugin level status
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                       | body | response code | response message | jsonPath                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |


  @jdbc
  Scenario Outline: Delete Credentials, Datasource and cataloger config for Json S3
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/gitcred                    |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDs |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollector/GitCollector    |      | 204           |                  |          |
