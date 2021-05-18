@MLP-13719 @MLP-13722
Feature:MLP-13719 MLP-13722: This feature is to verify As an IDA ADMIN I want to find discrete program generated errors that cause a HALT or WARNING In plugins
  Verify the data time stamps in error for the failed plugin configuration

  ##6867281##6867193##
  @MLP-13719 @webtest @regression @positive
  Scenario:SC#1:MLP-13719:Verification of error message on Manage configuration  by clicking the Error icon and verifying the timestamp
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollector/TestGitCollector"
    And supply payload with file name "/idc/IDX_PluginPayloads/MLP-13719_InCorrect_GitCollector_Plugin_Config.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/GitCollector/TestGitCollector" with the following query param
      | raw | false |
    And Status code 204 must be returned
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion and click menu option" operation in Manage Configurations panel
      | button    | actionItem | attribute        | itemName              |
      | LocalNode | Collector  | TestGitCollector | Run the configuration |
    And user performs "click" operation in Manage Configurations panel
      | button     | actionItem       |
      | Error Icon | TestGitCollector |
    And user verifies "Error tooltip" is "displayed" in Manage Configurations panel
    And user "verifies presence" of following "Text in Error tooltip" in Manage Configurations Page
      | ANALYSIS-GIT-0001: Git plugin encountered an error |
    And user verifies "Timestamp in the Error tooltip" is "displayed" in Manage Configurations panel

     ##6884929##6884931##6884932##6884935##
  @MLP-13721 @webtest @regression @positive
  Scenario:SC#2:MLP-13721:Verification of clearing error message on Manage configuration  by clicking the clear and clear all links
    Given  User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem | attribute        |
      | LocalNode | Collector  | TestGitCollector |
    And user performs "click" operation in Manage Configurations panel
      | button     | actionItem       |
      | Error Icon | TestGitCollector |
    And user performs "click" operation in Manage Configurations panel
      | button     | actionItem       |
      | Error Icon | TestGitCollector |
      | Clear      | TestGitCollector |
      | ClearAll   | TestGitCollector |
    And user verifies "Error message is emptied" is "displayed" in Manage Configurations panel
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollector/TestGitCollector"