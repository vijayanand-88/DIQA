@MLP-19184
Feature:MLP-19184 MLP-19382: This feature is to verify the improvements in the landing page and UI

  ##6981525##6981526##6981528##6981530##6981527##6981529##
  @MLP-19184 @webtest @regression @positive
  Scenario: SC1#:MLP-19184: Verify if First time user can see the Landing page
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-12929_SingleParam_false.json"
    When user makes a REST Call for POST request with url "settings/eula/accept"
    And Status code 204 must be returned
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user verifies "License panel" is "displayed" in "License page"
    And user "click" on "AGREE" button in "License page"
    And user verifies "Welcome message under settings icon" is "displayed" in "Welcome Page"
    And user verifies "Create new Business Application" is "displayed" in "Welcome page"
    And user verifies "Import Business Application via Excel file" is "displayed" in "Welcome page"
    And user verifies "List of Business Applications" is "displayed" in "Welcome page"
    And user verifies "Create a configuration and load new data" is "displayed" in "Welcome page"

  ##6981532##  ##Bug
  @MLP-19184 @webtest @regression @positive
  Scenario: SC2#:MLP-19184: Verify if clicking respective buttons from Landing page navigates to appropriate screen
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-12929_SingleParam_false.json"
    When user makes a REST Call for POST request with url "settings/eula/accept"
    And Status code 204 must be returned
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user verifies "License panel" is "displayed" in "License page"
    And user "click" on "AGREE" button in "License page"
    And user verifies "Welcome message under settings icon" is "displayed" in "Welcome Page"
    And user "click" on "Create new Business Application" button in "Welcome page"
    And user verifies the "Create" pop up is "displayed"
    And user "click" on "Close button" button in "Welcome page"
    And user "click" on "Yes" button in "welcome page"
    And user "click" on "Import Business Application via Excel file" button in "Welcome page"
    And user verifies the "Excel Importer" pop up is "displayed"

  ##6981533##6981534####6977958##6977959##6977961##6978519##
  @MLP-19184 @webtest @regression @positive
  Scenario: SC3#:MLP-19184: Verify if the User Profile screen > Default View is set as Home
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Credentials" in "Landing page"
    And user "click" on "Home Button" button in "Manage Credentials"
    And user verifies "Welcome message under settings icon" is "displayed" in "Welcome Page"
    And user "click" on "Create new Business Application" button in "Welcome page"
    And user "click" on "Popup Close" button in "Create BusinessApplication"
    And user clicks on "Yes" link in the "Edit Category popup"
    And user performs following actions in the header
      | actionType | actionItem    |
      | click      | Profile Image |
      | click      | Profile       |
    And user "Default Option selected" in "Profile Setting" Page
      | fieldName    | option |
      | Default View | Home   |
    And user performs following actions in the header
      | actionType         | actionItem  |
      | verifies displayed | Search Area |
    And user clicks on search icon
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user verifies "Catalog type" is "not displayed" in "Search Results"
    And user clicks on first item on the item list page
    And user verifies "Your Rating" is "displayed" in "above Average in Item view Page"
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem |
      | Click      | EditBAName |
    And user "Default BA Option selected" in "Item View" Page
      | fieldName            | option  |
      | Business Criticality | <empty> |

  @git
  Scenario: Create Datasource and Credentials and run GitCollector
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                             | username    | password    |
      | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | $..userName | $..password |
    And Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                | body                                                                 | response code | response message   | jsonPath |
      | application/json | raw   | false | Delete | settings/credentials/GitCred                       |                                                                      |               |                    |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS    |                                                                      |               |                    |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/GitCollectorConfig |                                                                      |               |                    |          |
      |                  |       |       | Put    | settings/credentials/GitCred                       | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | 200           |                    |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/GitDS    | idc/IDX_PluginPayloads/MLP-14102_GitCollector_DataSource_Config.json | 204           |                    |          |
      |                  |       |       | Put    | settings/analyzers/GitCollector/GitCollectorConfig | idc/IDX_PluginPayloads/MLP-15889_GitCollector_Plugin_Config.json     | 204           |                    |          |
      |                  |       |       | Get    | settings/analyzers/GitCollector/GitCollectorConfig |                                                                      | 200           | GitCollectorConfig |          |

  @git
  Scenario:Run GitCollector
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message   |
      | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |      | 200           | GitCollectorConfig |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorConfig  |      | 200           |                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |      | 200           | IDLE               |

  ##6978520##7015414##
  @MLP-19387 @MLP-20220 @webtest @regression @positive
  Scenario: SC4#:MLP-19387 MLP-20220: Verify the vertical and Horizontal bar is seen to view the log content
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem | attribute          |
      | LocalNode | Collector  | GitCollectorConfig |
    And user "click configuration menu buttons" in "Manage Configurations" Page
      | fieldName                           | option             |
      | Shows the logs of the configuration | GitCollectorConfig |
    And user verifies "Horizontal Bar for Log Viewer" is "displayed" in Manage Configurations panel
    And user verifies "Vertical Bar for Log Viewer" is "displayed" in Manage Configurations panel

  @git @precondition
  Scenario: Delete the Config
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                | body | response code | response message | jsonPath |
      | application/json | raw   | false | Delete | settings/credentials/GitCred                       |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS    |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/GitCollectorConfig |      |               |                  |          |

  ##6978521##
  @MLP-16758 @webtest @regression @positive
  Scenario:SC#5:MLP-16758: Verify the autocomplete drop down of search text is highlighted when moving using the key press and down
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "customer_i"
    And user verifies the background color of the page
      | StyleType | ColorCode           | Page               |
      | color     | rgba(84, 84, 84, 1) | Search Suggestions |