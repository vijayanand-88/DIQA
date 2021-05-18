@MLP-18457 @MLP-24985 @MLP-24987
Feature:A_MLP-18457:MLP-18458: This feature is to verify Data Tab in Business Application

  @MLP-24985 @regression @positive
  Scenario:MLP-24985:Configure Git
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                 | body                                                                                      | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/TestGitDS |                                                                                           |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/BAGitCollector      |                                                                                           |               |                  |          |
      |                  |       |       | Delete | settings/credentials/TestGitCredential              |                                                                                           |               |                  |          |
      |                  |       |       | Put    | settings/credentials/TestGitCredential              | idc/IDx_DataSource_Credentials_Payloads/MLP-14658_Username_Pasword_Credential_Config.json | 200           |                  |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/TestGitDS | idc/IDX_PluginPayloads/MLP-18457_GitCollector_DataSource_Config.json                      | 204           |                  |          |

    ##7134262##7134263##7134264##7134265##7134268##7134269##7134270##7134271##7208166##
  @MLP-24985 @webtest @regression @positive @e2e
  Scenario:MLP-24985:SC#1:verify the user have an option to add plugin configuration under Data Tab in business application
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute   |
      | Item Name | SampleGitBA |
    And user "click" on "Save and Open" button in "Create Item Page"
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                                                   |
      | Verify Data Tab Label Presence | No data have yet been captured for this business application |
    And user "click" on "Add Plugin Configuration button" button in "Item View page"
    And user "Verifies popup" is "displayed" for "Add Configuration to Business Application"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute         |
      | Node        | LocalNode         |
      | Type        | Collector         |
      | Plugin      | GitCollector      |
      | Data Source | TestGitDS         |
      | Credential  | TestGitCredential |
    And user verifies the "Default BA Option selected" for "" in Add Manage Configuration Page
      | SampleGitBA |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute      |
      | Name      | BAGitCollector |
    And user "click" on "Add attribute for Branch" button under "Filter" in Manage Configurations
    And user "click" on "Add entered attribute" button under "FILTERS" in Manage Configurations
    And user "click" on "Test Connection" button in "Add Configuration page"
    And user verifies "Successful datasource connection" is "displayed" in Add Configuration Page
    And user "click" on "ConfigSave" button in "Add Configuration page"
    And user verifies whether "Item view page title" is "displayed" for "SampleGitBA" Item view page

      ##7134272##7134273##
  @MLP-24985 @webtest @regression @positive
  Scenario:MLP-24985:SC#2:Verify the popup title should be displayed as "Add Configurations to {node name}" when user navigates to add configuration page via Manage Configurations
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "Verifies popup" is "displayed" for "Add Configuration to LocalNode"
    And user "verifies not presence" of following "Add Configuration Popup fields" in Manage Configurations Page
      | Node |

    ##7134274##7134278##7134279####7134280##7134281##7134282##7134284##7134285##7204336##
  @MLP-24987 @webtest @regression @positive @e2e
  Scenario:MLP-24987:SC#1:Verify user can able to add a configuration for the Business Application and the captured data is displayed under the BA Item view
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "SampleGitBA" and clicks on search
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And user verifies whether "Item view page title" is "displayed" for "SampleGitBA" Item view page
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                     | ItemName                                                                                                                                                     | Section        |
      | Plugin Configuration Accordion | Verify Accordion Plugin Status | BAGitCollector                                                                                                                                               | warning        |
      | Plugin Configuration Accordion | Accordion presence             | BAGitCollector                                                                                                                                               |                |
      | Plugin Configuration Accordion | Expand Accordion               | BAGitCollector                                                                                                                                               |                |
      | Plugin Configuration Accordion | Data Content                   | No data has yet been captured with this configuration                                                                                                        |                |
      | Plugin Configuration Accordion | Verify Header Menu options     | Shows the logs of the configuration,Clone the configuration,Edit the configuration,Unassign the configuration,Delete the configuration,Run the configuration | BAGitCollector |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem                                             | ItemName |
      | Verify Plugin Configuration Values | Status                                                 | Idle     |
      | Verify Plugin Configuration Values | No. of Data Elements captured for Business Application | N/A      |
      | Verify Plugin Configuration Values | Last execution                                         | N/A      |
      | Verify Plugin Configuration Values | Used in Pipelines                                      | N/A      |
      | Verify Plugin Configuration Values | Scheduled                                              | N/A      |
    And user "click" on "Capture new data" button in "Item View page"
    And user "Verifies popup" is "displayed" for "Add Configuration to Business Application"

      ##7134286##7134287##7134288##7134289##7134290##7134291##
  @MLP-24987 @webtest @regression @positive @e2e
  Scenario:MLP-24987:SC#2:Verify after the successful execution, all the details should be updated in the accordion
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "SampleGitBA" and clicks on search
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem         | ItemName       |
      | Plugin Configuration Accordion | Accordion presence | BAGitCollector |
      | Plugin Configuration Accordion | Expand Accordion   | BAGitCollector |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem                | ItemName              | Section        |
      | Plugin Configuration Accordion     | Click Header Menu options | Run the configuration | BAGitCollector |
      | Verify Plugin Configuration Values | Status                    | Running..             |                |

      ##7134292##7134294##7134296####7134297##7134298##7204337##
  @MLP-24987 @webtest @regression @positive
  Scenario:MLP-24987:SC#3: Verify link "Show the data elements in a list" and clicking on the list takes the user to the Search Results with the data elements for the respective plugin
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "SampleGitBA" and clicks on search
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem         | ItemName       |
      | Plugin Configuration Accordion | Accordion presence | BAGitCollector |
      | Plugin Configuration Accordion | Expand Accordion   | BAGitCollector |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem                                             | ItemName                                               |
      | Verify Plugin Configuration Values | Status                                                 | Idle                                                   |
      | Verify Plugin Configuration Values | No. of Data Elements captured for Business Application | 42                                                     |
      | Verify Plugin Configuration Values | Last execution after plugin run                        |                                                        |
      | Plugin Configuration Accordion     | Store Dataelements Count                               | No. of Data Elements captured for Business Application |
    And user "click" on "Show the data elements in a list link" for "Collector for BAGITcollector" in "Item View" page
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                                      | ItemName |
      | Plugin Configuration Accordion | Verify accordion item and Search count are same |          |
    And user enters the search text "SampleGitBA" and clicks on search
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag             | fileName | userTag |
      | Default     | Directory | Metadata Type | SampleGitBA,Git | java     |         |
    And user enters the search text "SampleGitBA" and clicks on search
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                | ItemName                            | Section        |
      | Plugin Configuration Accordion | Click Header Menu options | Shows the logs of the configuration | BAGitCollector |
    And user verifies "Log Viewer" is "displayed" in Manage Configurations panel

  ##7208169##7208170##7208171##7208173##
  @MLP-24987 @webtest @regression @positive
  Scenario:MLP-27838:SC#4:Verify after the successful plugin run, user should see the tabular view of data displayed for the plugin configuration inside the accordion in the Manage Configuration screen
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "SampleGitBA" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem       | ItemName       |
      | Plugin Configuration Accordion | Expand Accordion | BAGitCollector |
      | Verify Tabular View            | Data             |                |
      | Verify Data table              | Column Names     | Name,Count     |
      | Verify Data table Column Value | File             | 35             |
      | Verify Data table Column Value | Project          | 1              |
      | Verify Data table Column Value | Analysis         | 1              |
      | Verify Data table Column Value | Directory        | 5              |
      | Verify the Sorting Order       | Ascending        | Name           |
      | Verify the Sorting Order       | Descending       | Name           |
    And user enters the search text "SampleGitBA" and clicks on search
    And user performs "facet selection" in "Git" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user "click" on "firstItemCheckbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Business Applications" in "Search results page"
    And User performs following actions in the "Assign a Business Application" popup
      | Actiontype                        | ActionItem  | Section  |
      | Remove tagged item in the Section | SampleGitBA | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"
    And user enters the search text "SampleGitBA" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem | ItemName |
      | Verify Data table Column Value | File       | 34       |

  ##7204338##7204339##7204340##
  @MLP-26962 @webtest @regression @positive
  Scenario:MLP-26962:SC#5:Verify after successful run, when few items are untagged in the search results for the particular BA then in the capture tab the removed items should be reflected in the data elements count
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "SampleGitBA" and clicks on search
    And user performs "facet selection" in "Git" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Business Applications" in "Search results page"
    And User performs following actions in the "Assign a Business Application" popup
      | Actiontype                        | ActionItem  | Section  |
      | Remove tagged item in the Section | SampleGitBA | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"
    And user enters the search text "SampleGitBA" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem       | ItemName       |
      | Plugin Configuration Accordion | Expand Accordion | BAGitCollector |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem                                             | ItemName                                               |
      | Verify Plugin Configuration Values | No. of Data Elements captured for Business Application | 36                                                     |
      | Verify Plugin Configuration Values | Missing Chart type                                     | Directory                                              |
      | Plugin Configuration Accordion     | Store Dataelements Count                               | No. of Data Elements captured for Business Application |
    And user "click" on "Show the data elements in a list link" for "BAGitCollector" in "Item View" page
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                                      | ItemName |
      | Plugin Configuration Accordion | Verify accordion item and Search count are same |          |
    Then user "verify non presence" of following "metadata list not contains" in Item Search Results Page
      | Directory |

  ##7204341##
  @MLP-26962 @webtest @regression @positive
  Scenario:MLP-26962:SC#6: Verify the capture tab accordion pattern and manage configurations accordion pattern should not be same
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem | attribute      |
      | LocalNode | Collector  | BAGitCollector |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem              | ItemName |
      | Verify Plugin Configuration Values | Number of Data Elements | 42       |

    ##7134299##7134300##
  @MLP-24987 @webtest @regression @positive
  Scenario:MLP-24987:SC#7:Verify user can delete the plugin configuration with the option provided in the accordion header
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "SampleGitBA" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                | ItemName                 | Section        |
      | Plugin Configuration Accordion | Expand Accordion          | BAGitCollector           |                |
      | Plugin Configuration Accordion | Click Header Menu options | Delete the configuration | BAGitCollector |
    And user "click" on "DELETE" button in "Delete Configuration"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem        | ItemName       |
      | Plugin Configuration Accordion | Accordion absence | BAGitCollector |
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "verify not displayed" of following "plugin list" in Manage Configurations Page
      | BAGitCollector |

    ##7134301##
  @MLP-24987 @webtest @regression @positive
  Scenario:MLP-18457:SC#8:Verify the Put call /settings/analyzers/{pluginname}/{configurationname} for the config created via BusinessApplication has new parameter startwith and the value for that should be "node"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                | body                                                                           | response code | response message | jsonPath |
      | application/json |       |       | Put  | settings/analyzers/GitCollector/SampleGitCollector | idc/IDX_PluginPayloads/MLP_24987_GitCollector_with_StartWith_Param_Config.json | 204           |                  |          |
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "SampleGitBA" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem         | ItemName           |
      | Plugin Configuration Accordion | Accordion presence | SampleGitCollector |

  @MLP-18457 @regression @positive
  Scenario: Delete the Configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                 | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/credentials/TestGitCredential              |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/TestGitDS |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/BAGitCollector      |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/SampleGitCollector  |      |               |                  |          |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name        | type                | query | param |
      | SingleItemDelete | Default | SampleGitBA | BusinessApplication |       |       |