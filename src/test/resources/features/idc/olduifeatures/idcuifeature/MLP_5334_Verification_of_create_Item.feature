Feature: MLP-5334 Verification of Create Item

  @webtest @MLP-5334 @webtest @positive
  Scenario: Enabling item types for the BigData Catalog
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Administration" dashboard
    And User "click" on "CATALOG MANAGER" link on the Dashboard page
    And user clicks on mentioned Subject Area in json config file "BigData"
    And user "click" on "Schemas, Types and Attributes" from the edit catalog panel
    And user "click" on the dropdown and select the menu for "Schemas" and selects "BigData (10.1.0)" in catalog advance options panel
    And user clicks on mentioned Subject Area in json config file "BigData"
    And user "click" on "Schemas, Types and Attributes" from the edit catalog panel
    And user "click" on the dropdown and select the menu for "Types" and selects "Table" in catalog advance options panel
    And user "click" on "Schemas, Types and Attributes" from the edit catalog panel
    And user "click" on the dropdown and select the menu for "Types" and selects "Field" in catalog advance options panel
    And user "click" on "Schemas, Types and Attributes" from the edit catalog panel
    And user "click" on the dropdown and select the menu for "Types" and selects "Column" in catalog advance options panel
    And user clicks on save button in the subject area item view page
    And user clicks on save button in the Edit Catalog page
    And user should be able logoff the IDC

  @webtest @MLP-5334 @webtest @positive
  Scenario:Verification of creating an item of type Field
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects catalog "BigData" and type "Field" in create item panel
    And user selects root type "Field" and name "_c22" in create item panel
    And user "verifies displayed" alert for "FieldName" as "name field should not be empty"
    And user enters the following values in create item panel fields
      | createItemFieldName | createItemFieldValue |
      | NAME                | FieldItem            |
#      | CREATED BY                    | TestSystem              |
#      | DATA TYPE                     | String                  |
#      | COMMENTS                      | This is Part of testing |
#      | MAXIMUM LENGTH                | 100                     |
#      | MINIMUM LENGTH                | 20                      |
#      | PERCENTAGE OF NON NULL VALUES | 100                     |
#      | NUMBER OF UNIQUE VALUES       | 5                       |
#      | PERCENTAGE OF UNIQUE VALUES   | 5                       |
    Then user "click" on "Save and open" in create item panel
    And user get the ID for item "FieldItem" from below query for create item page
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Field   | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "items/BigData/BigData.Field:::"

  @webtest @MLP-5334 @webtest @positive
  Scenario:Verification of creating an item of type Table
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects catalog "BigData" and type "Table" in create item panel
    And user selects root type "Database" and name "default" in create item panel
    And user "verifies displayed" alert for "FieldName" as "name field should not be empty"
    And user enters the following values in create item panel fields
      | createItemFieldName | createItemFieldValue |
      | NAME                | A_TableItem          |
#      | CREATED BY          | TestSystem                               |
#      | INPUT TYPE          | org.apache.hadoop.mapred.TextInputFormat |
#      | COMMENTS            | This is Part of testing                  |
#      | NUMBER OF ROWS      | 12                                       |
#      | STORAGE TYPE        | managed                                  |
#      | TABLE SIZE          | 588280                                   |
#      | FIELD DELIMITERS    | field.delim=\u0001, line.delim=\u000a    |
    Then user "click" on "Save and open" in create item panel
    And user get the ID for item "A_TableItem" from below query for create item page
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Table   | ID         | name         |

  @webtest @MLP-5334 @webtest @positive
  Scenario:Verification of adding a star for newly created item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "A_TableItem" and clicks on search
    And user clicks on first item on the item list page
    And user gives "5" rating to the clicked item
    And user clicks on close button in the item preview page
    And User "click" on "remove Search Text Button" link on the Dashboard page
    And user clicks on search icon
    And user refreshes the application
    And user clicks on rating 5 checkbox and get item count
    Then solr search count should be matched for rating 5
    And solr item names should be matched for rating 5

  @webtest @MLP-5334 @webtest @positive
  Scenario:Verification of adding/creating a tag for newly created item
    Given user deletes primary key constraint for deleting tag "QAAUTOMATION TAG"
    And user deletes the created tag "QAAUTOMATION TAG"
    When User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "A_TableItem" and clicks on search
    And user clicks on first item on the item list page
    And user "click" on "add tag button" in Item view page
    And user assign the following tags to item
      | tagName       |
      | Email Address |
    And user click on create new tag in the Add tags panel
    And user enters tag details and click save
    And user clicks on save button
    And user clicks on close button in the item full view page
    When user clicks on first item on the item list page
    Then user verifies tags "Email Address" and "QAAUTOMATION TAG" are displayed
    And user get the ID for item "A_TableItem" from below query for create item page
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Table   | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "items/BigData/BigData.Table:::"
    And user makes a REST Call for DELETE request with url "/tags/BigData/tags/QAAUTOMATION%20TAG?roottag=QAAUTOMATION%20TAG"


  @webtest @MLP-5334 @webtest @positive
  Scenario:Verification of Unsaved changes pop up during the creation of an Item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects catalog "BigData" and type "Field" in create item panel
    And user selects root type "Field" and name "_c22" in create item panel
    And user "click" on "Create panel close button" in create item panel
    And user clicks on No button in alert message
    And user verifies create item panel is displayed
    Then user "click" on "Create panel close button" in create item panel
    And user clicks on Yes button in alert message
    And user "verifies displayed" on "QuickStart" dashboard

  @webtest @MLP-5334 @webtest @positive
  Scenario:Verification of creating an item with same for different types
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects catalog "BigData" and type "Column" in create item panel
    And user selects root type "Column" and name "customerid" in create item panel
    And user enters the following values in create item panel fields
      | createItemFieldName | createItemFieldValue      |
      | NAME                | SameNamewithDifferentType |
    And user "click" on "Save" in create item panel
    And user selects catalog "BigData" and type "Table" in create item panel
    And user selects root type "Database" and name "default" in create item panel
    And user enters the following values in create item panel fields
      | createItemFieldName | createItemFieldValue      |
      | NAME                | SameNamewithDifferentType |
    And user "click" on "Save" in create item panel
    Then user enters the search text "SameNamewithDifferentType" and clicks on search
    And user get the ID for item "SameNamewithDifferentType" from below query for create item page
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Table   | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "items/BigData/BigData.Table:::"

  @webtest @MLP-5334 @webtest @positive
  Scenario:Verification of Deleting an item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "SameNamewithDifferentType" and clicks on search
    And user clicks on first item Name in item list view from search result
    Then user clicks on "Delete" icon in item full view page
    And user clicks on Yes button in alert message

  @webtest @MLP-5334 @webtest @positive
  Scenario: Remove Schema and Type for BigData Catalog
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Administration" dashboard
    And User "click" on "CATALOG MANAGER" link on the Dashboard page
    And user clicks on mentioned Subject Area in json config file "BigData"
    And user "click" on "Schemas, Types and Attributes" from the edit catalog panel
    And user removes following items from the "SCHEMAS, TYPES AND ATTRIBUTES" panel
      | BigData (10.1.0) |
      | Table            |
    And user clicks on save button in the subject area item view page
    And user clicks on save button in the Edit Catalog page
    And user should be able logoff the IDC