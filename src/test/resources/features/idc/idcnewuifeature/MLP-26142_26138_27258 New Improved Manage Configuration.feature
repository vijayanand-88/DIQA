@MLP-26142
Feature:MLP-26142 New Improved Manage Configuration with the existing and some additional functionalities in UX
  MLP-26138 New Improved Capture with New in UX
  MLP-27258  Assigned to BA field in Accordion Content in Capture Tab and same should be Hyper Link should Navigate to the Capture Tab in Item View Screen


  @MLP-26142 @webtest @regression @positive
  Scenario:MLP-26142:Configure Git
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                 | body                                                                                      | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/TestGitDS |                                                                                           |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/BAGitCollector      |                                                                                           |               |                  |          |
      |                  |       |       | Delete | settings/credentials/TestGitCredential              |                                                                                           |               |                  |          |
      |                  |       |       | Put    | settings/credentials/TestGitCredential              | idc/IDx_DataSource_Credentials_Payloads/MLP-14658_Username_Pasword_Credential_Config.json | 200           |                  |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/TestGitDS | idc/IDX_PluginPayloads/MLP-18457_GitCollector_DataSource_Config.json                      | 204           |                  |          |


  #7162854#7162856#7162860
  @MLP-26142 @webtest @regression @positive
  Scenario:MLP-26142:SC#1:verify the user have an option to add plugin configuration in manage configuration
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_511  |
    And user "click" on "Save and Open" button in "Create Item Page"
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "Verifies popup" is "displayed" for "Add Configuration to LocalNode"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName            | attribute         |
      | Type                 | Collector         |
      | Plugin               | GitCollector      |
      | Data Source          | TestGitDS         |
      | Credential           | TestGitCredential |
      | Business Application | Item_511          |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute      |
      | Name      | BAGitCollector |
    And user "click" on "Add attribute for Branch" button under "Filter" in Manage Configurations
    And user "click" on "Add entered attribute" button under "FILTERS" in Manage Configurations
    And user "click" on "Test Connection" button in "Add Configuration page"
    And user verifies "Successful datasource connection" is "displayed" in Add Configuration Page
    And user "click" on "ConfigSave" button in "Add Configuration page"

  #7162854#7162856#7162872#7162874#7162868#7162876#7162878
  @MLP-26142 @webtest @regression @positive
  Scenario:MLP-26142:SC#2:verify the user have an option to verify new ui in manage configuration
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem | attribute      |
      | LocalNode | Collector  | BAGitCollector |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                  | ItemName                                                                                                                                                     | Section        |
      | Plugin Configuration Accordion | Data Content                | No data has yet been captured with this configuration                                                                                                        |                |
      | Plugin Configuration Accordion | Verify Header Menu options  | Shows the logs of the configuration,Clone the configuration,Edit the configuration,Schedule the configuration,Delete the configuration,Run the configuration | BAGitCollector |
      | Plugin Configuration Accordion | Verify accordion Icon       | BAGitCollector                                                                                                                                               | GitCollector   |
      | Plugin Configuration Accordion | Verify Configuration Header | Collector                                                                                                                                                    | 128, 128, 128  |
    Then user "verify presence" of following "Plugin accordion labels under Data Tab" in Item View Page
      | Data:                             |
      | Status:                           |
      | Number of Data Elements:          |
      | Last execution:                   |
      | Assigned to Business Application: |
      | Used in Pipelines:                |
      | Scheduled:                        |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem                        | ItemName |
      | Verify Plugin Configuration Values | Status                            | Idle     |
      | Verify Plugin Configuration Values | Number of Data Elements           | N/A      |
      | Verify Plugin Configuration Values | Last execution                    | N/A      |
      | Verify Plugin Configuration Values | Assigned to Business Application: | Item_511 |
      | Verify Plugin Configuration Values | Used in Pipelines:                | N/A      |

  #7162854#7162856#7162867
  @MLP-26142 @webtest @regression @positive
  Scenario:MLP-26142:SC#3:verify plugin status when it is running
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem   | attribute      |
      | LocalNode | GitCollector | BAGitCollector |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem                | ItemName              | Section        |
      | Plugin Configuration Accordion     | Click Header Menu options | Run the configuration | BAGitCollector |
      | Verify Plugin Configuration Values | Status                    | Running..             |                |

  #7162854#7162856#7162859#7162868#7162872#7162874
  @MLP-26142 @webtest @regression @positive
  Scenario:MLP-26142:SC#4:verify accordion present with label, links and Logs
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem   | attribute      |
      | LocalNode | GitCollector | BAGitCollector |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem                       | ItemName                |
      | Verify Plugin Configuration Values | Status                           | Idle                    |
      | Verify Plugin Configuration Values | Number of Data Elements          | 42                      |
      | Verify Plugin Configuration Values | Last execution                   |                         |
      | Verify Plugin Configuration Values | Data                             | bar-chart               |
      | Verify Plugin Configuration Values | Assigned to Business Application | Item_511                |
      | Verify Plugin Configuration Values | Used in Pipelines                | N/A                     |
      | Plugin Configuration Accordion     | Store Dataelements Count         | Number of Data Elements |
    And user "click" on "Show the data elements in a list link" for "BAGitCollector" in "Item View" page
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                                      | ItemName |
      | Plugin Configuration Accordion | Verify accordion item and Search count are same |          |
    And user enters the search text "Item_511" and clicks on search
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name    | facet         | Tag          | fileName           | userTag |
      | Default     | Project | Metadata Type | Item_511,Git | pythonanalyzerdemo |         |
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem   | attribute      |
      | LocalNode | GitCollector | BAGitCollector |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                | ItemName                            | Section        |
      | Plugin Configuration Accordion | Click Header Menu options | Shows the logs of the configuration | BAGitCollector |
    And user verifies "Log Viewer" is "displayed" in Manage Configurations panel

  #7162854#7162856#
  @MLP-26142 @webtest @regression @positive
  Scenario:MLP-26142:SC#5:verify accordion present and able to click on schedule plugin
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem   | attribute      |
      | LocalNode | GitCollector | BAGitCollector |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                | ItemName                   | Section        |
      | Plugin Configuration Accordion | Click Header Menu options | Schedule the configuration | BAGitCollector |
    And user "Verifies popup" is "displayed" for "Configure Schedule"

  #7162854#7162856#7162866
  @MLP-26142 @webtest @regression @positive
  Scenario:MLP-26142:SC#6:verify accordion present and able to click on delete plugin
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem   | attribute      |
      | LocalNode | GitCollector | BAGitCollector |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                | ItemName                 | Section        |
      | Plugin Configuration Accordion | Click Header Menu options | Delete the configuration | BAGitCollector |
    And user "click" on "DELETE" button in "Delete Configuration"
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "verify not displayed" of following "plugin list" in Manage Configurations Page
      | BAGitCollector |
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem        | ItemName       |
      | Plugin Configuration Accordion | Accordion absence | BAGitCollector |

  @MLP-26142 @regression @positive
  Scenario:User deletes the item from database
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                    | type            | query | param |
      | SingleItemDelete | Default | collector/GitCollector/BAGitCollector/% | Analysis        |       |       |
      | SingleItemDelete | Default | pythonanalyzerdemo                      | Project         |       |       |
      | SingleItemDelete | Default | GitCollector:BAGitCollector             | AnalysisDetails |       |       |

  #7162854#7162862#
  @MLP-26142 @webtest @regression @positive
  Scenario:MLP-26142:SC#6.1:verify user have an option to Edit the plugin configuration through mananage configuration
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "Verifies popup" is "displayed" for "Add Configuration to LocalNode"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName            | attribute         |
      | Type                 | Collector         |
      | Plugin               | GitCollector      |
      | Data Source          | TestGitDS         |
      | Credential           | TestGitCredential |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute      |
      | Name      | BAGitCollector |
    And user "click" on "Add attribute for Branch" button under "Filter" in Manage Configurations
    And user "click" on "Add entered attribute" button under "FILTERS" in Manage Configurations
    And user "click" on "Test Connection" button in "Add Configuration page"
    And user verifies "Successful datasource connection" is "displayed" in Add Configuration Page
    And user "click" on "ConfigSave" button in "Add Configuration page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem         | ItemName       |
      | Plugin Configuration Accordion | Accordion presence | BAGitCollector |
      | Plugin Configuration Accordion | Expand Accordion   | BAGitCollector |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                | ItemName               | Section        |
      | Plugin Configuration Accordion | Click Header Menu options | Edit the configuration | BAGitCollector |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName            | attribute         |
      | Business Application | Item_511          |
    And user "click" on "Test Connection" button in "Add Configuration page"
    And user verifies "Successful datasource connection" is "displayed" in Add Configuration Page
    And user "click" on "ConfigSave" button in "Add Configuration page"


  #7162854#7162856#7162867
  @MLP-26142 @webtest @regression @positive
  Scenario:MLP-26142:SC#7:verify the Plugin status is running after the configuration is edited
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem   | attribute      |
      | LocalNode | GitCollector | BAGitCollector |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem                | ItemName              | Section        |
      | Plugin Configuration Accordion     | Click Header Menu options | Run the configuration | BAGitCollector |
      | Verify Plugin Configuration Values | Status                    | Running..             |                |

  #7162854#7162856#7162857#7162868
  @MLP-26142 @webtest @regression @positive
  Scenario:MLP-26142:SC#8:verify the plugin accordion information after the pluign run
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem   | attribute      |
      | LocalNode | GitCollector | BAGitCollector |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem                       | ItemName                |
      | Verify Plugin Configuration Values | Status                           | Idle                    |
      | Verify Plugin Configuration Values | Number of Data Elements          | 42                      |
      | Verify Plugin Configuration Values | Last execution                   |                         |
      | Verify Plugin Configuration Values | Data                             | bar-chart               |
      | Verify Plugin Configuration Values | Assigned to Business Application | Item_511                |
      | Verify Plugin Configuration Values | Used in Pipeline                 | N/A                     |
      | Plugin Configuration Accordion     | Store Dataelements Count         | Number of Data Elements |

  #7162854#7162856#7162864
  @MLP-26142 @webtest @regression @positive
  Scenario:MLP-26142:SC#9:verify user able to clone the plugin configuration in manage configuration
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem   | attribute      |
      | LocalNode | GitCollector | BAGitCollector |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                | ItemName                | Section        |
      | Plugin Configuration Accordion | Click Header Menu options | Clone the configuration | BAGitCollector |
    And user "click" on "Test Connection" button in "Add Configuration page"
    And user verifies "Successful datasource connection" is "displayed" in Add Configuration Page
    And user "click" on "ConfigSave" button in "Add Configuration page"

  #7162854#7162856#7162864#7162868#7162876#7162878
  @MLP-26142 @webtest @regression @positive
  Scenario:MLP-26142:SC#10:verify accordion UI after Configuration clone
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem   | attribute           |
      | LocalNode | GitCollector | BAGitCollector Copy |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                  | ItemName                                                                                                                                                     | Section        |
      | Plugin Configuration Accordion | Data Content                | No data has yet been captured with this configuration                                                                                                        |                |
      | Plugin Configuration Accordion | Verify Header Menu options  | Shows the logs of the configuration,Clone the configuration,Edit the configuration,Schedule the configuration,Delete the configuration,Run the configuration | BAGitCollector |
      | Plugin Configuration Accordion | Verify accordion Icon       | BAGitCollector                                                                                                                                               | GitCollector   |
      | Plugin Configuration Accordion | Verify Configuration Header | Collector                                                                                                                                                    | 128, 128, 128  |
    Then user "verify presence" of following "Plugin accordion labels under Data Tab" in Item View Page
      | Data                              |
      | Status                            |
      | Number of Data Elements           |
      | Last execution                    |
      | Assigned to Business Application: |
      | Used in Pipelines:                |
      | Scheduled                         |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem                        | ItemName |
      | Verify Plugin Configuration Values | Status                            | Idle     |
      | Verify Plugin Configuration Values | Number of Data Elements           | N/A      |
      | Verify Plugin Configuration Values | Last execution                    | N/A      |
      | Verify Plugin Configuration Values | Assigned to Business Application: | Item_511 |
      | Verify Plugin Configuration Values | Used in Pipelines:                | N/A      |

  #7162854#7162856#7162866
  @MLP-26142 @webtest @regression @positive
  Scenario:MLP-26142:SC#11:verify user able to delete the plugin from manage configuration
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem   | attribute      |
      | LocalNode | GitCollector | BAGitCollector |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                | ItemName                 | Section        |
      | Plugin Configuration Accordion | Click Header Menu options | Delete the configuration | BAGitCollector |

  #7162854#7162856#7162866
  @MLP-26142 @webtest @regression @positive
  Scenario:MLP-26142:SC#12:verify user able to delete the plugin from manage configuration
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem   | attribute           |
      | LocalNode | GitCollector | BAGitCollector Copy |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                | ItemName                 | Section             |
      | Plugin Configuration Accordion | Click Header Menu options | Delete the configuration | BAGitCollector Copy |
    And user "click" on "DELETE" button in "Delete Configuration"


    #7162869
  @MLP-26142 @webtest @regression @positive
  Scenario:MLP-26142:SC#13: verify able to search for the plugin
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "SearchConfiguration" button under "LocalNode" in Manage Configurations
    And User performs following actions in the Item view Page
      | Actiontype             | ActionItem     |
      | Search In Node         | BAGitCollector |
      | Verify Config Presence | BAGitCollector |


    #7162854#7162856#7162872#7162874#7162868#7162876#7162878
  @MLP-26142 @webtest @regression @positive
  Scenario:MLP-26142:SC#14:verify the Business application is set as link in manage configuration
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem | attribute      |
      | LocalNode | Collector  | BAGitCollector |
    And user "click" on "Assigned to Business Application" for "Item_511" in "Item View" page
    And user "verifies presence" of following "Admin page Title" in "" page
      | Item_511 |


   #7192225#7192227#7192229#7192230#7192231#7192234
  @MLP-27258 @webtest @regression @positive
  Scenario:MLP-27258:SC#15:verify the Business application is set as link in manage configuration, Assign exisiting config in captire Tab
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Item_511" item from search results
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem       | ItemName       | Section |
      | Plugin Configuration Accordion | Expand Accordion | BAGitCollector |         |
    Then user "verify non presence" of following "Plugin accordion labels under Data Tab" in Item View Page
      | Assigned to Business Application: |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                 | ItemName                   | Section        |
      | Plugin Configuration Accordion | Verify Header Menu options | Unassign the configuration | BAGitCollector |
      | Plugin Configuration Accordion | Click Header Menu options  | Unassign the configuration | BAGitCollector |
      | Click                          | Unassignconfig             | UNASSIGN                   |                |
    And user "click" on "Assign existing configuration" button in "Item View page"
    And user "Verifies popup" is "displayed" for "Assign existing Configuration to Business Application"

  @MLP-26142 @regression @positive
  Scenario: Delete the Configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                 | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/credentials/TestGitCredential              |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/TestGitDS |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/BAGitCollector      |      |               |                  |          |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name     | type                | query | param |
      | SingleItemDelete | Default | Item_511 | BusinessApplication |       |       |

  @MLP-26142 @regression @positive
  Scenario:User deletes the item from database
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                    | type            | query | param |
      | SingleItemDelete | Default | collector/GitCollector/BAGitCollector/% | Analysis        |       |       |
      | SingleItemDelete | Default | pythonanalyzerdemo                      | Project         |       |       |
      | SingleItemDelete | Default | GitCollector:BAGitCollector             | AnalysisDetails |       |       |


  #7162831
  @MLP-26138 @webtest @regression @positive
  Scenario:MLP-26138:Configure Git
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                 | body                                                                                      | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/TestGitDS |                                                                                           |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/BAGitCollector      |                                                                                           |               |                  |          |
      |                  |       |       | Delete | settings/credentials/TestGitCredential              |                                                                                           |               |                  |          |
      |                  |       |       | Put    | settings/credentials/TestGitCredential              | idc/IDx_DataSource_Credentials_Payloads/MLP-14658_Username_Pasword_Credential_Config.json | 200           |                  |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/TestGitDS | idc/IDX_PluginPayloads/MLP-18457_GitCollector_DataSource_Config.json                      | 204           |                  |          |

    ##7162831#7162832#7162833
  @MLP-26138 @webtest @regression @positive
  Scenario:MLP-26138:SC#1:verify the user have an option to add plugin configuration under Data Tab in business application
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_511  |
    And user "click" on "Save and Open" button in "Create Item Page"
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                                                   |
      | Verify Data Tab Label Presence | No data have yet been captured for this business application |
    And user "click" on "Capture new data" button in "Item View page"
    And user "Verifies popup" is "displayed" for "Add Configuration to Business Application"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute         |
      | Node        | LocalNode         |
      | Type        | Collector         |
      | Plugin      | GitCollector      |
      | Data Source | TestGitDS         |
      | Credential  | TestGitCredential |
    And user verifies the "Default BA Option selected" for "" in Add Manage Configuration Page
      | Item_511 |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute      |
      | Name      | BAGitCollector |
    And user "click" on "Add attribute for Branch" button under "Filter" in Manage Configurations
    And user "click" on "Add entered attribute" button under "FILTERS" in Manage Configurations
    And user "click" on "Test Connection" button in "Add Configuration page"
    And user verifies "Successful datasource connection" is "displayed" in Add Configuration Page
    And user "click" on "ConfigSave" button in "Add Configuration page"
    And user verifies whether "Item view page title" is "displayed" for "Item_511" Item view page

    ##7162831#7162832#7162833
  @MLP-26138 @webtest @regression @positive
  Scenario:MLP-26138:SC#2:Verify the popup title should be displayed as "Add Configurations to {node name}" when user navigates to add configuration page via Manage Configurations
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


    ##7162831#7162832#7162833#7162848
  @MLP-26138 @webtest @regression @positive
  Scenario:MLP-26138:SC#3:Verify user can able to add a configuration for the Business Application and the captured data is displayed under the BA Item view
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And user verifies whether "Item view page title" is "displayed" for "Item_511" Item view page
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                     | ItemName                                                                                                                                                     | Section        |
      | Plugin Configuration Accordion | Verify Accordion Plugin Status | BAGitCollector                                                                                                                                               | Status:        |
      | Plugin Configuration Accordion | Accordion presence             | BAGitCollector                                                                                                                                               |                |
      | Plugin Configuration Accordion | Expand Accordion               | BAGitCollector                                                                                                                                               |                |
      | Plugin Configuration Accordion | Data Content                   | No data has yet been captured with this configuration                                                                                                        |                |
      | Plugin Configuration Accordion | Verify Header Menu options     | Shows the logs of the configuration,Clone the configuration,Edit the configuration,Unassign the configuration,Delete the configuration,Run the configuration | BAGitCollector |
      | Plugin Configuration Accordion | Verify accordion Icon          | BAGitCollector                                                                                                                                               | GitCollector   |
    Then user "verify presence" of following "Plugin accordion labels under Data Tab" in Item View Page
      | Data                                                    |
      | Status                                                  |
      | No. of Data Elements captured for Business Application: |
      | Last execution                                          |
      | Used in Pipelines:                                      |
      | Scheduled                                               |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem                                              | ItemName |
      | Verify Plugin Configuration Values | Status                                                  | Idle     |
      | Verify Plugin Configuration Values | No. of Data Elements captured for Business Application: | N/A      |
      | Verify Plugin Configuration Values | Last execution                                          | N/A      |
      | Verify Plugin Configuration Values | Used in Pipelines:                                      | N/A      |
    And user "click" on "Capture new data" button in "Item View page"
    And user "Verifies popup" is "displayed" for "Add Configuration to Business Application"

    ##7162831#7162832#7162833#7162839
  @MLP-26138 @webtest @regression @positive
  Scenario:MLP-26138:SC#4:Verify after the successful execution, all the details should be updated in the accordion
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
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

    ##7162831#7162832#7162833
  @MLP-26138 @webtest @regression @positive
  Scenario:MLP-26138:SC#5: Verify link "Show the data elements in a list link" and clicking on the list takes the user to the Search Results with the data elements for the respective plugin
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem         | ItemName       |
      | Plugin Configuration Accordion | Accordion presence | BAGitCollector |
      | Plugin Configuration Accordion | Expand Accordion   | BAGitCollector |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem                                              | ItemName  |
      | Verify Plugin Configuration Values | Status                                                  | Idle      |
      | Verify Plugin Configuration Values | No. of Data Elements captured for Business Application: | 42        |
      | Verify Plugin Configuration Values | Last execution                                          |           |
      | Verify Plugin Configuration Values | Data                                                    | bar-chart |
      | Verify Plugin Configuration Values | Used in Pipelines                                       | N/A       |
    And user "click" on "Show the data elements in a list link" for "BAGitCollector" in "Item View" page
    And user enters the search text "Item_511" and clicks on search
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name    | facet         | Tag          | fileName           | userTag |
      | Default     | Project | Metadata Type | Item_511,Git | pythonanalyzerdemo |         |
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                | ItemName                            | Section        |
      | Plugin Configuration Accordion | Click Header Menu options | Shows the logs of the configuration | BAGitCollector |
    And user verifies "Log Viewer" is "displayed" in Manage Configurations panel


    #7162835#7162836
  @MLP-26138 @webtest @regression @positive
  Scenario:MLP-26138:SC#6:Verify after the successful execution, all the details should be updated in the accordion
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem         | ItemName       |
      | Plugin Configuration Accordion | Accordion presence | BAGitCollector |
      | Plugin Configuration Accordion | Expand Accordion   | BAGitCollector |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                | ItemName               | Section        |
      | Plugin Configuration Accordion | Click Header Menu options | Edit the configuration | BAGitCollector |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute      |
      | Label     | BAGitCollector |
    And user "click" on "Test Connection" button in "Add Configuration page"
    And user verifies "Successful datasource connection" is "displayed" in Add Configuration Page
    And user "click" on "ConfigSave" button in "Add Configuration page"


    #7162837#7162838
  @MLP-26138 @webtest @regression @positive
  Scenario:MLP-26138:SC#7:Verify after the successful execution, all the details should be clone in the accordion
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem         | ItemName       |
      | Plugin Configuration Accordion | Accordion presence | BAGitCollector |
      | Plugin Configuration Accordion | Expand Accordion   | BAGitCollector |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                | ItemName                | Section        |
      | Plugin Configuration Accordion | Click Header Menu options | Clone the configuration | BAGitCollector |
    And user "click" on "Test Connection" button in "Add Configuration page"
    And user verifies "Successful datasource connection" is "displayed" in Add Configuration Page
    And user "click" on "ConfigSave" button in "Add Configuration page"

    #7162837#7162838
  @MLP-26138 @webtest @regression @positive
  Scenario:MLP-26138:SC#8:Verify user can delete the plugin configuration with the option provided in the accordion header
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                | ItemName                 | Section             |
      | Plugin Configuration Accordion | Expand Accordion          | BAGitCollector Copy      |                     |
      | Plugin Configuration Accordion | Click Header Menu options | Delete the configuration | BAGitCollector Copy |
    And user "click" on "DELETE" button in "Delete Configuration"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem        | ItemName            |
      | Plugin Configuration Accordion | Accordion absence | BAGitCollector Copy |

    #7162834#7162841#7162843#7162846#7162848
  @MLP-26138 @webtest @regression @positive
  Scenario:MLP-26138:SC#9:Verify user can delete the plugin configuration with the option provided in the accordion header
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
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

    #7162834#7162841#7162843#7162846#7162848
  @MLP-26138 @webtest @regression @positive
  Scenario:MLP-26138:SC#10:Verify the Put call /settings/analyzers/{pluginname}/{configurationname} for the config created via BusinessApplication has new parameter startwith and the value for that should be "node"
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

  @MLP-26138 @regression @positive
  Scenario: Delete the Configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                 | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/credentials/TestGitCredential              |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/TestGitDS |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/BAGitCollector      |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/SampleGitCollector  |      |               |                  |          |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name     | type                | query | param |
      | SingleItemDelete | Default | Item_511 | BusinessApplication |       |       |


  @MLP-26138 @regression @positive
  Scenario:User deletes the item from database
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                    | type            | query | param |
      | SingleItemDelete | Default | collector/GitCollector/BAGitCollector/% | Analysis        |       |       |
      | SingleItemDelete | Default | pythonanalyzerdemo                      | Project         |       |       |
      | SingleItemDelete | Default | GitCollector:BAGitCollector             | AnalysisDetails |       |       |