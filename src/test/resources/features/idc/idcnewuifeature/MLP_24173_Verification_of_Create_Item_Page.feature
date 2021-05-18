@MLP-24173
Feature:MLP_24173: This feature is to verify Create Item page

  @MLP-24173 @webtest @regression @positive
  Scenario:Create a BA Item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute    | option |
      | BusinessApplication | Test BA Item | Save   |

  ##7118564##7118566##7118568##7118570##7118578##7118584##7118585##
  @MLP-24173 @webtest @regression @positive
  Scenario:SC#1:MLP-24173:Verify user able to see the show more icon and Edit icon in BA Item view for TestSystem Administrator
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Test BA Item" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype                           | ActionItem                 |
      | Verify Presence                      | Item view Edit Button      |
      | Verify Presence                      | Item view Show More Icon   |
      | Verify BA Item widgets are read only |                            |
      | Click                                | Item view Edit Button      |
      | Verify BA Item widgets are Editable  |                            |
      | Verify Absence                       | Item view Edit Button      |
      | Verify Presence                      | Item view BA Save Button   |
      | Verify Presence                      | Item view BA Cancel Button |
    Then user "verify presence" of following "BA Item view frozen tabs List" in Item Search Results Page
      | Architecture |
      | Support      |
      | Security     |
      | Compliance   |
      | Data         |
    And User performs following actions in the Item view Page
      | Actiontype           | ActionItem      | ItemName        |
      | Enter Business Owner | Business Owners | Test Data Admin |
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Unsaved Changes popup"
    And user refreshes the application
    And User performs following actions in the Item view Page
      | Actiontype                           | ActionItem |
      | Verify BA Item widgets are read only |            |


  ##7118587##7118588##7123394##
  @MLP-24173 @webtest @regression @positive
  Scenario:SC#2:MLP-24173:Verify clicking the cancel button while editing resets the old changes and the edit icon will be displayed replacing the Save and Cancel button
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Test BA Item" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem            |
      | Click      | Item view Edit Button |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem              | ItemName        |
      | Enter Business Owner               | Business Owners         | Test Data Admin |
      | Click                              | Item view Save Button   |                 |
      | Verify Business Owner Widget value | Business Owners         | Test Data Admin |
      | Click                              | Item view Edit Button   |                 |
      | Enter Business Owner               | Business Owners         | Test Guest User |
      | Click                              | Item view Cancel Button |                 |
    And user clicks on "Yes" link in the "Unsaved Changes popup"
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem            | ItemName        |
      | Verify Absence                     | Business Owners       | Test Guest User |
      | Click                              | Item view Edit Button |                 |
      | Enter Business Owner               | Business Owners       | Test Guest User |
      | Click                              | Item view Save Button |                 |
      | Verify Business Owner Widget value | Business Owners       | Test Guest User |

    ##7118590##
  @MLP-24173 @webtest @regression @positive
  Scenario:SC#3:MLP-24173:Verify Guest user should not able to see the Edit icon and show more icon
    Given User launch browser and traverse to login page
    When user enter credentials for "Information User" role
    And user enters the search text "Test BA Item" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype      | ActionItem               |
      | Verify Absence  | Item view Show More Icon |
      | Verify Disabled | Item view Edit Button    |

      ##7118589##7118572##7118574##
  @MLP-24173 @webtest @regression @positive
  Scenario:SC#4:MLP-24173:Verify option Rename will be displayed under the Show more icon
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Test BA Item" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype      | ActionItem                         |
      | Click           | Item view Show More Icon           |
      | Verify Presence | Rename Option under Show more Icon |
    And User performs following actions in the Item view Page
      | Actiontype     | ActionItem      | ItemName | Section                   |
      | Verify Absence | Description     | Save     | Widget Save/Cancel Button |
      | Verify Absence | Description     | Cancel   | Widget Save/Cancel Button |
      | Verify Absence | Details         | Save     | Widget Save/Cancel Button |
      | Verify Absence | Details         | Cancel   | Widget Save/Cancel Button |
      | Verify Absence | Business Owners | Save     | Widget Save/Cancel Button |
      | Verify Absence | Business Owners | Cancel   | Widget Save/Cancel Button |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem            |
      | Click      | Item view Edit Button |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem            | ItemName      |
      | Enter Business Owner               | Business Owners       | Becubic Build |
      | Click                              | Item view Save Button |               |
      | Verify Business Owner Widget value | Business Owners       | Becubic Build |
      | Click                              | Item view Edit Button |               |
    And user "enter text" in "Item View page"
      | fieldName      | actionItem     |
      | Application ID | Attribute text |
    And User performs following actions in the Item view Page
      | Actiontype             | ActionItem            | ItemName                             |
      | Enter Description      | Description           | Bussiness Owner description is added |
      | Click                  | Item view Save Button |                                      |
      | Verifies Item Presence | Description           | Bussiness Owner description is added |

  ##7118576##7118586##
  @MLP-24173 @webtest @regression @positive
  Scenario:SC#5:MLP-24173:Verify user able to re edit the widgets which are already saved
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Test BA Item" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype             | ActionItem            | ItemName                               |
      | Click                  | Item view Edit Button |                                        |
      | Enter Description      | Description           | Bussiness Owner description is updated |
      | Click                  | Item view Save Button |                                        |
      | Verifies Item Presence | Description           | Bussiness Owner description is updated |

  Scenario:Delete the BA Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name         | type                | query | param |
      | SingleItemDelete | Default | Test BA Item | BusinessApplication |       |       |

  ##7236661##MLPQA-3350##
  @MLP-29532@regression @positive
  Scenario Outline:SC#1_Create BusinessApplication
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                     | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc/BusinessApplication/BADataOwners.json | 200           |                  |          |

  ##7236660##MLPQA-3352####7236659##MLPQA-3351##
  @MLP-29532 @webtest @regression @positive
  Scenario:SC#2:MLP-24173:Verify DataOwners in the specific tab
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_DataOwners" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem            | ItemName      |
      | Verify Business Owner Widget value | Business Owners       | Becubic Build |
    And user "click" on "Item view Tab" for "Architecture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem            | ItemName      |
      | Verify Business Owner Widget value | Technology Owners       | Becubic Build |
    And user "click" on "Item view Tab" for "Support" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem            | ItemName      |
      | Verify Business Owner Widget value | Relationship Owners       | Becubic Build |
    And user "click" on "Item view Tab" for "Security" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem            | ItemName      |
      | Verify Business Owner Widget value | Security Owners       | Becubic Build |
    And user "click" on "Item view Tab" for "Compliance" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem            | ItemName      |
      | Verify Business Owner Widget value | Compliance Owners       | Becubic Build |




