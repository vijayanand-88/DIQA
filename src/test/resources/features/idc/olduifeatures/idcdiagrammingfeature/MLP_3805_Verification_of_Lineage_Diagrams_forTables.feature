@MLP-3805
Feature: MLP-3805 Verification of lineage diagrams for Tables

  @MLP-3805 @webtest @positive @regression @Diagramming
  Scenario: MLP-3805 Verification of the grouping all columns to table
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "orders" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option          | dropdown      |
      | Forward Lineage | relationships |
    Then user verifies whether the following image is present
      | Method           | Action                    | Path                    |
      | initializeImage  | forward_Lineage_Table.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                         |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option           | dropdown      |
      | Backward Lineage | relationships |
    And user verifies whether the following image is present
      | Method           | Action                     | Path                    |
      | initializeImage  | backward_Lineage_Table.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                          |                         |

  @MLP-3805 @webtest @positive @regression @Diagramming
  Scenario: MLP-3805 Verification of Select All and Deselect All button in the hamburger icon
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "employees_full" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown |
      | Select All | select   |
    Then user verifies whether the following image is present
      | Method           | Action                 | Path                    |
      | initializeImage  | Lineage_Select_All.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                      |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option       | dropdown |
      | Deselect All | select   |
    And user verifies whether the following image is present
      | Method           | Action                   | Path                    |
      | initializeImage  | Lineage_Deselect_All.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                        |                         |

  @MLP-3805 @webtest @positive @regression @Diagramming
  Scenario: MLP-3805 Verification of collapsing diagram with multiple collapsed item set
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "customerdemographics" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    And user select the following items by pressing "CONTROL"
      | lineageNodeName      | lineageNodeType |
      | customerdemographics | Table           |
      | customers            | Table           |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option            | dropdown    |
      | Collapse Selected | MoreActions |
    Then user verifies whether the following image is present
      | Method           | Action                              | Path                    |
      | initializeImage  | Lineage_Collapse_Selected_Item1.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                   |                         |
    And user select the following items by pressing "CONTROL"
      | lineageNodeName      | lineageNodeType |
      | customercustomerdemo | Table           |
      | categories           | Table           |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option            | dropdown    |
      | Collapse Selected | MoreActions |
    And user verifies whether the following image is present
      | Method           | Action                              | Path                    |
      | initializeImage  | Lineage_Collapse_Selected_Item2.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                   |                         |

  @MLP-3805 @webtest @positive @regression @Diagramming
  Scenario: MLP-3805 Verification of collapsing diagram
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "customerdemographics" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option          | dropdown      |
      | Forward Lineage | relationships |
    And user select the following items by pressing "CONTROL"
      | lineageNodeName      | lineageNodeType |
      | customerdemographics | Table           |
      | customers            | Table           |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option            | dropdown    |
      | Collapse Selected | MoreActions |
    Then user verifies whether the following image is present
      | Method           | Action                              | Path                    |
      | initializeImage  | Lineage_Collapse_Selected_Item1.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                   |                         |
    And user clicks on expand button for "Collapsed Item Set 1" node
    And user verifies whether the following image is present
      | Method           | Action                 | Path                    |
      | initializeImage  | Lineage_Expand_All.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                      |                         |

  @MLP-3805 @webtest @positive @regression @Diagramming
  Scenario: MLP-3805 Verification of Collapse button in the Hamburger menu
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "employees_full" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option          | dropdown      |
      | Forward Lineage | relationships |
    And user clicks on the icon in the diagramming page
      | iconName  |
      | ExpandAll |
    Then user verifies whether the following image is present
      | Method           | Action                       | Path                    |
      | initializeImage  | Lineage_Expand_All_Image.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                            |                         |
    And user clicks on the icon in the diagramming page
      | iconName    |
      | CollapseAll |
    And user verifies whether the following image is present
      | Method           | Action                         | Path                    |
      | initializeImage  | Lineage_Collapse_All_Image.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                              |                         |

  @MLP-3805 @webtest @positive @regression @Diagramming
  Scenario: MLP-3805 Verification of Actions Select All Forward button in hamburger icon
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "LineageDemo Cluster" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Cluster" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown      |
      | References | relationships |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | Production       | Service          | Add References    |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option             | dropdown |
      | Select All Forward | select   |
    Then user verifies whether the following image is present
      | Method           | Action                                       | Path                    |
      | initializeImage  | Relationships_Service_Select_All_Forward.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                            |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option       | dropdown |
      | Deselect All | select   |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | Marketplace      | Database         | Add References    |
    And user clicks on "zoom out" icon in diagram
    And user selects the value from the dropdown for various operations in Diagramming page
      | option             | dropdown |
      | Select All Forward | select   |
    And user verifies whether the following image is present
      | Method           | Action                                        | Path                    |
      | initializeImage  | Relationships_Database_Select_All_Forward.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                             |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option       | dropdown |
      | Deselect All | select   |
    And user clicks on "zoom out" icon in diagram
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | Transactions     | Table            | Add References    |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option             | dropdown |
      | Select All Forward | select   |
    And user verifies whether the following image is present
      | Method           | Action                                     | Path                    |
      | initializeImage  | Relationships_Table_Select_All_Forward.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                          |                         |

  @MLP-3805 @webtest @positive @regression @Diagramming
  Scenario: MLP-3805 Verification of "Hide Selected" functionality in hamburger icon
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      | employees_full  | Table           |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option        | dropdown    |
      | Hide Selected | MoreActions |
    Then user verifies whether the following image is present
      | Method           | Action                    | Path                    |
      | initializeImage  | Lineage_Hide_Selected.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                         |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option   | dropdown    |
      | Show All | MoreActions |
    And user verifies whether the following image is present
      | Method           | Action               | Path                    |
      | initializeImage  | Lineage_Show_All.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                    |                         |

  @MLP-3805 @webtest @positive @regression @Diagramming
  Scenario: MLP-3805 Verification of Adding references recursive
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user clicks on search icon
    And user enters the search text "shipcountry" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Column" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user "click" full view icon in the Diagramming page
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList        |
      | orders           | Table            | Add References Recursive |
    And user clicks on "zoom out" icon in diagram
    And user clicks on "zoom out" icon in diagram
    Then user verifies whether the following image is present
      | Method           | Action                               | Path                    |
      | initializeImage  | Lineage_Add_References_Recursive.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                    |                         |

  @MLP-3805 @webtest @positive @regression @Diagramming
  Scenario: MLP-3805 Verification of Add usages recursive
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user clicks on search icon
    And user enters the search text "shipcountry" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Column" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user "click" full view icon in the Diagramming page
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList    |
      | orders           | Table            | Add Usages Recursive |
    And user clicks on "zoom out" icon in diagram
    And user clicks on "zoom out" icon in diagram
    Then user verifies whether the following image is present
      | Method           | Action                            | Path                    |
      | initializeImage  | Lineage_Add_Usuages_Recursive.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                 |                         |

  @MLP-3805 @webtest @positive @regression @Diagramming
  Scenario: MLP-3805 Verification of Add References option
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user clicks on search icon
    And user enters the search text "LineageDemo Cluster" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Cluster" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown      |
      | References | relationships |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | Production       | Service          | Add References    |
    Then user verifies whether the following image is present
      | Method           | Action                                   | Path                    |
      | initializeImage  | Relationships_Service_Add_References.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                        |                         |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | Marketplace      | Database         | Add References    |
    And user clicks on "zoom out" icon in diagram
    And user verifies whether the following image is present
      | Method           | Action                                    | Path                    |
      | initializeImage  | Relationships_Database_Add_References.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                         |                         |
    And user clicks on "zoom out" icon in diagram
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | Transactions     | Table            | Add References    |
    And user verifies whether the following image is present
      | Method           | Action                                        | Path                    |
      | initializeImage  | Relationships_Table_Select_Add_References.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                             |                         |

  @MLP-3805 @webtest @positive @regression @Diagramming
  Scenario: MLP-3805 Verification of Expand All boxes/Drilldown button in the Hamburger menu
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList  |
      | employees_full   | Table            | Drilldown / Expand |
    Then user verifies whether the following image is present
      | Method           | Action                        | Path                    |
      | initializeImage  | Lineage_Drill_down_Expand.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                             |                         |

  @MLP-3805 @webtest @positive @regression @Diagramming
  Scenario: MLP-3805 Verification of edge info popup for backward lineage
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "employees_full" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option           | dropdown      |
      | Backward Lineage | relationships |
    And user clicks on "zoom out" icon in diagram
    And user clicks on "zoom out" icon in diagram
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      | regions         | Table           |
    Then user verifies whether the following image is present
      | Method           | Action                     | Path                    |
      | initializeImage  | Lineage_Edge_Info_Icon.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                          |                         |

  @MLP-3805 @webtest @positive @regression @Diagramming
  Scenario: MLP-3805  Verification of "Relayout" is renamed to "Reload" with reload icon and Full size button is displayed next to optical size icons
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    Then user verifies whether the following image is present
      | Method           | Action                  | Path                    |
      | initializeImage  | Lineage_Reload_Icon.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                       |                         |
      | initializeImage  | Lineage_Full_Icon.png   | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                       |                         |

  @MLP-3805 @webtest @positive @regression @Diagramming
  Scenario: MLP-3805 Verification of zooming using + key and - key
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user clicks on search icon
    And user enters the search text "shippers" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    And user clicks on "zoom out" icon in diagram
    And user clicks on "zoom out" icon in diagram
    Then user verifies whether the following image is present
      | Method           | Action               | Path                    |
      | initializeImage  | Lineage_Zoom_Out.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                    |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option          | dropdown      |
      | Forward Lineage | relationships |
    And user clicks on "zoom in" icon in diagram
    And user verifies whether the following image is present
      | Method           | Action              | Path                    |
      | initializeImage  | Lineage_Zoom_In.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                   |                         |

  @MLP-3805 @webtest @positive @regression @Diagramming
  Scenario: MLP-3805 Verification of Add Usages option
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "sales_fact_dec_1998" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown      |
      | References | relationships |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames    | lineageItemTypes | hamburgerMenuList |
      | sales_fact_dec_1998 | Table            | Add Usages        |
    Then user verifies whether the following image is present
      | Method           | Action                             | Path                    |
      | initializeImage  | Relationships_Table_Add_Usages.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                  |                         |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | foodmart         | Database         | Add Usages        |
    And user verifies whether the following image is present
      | Method           | Action                                | Path                    |
      | initializeImage  | Relationships_Database_Add_Usages.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                     |                         |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | HIVE             | Service          | Add Usages        |
    And user clicks on "zoom out" icon in diagram
    And user verifies whether the following image is present
      | Method           | Action                               | Path                    |
      | initializeImage  | Relationships_Service_Add_Usages.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                    |                         |

  @MLP-2585 @webtest @positive @regression @Diagramming
  Scenario: MLP-2585 Verification of Actions Select Forward button in hamburger icon
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "LineageDemo Cluster" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Cluster" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown      |
      | References | relationships |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | Production       | Service          | Add References    |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option         | dropdown |
      | Select Forward | select   |
    Then user verifies whether the following image is present
      | Method           | Action                                   | Path                    |
      | initializeImage  | Relationships_Service_Select_Forward.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                        |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option       | dropdown |
      | Deselect All | select   |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | Marketplace      | Database         | Add References    |
    And user clicks on "zoom out" icon in diagram
    And user selects the value from the dropdown for various operations in Diagramming page
      | option         | dropdown |
      | Select Forward | select   |
    And user verifies whether the following image is present
      | Method           | Action                                    | Path                    |
      | initializeImage  | Relationships_Database_Select_Forward.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                         |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option       | dropdown |
      | Deselect All | select   |
    And user clicks on "zoom out" icon in diagram
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | Transactions     | Table            | Add References    |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option         | dropdown |
      | Select Forward | select   |
    And user verifies whether the following image is present
      | Method           | Action                                 | Path                    |
      | initializeImage  | Relationships_Table_Select_Forward.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                      |                         |

  @MLP-2585 @webtest @positive @regression @Diagramming
  Scenario: MLP-2585 Verification of Actions Select Backward button in hamburger icon
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "LineageDemo Cluster" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Cluster" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown      |
      | References | relationships |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | Production       | Service          | Add References    |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option          | dropdown |
      | Select Backward | select   |
    Then user verifies whether the following image is present
      | Method           | Action                                    | Path                    |
      | initializeImage  | Relationships_Service_Select_Backward.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                         |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option       | dropdown |
      | Deselect All | select   |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | Marketplace      | Database         | Add References    |
    And user clicks on "zoom out" icon in diagram
    And user selects the value from the dropdown for various operations in Diagramming page
      | option          | dropdown |
      | Select Backward | select   |
    And user verifies whether the following image is present
      | Method           | Action                                     | Path                    |
      | initializeImage  | Relationships_Database_Select_Backward.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                          |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option       | dropdown |
      | Deselect All | select   |
    And user clicks on "zoom out" icon in diagram
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | Transactions     | Table            | Add References    |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option          | dropdown |
      | Select Backward | select   |
    And user verifies whether the following image is present
      | Method           | Action                                  | Path                    |
      | initializeImage  | Relationships_Table_Select_Backward.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                       |                         |

  @MLP-2585 @webtest @positive @regression @Diagramming
  Scenario: MLP-2585 Verification of Actions Select All Backward button in hamburger icon
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "LineageDemo Cluster" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Cluster" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown      |
      | References | relationships |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | Production       | Service          | Add References    |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option              | dropdown |
      | Select All Backward | select   |
    Then user verifies whether the following image is present
      | Method           | Action                                        | Path                    |
      | initializeImage  | Relationships_Service_Select_All_Backward.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                             |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option       | dropdown |
      | Deselect All | select   |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | Marketplace      | Database         | Add References    |
    And user clicks on "zoom out" icon in diagram
    And user selects the value from the dropdown for various operations in Diagramming page
      | option              | dropdown |
      | Select All Backward | select   |
    And user verifies whether the following image is present
      | Method           | Action                                         | Path                    |
      | initializeImage  | Relationships_Database_Select_All_Backward.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                              |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option       | dropdown |
      | Deselect All | select   |
    And user clicks on "zoom out" icon in diagram
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | Transactions     | Table            | Add References    |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option              | dropdown |
      | Select All Backward | select   |
    And user verifies whether the following image is present
      | Method           | Action                                      | Path                    |
      | initializeImage  | Relationships_Table_Select_All_Backward.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                           |                         |

  @MLP-2168 @webtest @positive @regression @Diagramming
  Scenario: MLP-2168 Verification of all the select options available in diagramming page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user enters the search text "customerdemographics" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option               | dropdown      |
      | References Recursive | relationships |
    And user select the following items by pressing "CONTROL"
      | lineageNodeName      | lineageNodeType |
      | customerdemographics | Table           |
      | customercustomerdemo | DataSample      |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option                                  | dropdown |
      | Select Paths between 2 Items with loops | select   |
    Then user verifies whether the following image is present
      | Method           | Action                              | Path                    |
      | initializeImage  | path_between_2_items_with_loops.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 3                                   |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option       | dropdown |
      | Deselect All | select   |
    And user select the following items by pressing "CONTROL"
      | lineageNodeName      | lineageNodeType |
      | customerdemographics | Table           |
      | customercustomerdemo | DataSample      |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option                                 | dropdown |
      | Select Paths between 2 Items w/o loops | select   |
    And user verifies whether the following image is present
      | Method           | Action                                 | Path                    |
      | initializeImage  | path_between_2_items_without_loops.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 3                                      |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option       | dropdown |
      | Deselect All | select   |
    And user select the following items by pressing "CONTROL"
      | lineageNodeName      | lineageNodeType |
      | customerdemographics | Table           |
      | customercustomerdemo | DataSample      |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option                                    | dropdown |
      | Select all shortest Paths between 2 Items | select   |
    And user verifies whether the following image is present
      | Method           | Action                                | Path                    |
      | initializeImage  | all_shortest_path_between_2_items.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 3                                     |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option       | dropdown |
      | Deselect All | select   |
    And user select the following items by pressing "CONTROL"
      | lineageNodeName      | lineageNodeType |
      | customerdemographics | Table           |
      | customercustomerdemo | DataSample      |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option                               | dropdown |
      | Select shortest Path between 2 Items | select   |
    And user verifies whether the following image is present
      | Method           | Action                            | Path                    |
      | initializeImage  | shortest_path_between_2_items.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 3                                 |                         |

  @MLP-3805 @MLP-3089 @webtest @positive @regression @Diagramming
  Scenario: MLP-3805 MLP-3089 Verification of new background image
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "shippers" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user "click" full view icon in the Diagramming page
    Then user verifies whether the following image is present
      | Method           | Action                             | Path                    |
      | initializeImage  | Relationships_Background_Image.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                  |                         |
    And user "click" normal size icon in the Diagramming full view
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    And user verifies whether the following image is present
      | Method           | Action                       | Path                    |
      | initializeImage  | Lineage_Background_Image.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                            |                         |

  @MLP-2962 @webtest @positive @regression @Diagramming
  Scenario: MLP-2962 Verification of Drill up and Down option
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "shippers" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown      |
      | References | relationships |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | shippers         | Table            | Drillup           |
    Then user verifies whether the following image is present
      | Method           | Action                           | Path                    |
      | initializeImage  | Relationships_Table_Drill_up.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                |                         |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | northwind        | Database         | Add References    |
    And user clicks on "zoom out" icon in diagram
    And user clicks on "zoom out" icon in diagram
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList  |
      | shippers         | Table            | Drilldown / Expand |
    And user verifies whether the following image is present
      | Method           | Action                              | Path                    |
      | initializeImage  | Relationships_Column_Drill_down.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                   |                         |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | shippers         | Table            | Drillup           |
    And user clicks on "zoom in" icon in diagram
    And user clicks on "zoom in" icon in diagram
    And user verifies whether the following image is present
      | Method           | Action                           | Path                    |
      | initializeImage  | Relationships_Table_Drill_up.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                |                         |

  @MLP-2967 @MLP-3094 @webtest @positive @regression @Diagramming
  Scenario: MLP-2967 MLP-3094 Verification of no stratify error
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "fullname" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Column" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user "click" full view icon in the Diagramming page
    Then user verifies whether the following image is present
      | Method           | Action                              | Path                    |
      | initializeImage  | Relationships_No_Stratify_error.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                   |                         |
    And user "click" normal size icon in the Diagramming full view
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    And user verifies whether the following image is present
      | Method           | Action                       | Path                    |
      | initializeImage  | Schema_No_Stratify_error.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                            |                         |

  @MLP-3805 @webtest @positive @regression @Diagramming
  Scenario: MLP-3805 Verification of popup menu on nodes
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "fullname" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Column" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown      |
      | References | relationships |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | customer         | Table            | Drillup           |
    Then user verifies whether the following image is present
      | Method           | Action                               | Path                    |
      | initializeImage  | Relationships_pop_up_disappeared.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                    |                         |
    And user clicks the hamburger menu for the node
      | lineageNodeName | lineageNodeType |
      | foodmart        | Database        |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown      |
      | References | relationships |
    And user verifies whether the following image is present
      | Method           | Action                                     | Path                    |
      | initializeImage  | Relationships_pop_up_disappeared_Table.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                          |                         |
    And user "click" normal size icon in the Diagramming full view
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown      |
      | References | relationships |
    And user clicks the hamburger menu for the node
      | lineageNodeName | lineageNodeType |
      | customer        | Table           |
    And user uses robotclass with the following options
      | Method       | Action |
      | keyPress     | ESCAPE |
      | keyRelease   | ESCAPE |
      | setAutoDelay | 1000   |
    And user verifies whether the following image is present
      | Method           | Action                                           | Path                    |
      | initializeImage  | Relationships_pop_up_disappeared_normal_view.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                                |                         |

  @webtest @positive @regression @Diagramming
  Scenario: Verification of exclusion of other paths which is between 2 data items
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
    And supply payload with file name "idc/select_all_path.xml"
    When user makes a REST Call for POST request with url "import/DiagrammingCatalog" with the following query param
      | isRnx | true&rnxSchemaNamespace=http%3A%2F%2Fwww.asg.com%2FAnalyzer%2F9.5.0&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&streamStartItemCount=50000 |
    Then Status code 200 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "DiagrammingCatalog" catalog from catalog list
    And user clicks on search icon
    And user enters the search text "col0" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option               | dropdown      |
      | References Recursive | relationships |
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      | col1            | Column          |
      | col6            | Column          |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option                                 | dropdown |
      | Select Paths between 2 Items w/o loops | select   |
    Then user verifies whether the following image is present
      | Method           | Action                                 | Path                    |
      | initializeImage  | Relationships_Catalog_Without_loop.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                      |                         |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option       | dropdown |
      | Deselect All | select   |
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      | col1            | Column          |
      | col6            | Column          |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option                                    | dropdown |
      | Select all shortest Paths between 2 Items | select   |
    And user verifies whether the following image is present
      | Method           | Action                                     | Path                    |
      | initializeImage  | Relationships_Catalog_All_Sortest_Path.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                          |                         |

  @MLP-3477 @MLP-3199 @webtest @positive @regression @Diagramming
  Scenario Outline: MLP-3477 MLP-3199 Verification of the scrollbar for hop information pop up
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "Transactions" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option          | dropdown      |
      | Forward Lineage | relationships |
    And user clicks on the icon in the diagramming page
      | iconName  |
      | ExpandAll |
    And user hovers on diamond icon and click the info label icon
    Then user verifies whether the following image is present
      | Method           | Action                     | Path                    |
      | initializeImage  | Lineage_Hop_Info_Popup.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                          |                         |
    And user get the column "customerID" id from the following query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Column  | ID         | name         |
    And configure a new REST API for the service "IDC"
    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestServiceUser" user
    Then Status code 200 must be returned
    And response message contains value ""mode" : "COPY""
    And response message contains value ""type" : "LineageHop""
    And response message contains value ""name" : "lineageTest.Column:::7->lineageTest.Column:::14""
    Examples:
      | contentType      | acceptType       | type | url                                                           | endpoint | body |
      | application/json | application/json | Get  | searches/BigData/query/queryDiagramIn/BigData.Column%3A%3A%3A | ?limit=0 |      |

  @MLP-2962 @webtest @positive @regression @Diagramming
  Scenario: MLP-2962 Verification of Open New item option
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And user enters the search text "HIVE" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Service" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown      |
      | References | relationships |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | teststats        | Database         | Open Item         |
    Then user verifies whether the "teststats" pane is displayed
    And user verifies "4" pane is disaplayed
    And user clicks on "HIVE" item in the breadcrumb items
    And user verifies "4" pane is disaplayed

  @MLP-3199 @webtest @positive @regression @Diagramming
  Scenario: MLP-3199 Verification of expand all should now zoom one level down in lineage diagram
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
    And user clicks on the icon in the diagramming page
      | iconName  |
      | ExpandAll |
      | ExpandAll |
    Then user verifies whether the following image is present
      | Method           | Action                                | Path                    |
      | initializeImage  | Lineage_Expand_All_Zoom_one_level.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                     |                         |

  @MLP-2168 @webtest @positive @regression @Diagramming
  Scenario: MLP-2168 Importing data items using test file
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
    And supply payload with file name "idc/MLP_2168_sampleDataForPaths.xml"
    When user makes a REST Call for POST request with url "import/DiagrammingCatalog" with the following query param
      | isRnx | true&rnxSchemaNamespace=http%3A%2F%2Fwww.asg.com%2FAnalyzer%2F9.5.0&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&streamStartItemCount=50000 |
    Then Status code 200 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "DiagrammingCatalog" catalog from catalog list
    And user clicks on search icon
    And user selects the "Column" from the Type
    And user should be able logoff the IDC

  @MLP-3453 @webtest @positive @regression @Diagramming
  Scenario: MLP-3453 Verification of importing a Lineage.xml file
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
    And supply payload with file name "idc/MLP_3453_lineage.xml"
    When user makes a REST Call for POST request with url "import/DiagrammingCatalog" with the following query param
      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&streamStartItemCount=50000 |
    Then Status code 200 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "DiagrammingCatalog" catalog from catalog list
    And user clicks on search icon
    And user enters the search text "Rewards" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown      |
      | References | relationships |
    Then user verifies whether the following image is present
      | Method           | Action                           | Path                    |
      | initializeImage  | Relationships_import_lineage.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                                |                         |
