@MLP-20044 @MLP-20983
Feature:MLP-20044 MLP-20983: This feature is to verify the improvements in the Search results page and UI

  ##7015423##7015424##7015426##7015427##
  @MLP-20044 @webtest @regression @positive
  Scenario: SC1#:MLP-20044: To have tool header in search result item, contains select all and show only selected items
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user "click" on "firstItemCheckbox" button in "Item Search Results" page
    And user "click" on "Show only selected item" button in "Item Search Results" page
    Then user verifies "Single Item Result" is "displayed" in "Search Results" page
    And user verifies "Show All Button" is "displayed" in "Search Results" page
    And user "click" on "Show All Button" button in "Item Search Results" page
    And user verifies "Search page Improvements" is "displayed" in "Search Results" page

  ##7015429##
  @MLP-20044 @webtest @regression @positive
  Scenario: SC2#:MLP-20044: Verify the color code for each Type
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user verifies the "Color code for each type" in the "Search Result page"
      | StyleType        | ColorNameCode          | item          |
      | background-color | rgba(183, 216, 245, 1) | Column        |
      | background-color | rgba(228, 196, 149, 1) | File          |
      | background-color | rgba(210, 156, 78, 1)  | Directory     |
      | background-color | rgba(238, 226, 249, 1) | Function      |
      | background-color | rgba(183, 216, 245, 1) | Table         |
      | background-color | rgba(231, 233, 201, 1) | DataDomain    |
      | background-color | rgba(220, 196, 242, 1) | SourceTree    |
      | background-color | rgba(70, 214, 131, 1)  | Analysis      |
      | background-color | rgba(241, 225, 202, 1) | Field         |
      | background-color | rgba(111, 178, 235, 1) | Database      |
      | background-color | rgba(212, 215, 157, 1) | DataType      |
      | background-color | rgba(246, 156, 192, 1) | Service       |
      | background-color | rgba(252, 180, 146, 1) | Execution     |
      | background-color | rgba(250, 130, 73, 1)  | Operation     |
      | background-color | rgba(240, 90, 150, 1)  | Cluster       |
      | background-color | rgba(197, 201, 121, 1) | DataPackage   |
      | background-color | rgba(246, 156, 192, 1) | Host          |
      | background-color | rgba(138, 58, 213, 1)  | Project       |
      | background-color | rgba(238, 238, 238, 1) | Configuration |

  ##7015429##
  @MLP-20044 @webtest @regression @positive
  Scenario: SC3#:MLP-20044: Verify the short name for each Type
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user verifies the "Short name for each type" in the "Search Result page"
      | ColorNameCode | item          |
      | CO            | Column        |
      | FI            | File          |
      | DI            | Directory     |
      | FU            | Function      |
      | TA            | Table         |
      | DD            | DataDomain    |
      | ST            | SourceTree    |
      | AN            | Analysis      |
      | FI            | Field         |
      | DA            | Database      |
      | DT            | DataType      |
      | SE            | Service       |
      | EX            | Execution     |
      | OP            | Operation     |
      | CL            | Cluster       |
      | DP            | DataPackage   |
      | HO            | Host          |
      | PR            | Project       |
      | CO            | Configuration |

  ##7015440##7015441##
  @MLP-20044 @webtest @regression @positive
  Scenario: SC4#:MLP-20044: Verify if user can select bulk items and assign tag. Verify Tag facet is updated
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "employees_full" and clicks on search
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Tags" in "Search results page"
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem          |
      | Click      | Create a tag Button |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem |
      | Enter Text | TestTag    |
    And user "click" on "Assign/UnAssign Save" button in "Assign a Tag" page
    And user "click" on "Assign Tag" button in "Assign a Tag" page
    And user refreshes the application
    And user performs "facet selection" in "TestTag" attribute under "Tags" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 18 items" in Item Search results page
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Tags" in "Search results page"
    And User performs following actions in the "Assign a Business Application" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | TestTag    | Assigned |
    And user "click" on "Assign Tag" button in "Assign a Tag" page

  @webtest @regression @positive
  Scenario:Create an BA Item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option |
      | BusinessApplication | TestBA    | Save   |
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option |
      | BusinessApplication | TestBA1   | Save   |
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option |
      | BusinessApplication | Auto_BA   | Save   |

   ##7016980##
  @MLP-20026 @webtest @regression @positive
  Scenario: SC6#:MLP-20026:Verify if user can select bulk search items of same type and check if "ASSIGN/UNASSIGN TAGS" button is enabled
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Business Applications" in "Search results page"
    And user "Verifies popup" is "displayed" for "Assign a Business Application"

    ##7016981##
  @MLP-20026 @webtest @regression @positive
  Scenario: SC7#:MLP-20026: Verify if user can select Business Application Metadata item and assign tags for all items
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "TestBA" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 2 items" in Item Search results page
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Tags" in "Search results page"
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem          |
      | Click      | Create a tag Button |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem |
      | Enter Text | TestTag1   |
    And user "click" on "Assign/UnAssign Save" button in "Assign a Tag" page
    And user "click" on "Assign Tag" button in "Assign a Tag" page
    And user refreshes the application
    And user performs "facet selection" in "TestTag1" attribute under "Tags" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 2 items" in Item Search results page

      ##7016982##
  @MLP-20026 @webtest @regression @positive
  Scenario: SC8#:MLP-20026: Verify if for the Business Application items which are tagged already, certain tags can be untagged and search results updated
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "TestBA" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 2 items" in Item Search results page
    And user performs "checkbox selection" on "TestBA" item from search results
    And user "click" on "Search Results Show more options" for "Assign/Unassign Tags" in "Search results page"
    And User performs following actions in the Item view Page
      | Actiontype  | ItemName | Section  |
      | mouse hover | TestTag1 | Assigned |
      | Remove Tag  | TestTag1 | Assigned |
    And user "click" on "Assign" button in "Create Item Page"
    And user clicks on search icon
    And user performs "facet selection" in "TestTag1" attribute under "Tags" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 1 items" in Item Search results page
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Tags" in "Search results page"
    And User performs following actions in the Item view Page
      | Actiontype  | ItemName | Section  |
      | mouse hover | TestTag1 | Assigned |
      | Remove Tag  | TestTag1 | Assigned |
    And user "click" on "Assign Tag" button in "Assign a Tag" page

  ##7016984## #Duplicate - MLP-18355
#  @MLP-20026 @webtest @regression @positive
#  Scenario: SC9#:MLP-20026: Verify if for Global search items, Select All items does not enable "ASSIGN/UNASSIGN TAGS" button
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on search icon
#    And user "click" on "Select All checkbox" button in "Item Search Results" page
#    And user verifies "Assign/UnAssign Tags" is "not displayed" in "Search Results" page
#
    ##7016987##
  @MLP-20026 @webtest @regression @positive
  Scenario: SC10#:MLP-20026: Verify if user can select items and Assign a newly created tag to the items
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "TestBA" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Tags" in "Search results page"
    And User performs following actions in the Item view Page
      | Actiontype    | ActionItem | Section   |
      | Tag Selection | TestTag1   | Available |
    And user "click" on "Assign" button in "Create Item Page"
    And user refreshes the application
    And user clicks on search icon
    And user performs "facet selection" in "TestTag1" attribute under "Tags" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 2 items" in Item Search results page
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Tags" in "Search results page"
    And User performs following actions in the Item view Page
      | Actiontype  | ItemName | Section  |
      | mouse hover | TestTag1 | Assigned |
      | Remove Tag  | TestTag1 | Assigned |
    And user "click" on "Assign Tag" button in "Assign a Tag" page

  ##7016985## #Duplicate - MLP-18355
#  @MLP-20026 @webtest @regression @positive
#  Scenario: SC11#:MLP-20026: Verify if user selects mixed item types of same catalog like Table, Column item - then ASSIGN/UNASSIGN TAGS button is enabled
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on search icon
#    And user performs "facet selection" in "customer [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
#    Then results panel "search item count" should be displayed as "Select all 30 items" in Item Search results page
#    And user "click" on "Select All checkbox" button in "Item Search Results" page
#    And user verifies "Assign/UnAssign Tags" is "displayed" in "Search Results" page

    ##7043660##
  @MLP-20983 @webtest @regression @positive
  Scenario: SC12#:MLP-20983: Verify if user can create a Business Application item - name it as "BA Tag"
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option |
      | BusinessApplication | BA Tag    | Save   |

  ##7043661##7043662##
  @MLP-20983 @webtest @regression @positive
  Scenario: SC13#:MLP-20983: Verify if user opens an item > Add Tags > Verify in the Assign a Tag screen system does not display the "BA Tag" in 'Select a tag to assign' tags list
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA Tag" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     |
      | Click      | Add Tag Button |
    Then user verify "verify non presence" with following values under "Available" section in item search results page
      | BA Tag     |
      | Technology |

  @git
  Scenario: Create Datasource Credentials and Configuration for GitCollector
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                             | username    | password    |
      | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | $..userName | $..password |
    And Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                | body                                                                 | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/credentials/GitCred                       |                                                                      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS    |                                                                      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/GitCollectorConfig |                                                                      |               |                  |          |              |          |
      |                  |       |       | Put    | settings/credentials/GitCred                       | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | 200           |                  |          |              |          |
      |                  |       |       | Get    | settings/credentials/GitCred                       |                                                                      | 200           |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/GitDS    | idc/IDX_PluginPayloads/MLP-14102_GitCollector_DataSource_Config.json | 204           |                  |          |              |          |
      |                  |       |       | Get    | settings/analyzers/GitCollectorDataSource/GitDS    |                                                                      | 200           |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollector/GitCollectorConfig | idc/IDX_PluginPayloads/MLP-20220_GitCollector_Plugin_Config.json     | 204           |                  |          |              |          |

  ##7015413##7015424##
  @MLP-20220 @webtest @regression @positive
  Scenario: SC14#:MLP-20220: To verify the user is able to view the Selection of node and plugin configuration by clicking Manage Configurations Breadcrumb link (Internal Node)
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button       | actionItem | attribute          |
      | InternalNode | Collector  | GitCollectorConfig |
    And user "click configuration menu buttons" in "Manage Configurations" Page
      | fieldName                           | option             |
      | Shows the logs of the configuration | GitCollectorConfig |
    And user verifies "Log Viewer" is "displayed" in Manage Configurations panel
    And user "click" on "Manage Configurations Link" in Manage Configurations panel
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Configurations |

  @MLP-20983 @regression @positive
  Scenario: Run the Git Collector
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                | body | response code | response message |
      | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/collector/GitCollector/GitCollectorConfig  |      | 200           |                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/GitCollector/GitCollectorConfig |      | 200           | IDLE             |

  ##Bug id:
  ##7043663##
  @MLP-20983 @webtest @regression @positive
  Scenario: SC13#:MLP-20983: Verify if user can run a valid plugin and then navigate to the respective plugin item view. Verify in the 'Assign a Tag screen' system does not display the "Technology" and 'BA Tag' tags in 'Select a tag to assign' tags list
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "dynamic item click" on "collector/GitCollector/GitCollectorConfig" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     |
      | Click      | Add Tag Button |
    Then user verify "verify non presence" with following values under "Available" section in item search results page
      | BA Tag     |
      | Technology |

    ##7043664##7043665##
  @MLP-20983 @webtest @regression @positive
  Scenario: SC14#:MLP-20983: Verify if user can create a Tag "Custom Tag1" and save it from 'Assign a Tag' screen
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA Tag" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Tags" in "Search results page"
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem          |
      | Click      | Create a tag Button |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem |
      | Enter Text | CustomTag  |
    And user "click" on "Assign/UnAssign Save" button in "Assign a Tag" page
    And user "click" on "Assign Tag" button in "Assign a Tag" page
    And user refreshes the application
    And user performs "facet selection" in "CustomTag" attribute under "Tags" facets in Item Search results page
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Tags" in "Search results page"
    Then user verify "Presence of Assigned Tag" with following values under "Assigned" section in item search results page
      | CustomTag |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | CustomTag  | Assigned |
    And user "click" on "Assign Tag" button in "Assign a Tag" page

  Scenario:Delete an Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name    | type                | query | param |
      | SingleItemDelete | Default | TestBA  | BusinessApplication |       |       |
      | SingleItemDelete | Default | TestBA1 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Auto_BA | BusinessApplication |       |       |
      | SingleItemDelete | Default | BA Tag  | BusinessApplication |       |       |


  Scenario Outline:Delete plugin Configurations ,credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                         | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | tags/Default/tags/TestTag?roottag=General   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | tags/Default/tags/TestTag1?roottag=General  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | tags/Default/tags/CustomTag?roottag=General |      | 204           |                  |          |

  @git @precondition
  Scenario: Delete the Config
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                | body | response code | response message | jsonPath |
      | application/json | raw   | false | Delete | settings/credentials/GitCred                       |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS    |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/GitCollectorConfig |      |               |                  |          |


