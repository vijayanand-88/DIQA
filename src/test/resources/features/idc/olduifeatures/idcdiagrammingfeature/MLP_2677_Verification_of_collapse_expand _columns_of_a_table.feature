@MLP-2677
Feature:MLP-2677: This feature is to verify collapse and expand columns of table

  @MLP-2677 @webtest @regression @positive @Diagramming
  Scenario:MLP-2677: Verification of clicking twice on Expand All Boxes button
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "employees_full" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user checks the checkbox for "Table" in Type
    When user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    Then user verifies whether the following image is present
      | Method           | Action                          | Path                    |
      | initializeImage  | Lineage_Expand_All_Button.png   | DIAGRAMMING_IMAGES_PATH |
      | clickAction      | 2                               |                         |
      | initializeImage  | Lineage_ExpandAll_Table.png     | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                               |                         |
      | initializeImage  | Lineage_Expand_All_Button.png   | DIAGRAMMING_IMAGES_PATH |
      | clickAction      | 2                               |                         |
      | initializeImage  | Lineage_ExpandAll_Table.png     | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                               |                         |
      | initializeImage  | Lineage_Collapse_All_Button.png | DIAGRAMMING_IMAGES_PATH |
      | clickAction      | 2                               |                         |
      | initializeImage  | Lineage_CollapseAll_Table.png   | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                               |                         |
      | initializeImage  | Lineage_Collapse_All_Button.png | DIAGRAMMING_IMAGES_PATH |
      | clickAction      | 2                               |                         |
      | initializeImage  | Lineage_CollapseAll_Table.png   | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                               |                         |
    And user "click" normal size icon in the Diagramming full view
    And user should be able logoff the IDC


  @MLP-3097 @webtest @regression @positive @Diagramming
  Scenario:MLP-3097: Verification of backward lineage service
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "employeeterritories" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user checks the checkbox for "Table" in Type
    When user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    And user selects the value from the dropdown for various operations in Diagramming page
      | option           | dropdown      |
      | Backward Lineage | relationships |
    Then user verifies whether the following image is present
      | Method           | Action                     | Path                    |
      | initializeImage  | BackwardLineageDiagram.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                          |                         |
    And user "click" normal size icon in the Diagramming full view
    And user should be able logoff the IDC

  @webtest @regression @positive @Diagramming
  Scenario: Verification of diagram  reloaded by clicking the Reload icon
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "max_asian" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user checks the checkbox for "Column" in Type
    When user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    Then user verifies whether the following image is present
      | Method           | Action                | Path                    |
      | initializeImage  | ColumnReloadImage.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                     |                         |
    And user clicks on "zoom in" icon in diagram
    And user clicks on reload button in hamburger menu
    And user verifies whether the following image is present
      | Method           | Action                | Path                    |
      | initializeImage  | ColumnReloadImage.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 2                     |                         |
    And user "click" normal size icon in the Diagramming full view
    And user should be able logoff the IDC



