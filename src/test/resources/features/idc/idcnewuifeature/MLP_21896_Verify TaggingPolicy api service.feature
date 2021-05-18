@MLP-21896 @MLP-19595@MLP-22714@MLP-22261
Feature:MLP-21896 Verify TaggingPolicy-API: Create API for Select/Create/Update/Delete a Rule

# 7072975# 7072979# 7072980# 7072981
  @MLP-21896 @regression @positive
  Scenario Outline:MLP-21896:SC#1 Update policy tags
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                             | bodyFile                                             | path       | response code | response message       | jsonPath                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put    | policy/tagging/actions                                                          | payloads\idc\MLP_21896_TaggingPolicy\PutTagging.json | $.putCall  | 204           |                        |                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Post   | policy/tagging/actions                                                          | payloads\idc\MLP_21896_TaggingPolicy\PutTagging.json | $.Postcall | 200           | Gender                 | $..tags                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get    | policy/tagging/analyses                                                         |                                                      |            | 200           | AmazonRedshiftAnalyzer | $.[?(@.dataType=='UNSTRUCTURED')].pluginName |
      | IDC         | TestSystemUser | application/json |       |       | Delete | policy/tagging/analysis?dataType=UNSTRUCTURED&pluginName=AmazonRedshiftAnalyzer |                                                      |            | 204           |                        |                                              |

# 7030727# 7030728
  @MLP-19595@webtest@regression @positive
  Scenario:MLP-19595:SC#2_Verify if the response body does not have the parameter 'originType' for PII related tags
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And users performs following actions in Manage access
      | Actiontype                        | ActionItem | ItemName | Section |
      | Verifies Profile Icon Highlighted |            |          |         |

    # 7089852# 7089853 # 7089854
  @MLP-22714@regression @positive
  Scenario:MLP-22714:SC#3_Verify if the response body does not have the parameter 'originType' for PII related tags
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                     | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | tags/Default/structures |      | 200           |                  |          |
    Then user verifies whether the value is not present in response using json path "$..[?(@.name=='PII')].subTags[0].originType"
      | jsonValues               |
      | GDP_PERSONAL_INFORMATION |

#    # 7076282# 7076283  # 7076285 # 7076286# 7076287 #Duplicate
#  @MLP-22261 @webtest @regression @positive
#  Scenario:MLP-22261:SC#4_Verify the tooltip for Log icon displayed as "Shows the logs of the configuration"
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
#    And user performs "click" operation in Manage Configurations panel
#      | button          | actionItem            |
#      | Open Deployment | LocalNode             |
#      | Plugin Edit     | SimilarityLinkerTable |
#    And user verifies pluginconfiguration tooltip "SimilarityLinkerTable" and  "Shows the logs of the configuration" button
#    And user verifies pluginconfiguration tooltip "SimilarityLinkerTable" and  "Clone the configuration" button
#    And user verifies pluginconfiguration tooltip "SimilarityLinkerTable" and  "Edit the configuration" button
#    And user verifies pluginconfiguration tooltip "SimilarityLinkerTable" and  "Delete the configuration" button
#    And user verifies pluginconfiguration tooltip "SimilarityLinkerTable" and  "Run the configuration" button

