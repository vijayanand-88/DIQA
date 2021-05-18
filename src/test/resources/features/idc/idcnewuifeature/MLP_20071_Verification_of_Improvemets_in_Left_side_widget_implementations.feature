@MLP-20071 @MLP-20228 @MLP-18663
Feature:MLP-20071 MLP-20228 MLP-18663: This feature is to verify the left side widgets implementation and lineage statistics widgets

  ##7034153##7034154
  @MLP-20071 @webtest @regression @positive
  Scenario: SC1#:MLP-20071: Verify if for the Metadata items "Cluster, Service, Database, Table, Column" - item views has the widgets "Hierarchy, Rating and Tagging" aligned in the left
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And User performs following actions in the Item view Page
      | Actiontype                        | ActionItem | ItemName              |
      | Verifies Widget for Metadata type | Table      | Hierarchy,Tags,Rating |
      | Verifies Widget for Metadata type | Column     | Hierarchy,Tags,Rating |
      | Verifies Widget for Metadata type | Cluster    | Hierarchy,Tags,Rating |
      | Verifies Widget for Metadata type | Database   | Hierarchy,Tags,Rating |
      | Verifies Widget for Metadata type | Service    | Hierarchy,Tags,Rating |
      | Verifies Widget for Metadata type | Directory  | Hierarchy,Tags,Rating |
      | Verifies Widget for Metadata type | File       | Hierarchy,Tags,Rating |
      | Verifies Widget for Metadata type | Analysis   | Hierarchy,Tags,Rating |
      | Verifies Widget for Metadata type | Schema     | Hierarchy,Tags,Rating |

  ##7034156##
  @MLP-20071 @webtest @regression @positive
  Scenario:MLP-20071:Create an BA Item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option |
      | BusinessApplication | SampleBA  | Save   |

  ##7034157##
  @MLP-20228 @webtest @regression @positive
  Scenario: SC3#:MLP-20228: Verification of To additional attributes is added for the item type "Business Application"
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "SampleBA" item from search results
    Then user "verify multiAttribute widgets for BA" section has following values
      | Business | Architecture | Support | Security | Compliance | Data |
    And user verifies "Tags widget" is "displayed" in Manage Configurations panel
    And user verifies rating facet in item view
    And user "click" on "Item view Tab" for "Architecture" in "Item View Page"
    And user verifies "Tags widget" is "displayed" in Manage Configurations panel
    And user verifies rating facet in item view
    And user "click" on "Item view Tab" for "Support" in "Item View Page"
    And user verifies "Tags widget" is "displayed" in Manage Configurations panel
    And user verifies rating facet in item view
    And user "click" on "Item view Tab" for "Security" in "Item View Page"
    And user verifies "Tags widget" is "displayed" in Manage Configurations panel
    And user verifies rating facet in item view
    And user "click" on "Item view Tab" for "Compliance" in "Item View Page"
    And user verifies "Tags widget" is "displayed" in Manage Configurations panel
    And user verifies rating facet in item view
    And user "click" on "Item view Tab" for "Data" in "Item View Page"
    And user verifies "Tags widget" is "displayed" in Manage Configurations panel
    And user verifies rating facet in item view

  ##7030723##7030724##
  @MLP-20228 @webtest @regression @positive
  Scenario:SC4#:MLP-20228:Create an BA Item
    Given User launch browser and traverse to login page
    When user enter credentials for "Information User" role
    And user verifies "Create" is "not displayed" in "Left bar menu"
    And user verifies "Admin" is "not displayed" in "Left bar menu"

  Scenario:Delete plugin Configurations ,credentials
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                | body | response code | response message | jsonPath |
      | application/json | raw   | false | Delete | settings/credentials/GitCred                       |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS    |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/GitCollectorConfig |      |               |                  |          |


  @jdbc
  Scenario: Create Datasource, Plugin and Credentials for GitCollector
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
      |                  |       |       | Put    | settings/analyzers/GitCollector/GitCollectorConfig | idc/IDX_PluginPayloads/MLP-20220_GitCollector_Plugin_Config.json     | 204           |                    |          |
      |                  |       |       | Get    | settings/analyzers/GitCollector/GitCollectorConfig |                                                                      | 200           | GitCollectorConfig |          |

    ##7034870##7034871##
  @MLP-20388 @regression @positive
  Scenario:MLP-20388:SC5#: Verify if user can retrieve the Plugin Configuration using View Definitions > GET "/schemes/analyzers/{Pluginname}/{Configurationname}"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                               | body | response code | response message                                                                                                                           | jsonPath      |
      | application/json |       |       | Get  | schemes/analyzers/GitCollector/GitCollectorConfig |      | 200           | Name,Plugin version,Label,Event condition,Dry Run,Event class,pluginType,Node condition,Credential,Data Source,Business Application,Branch | "$..['label'] |

    ##7040071##7040072##7040074##
  @MLP-18663 @webtest @regression @positive
  Scenario: SC6#:MLP-18663: Verification of "Lineage Statistics" options under left side of the application
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "regions" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Lineage" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                                            | ActionItem                          |
      | Verify Lineage Statistics widgets                     | Diagram Data                        |
      | Verify Lineage Statistics widgets                     | Lineage Service Execution           |
      | Verify Lineage Statistics widgets                     | Number of Items by Type             |
      | Verify Lineage Statistics widgets                     | Number of Lineage Hops by Each Type |
      | Verify Number of Item types in Number of Items widget | Table                               |
    And User performs following actions in the Item view Page
      | Actiontype                               | ActionItem   | ItemName                |
      | Verify Lineage Statistics widget content | Diagram Data | Number of Diagram Nodes |
      | Verify Lineage Statistics widget content | Diagram Data | Number of Diagram Edges |

    ##7040073##
  @MLP-18663 @webtest @regression @positive
  Scenario: SC7#:MLP-18663: Verification of Lineage statistics panel displayed with "Lineage Service Execution"
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "regions" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Lineage" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                               | ActionItem                | ItemName                       |
      | Verify Lineage Statistics widget content | Lineage Service Execution | Execution Time                 |
      | Verify Lineage Statistics widget content | Lineage Service Execution | Execution Duration             |
      | Verify Lineage Statistics widget content | Lineage Service Execution | Visited Lineage Target Objects |
      | Verify Lineage Statistics widget content | Lineage Service Execution | Visited Lineage Hops           |
    And User performs following actions in the Item view Page
      | Actiontype                        | ActionItem   |
      | Verify Lineage Statistics widgets | Diagram Data |

    ##7042955##
  @MLP-18663 @webtest @regression @positive
  Scenario: SC8#:MLP-18663: Verification of Expand/Collapse of Diagram Data
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "regions" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Lineage" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                                | ActionItem                                 |
      | Collapse                                  | Diagram Data                               |
      | Collapse                                  | Lineage Service Execution                  |
      | Collapse                                  | Number of Items by Type (with parent type) |
      | Collapse                                  | Number of Lineage Hops by Each Type        |
      | Verify Lineage Statistics widgets absense | Diagram Data                               |
      | Expand                                    | Diagram Data                               |
      | Verify Lineage Statistics widgets         | Diagram Data                               |

  ##7042955##
  @MLP-18663 @webtest @regression @positive
  Scenario: SC9#:MLP-18663: Verification of Expand/Collapse of Lineage Service Execution
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "regions" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Lineage" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                                | ActionItem                                 |
      | Collapse                                  | Diagram Data                               |
      | Collapse                                  | Lineage Service Execution                  |
      | Collapse                                  | Number of Items by Type (with parent type) |
      | Collapse                                  | Number of Lineage Hops by Each Type        |
      | Verify Lineage Statistics widgets absense | Lineage Service Execution                  |
      | Expand                                    | Lineage Service Execution                  |
      | Verify Lineage Statistics widgets         | Lineage Service Execution                  |

      ##7042955##
  @MLP-18663 @webtest @regression @positive
  Scenario: SC10#:MLP-18663: Verification of Expand/Collapse of Number of Items by Type
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "regions" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Lineage" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                                | ActionItem                                 |
      | Collapse                                  | Diagram Data                               |
      | Collapse                                  | Lineage Service Execution                  |
      | Collapse                                  | Number of Items by Type (with parent type) |
      | Collapse                                  | Number of Lineage Hops by Each Type        |
      | Verify Lineage Statistics widgets absense | Number of Items by Type (with parent type) |
      | Expand                                    | Number of Items by Type (with parent type) |
      | Verify Lineage Statistics widgets         | Number of Items by Type (with parent type) |

##7042955##
  @MLP-18663 @webtest @regression @positive
  Scenario: SC11#:MLP-18663: Verification of Expand/Collapse of Number of Lineage Hops by Each Type
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "regions" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Lineage" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                                | ActionItem                                 |
      | Collapse                                  | Diagram Data                               |
      | Collapse                                  | Lineage Service Execution                  |
      | Collapse                                  | Number of Items by Type (with parent type) |
      | Collapse                                  | Number of Lineage Hops by Each Type        |
      | Verify Lineage Statistics widgets absense | Number of Lineage Hops by Each Type        |
      | Expand                                    | Number of Lineage Hops by Each Type        |
      | Verify Lineage Statistics widgets         | Number of Lineage Hops by Each Type        |






