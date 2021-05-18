Feature:MLP_23661_Verify Change Business criticality query to a generic attribute stored query

# 7109991
  @MLP-23661@regression @positive
  Scenario Outline:SC#1_Verify if user can create 4 BA items
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc\MLP-23661\BusinessApplication1.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc\MLP-23661\BusinessApplication2.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc\MLP-23661\BusinessApplication3.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc\MLP-23661\BusinessApplication4.json | 200           |                  |          |

    # 7109992
  @MLP-23661 @webtest @regression @positive
  Scenario:MLP-23661:SC#2_Verify if user can update the 'Business Criticality' for the created BA item as 'High'
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_Dashboard" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_Dashboard" item from search results
    And User performs following actions in the Item view Page
      | Actiontype                 | ActionItem           | ItemName |
      | Edit Icon BusinessTab      |                      |          |
      | Select Dropdown of Details | Business Criticality | High     |
      | Click                      | Save                 |          |

    # 7109993
  @MLP-23661 @webtest @regression @positive
  Scenario:MLP-23661:SC#3_Verify if user can update the 'Business Criticality' for the created BA item as 'Medium'
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_Dashboard1" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_Dashboard1" item from search results
    And User performs following actions in the Item view Page
      | Actiontype                 | ActionItem           | ItemName |
      | Edit Icon BusinessTab      |                      |          |
      | Select Dropdown of Details | Business Criticality | Medium   |
      | Click                      | Save                 |          |

     # 7109994
  @MLP-23661 @webtest @regression @positive
  Scenario:MLP-23661:SC#4_Verify if user can update the 'Business Criticality' for the created BA item as 'Low'
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_Dashboard2" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_Dashboard2" item from search results
    And User performs following actions in the Item view Page
      | Actiontype                 | ActionItem           | ItemName |
      | Edit Icon BusinessTab      |                      |          |
      | Select Dropdown of Details | Business Criticality | Low      |
      | Click                      | Save                 |          |

    # 7109996
  @MLP-23661 @webtest @regression @positive
  Scenario:MLP-23661:SC#5_Verify if user can update the 'Business Criticality' for the created BA item as 'empty'
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_Dashboard3" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_Dashboard3" item from search results
    And User performs following actions in the Item view Page
      | Actiontype                 | ActionItem           | ItemName |
      | Edit Icon BusinessTab      |                      |          |
      | Select Dropdown of Details | Business Criticality | <empty>  |
      | Click                      | Save                 |          |

    # 7109997
  @MLP-23661 @webtest @regression @positive
  Scenario:MLP-23661:SC#6_ Verify if the 'Business Criticality' widget has the ItemType drop down editable and configurable(Default selected is Business Application)
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" on "Widget settings Icon" for "Application by Business Criticality" in "Dashboard page"
    And user "verify Widget Item Type" in "Dashboard page"
      | fieldName                         | actionItem | itemName            |
      | verify Widget Item Type           | Item Type  | BusinessApplication |
      | Verify Configure Widget Attribute | Attribute  | businessCriticality |

# 7109998# 7109999 no step clarity
  @MLP-23661 @webtest @regression @positive
  Scenario:MLP-23661:SC#7_Verify if the 'Business Criticality' widget has the Attribute text field editable (Default written as 'businessCriticality')
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" on "Widget settings Icon" for "Application by Business Criticality" in "Dashboard page"
#    And user "verifies Piechart Business Criticality" in "Dashboard page"
#      | fieldName                    | actionItem |
#      | Businesscriticality Piechart | High       |
#      | Businesscriticality Piechart | Medium     |
#      | Businesscriticality Piechart | Low        |
#      | Businesscriticality Piechart | blank      |

  Scenario:Delete the BA Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name          | type                | query | param |
      | SingleItemDelete | Default | BA_Dashboard  | BusinessApplication |       |       |
      | SingleItemDelete | Default | BA_Dashboard1 | BusinessApplication |       |       |
      | SingleItemDelete | Default | BA_Dashboard2 | BusinessApplication |       |       |
      | SingleItemDelete | Default | BA_Dashboard3 | BusinessApplication |       |       |
