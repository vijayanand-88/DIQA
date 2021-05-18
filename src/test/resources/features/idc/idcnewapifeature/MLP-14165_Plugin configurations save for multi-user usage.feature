@MLP-14165
Feature: MLP-14165: Plugin configuration save for multi-user usage with pluginconfiguration name

  @git @precondition
  Scenario: Update Git Cataloger with
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                   | username    | password    |
      | idc/MLP-14165_Credentials_ValidConfig.json | $..userName | $..password |

    ##6814916##
  @MLP-14165 @regression @positive
  Scenario:SC#1:MLP-14165_Verification of PUT/settings/analyzers/{pluginname}/{configurationname} with Name & configuration name are same
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollector/GitCollector"
    And user makes a REST Call for DELETE request with url "settings/credentials/gitcred"
    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollectorDataSource/GitDs"
    And supply payload with file name "/idc/MLP-14165_Credentials_ValidConfig.json"
    When user makes a REST Call for PUT request with url "settings/credentials/gitcred" with the following query param
      | raw | false |
    And Status code 200 must be returned
    And supply payload with file name "/idc/MLP-14165_DataSource_ValidConfig.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/GitCollectorDataSource/GitDs" with the following query param
      | raw | false |
    And Status code 204 must be returned
    And supply payload with file name "idc\MLP-14165_ValidConfig.json"
    And user makes a REST Call for PUT request with url "settings/analyzers/GitCollector/GitCollector"
    And Status code 204 must be returned

    ##6814917##
  @MLP-14165 @regression @positive
  Scenario:SC#2:MLP-14165_Verification of PUT/settings/analyzers/{pluginname}/{configurationname} with Name & configuration name are different
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc\MLP-14165_ValidConfig.json"
    And user makes a REST Call for PUT request with url "settings/analyzers/GitCollector/default12"
    Then Status code 400 must be returned
    And response message contains value "Name of configuration parameter default12 does not match name of configuration GitCollector"

    ##6814914##
  @MLP-14165 @regression @positive
  Scenario:SC#3:MLP-14165_Verification of GET/settings/analyzers/{pluginname}/{configurationname} with valid Name
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "settings/analyzers/GitCollector/GitCollector"
    And Status code 200 must be returned

    ##6814915##
  @MLP-14165 @regression @positive
  Scenario:SC#4:MLP-14165_Verification of GET/settings/analyzers/{pluginname}/{configurationname} with invalid Name
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "settings/analyzers/GitCollector/default12"
    And Status code 404 must be returned
    And response message contains value "Missing configuration default12 for analysis plugin GitCollector"

    ##6814918##
  @MLP-14165 @regression @positive @spreadsheet
  Scenario:SC#5:MLP-14165_Verification of Delete/settings/analyzers/{pluginname}/{configurationname} with valid Name
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollector/GitCollector"
    And Status code 204 must be returned

      ##6814919##
  @MLP-14165 @regression @positive @spreadsheet
  Scenario:SC#6:MLP-14165_Verification of Delete/settings/analyzers/{pluginname}/{configurationname} with invalid Name
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollector/default12"
    And Status code 404 must be returned
    And response message contains value "Missing configuration default12 for analysis plugin GitCollector"


