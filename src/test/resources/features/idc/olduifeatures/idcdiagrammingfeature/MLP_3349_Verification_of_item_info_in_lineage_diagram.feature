@MLP-3349
Feature:MLP-3349: This feature is to verify item info popup in lineage diagram

  @MLP-3349 @MLP-3477 @webtest @regression @positive @Diagramming
  Scenario:MLP-3349 MLP-3477:Verification of item info popup shows the relevant information in lineage Tab
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "warehouse_id" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Column" from the Type
    When user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    And user clicks the item info icon for the following item
      | lineageItemNames | lineageItemTypes |
      | warehouse_id     | Column           |
    Then user verifies whether the following image is present
      | Method           | Action            | Path                    |
      | initializeImage  | IteminfoPopup.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 3                 |                         |
    And user "click" normal size icon in the Diagramming full view
    And user should be able logoff the IDC


  @MLP-3349 @webtest @regression @positive @Diagramming
  Scenario:MLP-3349: Verification of item info popup shows the relevant information in relationship Tab
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "warehouse_id" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user checks the checkbox for "Column" in Type
    When user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user "click" full view icon in the Diagramming page
    And user clicks the item info icon for the following item
      | lineageItemNames | lineageItemTypes |
      | warehouse_id     | Column           |
    Then user verifies whether the following image is present
      | Method           | Action                          | Path                    |
      | initializeImage  | Relationships_Iteminfopopup.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 3                               |                         |
    And user "click" normal size icon in the Diagramming full view
    And user should be able logoff the IDC


  @MLP-3349 @webtest @regression @positive @Diagramming
  Scenario:MLP-3349: Verification of item info popup shows the relevant information when zoomed in
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "warehouse_id" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user checks the checkbox for "Column" in Type
    When user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    And user clicks on "zoom in" icon in diagram
    And user clicks the item info icon for the following item
      | lineageItemNames | lineageItemTypes |
      | warehouse_id     | Column           |
    Then user verifies whether the following image is present
      | Method           | Action                    | Path                    |
      | initializeImage  | Lineage_Iteminfopopup.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 3                         |                         |
    And user "click" normal size icon in the Diagramming full view
    And user should be able logoff the IDC

  @MLP-3349 @webtest @regression @positive @Diagramming
  Scenario:MLP-3349: Verification of item info popup shows the relevant information when zoomed out
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "warehouse_id" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user checks the checkbox for "Column" in Type
    When user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user "click" full view icon in the Diagramming page
    And user clicks on "zoom out" icon in diagram
    And user clicks the item info icon for the following item
      | lineageItemNames | lineageItemTypes |
      | warehouse_id     | Column           |
    Then user verifies whether the following image is present
      | Method           | Action                             | Path                    |
      | initializeImage  | Lineage_IteminfoPopup_zoom_out.png | DIAGRAMMING_IMAGES_PATH |
      | verifyImageExist | 3                                  |                         |
    And user "click" normal size icon in the Diagramming full view
    And user should be able logoff the IDC

