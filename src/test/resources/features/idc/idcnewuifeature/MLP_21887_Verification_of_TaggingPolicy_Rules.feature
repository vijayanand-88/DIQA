@MLP-21887 @MLP-21888
Feature:A_MLP-21887 MLP-21888: This feature is to verify the Tagging Policy Page

  ##7064152##7064155##7064156##7064157##7066738##7064155##7064156##
  @MLP-21887 @webtest @regression @positive
  Scenario: SC#1:MLP-21887: To Verify the user is able to view the "Tagging Policy" sub menu under Policy menu in Administration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And user "verify sidebar menu items" of following "Policies" in "Landing" page
      | Trust Policy   |
      | Tagging Policy |
      | Masking Policy |
    And user "verifies presence" of following "Admin page Title" in "" page
      | Tagging Policy |
    And user "verifies presence" of following "Landed page Title is Bold" in "" page
      | Tagging Policy |
    And user "verifies presence" of following "Page Subtitle" in "Tagging Policy" page
      | Configure the policy for automatic tagging via Analyzer |
    And user verifies "Add New Rules Button" is "displayed" in "Tagging Policy Page"
    And user "verify presence" in "Tagging Policy page"
      | fieldName                    | actionItem |
      | Predefined Tagging Rule Type | Default    |

  @MLP-21888 @webtest @regression @positive
  Scenario: Create tag
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    Then user verifies the "Add Category" pop up is "displayed"
    And user "click" on "Add Category" button in "Manage Tags page"
    And user creates a tag with the following parameters
      | CategoryName  | Definition                     | Icon                | colorWidthHeight | Protected |
      | DemoParentTag | Created for Automation purpose | fa fa-envelope-open |                  | false     |
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Tags |
    And user refreshes the application
    And user "verifies presence" of following "Tags" in "Manage Tags" page
      | DemoParentTag |
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem                | ItemName      | Attribute |
      | Click      | Category Menu buttons     | DemoParentTag | Add       |
      | Enter Text | Category Name             | DemoSubTag    |           |
      | Click      | Edit category Save Button |               |           |
      | Click      | Category Menu buttons     | DemoParentTag | Add       |
      | Enter Text | Category Name             | DemoSampleTag |           |
      | Click      | Edit category Save Button |               |           |
    And user refreshes the application
    And user "click" on "Expand/Collapse Tag Button" for "DemoParentTag" in "Manage Tags"
    Then user "verifies Tree Sructure of Tags" of following "DemoParentTag" in "Manage Tags" Page
      | DemoSubTag    |
      | DemoSampleTag |

  ##7058448##7058458##7072966##7068171##
  @MLP-21888 @webtest @regression @positive
  Scenario:SC#3:MLP-21888:Verify the flow of tag policy
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And user "click" on "Add New Rule" button in "Trust Policy page"
    And User performs following actions in the Tagging Policy Page
      | Actiontype         | ActionItem     | ItemName                 |
      | Select Rule Option | Data Type      | UNSTRUCTURED             |
      | Select Rule Option | Analyzer Name  | UnstructuredDataAnalyzer |
      | Select Rule Option | Tag Category   | DemoParentTag            |
      | Enter rule value   | Tags           | DemoSubTag               |
      | Enter rule value   | Data Pattern   | \d                       |
      | Click              | Save Rule form |                          |
    And user "verify presence" in "Tagging Policy page"
      | fieldName            | actionItem               |
      | Rule for Plugin Type | UnstructuredDataAnalyzer |

  @git @precondition
  Scenario: Update Git Cataloger with
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                             | username    | password    |
      | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | $..userName | $..password |

  @git
  Scenario: Delete DS and Plugin Configuration
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                                  | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/credentials/GitCred                                         |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS                      |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/TestGitCollector                     |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/UnstructuredDataAnalyzer/UnstructuredDataAnalyzer |      |               |                  |          |

  @git
  Scenario: Create Datasource, Plugin and Credentials for GitCollector
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                  | body                                                                     | response code | response message         | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Put  | settings/credentials/GitCred                                         | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json     | 200           |                          |          |              |          |
      |                  |       |       | Get  | settings/credentials/GitCred                                         |                                                                          | 200           |                          |          |              |          |
      |                  |       |       | Put  | settings/analyzers/GitCollectorDataSource/GitDS                      | idc/IDX_PluginPayloads/MLP-14102_GitCollector_DataSource_Config.json     | 204           |                          |          |              |          |
      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource/GitDS                      |                                                                          | 200           | GitDS                    |          |              |          |
      |                  |       |       | Put  | settings/analyzers/GitCollector/TestGitCollector                     | idc/IDX_PluginPayloads/MLP-21888_GitCollector_Plugin_Config.json         | 204           |                          |          |              |          |
      |                  |       |       | Get  | settings/analyzers/GitCollector/TestGitCollector                     |                                                                          | 200           | TestGitCollector         |          |              |          |
      |                  |       |       | Put  | settings/analyzers/UnstructuredDataAnalyzer/UnstructuredDataAnalyzer | idc/IDX_PluginPayloads/MLP-21888_UnStructuredAnalyzer_Plugin_Config.json | 204           |                          |          |              |          |
      |                  |       |       | Get  | settings/analyzers/UnstructuredDataAnalyzer/UnstructuredDataAnalyzer |                                                                          | 200           | UnstructuredDataAnalyzer |          |              |          |

  @git @precondition
  Scenario: Run the Git Collector
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                  | body | response code | response message |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/TestGitCollector                        |      | 200           | IDLE             |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/TestGitCollector                         |      | 200           |                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/TestGitCollector                        |      | 200           | IDLE             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/UnstructuredDataAnalyzer |      | 200           | IDLE             |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/UnstructuredDataAnalyzer  |      | 200           |                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/UnstructuredDataAnalyzer |      | 200           | IDLE             |

    ##7068179##
  @MLP-21085 @webtest @regression @positive
  Scenario:SC#4:MLP-21085:Verify if for any item, system displays the sub tag created in "Select a tag to assign" list
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "DemoParentTag" attribute under "Tags" facets in Item Search results page
    And User performs following actions in the Item view Page
      | Actiontype                        | ActionItem    | ItemName            | Section |
      | Verify Tag Icon in Search Results | DemoParentTag | fa fa-envelope-open |         |

  ##7066739##7072970##7072968##
  @MLP-21888 @webtest @regression @positive
  Scenario:SC#5:MLP-21888: Verify the ellipses is displayed when Data type, Plugin name and Tag when characters exceeds
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And user "click" on "Add New Rule" button in "Trust Policy page"
    And User performs following actions in the Tagging Policy Page
      | Actiontype         | ActionItem     | ItemName            |
      | Select Rule Option | Data Type      | STRUCTURED          |
      | Select Rule Option | Analyzer Name  | SnowflakeDBAnalyzer |
      | Select Rule Option | Tag Category   | DemoParentTag       |
      | Enter rule value   | Tags           | DemoSubTag          |
      | Enter rule value   | Data Pattern   | \d                  |
      | Click              | Save Rule form |                     |
    And user "verify presence" in "Tagging Policy page"
      | fieldName            | actionItem          |
      | Rule for Plugin Type | SnowflakeDBAnalyzer |

    ##7068158##7068173##7068175##
  @MLP-21890 @webtest @regression @positive
  Scenario:SC#6:MLP-21890: To Verify first Default option is set to ALL for Datatype and plugin name
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And user "click" on "Add New Rule" button in "Trust Policy page"
    And user "verifies uploaded Analyzer Name" in "Tagging Policy" Page
      | fieldName | option |
      | Data Type | All    |
    And user "verifies tagging Policy Default Option" in "Tagging Policy" Page
      | fieldName    | option |
      | Analyzer Nam | All    |
    And User performs following actions in the Tagging Policy Page
      | Actiontype | ActionItem     | ItemName |
      | Click      | Save Rule form |          |
    And user verifies "Tag Rule form" is "displayed"
    And user "verifies tagging Policy Default Option" in "Tagging Policy" Page
      | fieldName | option |
      | Data Type | All    |

 ##7068174##7068161##
  @MLP-21890 @webtest @regression @positive
  Scenario:SC#7:MLP-21890: To Verify the user is unable to edit the Technologies, datatype and Plugin name while editing it
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And User performs following actions in the Tagging Policy Page
      | Actiontype             | ActionItem    | ItemName |
      | Click                  | Rule          | Default  |
      | Verify disabled fields | Data Type     |          |
      | Verify disabled fields | Analyzer Name |          |

    ##7068194##7068195##7068196##7068197##
  @MLP-21891 @webtest @regression @positive
  Scenario: SC8#:MLP-21891: Verify the user is able to delete the rule for itemtype by clicking delete icon
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And User performs following actions in the Tagging Policy Page
      | Actiontype | ActionItem         | ItemName                 |
      | Click      | Rule               | UnstructuredDataAnalyzer |
      | Click      | Rule Delete Button | UnstructuredDataAnalyzer |
    And user verifies the "Delete Data Type" pop up is "displayed"
    And user "click" on "Popup Cancel button" button in "Delete Data Type pop up"
    And user "verify presence" in "Tagging Policy page"
      | fieldName            | actionItem               |
      | Rule for Plugin Type | UnstructuredDataAnalyzer |
    And User performs following actions in the Tagging Policy Page
      | Actiontype | ActionItem         | ItemName                 |
      | Click      | Rule Delete Button | UnstructuredDataAnalyzer |
    And user "click" on "Close button" button in "Delete Data Type pop up"
    And user "verify presence" in "Tagging Policy page"
      | fieldName            | actionItem               |
      | Rule for Plugin Type | UnstructuredDataAnalyzer |
    And User performs following actions in the Tagging Policy Page
      | Actiontype | ActionItem         | ItemName                 |
      | Click      | Rule Delete Button | UnstructuredDataAnalyzer |
    And user "click" on "DELETE" button in "popup"
    And User performs following actions in the Tagging Policy Page
      | Actiontype          | ActionItem           | ItemName                 |
      | Verify Non Presence | Rule for Plugin Type | UnstructuredDataAnalyzer |

    ##7076744##
  @MLP-22599 @webtest @regression @positive
  Scenario:SC#9:MLP-22599: To Verify the user is able to view the unsaved changes popup is displayed when click the close icon of Trust policy and collapse the rule
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And user "click" on "Add New Rule" button in "Trust Policy page"
    And User performs following actions in the Tagging Policy Page
      | Actiontype         | ActionItem           | ItemName                 |
      | Select Rule Option | Data Type            | UNSTRUCTURED             |
      | Select Rule Option | Analyzer Name        | UnstructuredDataAnalyzer |
      | Select Rule Option | Tag Category         | DemoParentTag            |
      | Enter rule value   | Tags                 | DemoSubTag               |
      | Enter rule value   | Data Pattern         | \d                       |
      | Click              | Discard Tagging Rule |                          |
    And user verifies the "Unsaved Changes" pop up is "displayed"
    And user clicks on "No" link in the "Unsaved Changes Popup"
    And User performs following actions in the Tagging Policy Page
      | Actiontype | ActionItem | ItemName |
      | Click      | Rule       | ...      |
    And user verifies the "Unsaved Changes" pop up is "displayed"

    ##7076745##7076746##7076748##
  @MLP-22599 @webtest @regression @positive
  Scenario:SC#10:MLP-22599:To verify the user is able to close the unsaved changes popup by clicking the X icon
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And user "click" on "Add New Rule" button in "Trust Policy page"
    And User performs following actions in the Tagging Policy Page
      | Actiontype         | ActionItem           | ItemName                 |
      | Select Rule Option | Data Type            | UNSTRUCTURED             |
      | Select Rule Option | Analyzer Name        | UnstructuredDataAnalyzer |
      | Click              | Discard Tagging Rule |                          |
    And user verifies the "Unsaved Changes" pop up is "displayed"
    And user "click" on "Close button" button in "Unsaved Changes pop up"
    And user "verify presence" in "Tagging Policy page"
      | fieldName            | actionItem |
      | Rule for Plugin Type | ...        |
    And User performs following actions in the Tagging Policy Page
      | Actiontype         | ActionItem           | ItemName      |
      | Select Rule Option | Tag Category         | DemoParentTag |
      | Enter rule value   | Tags                 | DemoSubTag    |
      | Enter rule value   | Data Pattern         | \d            |
      | Click              | Discard Tagging Rule |               |
    And user clicks on "No" link in the "Unsaved Changes Popup"
    And User performs following actions in the Tagging Policy Page
      | Actiontype | ActionItem           | ItemName |
      | Click      | Discard Tagging Rule |          |
    And user clicks on "Yes" link in the "Unsaved Changes Popup"
    And User performs following actions in the Tagging Policy Page
      | Actiontype          | ActionItem           | ItemName                 |
      | Verify Non Presence | Rule for Plugin Type | UnstructuredDataAnalyzer |

    ##7068177##7076743##
  @MLP-21888 @webtest @regression @positive
  Scenario:SC#11:MLP-21888: To Verify the user is able to delete the action by clicking the X icon
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And user "click" on "Add New Rule" button in "Trust Policy page"
    And User performs following actions in the Tagging Policy Page
      | Actiontype         | ActionItem           | ItemName                 |
      | Select Rule Option | Data Type            | UNSTRUCTURED             |
      | Select Rule Option | Analyzer Name        | UnstructuredDataAnalyzer |
      | Select Rule Option | Tag Category         | DemoParentTag            |
      | Enter rule value   | Tags                 | DemoSubTag               |
      | Enter rule value   | Data Pattern         | \d                       |
      | Enter rule value   | Name Pattern         | name                     |
      | Enter rule value   | Type Pattern         | name                     |
      | Click              | Discard Tagging Rule |                          |
    And user verifies the "Unsaved Changes" pop up is "displayed"
    And user clicks on "Yes" link in the "Unsaved Changes Popup"
    And User performs following actions in the Tagging Policy Page
      | Actiontype          | ActionItem           | ItemName                 |
      | Verify Non Presence | Rule for Plugin Type | UnstructuredDataAnalyzer |

    ##7068168##7068178##7068170##
  @MLP-21888 @webtest @regression @positive
  Scenario:SC#12:MLP-21888: To Verify the user is able to enter Datapattern/TypePattern and Name pattern text fields
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And user "click" on "Add New Rule" button in "Trust Policy page"
    And User performs following actions in the Tagging Policy Page
      | Actiontype         | ActionItem     | ItemName                 |
      | Select Rule Option | Data Type      | UNSTRUCTURED             |
      | Select Rule Option | Analyzer Name  | UnstructuredDataAnalyzer |
      | Select Rule Option | Tag Category   | DemoParentTag            |
      | Enter rule value   | Tags           | DemoSubTag               |
      | Enter rule value   | Data Pattern   | \d                       |
      | Enter rule value   | Name Pattern   | name                     |
      | Enter rule value   | Type Pattern   | name                     |
      | Click              | Save Rule form |                          |
    And user "verify presence" in "Tagging Policy page"
      | fieldName            | actionItem               |
      | Rule for Plugin Type | UnstructuredDataAnalyzer |
    And User performs following actions in the Tagging Policy Page
      | Actiontype | ActionItem | ItemName                 |
      | Click      | Rule       | UnstructuredDataAnalyzer |
    And User performs following actions in the Tagging Policy Page
      | Actiontype       | ActionItem     | ItemName |
      | Enter rule value | Name Pattern   | name     |
      | Click            | matchFull      | name     |
      | Click            | Save Rule form |          |
    And user "verify presence" in "Tagging Policy page"
      | fieldName            | actionItem               |
      | Rule for Plugin Type | UnstructuredDataAnalyzer |

  ##7084065##7084067##7090259##
  @MLP-22866 @MLP-23097 @webtest @regression @positive
  Scenario:SC#13:MLP-22866:MLP-23097: To Verify the Match Empty is changed to Ignore if Empty or Null
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And user "click" on "Add New Rule" button in "Trust Policy page"
    And user "verifies presence" of following "Tagging policy Labels list" in "Tagging Policy" page
      | Data Type             |
      | Analyzer Name         |
      | Tag Category          |
      | Tags                  |
      | Data Pattern          |
      | Whole Word Match      |
      | Ignore empty and null |
      | Name Pattern          |
      | Type Pattern          |
    And user "verify label absense" in "Tagging Policy" Page
      | fieldName    |
      | Technologies |

  @webtest @regression @positive
  Scenario: Delete the tagging policies
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And User performs following actions in the Tagging Policy Page
      | Actiontype | ActionItem         | ItemName                 |
      | Click      | Rule               | UnstructuredDataAnalyzer |
      | Click      | Rule Delete Button | UnstructuredDataAnalyzer |
    And user "click" on "DELETE" button in "popup"
    And User performs following actions in the Tagging Policy Page
      | Actiontype          | ActionItem           | ItemName                 |
      | Verify Non Presence | Rule for Plugin Type | UnstructuredDataAnalyzer |
    And User performs following actions in the Tagging Policy Page
      | Actiontype | ActionItem         | ItemName            |
      | Click      | Rule               | SnowflakeDBAnalyzer |
      | Click      | Rule Delete Button | SnowflakeDBAnalyzer |
    And user "click" on "DELETE" button in "popup"
    And User performs following actions in the Tagging Policy Page
      | Actiontype          | ActionItem           | ItemName            |
      | Verify Non Presence | Rule for Plugin Type | SnowflakeDBAnalyzer |

  ##7091288##
  @MLP-22597 @webtest @regression @positive
  Scenario:MLP-22597:SC#1:Verify the mentioned Default PII Rules are displayed under Defaults Tagging policy in UI
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And User performs following actions in the Tagging Policy Page
      | Actiontype | ActionItem | ItemName |
      | Click      | Rule       | Default  |
    Then user "verify presence" of following "Default PII Rules" in "Tagging Policy" Page
      | 55555                                                  |
      | -555-                                                  |
      | ^[A-Z][a-z]{1,9}$                                      |
      | ^[a-z']{2,10}$                                         |
      | ^[a-z]$                                                |
      | [\w-\.]+@([\w-]+\.)+[\w-]{2,4}                         |
      | \d{3}[ -]{0,1}\d{2}[ -]{0,1}\d{4}                      |
      | (\+\d{1,3}\s)?\(?\d{1,3}\)?[\s.-]+\d{3}([\s.-]+)?\d{4} |
      | ^\d{1,2}\/\d{1,2}\/\d{4}$                              |
      | ^[a-z']{2,10}$                                         |
      | ^\$[0-9]+(\.[0-9][0-9])?$                              |
      | ([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4}                 |
      | (\+\d{1,3}\s)?\(?\d{1,3}\)?[\s.-]\d{3}([\s.-])?\d{4}   |

  @MLP-22597 @webtest @regression @positive
  Scenario:MLP-22597: Create a tagging policy for unstructured analyzer
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And user "click" on "Add New Rule" button in "Trust Policy page"
    And User performs following actions in the Tagging Policy Page
      | Actiontype         | ActionItem     | ItemName                 |
      | Select Rule Option | Data Type      | UNSTRUCTURED             |
      | Select Rule Option | Analyzer Name  | UnstructuredDataAnalyzer |
      | Select Rule Option | Tag Category   | DemoParentTag            |
      | Enter rule value   | Tags           | DemoSampleTag            |
      | Enter rule value   | Data Pattern   | \d                       |
      | Click              | Save Rule form |                          |
    And user "verify presence" in "Tagging Policy page"
      | fieldName            | actionItem               |
      | Rule for Plugin Type | UnstructuredDataAnalyzer |

  @git
  Scenario: Create config for GitCollector with pii file types
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                                  | body                                                                                 | response code | response message         | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/credentials/GitCred                                         |                                                                                      |               |                          |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/GitDSConfig                | idc/IDx_DataSource_Credentials_Payloads/MLL_22597_GitCollectorDataSourcesConfig.json | 204           |                          |          |              |          |
      |                  |       |       | Get    | settings/analyzers/GitCollectorDataSource/GitDSConfig                |                                                                                      | 200           | GitDSConfig              |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollector/GitCollectorConfig                   | idc/IDX_PluginPayloads/MLP_22597_GitCollector_config.json                            | 204           |                          |          |              |          |
      |                  |       |       | Get    | settings/analyzers/GitCollector/GitCollectorConfig                   |                                                                                      | 200           | GitCollectorConfig       |          |              |          |
      |                  |       |       | Put    | settings/analyzers/UnstructuredDataAnalyzer/UnstructuredDataAnalyzer | idc/IDX_PluginPayloads/MLP-21888_UnStructuredAnalyzer_Plugin_Config.json             | 204           |                          |          |              |          |
      |                  |       |       | Get    | settings/analyzers/UnstructuredDataAnalyzer/UnstructuredDataAnalyzer |                                                                                      | 200           | UnstructuredDataAnalyzer |          |              |          |

  @git @precondition
  Scenario: Run the Git Collector and unstructured data
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                  | body | response code | response message |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig                      |      | 200           | IDLE             |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorConfig                       |      | 200           |                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig                      |      | 200           | IDLE             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/UnstructuredDataAnalyzer |      | 200           | IDLE             |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/UnstructuredDataAnalyzer  |      | 200           |                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/UnstructuredDataAnalyzer |      | 200           | IDLE             |

    ##7091289##7091290##
  @MLP-22597 @webtest @regression @positive
  Scenario:MLP-22597:SC#2: To Verify the Default PII pattern gets tagged when for structured data type after the successful run of analyzer plugin
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    Then user "Tag List in facet" of following "Tags" in Item View Page
      | PII | Gender | Unlisted telephone numbers | Fax Number | Social Security Number | State | Email Address | IP Address |

    ##7091291##7091292##
  @MLP-22597 @webtest @regression @positive
  Scenario:MLP-22597:SC#3:Verify the user is able to edit the actions of Default PII Pattern under Tagging policy
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And User performs following actions in the Tagging Policy Page
      | Actiontype | ActionItem         | ItemName                 |
      | Click      | Rule               | UnstructuredDataAnalyzer |
      | Click      | Rule Delete Button | UnstructuredDataAnalyzer |
    And user "click" on "DELETE" button in "popup"
    And User performs following actions in the Tagging Policy Page
      | Actiontype          | ActionItem           | ItemName                 |
      | Verify Non Presence | Rule for Plugin Type | UnstructuredDataAnalyzer |
    And User performs following actions in the Tagging Policy Page
      | Actiontype  | ActionItem   | ItemName |
      | Click       | Rule         | Default  |
      | Store Value | Policy count |          |
    And user "click" on "Add New Policy" button in "Trust Policy page"
    And User performs following actions in the Tagging Policy Page
      | Actiontype                       | ActionItem        | ItemName |
      | Verify policy count is increased | Policy count      |          |
      | Click                            | Delete New policy |          |
      | Verify policy count is same      | Policy count      |          |

  @git
  Scenario: Delete Plugin Configuration
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                                  | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/credentials/GitCred                                         |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS                      |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/TestGitCollector                     |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/UnstructuredDataAnalyzer/UnstructuredDataAnalyzer |      |               |                  |          |