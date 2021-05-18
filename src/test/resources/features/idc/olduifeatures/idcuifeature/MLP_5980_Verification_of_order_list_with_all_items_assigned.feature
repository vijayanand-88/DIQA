@MLP-5980
Feature: MLP-5980 Verification of the order list with all the data elements for all items assigned

  @webtest @MLP-5980 @positive @UI-DataSet @regression
  Scenario: MLP-5980 Verification of Order List icon in the data Tab
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "sales_fact_dec_1998" and clicks on search
    And user selects the "Table" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "SalesDataSets" and description "SalesDataSets Dataset description"
    And user clicks on home button
    And user clicks On DataSet Dashboard And navigates to The "SALESDATASETS" Dataset "Data" Tab
    And user "verifies disabled" for "order list" in the Data tab
    Then user clicks on the following data item checkbox from the list
      | datasetItems        |
      | sales_fact_dec_1998 |
    And user "verifies enabled" for "order list" in the Data tab

  @webtest @MLP-5980 @positive @UI-DataSet @regression
  Scenario: MLP-5980 Verification of Unsaved changes pop up in the Order List panel
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks On DataSet Dashboard And navigates to The "SALESDATASETS" Dataset "Data" Tab
    And user "verifies disabled" for "order list" in the Data tab
    Then user clicks on the following data item checkbox from the list
      | datasetItems        |
      | sales_fact_dec_1998 |
    And user "verifies enabled" for "order list" in the Data tab
    And user "click" on "Order List"
    And user "click" on "remove button" for the "sales_fact_dec_1998" item in the order list panel
    And user clicks on close button in the Edit Tags page
    And user clicks on No button in alert message
    Then user "verify displayed" for the "ORDER LIST" panel
    And user clicks on close button in the Edit Tags page
    And user clicks on Yes button in alert message
    And user "verify not displayed" for the "ORDER LIST" panel

  @webtest @MLP-5980 @positive @UI-DataSet @regression
  Scenario: MLP-5980 Verification of Submitting an Order
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "store_id" and clicks on search
    And user enable first item checkbox from item search results
    And user assigns "SalesDataSets" dataset from the Assign data set panel
    And user clicks on home button
    When user clicks On DataSet Dashboard And navigates to The "SALESDATASETS" Dataset "Data" Tab
    Then user clicks on the following data item checkbox from the list
      | datasetItems        |
      | sales_fact_dec_1998 |
      | store_id            |
    And user "click" on "Order List"
    And user "verify displayed" for "2ITEMS REQUESTED FOR ACCESS" in the ORDER LIST panel
    And user "click" on "submit order" button
    And user "verify not displayed" for the "ORDER LIST" panel

  @webtest @MLP-5980 @positive @UI-DataSet @regression
  Scenario: MLP-5980 Verification of removing an item from the order list
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks On DataSet Dashboard And navigates to The "SALESDATASETS" Dataset "Data" Tab
    And user clicks on the following data item checkbox from the list
      | datasetItems        |
      | sales_fact_dec_1998 |
      | store_id            |
    And user "click" on "Order List"
    And user "verify displayed" for the "ORDER LIST" panel
    And user "click" on "remove button" for the "sales_fact_dec_1998" item in the order list panel
    And user verifies whether plus button is displayed for the "sales_fact_dec_1998" item and background color for the selected item for removal is "rgba(248, 215, 218, 1)" in the order list panel

  @webtest @MLP-5980 @positive @UI-DataSet @regression
  Scenario: MLP-5980 Verification of Submit order button when there is no item for request access
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "product_id" and clicks on search
    And user enable first item checkbox from item search results
    And user assigns "SalesDataSets" dataset from the Assign data set panel
    And user clicks on home button
    When user clicks On DataSet Dashboard And navigates to The "SALESDATASETS" Dataset "Data" Tab
    And user clicks on the following data item checkbox from the list
      | datasetItems |
      | product_id   |
    And user "click" on "Order List"
    And user "verify displayed" for the "ORDER LIST" panel
    And user "click" on "remove button" for the "product_id" item in the order list panel
    And user verifies whether plus button is displayed for the "product_id" item and background color for the selected item for removal is "rgba(248, 215, 218, 1)" in the order list panel
    And user "verifies disabled" on "submit order" button

  @webtest @MLP-5980 @positive @UI-DataSet @regression
  Scenario: MLP-5980 Verification of selecting data items from multiple pages and Submitting an Order
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Administration" dashboard
    And User "click" on "ITEM VIEW MANAGER" link on the Dashboard page
    And user clicks on item view "itemView_DataSet" and click on visual composer button
    And user clicks on "Data" tab displayed
    And the user clicks on edit button on the widget
    And user enter the page size as "2"
    And user clicks on the apply buuton in the edit widget panel
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    And user clicks on home button
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Administrator" role
    When user clicks On DataSet Dashboard And navigates to The "SALESDATASETS" Dataset "Data" Tab
    And user clicks on the following data item checkbox from the list
      | datasetItems        |
      | sales_fact_dec_1998 |
    And user clicks on next button in the pagination
    And user "click" on "First checkbox from the list in Data Panel" on DatasetPage
    And user "click" on "Order List"
    And user "verify displayed" for "2ITEMS REQUESTED FOR ACCESS" in the ORDER LIST panel
    And user "click" on "submit order" button
    And user clicks on notification icon
    And "Request for Access for SalesDataSets DataSet and BigData Catalog has been sent by TestDataSteward" notification content should get displayed in the requests tab
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "System Administrator1" role
    And user "click" on "Administration" dashboard
    And User "click" on "ITEM VIEW MANAGER" link on the Dashboard page
    And user clicks on item view "itemView_DataSet" and click on visual composer button
    And user clicks on "Data" tab displayed
    And the user clicks on edit button on the widget
    And user enter the page size as "14"
    And user clicks on the apply buuton in the edit widget panel
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    And user should be able logoff the IDC
    And user get the ID for data set "SalesDataSets" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-5980 @positive @UI-DataSet @regression
  Scenario: MLP-5980 Verification of Submitting an Order and verifying the removed item in the approver list
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "employeeterritories" and clicks on search
    And user selects the "Table" from the Type
    And user enables the following item checkboxes
      | itemName            |
      | employeeterritories |
    And user creates a dataset with name "TableAnalysisDataSets" and description "TableAnalysisDataSets Dataset description"
    And user enters the search text "shippers" and clicks on search
    And user selects the "Table" from the Type
    And user enables the following item checkboxes
      | itemName |
      | shippers |
    And user assigns "TableAnalysisDataSets" dataset from the Assign data set panel
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Administrator" role
    When user clicks On DataSet Dashboard And navigates to The "TABLEANALYSISDATASETS" Dataset "Data" Tab
    And user clicks on the following data item checkbox from the list
      | datasetItems        |
      | employeeterritories |
      | shippers            |
    And user "click" on "Order List"
    And user "click" on "remove button" for the "shippers" item in the order list panel
    And user "click" on "submit order" button
    And user clicks on notification icon and open first open area link in notifications panel
    And user "click" on "arrow icon" of the drop down in the panel
    Then user validates the following data items are not present in the open notification panel
      | orderListRemovedItems |
      | shippers              |
    And user get the ID for data set "TableAnalysisDataSets" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"
