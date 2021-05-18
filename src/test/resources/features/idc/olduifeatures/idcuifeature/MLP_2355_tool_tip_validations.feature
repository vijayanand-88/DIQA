@MLP-2355
Feature: MLP-2355 Validation of widgets tooltip

  @MLP-2355 @webtest @positive
  Scenario: MLP-2355 Verification of LinkAttribute Widget Tool Tip
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "Link Attribute Widget" and definition as "Link Attribute widget" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Operation" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "LINK WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
    And Widget "ATTRIBUTE NAME" field help icon should have hover text "Name of an item attribute"
    And Widget "DIRECTION" field help icon should have hover text "Specifies a link direction."
    And Widget "HEADERS" field help icon should have hover text "Configuration to define a table header from the table data"
    And user clicks on Add button near to field "HEADERS"
    And "ATTRIBUTE NAME" table header help icon should have hover text "Name of an item attribute that is used as a column header"
    And "COLUMN SIZE" table header help icon should have hover text "Size of the column (relative to other columns)"
    And "HIDDEN" table header help icon should have hover text "Flag to hide a column on the user interface"
    And "LABEL" table header help icon should have hover text "Label that is defined for a column in a table"
    And user clicks on close icon in table header page
    And Widget "PAGE SIZE" field help icon should have hover text "Maximum number of rows that are allowed on an item page"

  @MLP-2355 @webtest @positive
  Scenario: MLP-2355 Verification of Filter panel Tool Tip
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "Multiple Attribute Widget" and definition as "Multiple Attribute widget" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Operation" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "MULTIPLE ATTRIBUTES WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
    And user clicks on add button of filter in multiple attribute widget
    And user selects widget attribute name as "AttributeTypeFilter"
    And "MODE" attribute filter help icon should have hover text "Show or hide item attributes based on the configured filter mode"
    And "ATTRIBUTE TYPES" attribute filter help icon should have hover text "Include or exclude item attributes with specified types based on the configured mode"
    And user selects widget attribute name as "AttributeNameFilter"
    And "MODE" attribute filter help icon should have hover text "Show or hide item attributes based on the configured filter"
    And "ATTRIBUTE NAMES" attribute filter help icon should have hover text "Include or exclude item attributes based on the configured mode"
    And user selects widget attribute name as "GroovyAttributeFilter"
    And "MODE" attribute filter help icon should have hover text "Show or hide item attributes based on the configured filter mode"
    And "GROOVY SCRIPT" attribute filter help icon should have hover text "Groovy script to filter item properties. Current item and filtered property are provided as variables (named 'item' and 'property' correspondingly)."

  @MLP-2355 @webtest @positive
  Scenario: MLP-2355 Verification of JSON Widget Tool Tip
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "JSON Attribute Widget" and definition as "JSON Attribute widget" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Operation" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "JSON WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
    And Widget "ATTRIBUTE NAME" field help icon should have hover text "Name of an item attribute"
    And Widget "HEADERS" field help icon should have hover text "Configuration to define a table header from the table data"
    And user clicks on Add button near to field "HEADERS"
    And "ATTRIBUTE NAME" table header help icon should have hover text "Name of an item attribute that is used as a column header"
    And "COLUMN SIZE" table header help icon should have hover text "Size of the column (relative to other columns)"
    And "HIDDEN" table header help icon should have hover text "Flag to hide a column on the user interface"
    And "LABEL" table header help icon should have hover text "Label that is defined for a column in a table"
    And user clicks on close icon in table header page
#    And Widget "LABEL" field help icon should have hover text "Label of the specific item attribute"
#    And "TYPE" field help icon should have hover text as "Specifies how result will be represented on UI"

  @MLP-2355 @webtest @itemlist @sanity @positive
  Scenario:MLP-2355: Verification of Multiple Text Attributes Widget Tool Tip
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "MULTIPLE ATTRIBUTES WIDGET" and definition as "MULTIPLE ATTRIBUTES WIDGET" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Operation" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "MULTIPLE ATTRIBUTES WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
    Then Widget "FILTERS" field help icon should have hover text "A set of filters that defines the item properties to display on a widget"
    And user should be able logoff the IDC

  @MLP-2355 @webtest @itemlist @sanity @positive
  Scenario:MLP-2355: Verification of Attribute Widget Tool tip
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "ATTRIBUTE WIDGET" and definition as "ATTRIBUTE WIDGET" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Operation" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "ATTRIBUTE WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
    Then Widget "ATTRIBUTE NAME" field help icon should have hover text "Name of an item attribute"
    And Widget "LABEL" field help icon should have hover text "Label of the specific item attribute"
    And Widget "TYPE" field help icon should have hover text "Specifies how attribute will be represented on UI"
    And user should be able logoff the IDC

  @MLP-2355 @webtest @itemlist @sanity @positive
  Scenario:MLP-2355: Verification of Query Widget Tool Tip
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "GREMLIN QUERY WIDGET" and definition as "GREMLIN QUERY WIDGET" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Operation" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "GREMLIN QUERY WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
    Then Widget "LABEL" field help icon should have hover text "Label of the specific query result"
    And Widget "HEADERS" field help icon should have hover text "Configuration to define a table header from the table data"
    And Widget "QUERY TEXT" field help icon should have hover text "Gremlin query. Do not add terminal steps to the queries."
    And Widget "TYPE" field help icon should have hover text "Specifies how query result will be represented on UI"
    And Widget "PAGE SIZE" field help icon should have hover text "Maximum number of rows that are allowed on an item page"
    And user should be able logoff the IDC

  @MLP-2355 @webtest @itemlist @sanity @positive
  Scenario:MLP-2355: Verification of Multiple Link Widgets Tool Tip
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "MULTIPLE LINKS WIDGET" and definition as "MULTIPLE LINKS WIDGET" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Operation" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "MULTIPLE LINKS WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
#    Then Widget "ATTRIBUTES" field help icon should have hover text "A link that specifies a related item for a widget from the table"
#    And Widget "HEADERS" field help icon should have hover text "Configuration to define a table header from the table data"
#    And Widget "MODE" field help icon should have hover text "A configuration mode of an item to include or exclude a link from the table"
    And Widget "DIRECTION" field help icon should have hover text "Specifies a link direction"
    And Widget "PAGE SIZE" field help icon should have hover text "Maximum number of rows that are allowed on an item page"
    And user should be able logoff the IDC

  @MLP-2355 @webtest @itemlist @sanity @positive
  Scenario:MLP-2355: Verification of IFrame Widget Tool Tip
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "IFRAME WIDGET" and definition as "IFRAME WIDGET" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Operation" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "IFRAME WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
    Then Widget "LABEL" field help icon should have hover text "IFrame label"
    And Widget "IFRAME URL" field help icon should have hover text "IFrame URL"
    And user should be able logoff the IDC

  @MLP-2493 @webtest @regression @itemview @negative
  Scenario:MLP-2493: Verification of Preview and Apply button functionality for invalid name for existing tab
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on item view "itemView_Table" and click on visual composer button
    Then user enters " " name field of new item view panel dashboad
    And preview and apply should be disabled
    And user should be able logoff the IDC

  @MLP-2493 @webtest @regression @itemview @negative
  Scenario:MLP-2493: Verification of Preview and Apply button functionality for invalid name for new Tab
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    Then user enters " " name field of new item view panel dashboad
    And preview and apply should be disabled
    And user should be able logoff the IDC

  @MLP-2358 @webtest @regression @itemview @positive
  Scenario Outline:MLP-2358: Verification of setting up the customized preview for Multiple Tabs
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name and definition for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Operation" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And user enters "LINK WIDGET" name field of new item view panel dashboad
    And User drag and drop a "MULTIPLE LINKS WIDGET" widget to the page from the displayed widget sets
    And user clicks on add button in the Create New Item View panel
    And user enters "RATING WIDGET" name field of new item view panel dashboad
    And User drag and drop a "RATING WIDGET" widget to the page from the displayed widget sets
    And user clicks on add button in the Create New Item View panel
    And user enters "TAGS WIDGET" name field of new item view panel dashboad
    And User drag and drop a "TAGS WIDGET" widget to the page from the displayed widget sets
    And User clicks on Preview button
    Then Preview should display the "LINK WIDGET" Tab
    And user clicks on close icon in preview panel
    And user clicks on "RATING WIDGET" tab on visual composer
    And user clicks on set as preview button in Visual composer
    And User clicks on Preview button
    And Preview should display the "RATING WIDGET" Tab
    And user clicks on close icon in preview panel
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    And user clicks on item view "<NewItemView>" and click on visual composer button
    And User clicks on Preview button
    And Preview should display the "RATING WIDGET" Tab
    And user clicks on close icon in preview panel
    And user clicks on apply button on visual composer
    And user clicks on Delete button in the  Edit Item View panel
#    And user clicks on Yes button in alert message
    And user should be able logoff the IDC

    Examples:
      | NewItemView   |
      | New Item View |

  @MLP-2358 @webtest @regression @itemview @positive
  Scenario: MLP-2358: Verification of setting up the preview without Saving the changes
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name and definition for the item view
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And user enters "LINK WIDGET" name field of new item view panel dashboad
    And User drag and drop a "MULTIPLE LINKS WIDGET" widget to the page from the displayed widget sets
    And user clicks on add button in the Create New Item View panel
    And user enters "RATING WIDGET" name field of new item view panel dashboad
    And User drag and drop a "RATING WIDGET" widget to the page from the displayed widget sets
    And user clicks on add button in the Create New Item View panel
    And user enters "TAGS WIDGET" name field of new item view panel dashboad
    And User drag and drop a "TAGS WIDGET" widget to the page from the displayed widget sets
    And User clicks on Preview button
    Then Preview should display the "LINK WIDGET" Tab
    And user clicks on close icon in preview panel
    And user clicks on apply button on visual composer
    And user clicks on visual composer button
    And user clicks on "RATING WIDGET" tab on visual composer
    And user clicks on set as preview button in Visual composer
    And User clicks on Preview button
    And Preview should display the "RATING WIDGET" Tab
    And user clicks on close icon in preview panel
    And user clicks on close icon in edit item Full view panel
    And user clicks on visual composer button
    And User clicks on Preview button
    And Preview should display the "LINK WIDGET" Tab
    And user should be able logoff the IDC