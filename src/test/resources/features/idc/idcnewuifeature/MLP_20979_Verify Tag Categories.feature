Feature:MLP_20979_Verify Tag Categories

  @MLP-20979 @regression @positive
  Scenario Outline:SC#1_Create BusinessApplication
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc/BusinessApplication/BATrustPolicy.json | 200           |                  |          |

  @MLP-20979 @webtest @regression @positive
  Scenario:MLP-20979:SC#2_Custom Tag Creation
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Add Category" button in "Manage Tags page"
    And user create a tag with name "custom" in Manage Tags page

    # 7042923 # 7042931
  @MLP-20979 @webtest @regression @positive
  Scenario:MLP-20979:SC#3_Verify if - user can open an item and create a New Tag "CustomNew"
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_TrustPolicy" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_TrustPolicy" item from search results
    And user "click" on "TagAssign" button in "Create Item Page"
    And User performs following actions in the Item view Page
      | Actiontype      | ActionItem          |
      | Click           | Add Tag Button      |
      | Click           | Create a tag Button |
      | Enter Text      | customNew           |
      | Select Category | custom              |
    And user "click" on "SaveTag" button in "Create Tag Page"
    And user "click" on "Assign" button in "Create Item Page"
 # 7042941
  @MLP-20979 @regression @positive
  Scenario Outline: SC#4 Verify Tag Respose Code
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                     | body | response code | response message | filePath                           | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Get  | tags/Default/structures |      | 200           |                  | payloads\idc\MLP_20979\Actual.json |          |

# 7042961#7042987#7042993
  @MLP-20979 @regression @positive
  Scenario Outline:SC#5 Compare Json values of Response with Expected Json Value
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                       | actualValues                       | valueType     | expectedJsonPath | actualJsonPath                                                   |
      | payloads\idc\MLP_20979\Expected.json | payloads\idc\MLP_20979\Actual.json | stringCompare | $..Tags.value3   | $..rootTags..[?(@.name=='BusinessApplication')].name             |
      | payloads\idc\MLP_20979\Expected.json | payloads\idc\MLP_20979\Actual.json | stringCompare | $..Tags.value4   | $..rootTags..[?(@.name=='Technology')].name                      |
      | payloads\idc\MLP_20979\Expected.json | payloads\idc\MLP_20979\Actual.json | stringCompare | $..Tags.value5   | $..[?(@.name=='custom')]..subTags..[?(@.name=='customNew')].name |


  @MLP-20979 @regression @positive
  Scenario Outline: SC#6 Delete Tag
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type   | url                         | body | response code | response message | filePath | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Delete | tags/Default/tags/customNew |      | 204           |                  |          |          |
      | IDC         | TestSystem | application/json |       |       | Delete | tags/Default/tags/custom    |      | 204           |                  |          |          |

  @MLP-20979 @webtest @regression @positive
  Scenario:MLP-20979:SC#7_Delete Business Application
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_TrustPolicy" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_TrustPolicy" item from search results
    And user "Deletes" BA Item "BA_TrustPolicy" in Item View Page
    And user "click" on "Confirm" button in "Delete Role Popup"