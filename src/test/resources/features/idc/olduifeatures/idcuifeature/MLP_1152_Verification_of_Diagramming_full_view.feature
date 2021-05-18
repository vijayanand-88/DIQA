@MLP-1152
Feature:MLP-1152: This feature is to verify the full view functionality of Diagramming

  @MLP-1152 @webtest @regression @positive @Diagramming
  Scenario:MLP-1152: Verification of full view of diagramming and exiting the full view mode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "employees_full" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies the diagram menu is open by default
    Then user "verify" full view icon in the Diagramming page
    And user "click" full view icon in the Diagramming page
    And user verifies diagram is opened in full view
    And user "verify" normal size icon in the Diagramming full view
    And user "click" normal size icon in the Diagramming full view
    And user verifies "Relationships" tab is displayed and active in the item full view
    And user "verify" full view icon in the Diagramming page
    And user "click" full view icon in the Diagramming page
    And user uses robotclass with the following options
      | Method       | Action |
      | keyPress     | ESCAPE |
      | keyRelease   | ESCAPE |
      | setAutoDelay | 1000   |
    And user verifies "Relationships" tab is displayed and active in the item full view

  @MLP-3121 @webtest @regression @positive @Diagramming
  Scenario:MLP-3121: Verification of Diagram tabs for Column and Field item in the item view
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Column" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies "Relationships" tab is displayed and active in the item full view
    And user clicks on "Lineage" tab displayed
    And user verifies "Lineage" tab is displayed and active in the item full view
    And user clicks on close button in the diagramming page
    And user selects the "Column" from the Type
    And user selects the "Field" from the Type
    And user clicks on first item on the item list page
    And user clicks on "Relationships" tab displayed
    And user verifies "Relationships" tab is displayed and active in the item full view
    And user clicks on "Lineage" tab displayed
    And user verifies "Lineage" tab is displayed and active in the item full view
    And user should be able logoff the IDC










