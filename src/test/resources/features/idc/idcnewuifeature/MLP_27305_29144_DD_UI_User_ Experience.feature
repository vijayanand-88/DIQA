@MLPQA-17918 @MLP-27305 @MLP-29144 @MLP-29100 @MLP-29110 @MLP-29063 @MLP-29533 @MLP-13757 @MLP-14096
Feature:MLP-27305 MLP-29144 MLP-29100: To verify the User Experience of the ui functions and the sort functionality in popup and dropdown functions

  ##7190906##7190908##7190909##7190920##
  @MLP-27305 @webtest @regression @positive
  Scenario:MLP-27305:SC#1:Verify by default the Numeric sort is active in the Search results page and the Alpha sort should be inactive for the Metadata facet
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And User performs following actions in the Facets in Search Results Page
      | Actiontype                 | ActionItem    | ItemName |
      | Verify sort is active      | Metadata Type | Numeric  |
      | Verify sort is inactive    | Metadata Type | Alpha    |
      | Verify order is Descending | Metadata Type | Numeric  |
      | Click Sort                 | Metadata Type | Numeric  |
      | Verify order is Ascending  | Metadata Type | Numeric  |
      | Click Sort                 | Metadata Type | Numeric  |
      | Verify order is Descending | Metadata Type | Numeric  |
      | Click Sort                 | Metadata Type | Alpha    |
      | Verify sort is active      | Metadata Type | Alpha    |
      | Verify sort is inactive    | Metadata Type | Numeric  |

  ##7190910##7190913##7190917##7190919##7190922##
  @MLP-27305 @webtest @regression @positive
  Scenario:MLP-27305:SC#2:Verify the active Alpha sort should be in the Ascending order by default
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And User performs following actions in the Facets in Search Results Page
      | Actiontype                 | ActionItem    | ItemName |
      | Click Sort                 | Metadata Type | Alpha    |
      | Verify order is Ascending  | Metadata Type | Alpha    |
      | Click Sort                 | Metadata Type | Alpha    |
      | Verify order is Descending | Metadata Type | Alpha    |
      | Click Sort                 | Metadata Type | Alpha    |
      | Verify order is Ascending  | Metadata Type | Alpha    |
    And user performs "click" in "Show More Button" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet Show button presence" in "Show Relevant Button" attribute under "Metadata Type" facets in Item Search results page
    And User performs following actions in the Facets in Search Results Page
      | Actiontype | ActionItem    | ItemName |
      | Click Sort | Metadata Type | Numeric  |
    And user performs "facet Show button presence" in "Show Relevant Button" attribute under "Metadata Type" facets in Item Search results page
    And User performs following actions in the Facets in Search Results Page
      | Actiontype                 | ActionItem    | ItemName      |
      | Verify order is Descending | Metadata Type | Numeric       |
      | Verify sort absence        | Rating        | Alpha         |
      | Verify sort is inactive    | Rating        | Numeric       |
      | Click Sort                 | Rating        | Numeric       |
      | Verify order is Descending | Rating        | Numeric       |
      | Verify sort absence        | Tags          | Alpha,Numeric |
      | Verify sort absence        | Hierarchy     | Alpha,Numeric |

    #7234542#7234533##7234535##7234537##7234539##7234541##
  @MLP-29144 @webtest @regression @positive
  Scenario:MLP-29144:SC#1:Verify the sort option is available in the Assign/ Un Assign Tags as mentioned in above steps
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option        |
      | BusinessApplication | SampleBA  | Save and Open |
    And user enters the search text "SampleBA" and clicks on search
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Tags" in "Search results page"
    And User performs following actions in the "Assign/Unassign Tags" popup
      | Actiontype             | ActionItem | Section   |
      | verifies sorting order | Default    | Available |
    And User performs following actions in the Item view Page
      | Actiontype    | ActionItem   | Section   |
      | Tag Selection | Gender       | Available |
      | Tag Selection | Last Name    | Available |
      | Tag Selection | Phone Number | Available |
      | Tag Selection | Full Name    | Available |
      | Tag Selection | IP Address   | Available |
      | Sort Section  | Ascending    | Available |
    And User performs following actions in the "Assign/Unassign Tags" popup
      | Actiontype             | ActionItem | Section   |
      | verifies sorting order | Ascending  | Available |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem | Section   |
      | Sort Section | Descending | Available |
    And User performs following actions in the "Assign/Unassign Tags" popup
      | Actiontype             | ActionItem | Section   |
      | verifies sorting order | Descending | Available |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem | Section   |
      | Sort Section | Default    | Available |
    And User performs following actions in the "Assign/Unassign Tags" popup
      | Actiontype             | ActionItem | Section   |
      | verifies sorting order | Default    | Available |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem | Section  |
      | Sort Section | Ascending  | Assigned |
    And User performs following actions in the "Assign/Unassign Tags" popup
      | Actiontype             | ActionItem | Section  |
      | verifies sorting order | Ascending  | Assigned |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem | Section  |
      | Sort Section | Descending | Assigned |
    And User performs following actions in the "Assign/Unassign Tags" popup
      | Actiontype             | ActionItem | Section  |
      | verifies sorting order | Descending | Assigned |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem | Section  |
      | Sort Section | Default    | Assigned |
    And User performs following actions in the "Assign/Unassign Tags" popup
      | Actiontype             | ActionItem | Section  |
      | verifies sorting order | Default    | Assigned |

  @MLP-29144
  Scenario:MLP-29144: Create an table item
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                | body                                       | response code | response message | jsonPath |
      | application/json | raw   | false | Post | items/Default/root | idc/IDxPayloads/MLP_25436_Table_Item1.json | 200           |                  |          |

  @MLP-29144 @webtest
  Scenario:MLP-29144:Create BusinessApplication Item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option |
      | BusinessApplication | ATestBA   | Save   |
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option |
      | BusinessApplication | ZTestBA   | Save   |
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option |
      | BusinessApplication | JTestBA   | Save   |
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option |
      | BusinessApplication | PTestBA   | Save   |

    ##7234542##
  @MLP-29144 @webtest @regression @positive
  Scenario:MLP-29144:SC#2: Verify the sort option is available in the Assign/ Un Assign Business Application as mentioned in above steps
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "TableSingleTest1" and clicks on search
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Business Applications" in "Search results page"
    And User performs following actions in the Item view Page
      | Actiontype    | ActionItem | Section   |
      | Tag Selection | ATestBA    | Available |
      | Tag Selection | ZTestBA    | Available |
      | Tag Selection | JTestBA    | Available |
      | Tag Selection | PTestBA    | Available |
      | Sort Section  | Ascending  | Available |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype             | ActionItem | Section   |
      | verifies sorting order | Ascending  | Available |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem | Section   |
      | Sort Section | Descending | Available |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype             | ActionItem | Section   |
      | verifies sorting order | Descending | Available |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem | Section   |
      | Sort Section | Default    | Available |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype             | ActionItem | Section   |
      | verifies sorting order | Default    | Available |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem | Section  |
      | Sort Section | Ascending  | Assigned |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype             | ActionItem | Section  |
      | verifies sorting order | Ascending  | Assigned |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem | Section  |
      | Sort Section | Descending | Assigned |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype             | ActionItem | Section  |
      | verifies sorting order | Descending | Assigned |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem | Section  |
      | Sort Section | Default    | Assigned |
    And User performs following actions in the "Assign a Tag" popup
      | Actiontype             | ActionItem | Section  |
      | verifies sorting order | Default    | Assigned |

    #Bug ID:MLP-31449
  @git
  Scenario: Create plugin Configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                                  | body                                                                     | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/analyzers/GitCollector/GitCollectorConfig                   |                                                                          |               |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollector/GitCollectorConfig                   | idc/IDX_PluginPayloads/MLP-14104_GitCollector_Plugin_Config.json         | 204           |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/AvroS3Cataloger/AvroS3DemoCataloger1              | idc/IDX_PluginPayloads/MLP-14102_AvroCataloger_Plugin_Config.json        | 204           |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/UnstructuredDataAnalyzer/UnstructuredDataAnalyzer | idc/IDX_PluginPayloads/MLP-21888_UnStructuredAnalyzer_Plugin_Config.json | 204           |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollector/TestGitCollector                     | idc/IDX_PluginPayloads/MLP-18458_GitCollector_Plugin_Config.json         | 204           |                  |          |              |          |

    ##7234545##
  @MLP-29144 @webtest @regression @positive
  Scenario:MLP-29144:SC#3: Verify the sort option is available in the Assign/ Un Assign Business Application as mentioned in above steps
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "SampleBA" and clicks on search
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And user "click" on "Assign existing configuration" button in "Item View page"
    And User performs following actions in the Item view Page
      | Actiontype    | ActionItem                                              | Section                |
      | Tag Selection | Collector for GitCollector is "GitCollectorConfig"      | Select a Configuration |
      | Tag Selection | Cataloger for AvroS3Cataloger is "AvroS3DemoCataloger1" | Select a Configuration |
      | Sort Section  | Ascending                                               | Select a Configuration |
    And User performs following actions in the "Assign existing Configuration to Business Application" popup
      | Actiontype             | ActionItem | Section                |
      | verifies sorting order | Ascending  | Select a Configuration |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem | Section                |
      | Sort Section | Descending | Select a Configuration |
    And User performs following actions in the "Assign existing Configuration to Business Application" popup
      | Actiontype             | ActionItem | Section                |
      | verifies sorting order | Descending | Select a Configuration |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem | Section                |
      | Sort Section | Default    | Select a Configuration |
    And User performs following actions in the "Assign existing Configuration to Business Application" popup
      | Actiontype             | ActionItem | Section                |
      | verifies sorting order | Default    | Select a Configuration |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem | Section                |
      | Sort Section | Ascending  | Selected Configuration |
    And User performs following actions in the "Assign existing Configuration to Business Application" popup
      | Actiontype             | ActionItem | Section                |
      | verifies sorting order | Ascending  | Selected Configuration |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem | Section                |
      | Sort Section | Descending | Selected Configuration |
    And User performs following actions in the "Assign existing Configuration to Business Application" popup
      | Actiontype             | ActionItem | Section                |
      | verifies sorting order | Descending | Selected Configuration |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem | Section                |
      | Sort Section | Default    | Selected Configuration |

  @MLP-29144 @regression @positive
  Scenario: Delete the Configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                                  | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/GitCollector/GitCollectorConfig                   |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/AvroS3Cataloger/AvroS3DemoCataloger1              |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/UnstructuredDataAnalyzer/UnstructuredDataAnalyzer |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/TestGitCollector                     |      |               |                  |          |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name             | type                | query | param |
      | SingleItemDelete | Default | ATestBA          | BusinessApplication |       |       |
      | SingleItemDelete | Default | ZTestBA          | BusinessApplication |       |       |
      | SingleItemDelete | Default | JTestBA          | BusinessApplication |       |       |
      | SingleItemDelete | Default | PTestBA          | BusinessApplication |       |       |
      | SingleItemDelete | Default | TableSingleTest1 | Table               |       |       |

  ##7236932##7236933##7236934##7236935##7236937##7236944##7236945##7236946##
  @MLP-29100 @webtest @regression @positive
  Scenario:MLP-29100:SC#1: Verify the keyboard navigation in item view page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "SampleBA" and clicks on search
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype                                      | ActionItem            | ItemName             | Section |
      | Click                                           | Item view Edit Button |                      |         |
      | Verify Key Navigation hightlights field         | Dropdown field        | Business Criticality |         |
      | Verify dropdown is opened when enter is pressed | Business Location     |                      |         |
      | Verify first option in dropdown is highlighted  | Business Location     |                      |         |
      | Navigate to field and select using key          | Business Criticality  | Low                  |         |
      | Verify selected option is highlighted           | Business Criticality  | Low                  |         |


  ##7241936##7241937##7241938##7241939##7241940##7241941##7241942##7241943## Bug ID:MLP-31764
  @MLP-29110 @webtest @regression @positive
  Scenario:MLP-29110:SC#1: Verify the keyboard navigation in item view page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Local Users" in "Landing page"
    And user "click" on "Add Local User" in Manage Access page
    And user "Verifies popup" is "displayed" for "Create Local User"
    And users performs following actions in Manage access
      | Actiontype      | ActionItem                                              | ItemName   | Section          | Attribute                                                                                                                             |
      | Key Navigations | Click Dropdown                                          | Roles      |                  |                                                                                                                                       |
      | Key Navigations | Verify Dropdown Presence                                |            |                  |                                                                                                                                       |
      | Key Navigations | Verify First Option in the menu                         | Select all |                  |                                                                                                                                       |
      | Key Navigations | Verify Tab is Highlighted                               | Email      |                  |                                                                                                                                       |
      | Key Navigations | Verify Menu options are not Highlighted                 | Roles      |                  |                                                                                                                                       |
      | Key Navigations | Close Dropdown                                          | Roles      |                  |                                                                                                                                       |
      | Key Navigations | Verify menu option is highlighted on tab navigation     | Roles      |                  |                                                                                                                                       |
      | Key Navigations | Select a option from Dropdown                           | Roles      | Compliance Owner |                                                                                                                                       |
      | Key Navigations | Verify the presence of selected option in the field     | Roles      | Compliance Owner |                                                                                                                                       |
      | Key Navigations | Verify the presence of All selected option in the field | Roles      | Select all       | Data Administrator,Guest User,System Administrator,Business Owner,Technology Owner,Relationship Owner,Security Owner,Compliance Owner |


 ##7241944##7241945##7241946## Bug ID:MLP-31764
  @MLP-29110 @webtest @regression @positive
  Scenario:MLP-29110:SC#2: Verify when any of the option is deselected then the particular checkbox and the Select All checkbox should be unchecked and the options should be removed from the field
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Local Users" in "Landing page"
    And user "click" on "Add Local User" in Manage Access page
    And user "Verifies popup" is "displayed" for "Create Local User"
    And users performs following actions in Manage access
      | Actiontype      | ActionItem                                           | ItemName | Section    | Attribute      |
      | Key Navigations | Verify deselected item is not displayed in the field | Roles    | Select all | Business Owner |

    ##7244744## #Bug ID:MLP-31449
  @MLP-29063 @regression @positive
  Scenario:SC#1:MLP-29063: Verify user created config should be listed in the Manage Configurations screen below the particular type under the respective node
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                | body                                                                 | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/credentials/GitCred                       |                                                                      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS    |                                                                      |               |                  |          |              |          |
      |                  |       |       | Put    | settings/credentials/GitCred                       | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | 200           |                  |          |              |          |
      |                  |       |       | Get    | settings/credentials/GitCred                       |                                                                      | 200           |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/GitDS    | idc/IDX_PluginPayloads/MLP-14102_GitCollector_DataSource_Config.json | 204           |                  |          |              |          |
      |                  |       |       | Get    | settings/analyzers/GitCollectorDataSource/GitDS    |                                                                      | 200           | GitDS            |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollector/GitCollectorConfig | idc/IDX_PluginPayloads/MLP-14104_GitCollector_Plugin_Config.json     | 204           |                  |          |              |          |

    ##7244744## #Bug ID:MLP-31449
  @MLP-29063 @regression @positive
  Scenario:SC#1.1:MLP-29063: Verify user created config should be listed in the Manage Configurations screen below the particular type under the respective node
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message |
      | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |      | 200           | IDLE             |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorConfig  |      | 200           |                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |      | 200           | IDLE             |

   ##7244745##7244746##7244747## #Bug ID:MLP-31449
  @MLP-29063 @webtest @regression @positive
  Scenario:MLP-29063:SC#2:Verify clicking on Log for the particular config should launch the log screen with the log details
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion and click menu option" operation in Manage Configurations panel
      | button    | actionItem | attribute          | itemName                            |
      | LocalNode | Collector  | GitCollectorConfig | Shows the logs of the configuration |
    And user verifies "Log Viewer" is "displayed" in Manage Configurations panel
    And user navigates to previous page
    And user "verifies presence" of following "Capture and Import Data page Title" in "" page
      | Manage Configurations |
    And user "verifies presence" of following "Active Accordion" in Manage Configurations Page
      | GitCollectorConfig |

#  ##7247633##7247634##7247635##7247636##7247637##7247638##7247646##7247639##7247640##7249411## #Descoped
#  @MLP-29533 @webtest @regression @positive
#  Scenario:MLP-29533:SC#1:Verify the Search icon is placed before the Add icon in the header in the manage tags
#    And User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
#    And User performs following actions in search component in "Manage Tags" page
#      | Actiontype      | ActionItem                       | ItemName  |
#      | Verify Presence | Search Icon                      |           |
#      | Click           | Search Icon                      |           |
#      | Verify Presence | Search InputBox Placeholder text | Search... |
#      | Enter Text      | Name                             |           |
#    And User performs following actions in the Manage Tags Page
#      | Actiontype              | ActionItem | ItemName                                                                                                                                    | Attribute |
#      | Verify Default Sub tags | PII        | Email Address,Phone Number,Fax Number,Social Security Number,Postal Code,State,IP Address,Gender,Full Name,First Name,Last Name,Middle Name |           |
#    And User performs following actions in search component in "Manage Tags" page
#      | Actiontype      | ActionItem                       | ItemName  |
#      | Verify Presence | Search Icon                      |           |
#      | Click           | Search Icon                      |           |
#      | Verify Presence | Search InputBox Placeholder text | Search... |
#      | Enter Text      | Full Name                        |           |
#    And User performs following actions in the Manage Tags Page
#      | Actiontype          | ActionItem | ItemName  | Attribute |
#      | Verify tag presence | PII        | Full Name |           |
#    And User performs following actions in search component in "Manage Tags" page
#      | Actiontype | ActionItem |
#      | Enter Text | Big Data   |
#    And User performs following actions in the Manage Tags Page
#      | Actiontype          | ActionItem | ItemName | Attribute |
#      | Verify tag presence | Technology | Big Data |           |
#    And User performs following actions in search component in "Manage Tags" page
#      | Actiontype | ActionItem   |
#      | Click      | Clear Search |
#    And User performs following actions in the Manage Tags Page
#      | Actiontype                         | ActionItem | ItemName                                                                      | Attribute |
#      | Verifies Default Root tags Section |            | Structure Information Tags,PII Tags,Technology Tags,Business Application Tags |           |
#    And User performs following actions in search component in "Manage Tags" page
#      | Actiontype      | ActionItem       | ItemName |
#      | Click           | Close search box |          |
#      | Verify Presence | Search Icon      |          |

    ##7247641##
  @MLP-29533 @webtest @regression @positive
  Scenario:MLP-29533:SC#2: Verify the above scenarios are working as expected in Manage Excel Imports page
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in search component in "Manage Excel Imports" page
      | Actiontype      | ActionItem                       | ItemName  |
      | Verify Presence | Search Icon                      |           |
      | Click           | Search Icon                      |           |
      | Verify Presence | Search InputBox Placeholder text | Search... |
      | Enter Text      | TechnicalMetadataTemplate2       |           |
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem                 | ItemName                   |
      | verify column list contains     | Name                       | TechnicalMetadataTemplate2 |
      | verify column list not contains | TechnicalMetadataTemplate1 |                            |
      | verify column list not contains | BizAppsComplianceTemplate  |                            |
    And User performs following actions in search component in "Manage Excel Imports" page
      | Actiontype | ActionItem   |
      | Click      | Clear Search |
    And User performs following actions in the Excel Importer Page
      | Actiontype                  | ActionItem | ItemName                   |
      | verify column list contains | Name       | TechnicalMetadataTemplate2 |
      | verify column list contains | Name       | BizAppsUsersTemplate       |
      | verify column list contains | Name       | BizAppsSupportTemplate     |
      | verify column list contains | Name       | BizAppsSecurityTemplate    |
      | verify column list contains | Name       | BizAppsComplianceTemplate  |
    And User performs following actions in search component in "Manage Excel Imports" page
      | Actiontype      | ActionItem       | ItemName |
      | Click           | Close search box |          |
      | Verify Presence | Search Icon      |          |

        ##7247642##
  @MLP-29533 @webtest @regression @positive
  Scenario:MLP-29533:SC#3: Verify the above scenarios are working as expected in Manage Roles page
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Roles" in "Landing page"
    And User performs following actions in search component in "Manage Roles" page
      | Actiontype      | ActionItem                       | ItemName  |
      | Verify Presence | Search Icon                      |           |
      | Click           | Search Icon                      |           |
      | Verify Presence | Search InputBox Placeholder text | Search... |
      | Enter Text      | Owner                            |           |
    And users performs following actions in Manage access
      | Actiontype                   | ActionItem           |
      | Verify Role is displayed     | Technology Owner     |
      | Verify Role is displayed     | Security Owner       |
      | Verify Role is displayed     | Relationship Owner   |
      | Verify Role is displayed     | Compliance Owner     |
      | Verify Role is displayed     | Business Owner       |
      | Verify Role is not displayed | System Administrator |
    And User performs following actions in search component in "Manage Roles" page
      | Actiontype | ActionItem           | ItemName |
      | Enter Text | System Administrator |          |
    And users performs following actions in Manage access
      | Actiontype                   | ActionItem           |
      | Verify Role is not displayed | Technology Owner     |
      | Verify Role is not displayed | Security Owner       |
      | Verify Role is not displayed | Relationship Owner   |
      | Verify Role is not displayed | Compliance Owner     |
      | Verify Role is not displayed | Business Owner       |
      | Verify Role is displayed     | System Administrator |
    And User performs following actions in search component in "Manage Roles" page
      | Actiontype | ActionItem   |
      | Click      | Clear Search |
    And user "verifies presence" of following "Manage Access default roles list" in "Manage Roles" page
      | Technology Owner     |
      | System Administrator |
      | Security Owner       |
      | Relationship Owner   |
      | Plugin Runtime       |
      | Guest User           |
      | Data Administrator   |
      | Compliance Owner     |
      | Business Owner       |
    And User performs following actions in search component in "Manage Roles" page
      | Actiontype      | ActionItem       | ItemName |
      | Click           | Close search box |          |
      | Verify Presence | Search Icon      |          |

  ##7247643##
  @MLP-29533 @webtest @regression @positive
  Scenario:MLP-29533:SC#4: Verify the above scenarios are working as expected in Manage Local Users page
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Local Users" in "Landing page"
    And User performs following actions in search component in "Manage Local Users" page
      | Actiontype      | ActionItem                       | ItemName  |
      | Verify Presence | Search Icon                      |           |
      | Click           | Search Icon                      |           |
      | Verify Presence | Search InputBox Placeholder text | Search... |
      | Enter Text      | Test                             |           |
    And users performs following actions in Manage access
      | Actiontype                         | ActionItem                |
      | Verify Local User is displayed     | Test System Administrator |
      | Verify Local User is displayed     | Test Guest User           |
      | Verify Local User is displayed     | Test Data Admin           |
      | Verify Local User is not displayed | System Administrator      |
    And User performs following actions in search component in "Manage Local Users" page
      | Actiontype | ActionItem           | ItemName |
      | Enter Text | System Administrator |          |
    And users performs following actions in Manage access
      | Actiontype                         | ActionItem           |
      | Verify Local User is not displayed | Test System Admin    |
      | Verify Local User is not displayed | Test Guest User      |
      | Verify Local User is not displayed | Test Data Admin      |
      | Verify Local User is displayed     | System Administrator |
    And User performs following actions in search component in "Manage Local Users" page
      | Actiontype | ActionItem   |
      | Click      | Clear Search |
    And users performs following actions in Manage access
      | Actiontype                     | ActionItem                |
      | Verify Local User is displayed | Test System Administrator |
      | Verify Local User is displayed | Test Guest User           |
      | Verify Local User is displayed | Test Data Admin           |
      | Verify Local User is displayed | System Administrator      |
    And User performs following actions in search component in "Manage Local Users" page
      | Actiontype      | ActionItem       | ItemName |
      | Click           | Close search box |          |
      | Verify Presence | Search Icon      |          |

      ##7247645##
  @MLP-29533 @webtest @regression @positive
  Scenario:MLP-29533:SC#5: Verify the above scenarios are working as expected in Item View page
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "leadingcausesofdeath" and clicks on search
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype               | ActionItem | ItemName |
      | Verify Widget Item Count | Columns    | 235      |
    And User performs following actions in search component in "Manage Local Users" page
      | Actiontype      | ActionItem                       | ItemName  |
      | Verify Presence | Item View Search Icon            |           |
      | Click           | Item View Search Icon            |           |
      | Verify Presence | Search InputBox Placeholder text | Search... |
      | Enter Text      | ci_min_c_bl_cancer               |           |
    And User performs following actions in the Item view Page
      | Actiontype               | ActionItem | ItemName |
      | Verify Widget Item Count | Columns    | 1        |
    And User performs following actions in search component in "Manage Local Users" page
      | Actiontype | ActionItem | ItemName |
      | Enter Text | ci_min_c   |          |
    And User performs following actions in the Item view Page
      | Actiontype               | ActionItem | ItemName |
      | Verify Widget Item Count | Columns    | 16       |
    And User performs following actions in search component in "Manage Local Users" page
      | Actiontype | ActionItem   |
      | Click      | Clear Search |
    And User performs following actions in the Item view Page
      | Actiontype               | ActionItem | ItemName |
      | Verify Widget Item Count | Columns    | 235      |
    And User performs following actions in search component in "Manage Local Users" page
      | Actiontype      | ActionItem            | ItemName |
      | Click           | Close search box      |          |
      | Verify Presence | Item View Search Icon |          |

        ##6908070##6908071##6908073##6908075##
  @MLP-13757 @webtest @regression @positive
  Scenario:SC#1:MLP-13757: Verify if the user can search item with Excellent Quality as 100
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text for Excellent quality and clicks on search on Subject Area page
    And user clicks on first item name link on the item list page
    And user should be able to see quality label
    And user "verifies displayed" in item view Page
      | fieldName | value |
      | Quality   | 100   |
    And user enters the search text for good quality and clicks on search on Subject Area page
    And user clicks on first item name link on the item list page
    And user should be able to see quality label
    And user "verifies displayed" in item view Page
      | fieldName | value |
      | Quality   | 87.5  |
    And user enters the search text for bad quality and clicks on search on Subject Area page
    And user clicks on first item name link on the item list page
    And user should be able to see quality label
    And user "verifies displayed" in item view Page
      | fieldName | value |
      | Quality   | 50    |
    And user enters the search text for Not Applicable quality and clicks on search on Subject Area page
    And user clicks on first item name link on the item list page
    And user should be able to see quality label
    And user "verifies not displayed" in item view Page
      | fieldName | value |
      | Quality   |       |

      #6889960##6889982##    ##6889990##6896451##
  @MLP-13759 @webtest @regression @positive
  Scenario:SC#1:MLP-13759 : Verify the Data sample Tab in Item View page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "employees_full" and clicks on search
    And user "selects" for the following filter in search results page
      | FilterType    | FilterValues |
      | MetaData Type | Table        |
    And user clicks on first item name link on the item list page
    And user "click" on "Data Sample" tab in Item view page
    And user "verifies displayed" on "DataSamplingTable" tab in Item view page
    And user "click" on "FirstColumn" tab in Item view page
    And user "verifies sorting order" of following "FirstColumn are in decending order" in "Item View" page
      |  |
    And user "click" on "Sort Icon" button in "Item View"
    And user "verifies sorting order" of following "FirstColumn are in ascending order" in "Item View" page
      |  |

  @MLP-29144 @webtest
  Scenario:MLP-30181:Create BusinessApplication Item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option |
      | BusinessApplication | Test BA   | Save   |

  @MLP-30181 @webtest @regression @positive @e2e
  Scenario:30181:Create tag
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Add Category" button in "Manage Tags page"
    Then user verifies the "Add Category" pop up is "displayed"
    And user "verifies presence" of following "Contextual Message" in "Add Category" page
      | Enter details to add a category. |
    And user creates a tag with the following parameters
      | CategoryName | Definition             | Icon                 | colorWidthHeight | Protected |
      | AutoTestTag  | Created for Automation | fa fa-address-book-o | 189,18           | false     |
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Tags |
    And User performs following actions in the Manage Tags Page
      | Actiontype          | ActionItem                 | ItemName    | Attribute |
      | Verify tag presence | Structure Information Tags | AutoTestTag |           |
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem                | ItemName        | Attribute |
      | Click      | Category Menu buttons     | AutoTestTag     | Add       |
      | Enter Text | Category Name             | AutoTestSubTag1 |           |
      | Click      | Edit category Save Button |                 |           |

  @git @MLP-30181
  Scenario: Create Datasource Credentials and Configuration for GitCollector
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                             | username    | password    |
      | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | $..userName | $..password |
    And Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                | body                                                                 | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/analyzers/GitCollector/GitCollectorConfig |                                                                      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS    |                                                                      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/GitCred                       |                                                                      |               |                  |          |              |          |
      |                  |       |       | Put    | settings/credentials/GitCred                       | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | 200           |                  |          |              |          |
      |                  |       |       | Get    | settings/credentials/GitCred                       |                                                                      | 200           |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/GitDS    | idc/IDX_PluginPayloads/MLP-14102_GitCollector_DataSource_Config.json | 204           |                  |          |              |          |
      |                  |       |       | Get    | settings/analyzers/GitCollectorDataSource/GitDS    |                                                                      | 200           |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollector/GitCollectorConfig | idc/IDX_PluginPayloads/MLP-30181_GitCollector_Plugin_Config.json     | 204           |                  |          |              |          |

  @MLP-30181 @sanity @positive @regression
  Scenario Outline: Run Git Collector
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                             | bodyFile | path | response code | response message | jsonPath                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |          |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollectorConfig')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorConfig  |          |      | 200           |                  |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |          |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollectorConfig')].status |

  @MLP-30181 @sanity @positive @regression
  Scenario Outline: Run LocalFileCollector
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                  | bodyFile                                             | path                 | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                | payloads/idc/IDX_PluginPayloads/LFCPluginConfig.json | $.LocalFileCollector | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/LocalFileCollector                                |                                                      |                      | 200           | LocalFileCollector |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/LocalFileCollector/* |                                                      |                      | 200           | IDLE               | $.[?(@.configurationName=='LocalFileCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/collector/LocalFileCollector/*  |                                                      |                      | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/LocalFileCollector/* |                                                      |                      | 200           | IDLE               | $.[?(@.configurationName=='LocalFileCollector')].status |

  @MLP-30181 @webtest @regression @positive @MLPQA-18083 @TEST_MLPQA-3163 @7265821 @TEST_MLPQA-3164 @7265820 @TEST_MLPQA-3165 @7265819 @TEST_MLPQA-3166 @7265818 @TEST_MLPQA-3167 @7265817 @TEST_MLPQA-3168 @7265816 @TEST_MLPQA-3169 @7265815 @TEST_MLPQA-3170 @7265814
  Scenario:MLP-30181:SC#1_Verify the contextual message for Assign a Tag page.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Capture and Import data" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem | attribute          |
      | LocalNode | Collector  | GitCollectorConfig |
    And user "click" on "Show the data elements in a list link" in Manage Configurations panel
    And user "verifies displayed" on "Facet presence" for "Tags" in "Search results" page
    And user "verifies displayed" on "Facet presence" for "Technology" in "Search results" page
    And user "verifies displayed" on "Facet presence" for "Business Application" in "Search results" page
    And user verifies "Test BA" Tag present under "BusinessApplication" Tag
    And user verifies "Git" Tag present under "Technology" Tag
    And user verifies "AutoTestSubTag1" Tag present under "AutoTestTag" Tag
    And user clicks on search icon
    And user verifies "Local Files" Tag present under "Technology" Tag
    And user performs "facet selection" in "AutoTestSubTag1" attribute under "Tags" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | java |
      | lib  |
    And user performs "facet selection" in "Git" attribute under "Technology" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | java |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | lib |

  @MLP-30181
  Scenario: Delete the Business application
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name        | type                | query | param |
      | SingleItemDelete | Default | Test BA     | BusinessApplication |       |       |
      | SingleItemDelete | Default | AutoTestTag | Tag                 |       |       |

  @MLP-30181 @regression @positive
  Scenario:MLP-14793: Delete data source and a credential
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                      | body | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/analyzers/GitCollector/GitCollectorConfig       |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS          |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/GitCred                             |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/LocalFileCollector/LocalFileCollector |      |               |                  |          |              |          |

      ##6811221##6811222##6811223##6811224##6811225##6811226##
  @MLP-14096 @webtest @regression @positive
  Scenario:SC#1:MLP-14096: Verify the header component
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the header
      | actionType         | actionItem           |
      | verifies displayed | Header text          |
      | verifies displayed | Header profile Icons |
      | verifies displayed | Search Block         |
      | verifies displayed | Search Area          |
    And user "enter text" in "Manage DataSource popup"
      | fieldName   | actionItem |
      | Search Area | Customer   |
    And user performs following actions in the header
      | actionType         | actionItem          |
      | verifies displayed | Search Cross button |
      | verifies displayed | Search Button       |
      | click              | Header text         |

    ##MLPQA-3301##MLPQA-3302##MLPQA-3303##7261322##7261321##7261320##
  ##MLPQA-3301##MLPQA-3302##MLPQA-3303##7261322##7261321##7261320##
  @MLP-29129 @webtest @regression @positive
  Scenario:MLP-29129:SC#1_Verify the DD page title across application
    Given User launch browser and traverse to login page
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem | Section                |
      | Verify page title | Login Page | Data Discovery - Login |
    When user enter credentials for "System Administrator1" role
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem | Section                  |
      | Verify page title | Home       | Data Discovery - Welcome |
    And user clicks on search icon
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem | Section                 |
      | Verify page title | Search     | Data Discovery - Search |
    And User performs following actions in the Manage Notifications Page
      | Actiontype | ActionItem             |
      | Click      | Notification bell Icon |
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem    | Section                        |
      | Verify page title | Notifications | Data Discovery - Notifications |
    And user performs following actions in the header
      | actionType | actionItem    |
      | click      | Profile Image |
      | click      | Profile       |
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem | Section                  |
      | Verify page title | Profile    | Data Discovery - Profile |
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem | Section                    |
      | Verify page title | Dashboard  | Data Discovery - Dashboard |

      #6889960##6889982##    ##6889990##6896451##
  @MLP-13759 @webtest @regression @positive
  Scenario:SC#1:MLP-13759 : Verify the Data sample Tab in Item View page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "employees_full" and clicks on search
    And user "selects" for the following filter in search results page
      | FilterType    | FilterValues |
      | MetaData Type | Table        |
    And user clicks on first item name link on the item list page
    And user "click" on "Data Sample" tab in Item view page
    And user "verifies displayed" on "DataSamplingTable" tab in Item view page
    And user "click" on "FirstColumn" tab in Item view page
    And user "verifies sorting order" of following "FirstColumn are in decending order" in "Item View" page
      |  |
    And user "click" on "Sort Icon" button in "Item View"
    And user "verifies sorting order" of following "FirstColumn are in ascending order" in "Item View" page
      |  |
  ##MLPQA-3301##MLPQA-3302##MLPQA-3303##7261322##7261321##7261320##
  @MLP-29129 @webtest @regression @positive
  Scenario:MLP-29129:SC#2_Verify the DD page title across application under capture
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Pipelines" in "Landing page"
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem       | Section                           |
      | Verify page title | Manage Pipelines | Data Discovery - Manage Pipelines |
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem            | Section                                |
      | Verify page title | Manage Configurations | Data Discovery - Manage Configurations |
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem          | Section                              |
      | Verify page title | Manage Data Sources | Data Discovery - Manage Data Sources |
    And user "click" on "Capture and Import Data Link" for "Manage Credentials" in "Landing page"
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem         | Section                             |
      | Verify page title | Manage Credentials | Data Discovery - Manage Credentials |
    And user "click" on "Capture and Import Data Link" for "Manage Bundles" in "Landing page"
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem     | Section                         |
      | Verify page title | Manage Bundles | Data Discovery - Manage Bundles |
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem           | Section                               |
      | Verify page title | Manage Excel Imports | Data Discovery - Manage Excel Imports |

      ##6811221##6811222##6811223##6811224##6811225##6811226##
  @MLP-14096 @webtest @regression @positive
  Scenario:SC#1:MLP-14096: Verify the header component
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the header
      | actionType         | actionItem           |
      | verifies displayed | Header text          |
      | verifies displayed | Header profile Icons |
      | verifies displayed | Search Block         |
      | verifies displayed | Search Area          |
    And user "enter text" in "Manage DataSource popup"
      | fieldName   | actionItem |
      | Search Area | Customer   |
    And user performs following actions in the header
      | actionType         | actionItem          |
      | verifies displayed | Search Cross button |
      | verifies displayed | Search Button       |
      | click              | Header text         |
  ##MLPQA-3301##MLPQA-3302##MLPQA-3303##7261322##7261321##7261320##
  @MLP-29129 @webtest @regression @positive
  Scenario:MLP-29129:SC#2_Verify the DD page title across application under Admin
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem  | Section                      |
      | Verify page title | Manage Tags | Data Discovery - Manage Tags |
    And user "click" on "Admin Link" for "Manage Roles" in "Landing page"
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem   | Section                       |
      | Verify page title | Manage Roles | Data Discovery - Manage Roles |
    And user "click" on "Admin Link" for "Manage LDAP Users" in "Landing page"
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem  | Section                            |
      | Verify page title | Manage LDAP | Data Discovery - Manage LDAP Users |
    And user "click" on "Admin Link" for "Manage LDAP Users" in "Landing page"
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem  | Section                            |
      | Verify page title | Manage LDAP | Data Discovery - Manage LDAP Users |
    And user "click" on "Admin Link" for "Manage Local Users" in "Landing page"
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem   | Section                             |
      | Verify page title | Manage Local | Data Discovery - Manage Local Users |
    And user "click" on "Admin Link" for "Trust Policy" in "Landing page"
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem   | Section                       |
      | Verify page title | Trust Policy | Data Discovery - Trust Policy |
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem     | Section                         |
      | Verify page title | Tagging Policy | Data Discovery - Tagging Policy |
    And user "click" on "Admin Link" for "Masking Policy" in "Landing page"
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem     | Section                         |
      | Verify page title | Masking Policy | Data Discovery - Masking Policy |
    And user "click" on "Admin Link" for "Manage Licenses" in "Landing page"
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem      | Section                          |
      | Verify page title | Manage Licenses | Data Discovery - Manage Licenses |
    And user "click" on "Admin Link" for "Itemtypes and Attributes" in "Landing page"
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem | Section                     |
      | Verify page title | Data Model | Data Discovery - Data Model |
    And user "click" on "Admin Link" for "View Audit Log" in "Landing page"
    And User performs following actions in the Item view Page
      | Actiontype        | ActionItem | Section                    |
      | Verify page title | Audit log  | Data Discovery - Audit Log |