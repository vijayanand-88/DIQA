@MLP-1947
Feature: MLP-1947 Assign property widgets to an Itemview

  @MLP-1947 @webtest @positive
  Scenario: MLP-1947_Verification of assigning Text AttributeWidget with type as date
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
    And User drag and drop a "ATTRIBUTE WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
#    And alert "Attribute Name should not be empty" should be there
#    And "LABEL" alert "Label should have not empty value" should be there
    And user selects the ATTRIBUTE NAME as "asg.createdAt" and alert should be gone and hit apply
    And user enter the value "Test Label" in label text box in attribute widget page
    And user selects "date" from type dropdown box
    And User clicks on Preview button
    Then user validates the attribute name is displayed as "date" in  preview page Label Name
      | description | schemaName | tableName | columnName    | criteriaName |
      | SELECT      | BigData    | V_Rating  | asg.createdAt |              |
    And user clicks on close button in the item full view page
    And the user clicks on edit button on the widget
    And user selects the ATTRIBUTE NAME as "asg.modifiedAt" and alert should be gone and hit apply
    And the user clicks on Save button in the Attribute widget page
    And User clicks on Preview button
    Then user validates the attribute name is displayed as "date" in  preview page Label Name
      | description | schemaName | tableName | columnName     | criteriaName |
      | SELECT      | BigData    | V_Rating  | asg.modifiedAt |              |
    And user clicks on close button in the item full view page
    And the user clicks on edit button on the widget
    And user clicks on Delete button on visual composer
    And user clicks Yes on the alert window

  @MLP-1947 @webtest @positive
  Scenario: Verification of assigning Text AttributeWidget with type as String
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
    And User drag and drop a "ATTRIBUTE WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
#    And alert "Attribute Name should not be empty" should be there
#    And "LABEL" alert "Label should have not empty value" should be there
    And user selects the ATTRIBUTE NAME as "asg.createdBy" and alert should be gone and hit apply
    And user enter the value "Test Label" in label text box in attribute widget page
    And user selects "string" from type dropdown box
    And User clicks on Preview button
    Then user validates the attribute name is displayed as "string" in  preview page Label Name
      | description | schemaName | tableName | columnName    | criteriaName |
      | SELECT      | BigData    | V_Rating  | asg.createdBy |              |
    And user clicks on close button in the item full view page
    And the user clicks on edit button on the widget
    And user selects the ATTRIBUTE NAME as "asg.modifiedBy" and alert should be gone and hit apply
    And the user clicks on Save button in the Attribute widget page
    And User clicks on Preview button
    Then user validates the attribute name is displayed as "string" in  preview page Label Name
      | description | schemaName | tableName | columnName     | criteriaName |
      | SELECT      | BigData    | V_Rating  | asg.modifiedBy |              |
    And user clicks on close button in the item full view page
    And the user clicks on edit button on the widget
    And user clicks on Delete button on visual composer
    And user clicks Yes on the alert window

  @MLP-1947 @webtest @positive
  Scenario: Verification of assigning Text AttributeWidget with type as JSON
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
    And User drag and drop a "ATTRIBUTE WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
#    And alert "Attribute Name should not be empty" should be there
#    And "LABEL" alert "Label should have not empty value" should be there
    And user selects the ATTRIBUTE NAME as "asg.createdBy" and alert should be gone and hit apply
    And user enter the value "Test Label" in label text box in attribute widget page
    And user selects "json" from type dropdown box
#    And User clicks on Preview button
#    Then user validates the attribute name is displayed as "json" in  preview page Label Name
#      | description | schemaName | tableName | columnName    | criteriaName |
#      | SELECT      | BigData    | V_Rating  | asg.createdBy |              |
#    And user clicks on close button in the item full view page
    And the user clicks on edit button on the widget
    And user selects the ATTRIBUTE NAME as "asg.modifiedBy" and alert should be gone and hit apply
    And the user clicks on Save button in the Attribute widget page
#    And User clicks on Preview button
#    Then user validates the attribute name is displayed as "json" in  preview page Label Name
#      | description | schemaName | tableName | columnName     | criteriaName |
#      | SELECT      | BigData    | V_Rating  | asg.modifiedBy |              |
#    And user clicks on close button in the item full view page
    And the user clicks on edit button on the widget
    And user clicks on Delete button on visual composer
    And user clicks Yes on the alert window

  @MLP-1947 @webtest @positive
  Scenario: Verification of assigning Text AttributeWidget with type as Binary
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
    And User drag and drop a "ATTRIBUTE WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
#    And alert "Attribute Name should not be empty" should be there
#    And "LABEL" alert "Label should have not empty value" should be there
    And user selects the ATTRIBUTE NAME as "asg.createdBy" and alert should be gone and hit apply
    And user enter the value "Test Label" in label text box in attribute widget page
    And user selects "binary" from type dropdown box
#    And User clicks on Preview button
#    Then user validates the attribute name is displayed as "binary" in  preview page Label Name
#      | description | schemaName | tableName | columnName    | criteriaName |
#      | SELECT      | BigData    | V_Rating  | asg.createdBy |              |
#    And user clicks on close button in the item full view page
    And the user clicks on edit button on the widget
    And user selects the ATTRIBUTE NAME as "asg.modifiedBy" and alert should be gone and hit apply
    And user selects "binary" from type dropdown box
#    And User clicks on Preview button
#    Then user validates the attribute name is displayed as "binary" in  preview page Label Name
#      | description | schemaName | tableName | columnName     | criteriaName |
#      | SELECT      | BigData    | V_Rating  | asg.modifiedBy |              |
#    And user clicks on close button in the item full view page
    And the user clicks on edit button on the widget
    And user clicks on Delete button on visual composer
    And user clicks Yes on the alert window

  @MLP-1947 @webtest @positive
  Scenario: Verification of assigning multipleTextAttributeWidget property
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "Test Item View" and definition as "Test Attribute View" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "MULTIPLE ATTRIBUTES WIDGET" widget to the page from the displayed widget sets
    And widget edit button should be highlighted
    And the user clicks on edit button on the widget
    And user enter the value "Operation" in label text box in attribute widget page
    And user clicks on apply button on item view config page
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    Then item view "Test Item View" should get added in database and "MULTIPLE ATTRIBUTES WIDGET" in data column
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |
    And user clicks on "Test Item View" from item view list
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on Yes button in alert message


  @ML-1947 @webtest @positive
  Scenario: MLP-1947 Verification of adding LinkAttribute property
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "Link Widget Item View" and definition as "Link Widget definition" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Column" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "LINK WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
    And user selects the ATTRIBUTE NAME as "has_Column" and alert should be gone and hit apply
    And user selects "BOTH" in "DIRECTION" field
    And user enter the value "Test Label" in label text box in attribute widget page
    And user enter the page size as "13"
    And user selects "table" from type dropdown box
   # And the user clicks on Save button in the Attribute widget page
    And User clicks on Preview button
    And user clicks on close button in the item full view page
    And the user clicks on edit button on the widget
    And user enter the page size as "10"
    And the user clicks on Save button in the Attribute widget page
    And User clicks on Preview button
    And user clicks on close button in the item full view page
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    Then item view "Link Widget Item View" should get added in database and "LINK WIDGET" in data column
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |
    And user clicks on "Link Widget Item View" from item view list
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on Yes button in alert message

  @ML-1947 @webtest @positive
  Scenario:  MLP-1947 Verification of adding MultiLinkAttribute in itemview
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "Multiple Link Widget Item View" and definition as "Multiple Link Widget definition" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Column" for Item View and click add button
    And user enters the Supported Type as "Table" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "MULTIPLE LINKS WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
    And user enters the attribute name as "has_Column" and click add button
#    And user enters the attribute name as "hdfsLocation" and click add button
#    And user enters the attribute name as "has_Table" and click add button
    And user selects "BOTH" in "DIRECTION" field
    And user selects "ALL" in "MODE" field
    And user clicks on apply button on item view config page
#    And the user clicks on Save button in the Attribute widget page
    And User clicks on Preview button
    Then following attributes should be displayed in preview page
      | previewPageAttributeList |
      | TABLES                |
      | COLUMNS               |
#      | HDFSLOCATION          |
#      | SIMILAR               |
#      | SIMILAR               |
    And user clicks on close button in the item full view page
    And the user clicks on edit button on the widget
    And user selects "INCLUDE" in "MODE" field
    And user clicks on apply button on item view config page
#    And the user clicks on Save button in the Attribute widget page
    And User clicks on Preview button
    Then following attributes should be displayed in preview page
      | previewPageAttributeList |
      | TABLES               |
      | COLUMNS              |
#      | HDFSLOCATION        |
    And user clicks on close button in the item full view page
    And the user clicks on edit button on the widget
    And user selects "EXCLUDE" in "MODE" field
    And user clicks on apply button on item view config page
#    And the user clicks on Save button in the Attribute widget page
    And User clicks on Preview button
    Then following attributes should not be displayed in preview page
      | previewPageAttributeList |
      | TABLES                |
      | COLUMNS               |
      | HDFSLOCATION         |
    And user clicks on close button in the item full view page
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    Then item view "Multiple Link Widget Item View" should get added in database and "MULTIPLE LINKS WIDGET" in data column
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |
    And user clicks on "Multiple Link Widget Item View" from item view list
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on Yes button in alert message

  @ML-1947 @webtest @positive
  Scenario:  MLP-1947 Verification of adding GREMLIN WIDGET in itemview
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "GREMLIN WIDGET Item View" and definition as "GREMLIN WIDGET Widget definition" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Column" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "GREMLIN QUERY WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
    And user enter the value "Test Label" in label text box in gremlin widget page
    And user enter the page size as "13"
    And user enters "g.V(items).out('has_Column').where(out('dataOfType').values('dataType').is('STRING'))" in Query text box
#    And user selects "table" from type dropdown box
    And user clicks on apply button on item view config page
    And User clicks on Preview button

  @MLP-1947 @webtest @visualcomposer @regression @positive
  Scenario: MLP-1947 Verification of adding empty filter for MultipleTextAttributeWidget
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "Test attribute View" and definition as "Test Attribute View" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    And user clicks on visual composer button
    When user clicks on add button in the Create New Item View panel
    And User drag and drop a "MULTIPLE ATTRIBUTES WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
    Then user clicks on add button of filter in multiple attribute widget
#    And alert "AttributeFilter should have at least one value selected" should be there
    And apply button should be disabled
    And user should be able logoff the IDC

  @MLP-1947 @webtest @visualcomposer @regression @positive
  Scenario: MLP-1947 Verification of adding empty header for LinkAttributeWidget
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "Test Link View" and definition as "Test Link View" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    And user clicks on visual composer button
    When user clicks on add button in the Create New Item View panel
    And User drag and drop a "LINK WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
#    And alert "Attribute Name should not be empty" should be there
    And apply button should be disabled
    And user should be able logoff the IDC

  @MLP-1947 @webtest @positive
  Scenario: MLP-1947_Verification of adding headers for LinkAttributeWidget
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
    And user selects the ATTRIBUTE NAME as "has_Operation" and alert should be gone and hit apply
    And user clicks on Add button near to field "HEADERS"
    And user enter attribute name as "permissions" in table header page
    And user click Apply button in table header window
    And user enter the value "Link Widget label" in label text box in attribute widget page
    And the user clicks on Save button in the Attribute widget page
    And User clicks on Preview button
    Then User validate item Preview full view page has "permissions" section
    And user clicks on close button in the item full view page
    And the user clicks on edit button on the widget
    And user click on table header "permissions"
    And user enables hidden checkbox in table header window
    And user click Apply button in table header window
    And the user clicks on Save button in the Attribute widget page
    And User clicks on Preview button
    Then table header "permissions" should not be displayed

  @MLP-1947 @webtest @positive
  Scenario:MLP-1947 Verification of adding JSONTableWidget to itemView
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "JSON Widget" and definition as "JSON widget desc" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "JSON WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
    And user selects the ATTRIBUTE NAME as "comments" and alert should be gone and hit apply
    And user enter the value "JSON Widget label" in label text box in attribute widget page
    And the user clicks on Save button in the Attribute widget page
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    Then item view "JSON Widget" should get added in database and "JSON WIDGET" in data column
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |
    And user clicks on "JSON Widget" from item view list
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on Yes button in alert message

  @MLP-1947 @webtest @positive
  Scenario:MLP-1947 Verification of pop up confirmation for deleting an Item view
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "Delete confirmation test" and definition as "Delete desc" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    And user clicks on Save button in the Create New Item View panel
    And user clicks on "Delete confirmation test" from item view list
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on No button in alert message
    And user clicks on close button in the New Subject Area page
    And user clicks on "Delete confirmation test" from item view list
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on Yes button in alert message

  @MLP-1947 @webtest @positive
  Scenario:MLP-1947 Verification of deleting a header value for LinkAttributeWidget
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "Link Widget Header Delete" and definition as "Link Attribute widget" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Operation" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "LINK WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
    And user selects the ATTRIBUTE NAME as "has_Operation" and alert should be gone and hit apply
    And user clicks on Add button near to field "HEADERS"
    And user enter attribute name as "permissions" in table header page
    And user click Apply button in table header window
    And user click on table header "permissions"
    And user click on delete button in table header child window
    And user clicks on Yes button in alert message
    And user enter the value "delete header" in label text box in attribute widget page
    And the user clicks on Save button in the Attribute widget page
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    And user clicks on "Link Widget Header Delete" from item view list
    And user clicks on visual composer button
    And the user clicks on edit button on the widget
    Then deleted header "permissions" should not be displayed in widget page
    And the user clicks on Save button in the Attribute widget page
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    And user clicks on "Link Widget Header Delete" from item view list
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on Yes button in alert message


  @MLP-1947 @webtest @positive
  Scenario:MLP-1947 Verification of adding Tags Widget to itemView
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


  @MLP-1947 @webtest @positive
  Scenario:MLP-1947 Verification of adding AttributeTypeFilter for MultipleTextAttributeWidget
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "MultipleText WIDGET" and definition as "MultipleText desc" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "MULTIPLE ATTRIBUTES WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
    And user clicks on add button of filter in multiple attribute widget
    And user selects widget attribute name as "AttributeTypeFilter"
    And user selects "INCLUDE" in "MODE" field
    And user enters the attribute Type as "string" for Item View and click add button
    And user click Apply button in Attribute Filter window
    And user enter the value "Test Label" in label text box in attribute widget page
    And the user clicks on Save button in the Attribute widget page
    And User clicks on Preview button
    Then preview page table should have only following values
      | attributeTableValues |
      | Creator              |
      | Modified by          |
      | Location             |
      | name                 |
      | Storage type         |
    And user clicks on close button in the item full view page
    And the user clicks on edit button on the widget
    And user click item name "AttributeTypeFilter" in widget page
    And user selects "EXCLUDE" in "MODE" field
    And user click Apply button in Attribute Filter window
    And the user clicks on Save button in the Attribute widget page
    And User clicks on Preview button
    Then preview page table should not have following values
      | attributeTableValues |
      | Creator              |
      | Modified by          |
      | Location             |
      | name                 |
      | Storage type         |

  @MLP-1947 @webtest @positive
  Scenario:MLP-1947 Verification of adding StoredQueryWidget to item View
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "Stored Widget" and definition as "Stored widget desc" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "STORED QUERY WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
    And user enters "gremlinstoredQuery" in query name field
    And the user clicks on Save button in the Attribute widget page
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    Then item view "Stored Widget" should get added in database and "StoredQueryWidget" in data column
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |
    And user clicks on "Stored Widget" from item view list
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on Yes button in alert message

  @MLP-1947 @webtest @positive
  Scenario:MLP_1947 Verification of adding GroovyAttributeFilter for MultipleTextAttributeWidget
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "MultipleText WIDGET" and definition as "MultipleText desc" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Database" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "MULTIPLE ATTRIBUTES WIDGET" widget to the page from the displayed widget sets
    And the user clicks on edit button on the widget
    And user clicks on add button of filter in multiple attribute widget
    And user selects widget attribute name as "GroovyAttributeFilter"
    And user selects "INCLUDE" in "MODE" field
    And user enters "(property.label() == 'asg.createdBy' || property.label() == 'asg.createdAt')" in "GROOVY SCRIPT" text field
    And user click Apply button in Attribute Filter window
    And user enter the value "Test Label" in label text box in attribute widget page
    And the user clicks on Save button in the Attribute widget page
#    And the user clicks on Save button in the Attribute widget page
    And User clicks on Preview button
    Then preview page table should have only following values
      | attributeTableValues |
      | Created       |
      | Creator       |
    And user clicks on close button in the item full view page
    And the user clicks on edit button on the widget
    And user click item name "GroovyAttributeFilter" in widget page
    And user selects "EXCLUDE" in "MODE" field
    And user click Apply button in Attribute Filter window
    And user clicks on apply button on item view config page
#    And the user clicks on Save button in the Attribute widget page
    And User clicks on Preview button
    Then preview page table should not have following values
      | attributeTableValues |
      | Created       |
      | Creator       |