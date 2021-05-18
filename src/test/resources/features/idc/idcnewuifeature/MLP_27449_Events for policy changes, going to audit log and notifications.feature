@MLP-27449 @e2e
Feature:MLP_27449: This feature is to verify Events for policy changes, going to audit log and notifications

  ##7198272##
  @MLP-27449 @webtest @regression @positive
  Scenario:MLP-27449: SC#1_Verify if On saving the 'Trust Policy', system displays a notification in notification panel
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Trust Policy" in "Landing page"
    And user clicks "BusinessApplication" Trust Policy Rules in Administration page
    And user create and Edit Trust Policy Rules
      | actionType            | actionItem       | ItemName             |
      | Create and Edit Rules | TrustPolicySave  |                      |
    And User performs following actions in the Manage Notifications Page
      | Actiontype      | ActionItem                              | ItemName                                                                      |
      | Click           | Notification bell Icon                  |                                                                              '|
      | Click           | First notification in List              |                                                                               |
      | Verify Presence | Notification Title and Content          | Trust policy change,Trust policies have been changed for BusinessApplication  |

  ##7198294##
  @MLP-27449 @webtest @regression @positive
  Scenario:MLP-27449: SC#2_Verify if On saving the 'Tagging Policy', system displays a notification in notification panel
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And user clicks "Default" Trust Policy Rules in Administration page
    And user create and Edit Trust Policy Rules
      | actionType            | actionItem       | ItemName             |
      | Create and Edit Rules | TrustPolicySave  |                      |
    And User performs following actions in the Manage Notifications Page
      | Actiontype      | ActionItem                              | ItemName                                                                 |
      | Click           | Notification bell Icon                  |                                                                         '|
      | Click           | First notification in List              |                                                                          |
      | Verify Presence | Notification Title and Content          | Tagging policy change,Tagging policies have been changed for all plugins |

  ##7198295##
  @MLP-27449 @webtest @regression @positive
  Scenario:MLP-27449: SC#3_Verify if On saving the 'Tagging Policy', system displays a notification in notification panel
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Masking Policy" in "Landing page"
    And user clicks "Column" Trust Policy Rules in Administration page
    And user create and Edit Trust Policy Rules
      | actionType            | actionItem       | ItemName             |
      | Create and Edit Rules | TrustPolicySave  |                      |
    And User performs following actions in the Manage Notifications Page
      | Actiontype      | ActionItem                              | ItemName                                                                 |
      | Click           | Notification bell Icon                  |                                                                         '|
      | Click           | First notification in List              |                                                                          |
      | Verify Presence | Notification Title and Content          | Masking policy change,Masking policies have been changed for type Column |

  ##7198296##
  @MLP-27449  @regression @positive
  Scenario:MLP-27449: SC4_Verify if GET Statistics shows TrustPolicyChangeEvent, TaggingPolicyChangeEvent, MaskingPolicyChangeEvent
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                     | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | auditrecords/statistics |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage           |
      | userName                  |
      | TestSystem                |
      | eventType                 |
      | TrustPolicyChangeEvent    |
      | TaggingPolicyChangeEvent  |
      | MaskingPolicyChangeEvent  |
