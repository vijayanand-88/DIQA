@MLP-21945
Feature:MLP-21945: This feature is to verify the item view page

  ##7087461##7087462##7087463##7087464##
  @MLP-21945 @webtest @regression @positive
  Scenario: SC#1:MLP-21945: To Verify the user is able to navigate to via Hierarchy in the item view page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "employees_full" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype           | ActionItem |
      | Click Hierarchy link | northwind  |
    And user verifies "New tab is not opened" is "displayed"
    And user verifies "Item view page title" for "northwind" in Item view page
    Then user performs click and verify in new window
      | Table  | value      | Action               | RetainPrevwindow | indexSwitch |
      | Tables | categories | click and switch tab | No               |             |
    And user verifies "New tab is not opened" is "displayed"
    And user verifies "Item view page title" for "categories" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Columns | catmapping | click and switch tab | No               |             |
    And user verifies "New tab is not opened" is "displayed"
    And user verifies "Item view page title" for "catmapping" in Item view page
    And user navigates to previous page
    And user verifies "Item view page title" for "categories" in Item view page

  @webtest @regression @positive
  Scenario: Create an BA Item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem    |
      | click      | Settings Icon |
      | click      | CreateButton  |
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | SampleBA  |
    And user "click" on "Save" button in "Create Item Page"

  @precondition
  @MLP-22277 @regression @positive
  Scenario: Run Git Collector
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body                                                                                      | response code | response message | jsonPath                                              |
      | application/json |       |       | Delete       | settings/analyzers/GitCollectorDataSource/GitDS                               |                                                                                           |               |                  |                                                       |
      |                  |       |       | Delete       | settings/analyzers/GitCollector/TestGitCollector                              |                                                                                           |               |                  |                                                       |
      |                  |       |       | Delete       | settings/credentials/GitCred                                                  |                                                                                           |               |                  |                                                       |
      |                  |       |       | Put          | settings/credentials/GitCred?allowUpdate=false                                | idc/IDx_DataSource_Credentials_Payloads/MLP-14658_Username_Pasword_Credential_Config.json | 200           |                  |                                                       |
      |                  |       |       | Put          | settings/analyzers/GitCollectorDataSource/GitDS                               | idc/IDx_DataSource_Credentials_Payloads/MLP-21945_GitCollectorDS_Config.json              | 204           |                  |                                                       |
      |                  |       |       | Put          | settings/analyzers/GitCollector/TestGitCollector                              | idc/IDX_PluginPayloads/MLP-22777_GitCollector_Plugin_Config.json                          | 204           |                  |                                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/TestGitCollector |                                                                                           | 200           | IDLE             | $.[?(@.configurationName=='TestGitCollector')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/TestGitCollector  |                                                                                           | 200           |                  |                                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/TestGitCollector |                                                                                           | 200           | IDLE             | $.[?(@.configurationName=='TestGitCollector')].status |

  ##7085560##7085561##7085562##
  @MLP-22277 @webtest @regression @positive
  Scenario:SC#2:MLP-22277: To verify the tool tips displayed as Filter Tags when user is in usages diagram
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text " StudentDerivedClass" and clicks on search
    And user performs "facet selection" in "Git" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Relationships" tab in Overview page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option | dropdown      |
      | Usages | relationships |
    And user verifies the "Filter tags Icon" is "displayed"
    Then following items should "get" displayed in Lineage Diagram
      | lineageNodeName | lineageNodeType |
      | Git             | Tag             |
      | SampleBA        | Tag             |
    And user "click" on "Filter tags icon" icon in LineageDiagramming page
    And user "click" on "Filter tags" for "Technology" in LineageDiagramming page
    Then following items should "not get" displayed in Lineage Diagram
      | lineageNodeName | lineageNodeType |
      | Git             | Tag             |
    Then following items should "get" displayed in Lineage Diagram
      | lineageNodeName | lineageNodeType |
      | SampleBA        | Tag             |
    And user "click" on "Filter tags" for "BusinessApplication" in LineageDiagramming page
    Then following items should "not get" displayed in Lineage Diagram
      | lineageNodeName | lineageNodeType |
      | Git             | Tag             |
      | SampleBA        | Tag             |

  Scenario:Delete the created business application
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name     | type                | query | param |
      | MultipleIDDelete | Default | SampleBA | BusinessApplication |       |       |

  @git
  Scenario: Delete Plugin Configuration
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                              | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/credentials/GitCred                     |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS  |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/TestGitCollector |      |               |                  |          |
