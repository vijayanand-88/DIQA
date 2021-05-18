@MLP-23097
Feature: MLP-23097: Verification of api calls against tagging page

    ##7090261##
  @MLP-23097 @regression @positive @dashboard
  Scenario: SC#1: MLP-23097: MLP-23097:Verify PUT call for policy/tagging/actions?catalogname=Default with response 204
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                        | body                                                                | response code | response message | jsonPath |
      | application/json |       |       | Put  | policy/tagging/actions?catalogname=Default | idc/IDX_Integration_Payloads/MLP_23097_TagRule_with_technology.json | 204           |                  |          |

    ##7090261##
  @MLP-23097 @webtest @regression @positive
  Scenario:MLP-23097: Verify created rule in UI
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And User performs following actions in the Tagging Policy Page
      | Actiontype | ActionItem | ItemName  |
      | Click      | Rule       | All (Git) |
    And user "verify presence" in "Tagging Policy page"
      | fieldName            | actionItem |
      | Rule for Plugin Type | All (Git)  |
    And User performs following actions in the Tagging Policy Page
      | Actiontype | ActionItem         | ItemName  |
      | Click      | Rule Delete Button | All (Git) |
    And user "click" on "DELETE" button in "popup"
