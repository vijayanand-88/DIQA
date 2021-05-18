@MLP-24165:
Feature: MLP-24165: Verification of api calls against notification page

    ##7119456##
  @MLP-24165 @regression @positive @dashboard
  Scenario: SC#1:MLP-24165:Verify the Get call '/notifications' with response code 200
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                             | body | response code | response message                  | jsonPath |
      | application/json |       |       | Get  | notifications?type=type%3Dnotifications&limit=0 |      | 200           | newNotifications,oldNotifications |          |

  @git
  Scenario: Create Datasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                             | body                                                                 | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/credentials/GitCred                    |                                                                      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS |                                                                      |               |                  |          |              |          |
      |                  |       |       | Put    | settings/credentials/GitCred                    | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | 200           |                  |          |              |          |
      |                  |       |       | Get    | settings/credentials/GitCred                    |                                                                      | 200           |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/GitDS | idc/IDX_PluginPayloads/MLP-14102_GitCollector_DataSource_Config.json | 204           |                  |          |              |          |
      |                  |       |       | Get    | settings/analyzers/GitCollectorDataSource/GitDS |                                                                      | 200           | GitDS            |          |              |          |

    ##7119458##
  @MLP-24165 @regression @positive
  Scenario: MLP-24165:updating the id from the response
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "notifications?limit=0" and retrieves value from using jsonpath "$..newNotifications[?(@.title=='Analyser Configuration GitCollectorDataSource changed')].notificationId"
    When user makes a REST Call for "GET" request with url "notifications/root.Notification%3A%3A%3AstoredText" and path ""
    Then Status code 200 must be returned
    Then Json response message should contains the following value
      | responseMessage                                       |
      | Analyser Configuration GitCollectorDataSource changed |

  ##7127905##
  @MLP-24165 @regression @positive
  Scenario: MLP-24165:Verify the Post call '/notifications{id}' with response code 204
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "notifications?limit=0" and retrieves value from using jsonpath "$..newNotifications[?(@.title=='Analyser Configuration GitCollectorDataSource changed')].notificationId"
    When user makes a REST Call for "POST" request with url "notifications/root.Notification%3A%3A%3AstoredText" and path ""
    Then Status code 204 must be returned

