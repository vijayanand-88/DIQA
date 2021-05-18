@MLP-20593
Feature:MLP_20593: This feature is to verify user is able to create and edit trust policy rules for trust score calculation

  @MLP-20593@regression @positive
  Scenario Outline:SC#1_Create BusinessApplication
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc/BusinessApplication/BATrustPolicy.json | 200           |                  |          |

 # 7047699
  @MLP-20593 @webtest @regression @positive
  Scenario:MLP-20593:SC#2_Verify if 'ItemType' drop down is not listed for existing rules.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Trust Policy" in "Landing page"
    And user "click" on "Add New Rule" button in "Trust Policy page"
    And user "verifies widgets absence" in "Trust Policy page"
      | fieldName                                | actionItem          |
      | verifies Trust Policy Rules Item Type BA | BusinessApplication |

# 7047700# 7047702 # 7047703# 7047704 # 7047705# 7047706
  @MLP-20593 @webtest @regression @positive
  Scenario:MLP-20593:SC#3_Verify if the user can modify an existing rule with different factor from the Factor drop down. Verify if refreshing that item in UI - Trust score is not calculated for that factor alone
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_TrustPolicy" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_TrustPolicy" item from search results
    And User performs following actions in the Item view Page
      | Actiontype                 | ActionItem           | ItemName |
      | Click                      | EditBAName           |          |
      | Select Dropdown of Details | Authoritative Source | Yes      |
      | Click                      | SaveBAName           |          |
    And user "click" on "Admin Link" for "Trust Policy" in "Landing page"
    And user clicks "BusinessApplication" Trust Policy Rules in Administration page
    And user create and Edit Trust Policy Rules
      | actionType            | actionItem       | ItemName             |
      | Create and Edit Rules | TrustPolicyLabel | Authoritative_source |
      | Create and Edit Rules | SelectFactor     | TAGGING              |
      | Create and Edit Rules | TrustPolicySave  |                      |
    And user enters the search text "BA_TrustPolicy" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_TrustPolicy" item from search results
    And User performs following actions in the Item view Page
      | Actiontype                 | ActionItem           | ItemName |
      | Click                      | EditBAName           |          |
      | Select Dropdown of Details | Authoritative Source | No      |
      | Click                      | SaveBAName           |          |
    And user refreshes the application
    And User performs following actions in the Item view Page
      | Actiontype                 | ActionItem           | ItemName |
      | Click                      | EditBAName           |          |
      | Select Dropdown of Details | Authoritative Source | No      |
      | Click                      | SaveBAName           |          |
    And User Clicks TrustScore Expand in Item View page
    And user create and Edit Trust Policy Rules
      | actionType            | actionItem                                        | ItemName             |
      | Create and Edit Rules | Verify ChartLegend Label                          | Authoritative_source |
      | Create and Edit Rules | Verify ChartLegend Authoritative Trust Score zero | Authoritative_source |

  @MLP-20593 @webtest @regression @positive
  Scenario:MLP-20593:SC#4_Revert Business Application Rules
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Trust Policy" in "Landing page"
    And user clicks "BusinessApplication" Trust Policy Rules in Administration page
    And user create and Edit Trust Policy Rules
      | actionType                 | actionItem       | ItemName             |
      | Change Trust Policy Label  | TrustPolicyLabel | Authoritative Source |
      | Change Trust Policy Factor | SelectFactor     | ATTRIBUTE_TRUE       |
      | Create and Edit Rules      | TrustPolicySave  |                      |

  @MLP-20593@regression @positive @webtest
  Scenario:MLP-20593:SC#5_Delete Business Application
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_TrustPolicy" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_TrustPolicy" item from search results
    And user "Deletes" BA Item "BA_TrustPolicy" in Item View Page
    And user "click" on "Confirm" button in "Delete Role Popup"
    And user "click" on "Admin Link" for "Trust Policy" in "Landing page"