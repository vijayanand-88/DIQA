@MLP-3121
Feature: Verification of the widget for Diagramming

  @MLP-3121 @webtest @regression @positive @Diagramming
  Scenario:MLP-3121: Verification of widget name and diagram theme for diagramming
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    When user clicks on Create button in ItemView Management Panel
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Column" for Item View and click add button
    And user clicks on visual composer button
    Then user clicks on add button in the Create New Item View panel
    And User drag and drop a "DIAGRAM WIDGET" widget to the page from the displayed widget sets
    And user verifies whether following widgets are displayed
      | widgetList     |
      | DIAGRAM WIDGET |
    And the user clicks on edit button on the widget
    And user verifies the label "THEME" in New node panel
    And user verifies the following in Theme dropdown
      | themeList     |
      | lineage       |
      | relationships |
    And user should be able logoff the IDC

  @MLP-3121 @webtest @regression @positive @Diagramming
  Scenario:MLP-3121: Verification of Diagram tabs for Column item in the item view
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user clicks on search icon
    When user selects the "Column" from the Type
    And user clicks on first item on the item list page
    Then user clicks on "Relationships" tab displayed
    And user verifies diagram is displayed in diagramming page
    And user clicks on "Lineage" tab displayed
    And user verifies diagram is displayed in diagramming page
    And user should be able logoff the IDC

  @MLP-3121 @webtest @regression @positive @Diagramming
  Scenario:MLP-3121: Verification of Diagram tabs for Field item in the item view
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user clicks on search icon
    When user selects the "Field" from the Type
    And user clicks on first item on the item list page
    Then user clicks on "Relationships" tab displayed
    And user verifies diagram is displayed in diagramming page
    And user clicks on "Lineage" tab displayed
    And user verifies diagram is displayed in diagramming page
    And user should be able logoff the IDC