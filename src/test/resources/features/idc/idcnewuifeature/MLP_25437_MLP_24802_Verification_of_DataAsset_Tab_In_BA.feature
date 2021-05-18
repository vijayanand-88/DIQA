@MLP-25437 @MLP-24802
Feature:MLP-25437 MLP-24802: This feature is to verify DataAsset tab  in Business Application and stewardship tab in Item view

  @MLP-25437@regression @positive
  Scenario Outline:SC#1_Create BusinessApplication
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                     | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc/BusinessApplication/BADataAsset.json | 200           |                  |          |

      ##7147520##7147525##
  @MLP-25437 @webtest @regression @positive
  Scenario:MLP-25437:SC#2:Verify the DataAsset tab is displayed with no Graphical Representation before assigning BA
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_DataAsset" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Data Asset" in "Item View Page"
    Then user "verify presence" of following "Plugin accordion labels under DataAsset Tab" in Item View Page
      | Data                                    |
      | Total number of Assigned Data Elements: |
    And user performs following actions in the header
      | actionType | actionItem |
      | click      | Refresh    |

  @MLP-25437 @regression @positive
  Scenario:MLP-25437: Delete the credential
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                          | body | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/credentials/GitCred |      |               |                  |          |              |          |

  Scenario Outline:SC#3 Create Credential and Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                             | body                                                                  | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/GitCred                                                    | /idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/credentials/GitCred                                                    |                                                                       | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                       | /idc/IDX_PluginPayloads/MLP-14102_GitCollector_DataSource_Config.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource                                       |                                                                       | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector/GitCollectorConfig                              | /idc/IDX_PluginPayloads/MLP-14104_GitCollector_Plugin_Config.json     | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector/GitCollectorConfig                              |                                                                       | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |                                                                       | 200           | IDLE             |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorConfig  |                                                                       | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |                                                                       | 200           | IDLE             |          |

    ##7147521##7147522##7147523##7147524##
  @MLP-25437 @webtest @regression @positive
  Scenario:MLP-25437:SC#4:Verify the DataAsset tab by the assinging the elements to BA,
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user "selects" for the following filter in search results page
      | FilterType    | FilterValues |
      | Tags          | Git          |
      | Metadata Type | Directory    |
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Business Applications" in "Search results page"
    And User performs following actions in the Item view Page
      | Actiontype    | ActionItem   | Section      |
      | Click         | Search       |              |
      | Enter Text    | Tag Text box | BA_DataAsset |
      | Tag Selection | BA_DataAsset | Available    |
    And user "click" on "Assign" button in "Create Item Page"
    And user enters the search text "BA_DataAsset" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Data Asset" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem | ItemName |
      | Verify Plugin Configuration Values | Technology | Git      |

     ##7147526##7147528##
  @MLP-25437 @webtest @regression @positive
  Scenario:MLP-25437:SC#5:Verify the Show Data elements in a list in Data Asset Tab
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_DataAsset" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Data Asset" in "Item View Page"
    And user verifies whether "Show the data elements in a list" is "displayed" for "" Item view page
    And user "click" on "Show the data elements in a list" button in "Item View page"
    And user verifies the count from Data Asset and facets filters of tag "BA_DataAsset" are same.

    ##7147527##
  @MLP-25437 @webtest @regression @positive
  Scenario:MLP-25437:SC#6:Verify the Tag facets filter displayed with New BA Tag after assinging elements
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user "selects" for the following filter in search results page
      | FilterType | FilterValues |
      | Tags       | BA_DataAsset |

    ##7147529##
  @MLP-18457 @webtest @regression @positive
  Scenario:MLP-25437:SC#7:Verify the completeness Widget is displayed with Data Asset with green color
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_DataAsset" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user performs following actions in the header
      | actionType | actionItem          |
      | click      | Completeness Widget |
      | displayed  | Data Asset          |
    And user verifies the background color of the page
      | StyleType        | ColorCode             | Page       |
      | background-color | rgba(147, 218, 73, 1) | Data Asset |

    ##7147530##7147531##
  @MLP-25437 @webtest @regression @positive
  Scenario:MLP-25437:SC#8:Verify the Edit icon is disabled for DataAsset and Capture Tab
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_DataAsset" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And user verifies whether "Edit Icon" is "disabled" for "" Item view page
    And user "click" on "Item view Tab" for "Data Asset" in "Item View Page"
    And user verifies whether "Edit Icon" is "disabled" for "" Item view page

    ##7133787##7133788##
  @MLP-24802 @webtest @regression @positive
  Scenario:MLP-24802:SC#1:Verify of stewardship tab with owners after assigning the items to BA item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the header
      | actionType | actionItem    |
      | click      | Search Button |
    And user "selects" for the following filter in search results page
      | FilterType | FilterValues |
      | Tags       | BA_DataAsset |
    And user clicks on first item on the item list page
    And user "click" on "Stewardship" tab in Overview page
    And User performs following actions in the Item view Page
      | Actiontype             | ActionItem | ItemName            |
      | Verify Itemview Owners | Owners     | Business Owners     |
      | Verify Itemview Owners | Owners     | Technology Owners   |
      | Verify Itemview Owners | Owners     | Relationship Owners |
      | Verify Itemview Owners | Owners     | Security Owners     |
      | Verify Itemview Owners | Owners     | Compliance Owners   |

  ##7133790##7133792##7133793##7133795##
  @MLP-24802 @webtest @regression @positive
  Scenario:MLP-24802:SC#2:Verify of stewardship tab with owners and its details after assigning the items to BA item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the header
      | actionType | actionItem    |
      | click      | Search Button |
    And user "selects" for the following filter in search results page
      | FilterType | FilterValues |
      | Tags       | BA_DataAsset |
    And user clicks on first item on the item list page
    And user "click" on "Stewardship" tab in Overview page
    And User performs following actions in the Item view Page
      | Actiontype             | ActionItem      | ItemName              |
      | Verify Itemview Owners | OwnersIcon      | Avatar Icon           |
      | Verify Itemview Owners | OwnerName       | Becubic Build         |
      | Click                  | OwnerName       | Becubic Build         |
      | Verify Itemview Owners | User info Panel |                       |
      | Verify Itemview Owners | OwnersIcon      | Avatar Icon           |
      | Verify Itemview Owners | OwnerName       | Becubic Build         |
      | Verify Itemview Owners | OwnerNameEmail  | becubic_build@asg.com |
      | Click                  | OwnerCloseIcon  |                       |

  ##7133794##7133796##
  @MLP-24802 @webtest @regression @positive
  Scenario:MLP-24802:SC#3:Verify of stewardship tab with expand/collapse and No data available
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the header
      | actionType | actionItem    |
      | click      | Search Button |
    And user "selects" for the following filter in search results page
      | FilterType | FilterValues |
      | Tags       | BA_DataAsset |
    And user clicks on first item on the item list page
    And user "click" on "Stewardship" tab in Overview page
    And user verifies whether "No data available" is "displayed" for "" Item view page
    And user performs following actions in the header
      | actionType | actionItem         |
      | click      | WidgetCollapseIcon |
      | click      | WidgetExpandIcon   |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name         | type                | query | param |
      | SingleItemDelete | Default | BA_DataAsset | BusinessApplication |       |       |

  @MLP-25437 @regression @positive
  Scenario:MLP-25437: Delete a data source and a credential
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                | body | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/GitDS    |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/GitCollectorConfig |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/GitCred                       |      |               |                  |          |              |          |
