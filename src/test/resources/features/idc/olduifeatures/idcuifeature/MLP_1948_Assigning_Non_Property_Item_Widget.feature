@MLP-1948
Feature: Assign non property  widgets to an Itemview

  @MLP-1948 @webtest @positive
  Scenario: MLP-1948_Verification of assigning non property ItemRatingWidget to item view
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "Rating Widget" and definition as "Rating Widget desc" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "RATING WIDGET" widget to the page from the displayed widget sets
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    Then item view "Rating Widget" should get added in database and "ItemRatingWidget" in data column
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |
    And user clicks on "Rating Widget" from item view list
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on Yes button in alert message


  @MLP-1948 @webtest @positive
  Scenario:MLP-1948_Verification of assigning non property TagListWidget to item view
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "Tags WIDGET" and definition as "Tags widget desc" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "TAGS WIDGET" widget to the page from the displayed widget sets
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    Then item view "Tags WIDGET" should get added in database and "TagListWidget" in data column
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |
    And user clicks on "Tags WIDGET" from item view list
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on Yes button in alert message