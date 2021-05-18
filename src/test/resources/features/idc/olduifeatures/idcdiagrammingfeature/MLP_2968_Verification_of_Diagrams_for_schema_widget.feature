@MLP-2968
Feature: MLP-2968 Verification of lineage diagrams for schema view

  @MLP-2968 @webtest @positive @regression @Diagramming
  Scenario: MLP-2968 Verification of selecting namespace relationship in Schema View
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user clicks on "Schema" dashboard
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option                           | dropdown    |
      | Show Namespace Relationship only | MoreActions |
    Then user verifies whether the following image is present
      | Method           | Action                                 | Path                    |
      | initializeImage  | Schema_show_namespace_relationship.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                      |                         |

  @MLP-2968 @webtest @positive @regression @Diagramming
  Scenario: MLP-2968 Verification of selecting show link relationship in Schema View
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user clicks on "Schema" dashboard
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option                      | dropdown    |
      | Show Link Relationship only | MoreActions |
    Then user verifies whether the following image is present
      | Method           | Action                                 | Path                    |
      | initializeImage  | Schema_Show_link_relationship_only.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                      |                         |

  @MLP-2968 @webtest @positive @regression @Diagramming
  Scenario: MLP-2968 Verification of selecting show namespace and link relationship in Schema View
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user clicks on "Schema" dashboard
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option                               | dropdown    |
      | Show Namespace and Link Relationship | MoreActions |
    Then user verifies whether the following image is present
      | Method           | Action                                      | Path                    |
      | initializeImage  | Schema_show_namespace_and_link_relation.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                           |                         |

  @MLP-2968 @webtest @positive @regression @Diagramming
  Scenario: MLP-2968 Verification of Select All and Deselect All button in the hamburger icon of schema view widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user clicks on "Schema" dashboard
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown |
      | Select All | select   |
    Then user verifies whether the following image is present
      | Method           | Action                | Path                    |
      | initializeImage  | Schema_Select_All.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                     |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option       | dropdown |
      | Deselect All | select   |
    And user verifies whether the following image is present
      | Method           | Action                  | Path                    |
      | initializeImage  | Schema_Deselect_All.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                       |                         |

  @MLP-2968 @webtest @positive @regression @Diagramming
  Scenario: MLP-2968 Verification of search by name in schema widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user clicks on "Schema" dashboard
    And user "click" full view icon in the Diagramming page
    And user enters "Source" in the search box and clicks search icon in the Diagramming Page
    Then user verifies whether the following image is present
      | Method           | Action                   | Path                    |
      | initializeImage  | Schema_search_result.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                        |                         |

  @webtest @MLP-2968 @webtest @positive @regression @Diagramming
  Scenario: MLP-2968 Verification of Export SVG button in the hamburger icon of schema view widget
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user clicks on "Schema" dashboard
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown    |
      | Export SVG | MoreActions |
    And exported file should be moved to the destination location
      | fileName | extension | path                    | destFileName          |
      | lineage  | .svg      | SVG_FILES_DOWNLOAD_PATH | schema_export_Lineage |
    And user deletes the file "schema_export_Lineage" from "SVG_FILES_DOWNLOAD_PATH"
    And user should be able logoff the IDC

  @MLP-2968 @webtest @positive @regression @Diagramming
  Scenario: MLP-2968 Verification of collapse selected in schema view widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user clicks on "Schema" dashboard
    And user "click" full view icon in the Diagramming page
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      |                 | Project         |
      |                 | Service         |
      |                 | Database        |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option            | dropdown    |
      | Collapse Selected | MoreActions |
    Then user verifies whether the following image is present
      | Method           | Action                       | Path                    |
      | initializeImage  | Schema_Collapse_Selected.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                            |                         |
    And user clicks on expand button for "Collapsed Set 1" node
    And user verifies whether the following image is present
      | Method           | Action                 | Path                    |
      | initializeImage  | Schema_uncollapsed.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                      |                         |

  @MLP-2968 @webtest @positive @regression @Diagramming
  Scenario: MLP-2968 Verification of Actions Select Forward and Backward button in hamburger icon in schema view widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user clicks on "Schema" dashboard
    And user "click" full view icon in the Diagramming page
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      |                 | Project         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option         | dropdown |
      | Select Forward | select   |
    Then user verifies whether the following image is present
      | Method           | Action                    | Path                    |
      | initializeImage  | Schema_select_forward.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                         |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option       | dropdown |
      | Deselect All | select   |
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      |                 | SourceTree      |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option          | dropdown |
      | Select Backward | select   |
    Then user verifies whether the following image is present
      | Method           | Action                     | Path                    |
      | initializeImage  | Schema_select_backward.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                          |                         |

  @MLP-2968 @webtest @positive @regression @Diagramming
  Scenario: MLP-2968 Verification of Actions Select All Backward button in hamburger icon
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user clicks on "Schema" dashboard
    And user "click" full view icon in the Diagramming page
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      |                 | Project         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option              | dropdown |
      | Select All Backward | select   |
    Then user verifies whether the following image is present
      | Method           | Action                         | Path                    |
      | initializeImage  | Schema_select_All_Backward.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                              |                         |

  @MLP-2968 @webtest @positive @regression @Diagramming
  Scenario: MLP-2968 Verification of Actions for zooming in the hamburger icon of schema view widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user clicks on "Schema" dashboard
    And user "click" full view icon in the Diagramming page
    And user clicks on "zoom out" icon in diagram
    And user clicks on "zoom out" icon in diagram
    Then user verifies whether the following image is present
      | Method           | Action              | Path                    |
      | initializeImage  | Schema_zoom_out.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                   |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option                            | dropdown      |
      | http://www.asg.com/Analyzer/9.5.0 | relationships |
    And user clicks on "zoom in" icon in diagram
    And user clicks on "zoom in" icon in diagram
    And user verifies whether the following image is present
      | Method           | Action             | Path                    |
      | initializeImage  | Schema_zoom_in.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                  |                         |

  @MLP-2968 @webtest @positive @regression @Diagramming
  Scenario: MLP-2968 Verification of "Hide UnSelected" and "Hide Selected" functionality in hamburger icon of schema view widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user clicks on "Schema" dashboard
    And user "click" full view icon in the Diagramming page
    And user verifies whether the following image is present
      | Method           | Action                  | Path                    |
      | initializeImage  | Schema_Deselect_All.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                       |                         |
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      |                 | Namespace       |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option        | dropdown    |
      | Hide Selected | MoreActions |
    Then user verifies whether the following image is present
      | Method           | Action                   | Path                    |
      | initializeImage  | Schema_Hide_Selected.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                        |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option   | dropdown    |
      | Show All | MoreActions |
    And user verifies whether the following image is present
      | Method           | Action                          | Path                    |
      | initializeImage  | Schema_Deselect_All_ShowAll.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                               |                         |
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      |                 | Namespace       |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option          | dropdown    |
      | Hide Unselected | MoreActions |
    And user verifies whether the following image is present
      | Method           | Action                     | Path                    |
      | initializeImage  | Schema_Hide_Unselected.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                          |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option   | dropdown    |
      | Show All | MoreActions |
    And user verifies whether the following image is present
      | Method           | Action                             | Path                    |
      | initializeImage  | Schema_Deselect_All_Unselected.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                  |                         |

  @MLP-2968 @webtest @positive @regression @Diagramming
  Scenario: MLP-2968 Verification of selecting catalogs in Schema View
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user clicks on "Schema" dashboard
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option  | dropdown      |
      | BigData | relationships |
    And user clicks on "zoom out" icon in diagram
    And user clicks on "zoom out" icon in diagram
    Then user verifies whether the following image is present
      | Method           | Action                  | Path                    |
      | initializeImage  | Schema_BigData_view.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                       |                         |

  @MLP-2968 @webtest @positive @regression @Diagramming
  Scenario: MLP-2968 Verification of invert selection in the hamburger icon
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user clicks on "Schema" dashboard
    And user "click" full view icon in the Diagramming page
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      |                  | SourceTree       |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option           | dropdown |
      | Invert Selection | select   |
    Then user verifies whether the following image is present
      | Method           | Action                      | Path                    |
      | initializeImage  | Schema_Invert_Selection.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                           |                         |

  @MLP-2963 @webtest @positive @regression @Diagramming
  Scenario: MLP-2963 Verification of data flow from right to left in lineage diagrams
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "customerID" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user checks the checkbox for "Accounting [Database]" in Parent hierarchy
    And user selects the "Column" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option          | dropdown      |
      | Forward Lineage | relationships |
    And user clicks on expand button for "Loyalty [Database]" node
    Then user verifies whether the following image is present
      | Method           | Action                       | Path                    |
      | initializeImage  | Lineage_Database_Loyalty.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                            |                         |
    And user clicks on expand button for "Rewards [Table]" node
    And user verifies whether the following image is present
      | Method           | Action                    | Path                    |
      | initializeImage  | Lineage_Table_Rewards.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                         |                         |
    And user clicks on expand button for "MarketingCampaigns [Table]" node
    And user verifies whether the following image is present
      | Method           | Action                       | Path                    |
      | initializeImage  | Lineage_Column_Marketing.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                            |                         |
    And user clicks on expand button for "Marketplace [Database]" node
    And user verifies whether the following image is present
      | Method           | Action                        | Path                    |
      | initializeImage  | Lineage_Table_Marketplace.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                             |                         |
    And user clicks on expand button for "Transactions [Table]" node
    And user verifies whether the following image is present
      | Method           | Action                          | Path                    |
      | initializeImage  | Lineage_Column_Transactions.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                               |                         |
    And user clicks on expand button for "TopSellers [Table]" node
    And user verifies whether the following image is present
      | Method           | Action                        | Path                    |
      | initializeImage  | Lineage_Column_TopSellers.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                             |                         |
    And user clicks on expand button for "Reporting [Database]" node
    And user verifies whether the following image is present
      | Method           | Action                         | Path                    |
      | initializeImage  | Lineage_Database_Reporting.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                              |                         |
    And user clicks on expand button for "AccountReports [Table]" node
    And user verifies whether the following image is present
      | Method           | Action                           | Path                    |
      | initializeImage  | Lineage_Table_AccountReports.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                |                         |
    And user clicks on expand button for "Accounts [Table]" node
    And user verifies whether the following image is present
      | Method           | Action                      | Path                    |
      | initializeImage  | Lineage_Column_Accounts.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                           |                         |

  @MLP-2963 @webtest @positive @regression @Diagramming
  Scenario: MLP-2963 Verification of data flow from left to right in lineage diagrams
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "customerID" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user checks the checkbox for "Accounting [Database]" in Parent hierarchy
    And user selects the "Column" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option          | dropdown      |
      | Forward Lineage | relationships |
    And user clicks on expand button for "Accounts [Table]" node
    And user verifies whether the following image is present
      | Method           | Action                         | Path                    |
      | initializeImage  | Lineage_Column_Accounts_LR.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                              |                         |
    And user clicks on expand button for "Marketplace [Database]" node
    And user verifies whether the following image is present
      | Method           | Action                           | Path                    |
      | initializeImage  | Lineage_Table_Marketplace_LR.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                |                         |
    And user clicks on expand button for "Transactions [Table]" node
    And user verifies whether the following image is present
      | Method           | Action                             | Path                    |
      | initializeImage  | Lineage_Column_Transactions_LR.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                  |                         |
    And user clicks on expand button for "TopSellers [Table]" node
    And user verifies whether the following image is present
      | Method           | Action                           | Path                    |
      | initializeImage  | Lineage_Column_TopSellers_LR.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                |                         |
    And user clicks on expand button for "Reporting [Database]" node
    And user verifies whether the following image is present
      | Method           | Action                            | Path                    |
      | initializeImage  | Lineage_Database_Reporting_LR.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                 |                         |
    And user clicks on expand button for "AccountReports [Table]" node
    And user verifies whether the following image is present
      | Method           | Action                              | Path                    |
      | initializeImage  | Lineage_Table_AccountReports_LR.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                   |                         |
    And user clicks on "zoom out" icon in diagram
    And user clicks on "zoom out" icon in diagram
    And user clicks on expand button for "Loyalty [Database]" node
    Then user verifies whether the following image is present
      | Method           | Action                          | Path                    |
      | initializeImage  | Lineage_Database_Loyalty_LR.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                               |                         |
    And user clicks on expand button for "Rewards [Table]" node
    And user verifies whether the following image is present
      | Method           | Action                       | Path                    |
      | initializeImage  | Lineage_Table_Rewards_LR.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                            |                         |
    And user clicks on expand button for "MarketingCampaigns [Table]" node
    And user verifies whether the following image is present
      | Method           | Action                          | Path                    |
      | initializeImage  | Lineage_Column_Marketing_LR.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                               |                         |

  @MLP-2967 @webtest @positive @regression @Diagramming
  Scenario: MLP-2967 Verification of lineage edges
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/catalogs/DiagrammingCatalog"
    And supply payload with file name "idc/Diagramming_CreateCatalog.json"
    And user makes a REST Call for POST request with url "settings/catalogs"
    And Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "idc/MLP_2967_lineage.xml"
    When user makes a REST Call for POST request with url "import/DiagrammingCatalog" with the following query param
      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&streamStartItemCount=50000 |
    Then Status code 200 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "DiagrammingCatalog" catalog from catalog list
    And user clicks on search icon
    And user enters the search text "accounting" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Function" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown      |
      | References | relationships |
    And user clicks on "zoom in" icon in diagram
    And user clicks on "zoom in" icon in diagram
    Then user verifies whether the following image is present
      | Method           | Action                        | Path                    |
      | initializeImage  | Relationships_Lineage_Hop.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                             |                         |









