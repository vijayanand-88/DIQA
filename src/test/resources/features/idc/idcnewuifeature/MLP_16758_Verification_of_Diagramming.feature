@MLP-16758
Feature:MLP-16758: This feature is to verify As a IDA Admin, I need to validate the Lineage Diagram Icon.

  ##6926543####6926811##
  @MLP-16758 @webtest @regression @positive
  Scenario:SC#1:MLP-16758: Verify that the user is able to export the SVG file
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "customerID" and clicks on search
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user "click" on "ExportSVG" icon in LineageDiagramming page
    And exported file should be moved to the destination location
      | fileName | extension | path                    | destFileName   |
      | lineage  | .svg      | SVG_FILES_DOWNLOAD_PATH | export_Lineage |
    And user deletes the file "export_Lineage" from "SVG_FILES_DOWNLOAD_PATH"
    And user enters the search text "customerID" and clicks on search
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user "click" on "search" icon in LineageDiagramming page
    And user "enter text" on "customerID" icon in LineageDiagramming page
    And user verifies the "select All" operation is "displayed"

  ##6926819##
  @MLP-16758 @webtest @regression @positive
  Scenario:SC#2:MLP-16758: Verify that the user is able to reload  the Lineage Diagramming
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "max_asian" and clicks on search
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user "click" on "Reload" icon in LineageDiagramming page

  ##6926546##  ##6926548##
  @MLP-16758 @webtest @regression @positive
  Scenario:SC#3:MLP-16758: Verify that the user is able to zoomin  the Lineage Diagramming using + Key
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "customerID" and clicks on search
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user "click" on "ZOOMIN+" icon in LineageDiagramming page
    And user verifies the "110" operation is "displayed"
    And user "enter text" on "100" icon in LineageDiagramming page
    And user "click" on "Outside" icon in LineageDiagramming page
    And user enters the search text "customerID" and clicks on search
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user "click" on "ZOOMOUT-" icon in LineageDiagramming page
    And user verifies the "90" operation is "displayed"
    And user "enter text" on "100" icon in LineageDiagramming page
    And user "click" on "Outside" icon in LineageDiagramming page

    ##6926549##6926552##    ##6926549##6926553##    ##6926549##6926609##
  @MLP-16758 @webtest @regression @positive
  Scenario:SC#4:MLP-16758: Verify that the user is able to verify the forwardLineage
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "customerID" and clicks on search
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user "select dropdown" in Diagramming Page
      | fieldName | attribute       |
      | Type      | Forward Lineage |
    And user "click" on "ExportSVG" icon in LineageDiagramming page
    And exported file should be moved to the destination location
      | fileName | extension | path                    | destFileName    |
      | lineage  | .svg      | SVG_FILES_DOWNLOAD_PATH | Forward_Lineage |
    And user deletes the file "Forward_Lineage" from "SVG_FILES_DOWNLOAD_PATH"
    And user enters the search text "customerID" and clicks on search
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user "select dropdown" in Diagramming Page
      | fieldName | attribute        |
      | Type      | Backward Lineage |
    And user "click" on "ExportSVG" icon in LineageDiagramming page
    And exported file should be moved to the destination location
      | fileName | extension | path                    | destFileName     |
      | lineage  | .svg      | SVG_FILES_DOWNLOAD_PATH | Backward_Lineage |
    And user deletes the file "Backward_Lineage" from "SVG_FILES_DOWNLOAD_PATH"
    And user enters the search text "customerID" and clicks on search
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user "select dropdown" in Diagramming Page
      | fieldName | attribute          |
      | Type      | End-to-end Lineage |
    And user "click" on "ExportSVG" icon in LineageDiagramming page
    And exported file should be moved to the destination location
      | fileName | extension | path                    | destFileName       |
      | lineage  | .svg      | SVG_FILES_DOWNLOAD_PATH | End-to-end_Lineage |
    And user deletes the file "Backward_Lineage" from "SVG_FILES_DOWNLOAD_PATH"

    ##6926619##6926631##  ##6926636##6926641##
  @MLP-16758 @webtest @regression @positive
  Scenario:SC#5:MLP-16758: Verify that the user is able to verify the select all & Deselect ALL.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "customerID" and clicks on search
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user "select options" in Diagramming Page
      | fieldName | attribute  |
      | Type      | Select All |
    And user verifies the "select All" operation is "displayed"
    And user "select options" in Diagramming Page
      | fieldName | attribute    |
      | Type      | Deselect All |
    And user verifies the "select All" operation is "not displayed"
    And user enters the search text "customerID" and clicks on search
    And user performs "facet selection" in "customers [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      | customers       | Table           |
    And user "select options" in Diagramming Page
      | fieldName | attribute     |
      | Type      | Hide Selected |
    And user verifies the "select All" operation is "not displayed"
    And user "select options" in Diagramming Page
      | fieldName | attribute       |
      | Type      | Hide Unselected |
    And user verifies the "select All" operation is "not displayed"
    And user enters the search text "customerID" and clicks on search
    And user performs "facet selection" in "customers [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      | customers       | Table           |
    And user "select options" in Diagramming Page
      | fieldName | attribute     |
      | Type      | Hide Selected |
    And user verifies the "select All" operation is "not displayed"
    And user "select options" in Diagramming Page
      | fieldName | attribute |
      | Type      | Show All  |
    And user verifies the "select All" operation is "displayed"

  ##6926648## ##6926654##6926656##
  @MLP-16758 @webtest @regression @positive
  Scenario:SC#6:MLP-16758: Verify that the user is able to verify the showall.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "customerID" and clicks on search
    And user performs "facet selection" in "customers [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      | customers       | Table           |
    And user "select options" in Diagramming Page
      | fieldName | attribute     |
      | Type      | Hide Selected |
    And user verifies the "select All" operation is "not displayed"
    And user "select options" in Diagramming Page
      | fieldName | attribute |
      | Type      | Show All  |
    And user verifies the "select All" operation is "displayed"
    And user enters the search text "customerID" and clicks on search
    And user performs "facet selection" in "orders [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      | orders          | Table           |
    And user "select options" in Diagramming Page
      | fieldName | attribute       |
      | Type      | Expand Selected |
    And user verifies the "Expand" operation is "displayed"
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      | orders          | Table           |
    And user "select options" in Diagramming Page
      | fieldName | attribute         |
      | Type      | Collapse Selected |
    And user verifies the "Expand" operation is "displayed"

    ##6926658##  ##6926659##
  @MLP-16758 @webtest @regression @positive
  Scenario:SC#7:MLP-16758: Verify that the user is able to verify the Group selected.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "customerID" and clicks on search
    And user performs "facet selection" in "customers [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      | customerid      | Column          |
      | customers       | Table           |
    And user "select options" in Diagramming Page
      | fieldName | attribute      |
      | Type      | Group Selected |
    And user verifies the "Collapsed Item Set 1" operation is "displayed"
    And user enters the search text "customerID" and clicks on search
    And user performs "facet selection" in "customers [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user "select options" in Diagramming Page
      | fieldName | attribute        |
      | Type      | Invert Selection |
    And user verifies the "select All" operation is "displayed"

    ##6926665##6926670##
  @MLP-16758 @webtest @regression @positive
  Scenario:SC#8:MLP-16758: Verify that the user is able to verify the TraceBackward&Forward.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "customerID" and clicks on search
    And user performs "facet selection" in "customers [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      | customers       | Table           |
    And user "select options" in Diagramming Page
      | fieldName | attribute      |
      | Type      | Trace Backward |
    And user verifies the "Expand" operation is "displayed"
    And user "select options" in Diagramming Page
      | fieldName | attribute     |
      | Type      | Deselect All  |
      | Type      | Trace Forward |
    And user verifies the "select All" operation is "displayed"

    ##6926795##6926805##    ##6926746##6926766##
  @MLP-16758 @webtest @regression @positive
  Scenario:SC#9:MLP-16758: Verify that the user is able to verify the Trace to seed item and Trace between items.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "customerID" and clicks on search
    And user performs "facet selection" in "customers [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      | customers       | Table           |
    And user "select options" in Diagramming Page
      | fieldName | attribute          |
      | Type      | Trace All Forward  |
      | Type      | Deselect All       |
      | Type      | Trace All Backward |
    And user verifies the "select All" operation is "displayed"
    And user "select options" in Diagramming Page
      | fieldName | attribute          |
      | Type      | Trace to Seed Item |
    And user select the following items by pressing "CONTROL"
      | lineageNodeName | lineageNodeType |
      | customers       | Table           |
      | customerid      | Column          |
    And user "select options" in Diagramming Page
      | fieldName | attribute             |
      | Type      | Trace between 2 Items |

  ##6926840##    ##6926914##  ##6926849##
  @MLP-16758 @webtest @regression @positive
  Scenario:SC#10:MLP-16758: Verify that the user is able to verify the show grid.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "customerID" and clicks on search
    And user performs "facet selection" in "customers [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user "click" on "ShowGrid" icon in LineageDiagramming page
    And user verifies the "Grid" operation is "not displayed"
    And user enters the search text "customerID" and clicks on search
    And user performs "facet selection" in "customers [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user "click" on "Settings" icon in LineageDiagramming page
    And user verifies the "Settings" operation is "displayed"
    And user "click" on "checkbox" icon in LineageDiagramming page
    And user verifies the "Control" operation is "displayed"
    And user enters the search text "customerID" and clicks on search
    And user performs "facet selection" in "customers [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user "click" the slider to "7" in "DETAILS" section in diagramming page
    And user verifies the "[Cluster]" operation is "displayed"

  ##6926913##     ##6926913##
  @MLP-16758 @webtest @regression @positive
  Scenario:SC#11:MLP-16758: Verify that the user is able to verify the scope slider.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "fromCustomerID" and clicks on search
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user "click" the slider to "3" in "EXPAND SCOPE" section in diagramming page
    Then following items should "get" displayed in Lineage Diagram
      | lineageNodeName | lineageNodeType |
      | fromCustomerID  | Column          |
    And user "click" the slider to "1" in "EXPAND SCOPE" section in diagramming page
    Then following items should "not get" displayed in Lineage Diagram
      | lineageNodeName | lineageNodeType |
      | customerID      | Column          |
    And user enters the search text "fromCustomerID" and clicks on search
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user "click" on "FullSize" icon in LineageDiagramming page
    And user "click" on "Collapse Full Size" icon in LineageDiagramming page
    And user "click" on "Relationships" tab in Overview page
    And user "click" on "FullSize" icon in LineageDiagramming page
    And user "click" on "Collapse Full Size" icon in LineageDiagramming page
    And user enters the search text "fromCustomerID" and clicks on search
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user clicks the item info icon for the following item
      | lineageItemNames | lineageItemTypes |
      | fromCustomerID   | Column           |
    And user verifies the "Item info popup" is "displayed"

  @MLP-16758 @webtest @regression @positive
  Scenario:SC#12:MLP-16758: Verify that the user is able to verify the item info popup details.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "fromCustomerID" and clicks on search
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user clicks the item info icon for the following item
      | lineageItemNames | lineageItemTypes |
      | fromCustomerID   | Column           |
    And user verifies the "Item info popup" is "displayed"
    And user verifies the "Name" is "displayed"
    And user verifies the " Definition" is "displayed"
    And user verifies the "Tags" is "displayed"
    And user verifies the "Rating" is "displayed"
    And user enters the search text "fromCustomerID" and clicks on search
    And user clicks on first item name link on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user clicks the item info icon for the following item
      | lineageItemNames | lineageItemTypes |
      | fromCustomerID   | Column           |
    And user "click" on "Item info Close" icon in LineageDiagramming page
    And user clicks the item info icon for the following item
      | lineageItemNames | lineageItemTypes |
      | fromCustomerID   | Column           |
    And user "click" on "Outside" icon in LineageDiagramming page