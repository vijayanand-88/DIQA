@MLP-2528
Feature: 2585 - This feature is to verify the export feature

  @webtest @MLP-2585
  Scenario: MLP-2585 Verification of Export SVG button in the hamburger icon
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown    |
      | Export SVG | MoreActions |
    And exported file should be moved to the destination location
      | fileName | extension | path                    | destFileName   |
      | lineage  | .svg      | SVG_FILES_DOWNLOAD_PATH | export_Lineage |
    And user deletes the file "export_Lineage" from "SVG_FILES_DOWNLOAD_PATH"
    And user should be able logoff the IDC

  @webtest @MLP-2585
  Scenario: MLP-2585 Verification of hamburger icon
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user verifies the diagram menu is open by default
    And user should be able logoff the IDC

  @webtest @MLP-3805
  Scenario: MLP-3805 Verification of Export SVG button in the hamburger icon of schema view widget
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on "Schema" dashboard
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown    |
      | Export SVG | MoreActions |
    And exported file should be moved to the destination location
      | fileName | extension | path                    | destFileName          |
      | lineage  | .svg      | SVG_FILES_DOWNLOAD_PATH | schema_export_Lineage |
    And user deletes the file "schema_export_Lineage" from "SVG_FILES_DOWNLOAD_PATH"
    And user clicks on logout button

  @webtest @MLP-2182
  Scenario: MLP-2182 Verification of exporting the current state of lineage diagram as SVG image as an Administrator
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user selects the value from the dropdown for various operations in Diagramming page
      | option          | dropdown      |
      | Forward Lineage | relationships |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown    |
      | Export SVG | MoreActions |
    And exported file should be moved to the destination location
      | fileName | extension | path                    | destFileName    |
      | lineage  | .svg      | SVG_FILES_DOWNLOAD_PATH | Forward_Lineage |
    And user deletes the file "Forward_Lineage" from "SVG_FILES_DOWNLOAD_PATH"
    And user selects the value from the dropdown for various operations in Diagramming page
      | option           | dropdown      |
      | Backward Lineage | relationships |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown    |
      | Export SVG | MoreActions |
    And exported file should be moved to the destination location
      | fileName | extension | path                    | destFileName     |
      | lineage  | .svg      | SVG_FILES_DOWNLOAD_PATH | Backward_Lineage |
    And user deletes the file "Backward_Lineage" from "SVG_FILES_DOWNLOAD_PATH"
    And user should be able logoff the IDC

  @webtest @MLP-2182
  Scenario: MLP-2182 Verification of exporting the current state of lineage diagram as SVG image as a Data Administrator
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user selects the value from the dropdown for various operations in Diagramming page
      | option          | dropdown      |
      | Forward Lineage | relationships |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown    |
      | Export SVG | MoreActions |
    And exported file should be moved to the destination location
      | fileName | extension | path                    | destFileName    |
      | lineage  | .svg      | SVG_FILES_DOWNLOAD_PATH | Forward_Lineage |
    And user deletes the file "Forward_Lineage" from "SVG_FILES_DOWNLOAD_PATH"
    And user selects the value from the dropdown for various operations in Diagramming page
      | option           | dropdown      |
      | Backward Lineage | relationships |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown    |
      | Export SVG | MoreActions |
    And exported file should be moved to the destination location
      | fileName | extension | path                    | destFileName     |
      | lineage  | .svg      | SVG_FILES_DOWNLOAD_PATH | Backward_Lineage |
    And user deletes the file "Backward_Lineage" from "SVG_FILES_DOWNLOAD_PATH"
    And user should be able logoff the IDC

  @webtest @MLP-2182
  Scenario: MLP-2182 Verification of exporting the current state of lineage diagram as SVG image as an Information User
    Given User launch browser and traverse to login page
    And user enter credentials for "Information User" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user selects the value from the dropdown for various operations in Diagramming page
      | option          | dropdown      |
      | Forward Lineage | relationships |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown    |
      | Export SVG | MoreActions |
    And exported file should be moved to the destination location
      | fileName | extension | path                    | destFileName    |
      | lineage  | .svg      | SVG_FILES_DOWNLOAD_PATH | Forward_Lineage |
    And user deletes the file "Forward_Lineage" from "SVG_FILES_DOWNLOAD_PATH"
    And user selects the value from the dropdown for various operations in Diagramming page
      | option           | dropdown      |
      | Backward Lineage | relationships |
    And user selects the value from the dropdown for various operations in Diagramming page
      | option     | dropdown    |
      | Export SVG | MoreActions |
    And exported file should be moved to the destination location
      | fileName | extension | path                    | destFileName     |
      | lineage  | .svg      | SVG_FILES_DOWNLOAD_PATH | Backward_Lineage |
    And user deletes the file "Backward_Lineage" from "SVG_FILES_DOWNLOAD_PATH"
    And user should be able logoff the IDC