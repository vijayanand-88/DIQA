@MLP-18458
Feature:MLP-18458: This feature is to verify whether as an IDA Admin Add Business Application column in Manage Configuration

  @git @precondition
  Scenario: Update Git Cataloger with
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                                              | username    | password    |
      | idc/IDx_DataSource_Credentials_Payloads/MLP-18548_GitCollector_Credential_Config.json | $..userName | $..password |

    ##6972318##
  @MLP-18458 @regression @positive
  Scenario:SC#1:MLP-18458_Verification of PUT/settings/analyzers/{pluginname}/{configurationname} with Name & configuration name are same
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollectorDataSource/TestGitDS"
    And user makes a REST Call for DELETE request with url "settings/credentials/TestGitCredential"
    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-18548_GitCollector_Credential_Config.json"
    When user makes a REST Call for PUT request with url "settings/credentials/TestGitCredential" with the following query param
      | raw | false |
    And Status code 200 must be returned
    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-18548_GitCollector_DS_Config.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/GitCollectorDataSource/TestGitDS" with the following query param
      | raw | false |
    And Status code 204 must be returned
    And supply payload with file name "idc/IDX_PluginPayloads/MLP-18458_GitCollector_Plugin_Config.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/GitCollector/TestGitCollector" with the following query param
      | raw | false |
    And Status code 204 must be returned
    And user makes a REST Call for Get request with url "settings/analyzers/GitCollector/TestGitCollector"
    And Status code 200 must be returned
    Then user verifies whether the value is present in response using json path "$..['businessApplicationName']"
      | jsonValues  |
      | SampleGitBA |

  @git
  Scenario: Delete Plugin Configuration
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                 | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/GitCollector/TestGitCollector    |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/TestGitDS |      | 204           |                  |          |


