@MLP-2166
Feature: MLP-2166: Creation of a list of widgets used for the collection of the possible widgets within the itemview manager
  Decription: Once a user created a tab he can select widgets from a widget list and add this widgets by drag and drop into the tab. For this list of widgets we have to create for each existing itemview widget a list widget:
  * TagListWidget
  * DataSampleWidget
  * QueryWidget
  * JSONTableWidget
  * MultipleTextAttributeWidget
  * LinkAttributeWidget
  * TextAttributeWidget
  * ItemRatingWidget

  @MLP-2166 @visualcomposer @regression @sanity @positive
  Scenario: Deleteing all existing quicklinks from postgres db for Test Data
    Given When query is ran to delete an itemview "Operation" in "public" schema of "V_Setting" table
    Then item view "Operation" should not be found in "public" schema of "V_Setting" table

  @MLP-2166 @visualcomposer @regression @sanity @positive
  Scenario: Deleteing all existing quicklinks from postgres db for Test Data
    Given When query is ran to delete an itemview "itemview_TextAttribute" in "public" schema of "V_Setting" table
    Then item view "itemview_TextAttribute" should not be found in "public" schema of "V_Setting" table

  @MLP-2166 @visualcomposer @regression @sanity @positive
  Scenario: Deleteing all existing quicklinks from postgres db for Test Data
    Given When query is ran to delete an itemview "itemview_TestAttribute" in "public" schema of "V_Setting" table
    Then item view "itemview_TextAttribute" should not be found in "public" schema of "V_Setting" table

  @MLP-2166 @webtest @sanity @regression @visualcomposer @positive
  Scenario: MLP-2166 Verification of Visual Composer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When user clicks on Item View Management
    And user click on create button
    Then user should be able to see the Visual composer button
    And user should be able logoff the IDC

  @MLP_2166 @webtest @sanity @regression @visualcomposer @positive
  Scenario: MLP-2166 Verification of Widget list in the visual composer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user chooses catalog "BigData" in CATALOGS
    When user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    Then list of follwoing Widgets should be available
      | widgetList                   |
      | RATING WIDGET                |
      | SOLR QUERY WIDGET            |
      | SOLR NAMESPACE QUERY WIDGET  |
      | TAGS WIDGET                  |
      | GREMLIN QUERY WIDGET         |
      | NOTEBOOK WIDGET              |
      | IFRAME WIDGET                |
      | LINK WIDGET                  |
      | MULTIPLE ATTRIBUTES WIDGET   |
      | COMMENTS WIDGET              |
      | HTML ATTRIBUTE WIDGET        |
      | STORED QUERY WIDGET          |
      | JSON WIDGET                  |
      | DIAGRAM WIDGET               |
      | DATA SAMPLE WIDGET           |
      | MULTIPLE LINKS WIDGET        |
      | ATTRIBUTE WIDGET             |
      | LINKED ITEM ATTRIBUTE WIDGET |
      | TOP USERS WIDGET             |
    And user should be able logoff the IDC

  @MLP-2166 @webtest @sanity @regression @visualcomposer @positive
  Scenario: MLP-2166 Verification of search widget functionality in visual Composer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    When user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    Then user should see a search box and defualt text would be "Search a widget..."
    And user enters the search text "LIN"
    Then Widgets with text "LIN" should be available
    And user clears the search text and search text should be default "Search a widget..." and all widgets should be avaialble
    And user should be able logoff the IDC

  @MLP-2166 @webtest @sanity @regression @visualcomposer @positive
  Scenario: MLP-2166 Verification of warning message and button in visual Composer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    When user clicks on visual composer button
    Then warning label "Please add at least one tab." should be available
    And preview and apply should be disabled
    And user should be able logoff the IDC

  @MLP-2166 @webtest @visualcomposer @regression @positive
  Scenario: MLP-2166 Verification of validation message for Widgets via Visual Composer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "Operation" and definition as "Operation View" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Operation" for Item View and click add button
    And user clicks on visual composer button
    When user clicks on add button in the Create New Item View panel
    And User drag and drop a "LINK WIDGET" widget to the page from the displayed widget sets
    Then warning label "Tab or widget has invalid settings" should be available
    And widget edit button should be highlighted
    And the user clicks on edit button on the widget
#    Then alert "Attribute Name should not be empty" should be there
    And user selects the ATTRIBUTE NAME as "has_Operation" and alert should be gone and hit apply
    And user enter the value "Operation" in label text box in attribute widget page
    And user clicks on apply button on item view config page
    Then warning label and widget edit button alert should be gone
    And user should be able logoff the IDC

  @MLP-2166 @webtest @visualcomposer @regression @positive
  Scenario: MLP-2166 Verification of removing a widget from the Tab via visual composer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "Operation" and definition as "Operation View" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Operation" for Item View and click add button
    And user clicks on visual composer button
    When user clicks on add button in the Create New Item View panel
    And User drag and drop a "MULTIPLE ATTRIBUTES WIDGET" widget to the page from the displayed widget sets
    And widget edit button should be highlighted
    And the user clicks on edit button on the widget
    And user enter the value "Operation" in label text box in attribute widget page
    And user clicks on apply button on item view config page
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    And user clicks on item view "Operation" and click on visual composer button
    And User clicks on the Remove button
    Then Widget should be removed from item view
    And user should be able logoff the IDC

  @MLP-2166 @webtest @visualcomposer @regression @positive
  Scenario: MLP-2166 Verification of Previewing an item page via visual composer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "Database" and definition as "Database View" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    And user clicks on visual composer button
    When user clicks on add button in the Create New Item View panel
#    And User drag and drop a "DATA SAMPLE WIDGET" widget to the page from the displayed widget set
    And User drag and drop a "DATA SAMPLE WIDGET" widget to the page from the displayed widget sets
    And User drag and drop a "RATING WIDGET" widget to the page from the displayed widget sets
    And User clicks on Preview button
    Then preview of item view should have DATASAMPLING and Rating items
    And user should be able logoff the IDC

  @MLP-2166 @webtest @visualcomposer @regression @positive
  Scenario: MLP-2166 Verification of creating a item view
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "itemview_TextAttribute" and definition as "Text Attribute" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Field" for Item View and click add button
    And user clicks on visual composer button
    When user clicks on add button in the Create New Item View panel
    And User drag and drop a "MULTIPLE ATTRIBUTES WIDGET" widget to the page from the displayed widget sets
    And widget edit button should be highlighted
    And the user clicks on edit button on the widget
    And user enter the value "Operation" in label text box in attribute widget page
    And user clicks on apply button on item view config page
    And user clicks on apply button on visual composer
    Then user clicks on Save button in the Create New Item View panel

  @MLP-2166 @webtest @visualcomposer @regression @positive
  Scenario: MLP-2166 Verification of deleting a Visual Composer dashboard
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on item view "itemview_TextAttribute" and click on visual composer button
    When user clicks on delete button on dashboard of item view
    And user clicks on Yes button in alert message
    Then warning label "Please add at least one tab." should be available
    And user should be able logoff the IDC

  @MLP-2166 @webtest @visualcomposer @regression @positive
  Scenario: MLP-2166 Verification of Adding a new dashboard tab in visual composer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on item view "itemview_TextAttribute" and click on visual composer button
    When user clicks on add button in the Create New Item View panel
    And user enters "Tags View" name field of new item view panel dashboad
    And User drag and drop a "TAGS WIDGET" widget to the page from the displayed widget sets
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    And user clicks on item view "itemview_TextAttribute" and click on visual composer button
    Then user should be seeing new item view tab dashboard named as "Tags View"

  @MLP-2166 @webtest @visualcomposer @regression @positive
  Scenario: MLP-2166 Verification of Adding a multiple dashboard tab in visual composer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "itemview_TestAttribute" and definition as "Test Attribute View" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And user enters "Tab 1" name field of new item view panel dashboad
    When User drag and drop a "TAGS WIDGET" widget to the page from the displayed widget sets
    And user clicks on add button in the Create New Item View panel
    And user enters "Tab 2" name field of new item view panel dashboad
    And User drag and drop a "RATING WIDGET" widget to the page from the displayed widget sets
    And user clicks on add button in the Create New Item View panel
    And user enters "Tab 3" name field of new item view panel dashboad
    And User drag and drop a "MULTIPLE ATTRIBUTES WIDGET" widget to the page from the displayed widget sets
    And widget edit button should be highlighted
    And the user clicks on edit button on the widget
    And user enter the value "Operation" in label text box in attribute widget page
    And user clicks on apply button on item view config page
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    Then user verifies that the newly added item view "itemview_TestAttribute" is displayed in the Item View Management panel
    And user clicks on item view "itemview_TestAttribute" and click on visual composer button
    Then user should be seeing new item view tab dashboard named as "Tab 1"
    And user should be seeing new item view tab dashboard named as "Tab 2"
    And user should be seeing new item view tab dashboard named as "Tab 3"

  @MLP-2166 @webtest @visualcomposer @regression @negative
  Scenario: MLP-2166 Verification of creating a dashboard tab without a name
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "itemview_TestAttribute" and definition as "Test Attribute View" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    When user enters " " name field of new item view panel dashboad
    Then alert message "Invalid name. Leading/trailing blanks and slash/backslash are forbidden." about name should appear


  @MLP-2166 @webtest @visualcomposer @regression @negative
  Scenario: MLP-2166 Verification of creating a duplicate Visual Composer dashboard
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on item view "itemview_TextAttribute" and click on visual composer button
    When user clicks on add button in the Create New Item View panel
    Then alert message "This name already exists. Please enter a different one." about duplicate dashboard should exist

  @MLP-2166 @webtest @visualcomposer @regression @negative
  Scenario: MLP-2166 Verification of creating a Visual Composer dashboard with leading spaces
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on item view "itemview_TextAttribute" and click on visual composer button
    When user clicks on add button in the Create New Item View panel
    And user enters "Text view " name field of new item view panel dashboad
    Then alert message "Invalid name. Leading/trailing blanks and slash/backslash are forbidden." about duplicate dashboard should exist
    And user enters "  Text view" name field of new item view panel dashboad
    Then alert message "Invalid name. Leading/trailing blanks and slash/backslash are forbidden." about duplicate dashboard should exist


  @MLP-2166 @webtest @visualcomposer @regression @negative
  Scenario: MLP-2166 Verification of creating a Visual Composer dashboard with leading and trailing spaces
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on item view "itemview_TextAttribute" and click on visual composer button
    When user clicks on add button in the Create New Item View panel
    And user enters "Text/view" name field of new item view panel dashboad
    Then alert message "Invalid name. Leading/trailing blanks and slash/backslash are forbidden." about duplicate dashboard should exist
    And user enters "\Text view" name field of new item view panel dashboad
    Then alert message "Invalid name. Leading/trailing blanks and slash/backslash are forbidden." about duplicate dashboard should exist

  @MLP-2166 @webtest @visualcomposer @regression @positive
  Scenario: MLP-2166 Verification of exit button in visual composer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "itemview_TestAttribute" and definition as "Test Attribute View" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And user enters "Tab 1" name field of new item view panel dashboad
    When User drag and drop a "TAGS WIDGET" widget to the page from the displayed widget sets
    And user clicks on close icon in edit item Full view panel
    Then modal alert "You have unsaved changes. Are you sure you want to discard the changes?" should be there
    And user accepts the alerts
    Then user should be able to see the Visual composer button

  @MLP-2166 @webtest @visualcomposer @regression @positive
  Scenario: MLP-2166 Verification of deleting a tab from Visual Composer dashboard
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on item view "itemview_TestAttribute" and click on visual composer button
    When user clicks on "Tab 2" tab on visual composer
    And user clicks on delete button on dashboard of item view
    And user accepts the alerts
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    Then user clicks on item view "itemview_TestAttribute" and click on visual composer button
    And user should be seeing only 4 tabs in visual composer
    And user should be seeing new item view tab dashboard named as "Tab 1"
    And user should be seeing new item view tab dashboard named as "Tab 3"

  @MLP-2166 @webtest @visualcomposer @regression @positive
  Scenario: MLP-2166 Verification of deleting a widget via edit mode through Visual Composer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on item view "itemview_TextAttribute" and click on visual composer button
    And the user clicks on edit button on the widget
    When user clicks on Delete button on visual composer
    And user clicks on Yes button in alert message
    And user clicks on apply button on visual composer
    Then user clicks on visual composer button
    And Widget should be removed from item view
    And user should be able logoff the IDC

  @MLP-2356 @webtest @regression @itemview @positive
  Scenario:MLP-2356: Verification of PREVIEW label in the item preview of Visual Composer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "RATING WIDGET" widget to the page from the displayed widget sets
    Then User clicks on Preview button
    And "PREVIEW" label should be placed before item name
    And user should be able logoff the IDC

  @MLP-2166 @webtest @regression @itemview @negative
  Scenario:MLP-2166: Verification of moving widgets locations via visual composer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "itemview_SampleAttribute" and definition as "Sample Attribute View" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "TAGS WIDGET" widget to the page from the displayed widget sets
    And User drag and drop a "MULTIPLE LINKS WIDGET" widget to the page from the displayed widget sets
    And user should see the widget "TAGS WIDGET" at the "second" position
    And User drag and drop a "RATING WIDGET" widget to the page from the displayed widget sets
    And user clicks on apply button on visual composer
    And user clicks on visual composer button
    And User drag and drop a "DATA SAMPLE WIDGET" widget to the page from the displayed widget sets
    And user clicks on apply button on visual composer
    Then user clicks on visual composer button
    And user should not see the widget "TAGS WIDGET" at the "second" position
    And user should be able logoff the IDC

  @MLP-2164 @webtest @regression @itemview @positive
  Scenario:MLP-2164: Verification of changing flex layout to grid layout
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "BigData" from Catalog list
    And user should be in Subject Area page
    And user clicks on first item on the item list page
    And user verifies the grid layout for the value "METADATA"
    And user verifies the grid layout for the value "RATING"
    And user verifies the grid layout for the value "TAG"
    And user should be able logoff the IDC

  @webtest @MLP-2166 @regression @itemview @positive
  Scenario: MLP-2166 Verification of Re-sizing the widgets via Visual Composer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "itemview_SampleAttribute" and definition as "Sample Attribute View" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "RATING WIDGET" widget to the page from the displayed widget sets
    And user click Item View Manager resize button
    And user select "1 x 1" from resize widget list
    And user click Item View Manager resize button
    And Widget size "1 x 1" should be highlighted in widget resize menu list in item view manager
    And user select "1 x 2" from resize widget list
    And user click Item View Manager resize button
    Then Widget size "1 x 2" should be highlighted in widget resize menu list in item view manager
    And user select "1 x 3" from resize widget list
    And user click Item View Manager resize button
    Then Widget size "1 x 3" should be highlighted in widget resize menu list in item view manager