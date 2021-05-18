Feature: Diagramming Features

  @webtest @positive @MLP-2124 @UIDiagramming
  Scenario: MLP-2124_Verification of item type label in brackets beside the name in Lineage Diagrams
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab in item full view page
    And user "zoomIn" the Lineage diagram for "2" times
    And user click on drill icon for item "employees_full" and type "Table"
    Then Item type should "get" displayed beside the item name for following values
      | lineageNodeName | lineageNodeType |
#      | HIVE            | Service         |
      | northwind       | Database        |
      | employees_full  | Table           |
      | city            | Column          |

  @webtest @positive @MLP-2124 @UIDiagramming
  Scenario: MLP-2124_Verification of type displaying beside name in tool tip for Lineage Diagrams
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab in item full view page
    Then user mouse hovers below item in Lineage tab and verifies following type is displayed
      | lineageNodeName | lineageNodeType |
      | employees_full  | Table           |

  @webtest @positive @MLP-2172 @UIDiagramming
  Scenario: MLP-2172_Verification of "Hide Selected" functionality in hamburger icon
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab in item full view page
    And user clicks on node "employees_full" and type "Table" in Lineage tab
    And user clicks on "More Actions" menu and "Hide Selected" submenu
    Then node "employees_full" with type "Table" should "not get" displayed in Lineage diagram
    And user clicks on "More Actions" menu and "Show All" submenu
    Then node "employees_full" with type "Table" should "get" displayed in Lineage diagram

  @webtest @positive @MLP-2172 @UIDiagramming
  Scenario: MLP-2172_Verification of "Hide UnSelected" functionality in hamburger icon
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab in item full view page
    And user clicks on "More Actions" menu and "Hide Unselected" submenu
    Then node "employees_full" with type "Table" should "not get" displayed in Lineage diagram
    And user clicks on "More Actions" menu and "Show All" submenu
    Then node "employees_full" with type "Table" should "get" displayed in Lineage diagram

  @webtest @positive @MLP-2545 @UIDiagramming
  Scenario: MLP-2545_Verification of left mouse click selects one node
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab in item full view page
    And user clicks on node "employees_full" and type "Table" in Lineage tab
#    Then item "employees_full" should be highlighted with width "stroke-width: 2"
    Then following item should "be" highlighted and width should be "stroke-width: 2"
      | lineageNodeName | lineageNodeType |
      | employees_full  | Table           |

  @webtest @positive @MLP-2545 @UIDiagramming
  Scenario: MLP-2545_Verification of left click and ctrl key selects and deselects multiple nodes
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab in item full view page
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      | employees_full  | Table           |
      | suppliers       | Table           |
    Then following item should "be" highlighted and width should be "stroke-width: 2"
      | lineageNodeName | lineageNodeType |
      | employees_full  | Table           |
      | suppliers       | Table           |
    And user unselect the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      | employees_full  | Table           |
      | suppliers       | Table           |
    And user clicks on "Relationships" tab in item full view page
    And user clicks on "Lineage" tab in item full view page
    Then following item should "not be" highlighted and width should be "stroke-width: 2"
      | lineageNodeName | lineageNodeType |
      | employees_full  | Table           |
      | suppliers       | Table           |

  @webtest @positive @MLP-2673 @UIDiagramming
  Scenario: MLP-2673_Verification of zooming using + key
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab in item full view page
    And user "zoomIn" the Lineage diagram for "2" times using + icon
    Then following nodes should "get" displayed in Lineage Diagram
      | lineageNodeName | lineageNodeType |
      | HIVE            | Service         |

#  @webtest @positive @MLP-2673 @UIDiagramming
#  Scenario: MLP-2673_Verification of zooming using - key
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And login must be successful for all users
#    And user enters the search text "employees_full" and clicks on search
#    And user selects the "Table" from the Type
#    And user clicks on first item on the item list page
#    And user clicks on "Lineage" tab in item full view page
#    And user "zoomOut" the Lineage diagram for "3" times using + icon
#    Then following nodes should "not get" displayed in Lineage Diagram
#      | lineageNodeName | lineageNodeType |
#      | northwind       | Database        |

  @webtest @positive @MLP-2677 @UIDiagramming
  Scenario: MLP-2677_Verification of Collapse and Expand  button in the Lineage Diagram
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab in item full view page
    And user "click" full view icon in the Diagramming page
    And user "click" the slider to "7" in "EXPAND SCOPE" section in diagramming page
    Then following items should "get" displayed in Lineage Diagram
      | lineageNodeName | lineageNodeType |
      | city            | Column          |
      | region          | Column          |
      | address         | Column          |
      | country         | Column          |
      | postalcode      | Column          |
      | employeeid      | Column          |
    And user "click" the slider to "1" in "EXPAND SCOPE" section in diagramming page
    Then following items should "not get" displayed in Lineage Diagram
      | lineageNodeName | lineageNodeType |
      | city            | Column          |
      | region          | Column          |
      | address         | Column          |
      | country         | Column          |
      | postalcode      | Column          |
      | employeeid      | Column          |

#  @webtest @positive @MLP-2690 @UIDiagramming
#  Scenario: MLP-2690_Verification of collapsing diagram
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And login must be successful for all users
#    And user enters the search text "employees_full" and clicks on search
#    And user selects the "Table" from the Type
#    And user clicks on first item on the item list page
#    And user clicks on "Lineage" tab in item full view page
#    And user select the following items by pressing "CONTROL"
#      | lineageNodeName | lineageNodeType |
#      | employees_full  | Table           |
#      | suppliers       | Table           |
#    And user clicks on "More Actions" menu and "Collapse Selected" submenu
#    Then following items should "not get" displayed in Lineage Diagram
#      | lineageNodeName | lineageNodeType |
#      | employees_full  | Table           |
#      | suppliers       | Table           |
#    And user click on Cluster drill icon for item "Collapsed Item Set 1"
#    Then following items should "get" displayed in Lineage Diagram
#      | lineageNodeName | lineageNodeType |
#      | employees_full  | Table           |
#      | suppliers       | Table           |

#  @webtest @positive @MLP-2690 @UIDiagramming
#  Scenario: MLP-2690_Verification of collapsing diagram with multiple collapsed item set
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And login must be successful for all users
#    And user enters the search text "employees_full" and clicks on search
#    And user selects the "Table" from the Type
#    And user clicks on first item on the item list page
#    And user clicks on "Lineage" tab in item full view page
#    And user click on "Expand All" tool bar menu
#    And user select the following items by pressing "CONTROL"
#      | lineageNodeName | lineageNodeType |
#      | employees_full  | Table           |
#      | suppliers       | Table           |
#    And user clicks on "More Actions" menu and "Collapse Selected" submenu
#    And user select the following items by pressing "CONTROL"
#      | lineageNodeName | lineageNodeType |
#      | products        | Table           |
#      | supplierid      | Column          |
#    And user clicks on "More Actions" menu and "Collapse Selected" submenu
#    Then following items should "not get" displayed in Lineage Diagram
#      | lineageNodeName | lineageNodeType |
#      | employees_full  | Table           |
#      | suppliers       | Table           |
#      | products        | Table           |
#      | supplierid      | Column          |
#    And user click on Cluster drill icon for item "Collapsed Item Set 1"
#    And user click on Cluster drill icon for item "Collapsed Item Set 2"
#    Then following items should "get" displayed in Lineage Diagram
#      | lineageNodeName | lineageNodeType |
#      | employees_full  | Table           |
#      | suppliers       | Table           |
#      | products        | Table           |
#      | supplierid      | Column          |

#  @webtest @positive @MLP-2690 @UIDiagramming
#  Scenario: MLP-2690_Verification of collapsing item set is not created when single item is selected
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And login must be successful for all users
#    And user enters the search text "employees_full" and clicks on search
#    And user selects the "Table" from the Type
#    And user clicks on first item on the item list page
#    And user clicks on "Lineage" tab in item full view page
#    And user select the following items by pressing "CONTROL"
#      | lineageNodeName | lineageNodeType |
#      | employees_full  | Table           |
#    And user clicks on "More Actions" menu and "Collapse Selected" submenu
#    Then following items should "get" displayed in Lineage Diagram
#      | lineageNodeName | lineageNodeType |
#      | employees_full  | Table           |

#  @webtest @positive @MLP-2690 @UIDiagramming
#  Scenario: MLP-2690_Verification of collapsing node collapse the item set
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And login must be successful for all users
#    And user enters the search text "employees_full" and clicks on search
#    And user selects the "Table" from the Type
#    And user clicks on first item on the item list page
#    And user clicks on "Lineage" tab in item full view page
#    And user "click" full view icon in the Diagramming page
#    And user click on "Expand All" tool bar menu
#    And user select the following items by pressing "CONTROL"
#      | lineageNodeName | lineageNodeType |
#      | employees_full  | Table           |
#      | suppliers       | Table           |
#    And user clicks on "More Actions" menu and "Collapse Selected" submenu
#    And user select the following items by pressing "CONTROL"
#      | lineageNodeName      | lineageNodeType |
#      | products             | Table           |
#      | supplierid           | Column          |
#      | Collapsed Item Set 1 | _cluster_       |
#    And user clicks on "More Actions" menu and "Collapse Selected" submenu
#    Then following items should "not get" displayed in Lineage Diagram
#      | lineageNodeName      | lineageNodeType |
#      | Collapsed Item Set 1 | _cluster_       |
#      | products             | Table           |
#      | supplierid           | Column          |
#    And user click on Cluster drill icon for item "Collapsed Item Set 2"
#    Then following items should "get" displayed in Lineage Diagram
#      | lineageNodeName | lineageNodeType |
#      | employees_full  | Table           |
#      | suppliers       | Table           |
#      | products        | Table           |
#      | supplierid      | Column          |

  @webtest @positive @MLP-2585 @UIDiagramming
  Scenario: MLP-2585_Verification of Relayout button in the hamburger icon
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab in item full view page
    And user move the diagram to other location with following co-ordinates
      | action       | width | height |
      | moveByOffset | 30    | 40     |
    And user clicks on reload button in hamburger menu
    Then diagram position should get realigned to default position

  @webtest @positive @MLP-3083 @UIDiagramming
  Scenario:MLP-3083 Verification of semantic zoom
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab in item full view page
    And user get the default diagram position
    And user "zoomIn" the Lineage diagram for "2" times using + icon
    And user clicks on "onetoone" icon in Relationship tab
    Then diagram position should get realigned to default position
    And user "zoomOut" the Lineage diagram for "2" times using + icon
    And user clicks on "onetoone" icon in Relationship tab
    Then diagram position should get realigned to default position

  @webtest @positive @MLP-3083 @UIDiagramming
  Scenario:MLP-3083 Verification of clicking esc key on any open action menu
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab in item full view page
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown      |
      | References | relationships |
    And user "zoomOut" the Lineage diagram for "2" times using + icon
    And user clicks on item icon in "employees_full" table and type "Table"
    Then action menu popup for node should be displayed
#    And user uses robotclass with the following options
#      | Method       | Action |
#      | keyPress     | ESCAPE |
#      | keyRelease   | ESCAPE |
#      | setAutoDelay | 1000   |
#    And user clicks on "normalView" icon in Relationship tab
    Then action menu popup for node should not be displayed


  @webtest @positive @MLP-3083 @UIDiagramming
  Scenario:MLP-3083 Verification of clicking in the background when open action menu is open
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab in item full view page
    And user clicks on "fullView" icon in Relationship tab
    And user "zoomOut" the Lineage diagram for "2" times using + icon
    And user clicks on item icon in "employees_full" table and type "Table"
    Then action menu popup for node should be displayed
    And user clicks on diagram in item view page
#    And user clicks on "normalView" icon in Relationship tab
    Then action menu popup for node should not be displayed

#  @webtest @positive @MLP-3083 @UIDiagramming
#  Scenario:MLP-3083 Verification of new icons in menus and open actions
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And login must be successful for all users
#    And user enters the search text "employees_full" and clicks on search
#    And user selects the "Table" from the Type
#    And user clicks on first item on the item list page
#    And user clicks on "Relationships" tab in item full view page
#    And user validate new Lineage options are available in Relationship and Lineage tab
#    And user clicks on "fullView" icon in Relationship tab
#    Then Relationship/Lineage tab should have following submenu options under "SELECT" menu
#      | lineageSubMenuOptions                     |
#      | Select All                                |
#      | Select shortest Path between 2 Items      |
#      | Deselect All                              |
#      | Invert Selection                          |
#      | Select Backward                           |
#      | Select Forward                            |
#      | Select All Backward                       |
#      | Select All Forward                        |
#      | Select Paths between 2 Items with loops   |
#      | Select Paths between 2 Items w/o loops    |
#      | Select all shortest Paths between 2 Items |
#    Then Relationship/Lineage tab should have following submenu options under "VIEW" menu
#      | lineageSubMenuOptions |
#      | References            |
#      | Usages                |
#      | References Recursive  |
#      | Usages Recursive      |
#    Then Relationship/Lineage tab should have following submenu options under "SETTINGS" menu
#      | lineageSubMenuOptions |
#      | Use Optical Zoom      |
#      | Semantic Zoom         |
#    Then Relationship/Lineage tab should have following submenu options under "MORE ACTIONS" menu
#      | lineageSubMenuOptions |
#      | Export SVG            |
#      | Hide Selected         |
#      | Hide Unselected       |
#      | Show All              |
#      | Collapse Selected     |

#  @webtest @positive @MLP-3083 @UIDiagramming
#  Scenario:MLP-3083 Verification of Zoom button (-)
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And login must be successful for all users
#    And user enters the search text "employees_full" and clicks on search
#    And user selects the "Table" from the Type
#    And user clicks on "employees_full" item from search re/sults
#    And user clicks on "Relationships" tab in item full view page
#    And user clicks "SETTINGS" menu and following subMenu in Relationship/Lineage tab
#      | lineageSubMenuOptions |
#      | Use Optical Zoom      |
#    And user "zoomOut" the Lineage diagram for "5" times using + icon
#    Then following edge text should "be" displayed in diagram
#      | diagramEdgeText |
#      | has_Column      |
#      | has_DataSample  |
#      | similar         |
#    And user clicks on "onetoone" icon in Relationship tab
#    And user clicks "SETTINGS" menu and following subMenu in Relationship/Lineage tab
#      | lineageSubMenuOptions |
#      | Semantic Zoom         |
#    And user "zoomOut" the Lineage diagram for "5" times using + icon
#    Then following edge text should "not be" displayed in diagram
#      | diagramEdgeText |
#      | has_Column      |
#      | has_DataSample  |
#      | similar         |

#  @webtest @positive @MLP-3083 @UIDiagramming
#  Scenario:MLP-3083 Verification of Zoom button (+)
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And login must be successful for all users
#    And user enters the search text "employees_full" and clicks on search
#    And user selects the "Table" from the Type
#    And user clicks on first item on the item list page
#    And user clicks on "Relationships" tab in item full view page
#    And user clicks "SETTINGS" menu and following subMenu in Relationship/Lineage tab
#      | lineageSubMenuOptions |
#      | Use Optical Zoom      |
#    And user "zoomIn" the Lineage diagram for "5" times using + icon
#    Then following edge text should "be" displayed in diagram
#      | diagramEdgeText |
#      | has_Column      |
#      | has_DataSample  |
#      | similar         |
#    And user clicks on "onetoone" icon in Relationship tab
#    And user clicks "SETTINGS" menu and following subMenu in Relationship/Lineage tab
#      | lineageSubMenuOptions |
#      | Semantic Zoom         |
#    And user "zoomIn" the Lineage diagram for "5" times using + icon
#    Then following edge text should "not be" displayed in diagram
#      | diagramEdgeText |
#      | has_Column      |
#      | has_DataSample  |
#      | similar         |

  @webtest @positive @MLP-3084 @UIDiagramming
  Scenario: MLP-3084_Verification of popup menu on nodes
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab in item full view page
    And user clicks on "fullView" icon in Relationship tab
    And user "zoomOut" the Lineage diagram for "2" times using + icon
    And user clicks on item icon in "employees_full" table and type "Table"
    Then action menu popup for node should be displayed
#    And user press "ESCAPE" key using key press event
    Then action menu popup for node should not be displayed
    And user clicks on "fullView" icon in Relationship tab
    And user "zoomOut" the Lineage diagram for "2" times using + icon
    And user clicks on item icon in "employees_full" table and type "Table"
    Then action menu popup for node should be displayed
    And user clicks on diagram in item view page
    Then action menu popup for node should not be displayed

  @webtest @positive @MLP-3085 @UIDiagramming
  Scenario: MLP-3085 Verification of + and - icon on the left side of label
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab in item full view page
    And user clicks on "fullView" icon in Relationship tab
    And user selects the value from the dropdown for various operations in Diagramming page
      | option          | dropdown      |
      | Forward Lineage | relationships |
    And user click on drill icon for item "employees_full" and type "Table"
    And user click on collapse icon for item "employees_full" and type "Table"
    Then following items should "not get" displayed in Lineage Diagram
      | lineageNodeName | lineageNodeType |
      | city            | Column          |
      | region          | Column          |

  @webtest @positive @MLP-3085 @UIDiagramming
  Scenario: MLP-3085 Verification of action "New diagram" removed in item context menu
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab in item full view page
    And user clicks on "fullView" icon in Relationship tab
    And user "zoomOut" the Lineage diagram for "2" times using + icon
    And user clicks on item icon in "employees_full" table and type "Table"
    Then item icon popup "should not" have following values in popup
      | lineageSubMenuOptions |
      | New Diagram           |

  @webtest @positive @MLP-3085 @UIDiagramming
  Scenario: MLP-3085 Verification of i and : icon on the left side of label
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab in item full view page
    And user clicks on "fullView" icon in Relationship tab
    And user "zoomOut" the Lineage diagram for "2" times using + icon
    And user click on drill icon for item "employees_full" and type "Table"
    And user click on collapse icon for item "employees_full" and type "Table"
    And user clicks on item icon in "employees_full" table and type "Table"
    Then item icon popup "should" have following values in popup
      | lineageSubMenuOptions |
      | Open Item             |
      | Drilldown / Expand    |
      | Drillup               |

#  @webtest @positive @MLP-3085 @UIDiagramming
#  Scenario:MLP-3085 Verification of menu is automatically closed when executing another action
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And login must be successful for all users
#    And user enters the search text "employees_full" and clicks on search
#    And user selects the "Table" from the Type
#    And user clicks on first item on the item list page
#    And user clicks on "Lineage" tab in item full view page
#    And user validate new Lineage options are available in Relationship and Lineage tab
#    And Relationship/Lineage tab should have following submenu options under "SETTINGS" menu
#      | lineageSubMenuOptions |
#      | Use Optical Zoom      |
#      | Semantic Zoom         |
#    Then Relationship/Lineage tab should have following submenu options under "MORE ACTIONS" menu
#      | lineageSubMenuOptions |
#      | Export SVG            |
#      | Hide Selected         |
#      | Hide Unselected       |
#      | Show All              |
#      | Collapse Selected     |

  @webtest @positive @MLP-3085 @UIDiagramming
  Scenario:MLP-3085 Verification of yellow border for root item
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab in item full view page
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      | employees_full  | Table           |
    And user verifies the following color code in diagramming page
      | StyleType | ColorCode       | Node  |
      | stroke    | rgb(26, 52, 64) | Table |

  @webtest @positive @MLP-3436 @UIDiagramming
  Scenario: MLP-3436 Verification of drill down using + icon  there should be - icon to drill up
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab in item full view page
    And user click on drill icon for item "employees_full" and type "Table"
    Then following items should "get" displayed in Lineage Diagram
      | lineageNodeName | lineageNodeType |
      | city            | Column          |
      | region          | Column          |
      | address         | Column          |
      | country         | Column          |
      | postalcode      | Column          |
      | employeeid      | Column          |
    And user click on collapse icon for item "employees_full" and type "Table"
    Then following items should "not get" displayed in Lineage Diagram
      | lineageNodeName | lineageNodeType |
      | city            | Column          |
      | region          | Column          |
      | address         | Column          |
      | country         | Column          |
      | postalcode      | Column          |
      | employeeid      | Column          |

  @webtest @positive @MLP-3436 @UIDiagramming
  Scenario: MLP-3436 - Verification of Drill Up and Drill down option for + icon
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "employees_full" and clicks on search
    And login must be successful for all users
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab in item full view page
    And user clicks on item icon in "employees_full" table and type "Table"
    Then item icon popup "should" have following values in popup
      | lineageSubMenuOptions |
      | Open Item             |
      | Drilldown / Expand    |
      | Drillup               |

  @webtest @positive @MLP-3436 @UIDiagramming
  Scenario: MLP-3436 Verification of Drill up option for - icon
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab in item full view page
    And user clicks on item icon in "northwind" table and type "Database"
    Then item icon popup "should" have following values in popup
      | lineageSubMenuOptions |
      | Drillup               |
      | Open Item             |
      | Collapse              |
    Then item icon popup "should not" have following values in popup
      | lineageSubMenuOptions |
      | Drilldown / Expand    |

  @webtest @positive @MLP-3436 @UIDiagramming
  Scenario: MLP-3436 Verification of collapse icon in grey color
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab in item full view page
    And user clicks on item icon in "northwind" table and type "Database"
    Then item icon popup "should" have following values in popup
      | lineageSubMenuOptions |
      | Collapse              |

  @webtest @positive @MLP-3464 @UIDiagramming
  Scenario: MLP-3464_Verification of icon-only subtheme show infoicon/itemicon within a tooltip
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "employees_full" and clicks on search
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab in item full view page
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option          | dropdown      |
      | Forward Lineage | relationships |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList  |
      | employees_full   | Table            | Drilldown / Expand |
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | country          | Column           | Open Item         |
    Then Item Name "country" with type "Column" should be opened in "Item Panel View" panel
    And user clicks on close icon in preview panel
    And user clicks the hamburger menu and selects the option
      | lineageItemNames | lineageItemTypes | hamburgerMenuList |
      | employees_full   | Table            | Drillup           |
    Then following nodes should "not get" displayed in Lineage Diagram
      | lineageNodeName | lineageNodeType |
      | employees_full  | Table           |

#  @webtest @positive @MLP-3464 @UIDiagramming
#  Scenario: MLP-3464_Verification of info icon on lineage hop
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And login must be successful for all users
#    And user enters the search text "employees_full" and clicks on search
#    And user selects the "Table" from the Type
#    And user clicks on first item on the item list page
#    And user clicks on "Lineage" tab in item full view page
#    And user "click" full view icon in the Diagramming page
#    And user selects the value from the dropdown for various operations in Diagramming page
#      | option          | dropdown      |
#      | Forward Lineage | relationships |
#    And user click on "Expand All" tool bar menu
#    And user mouse hover edge icon and click lineage hop info icon
