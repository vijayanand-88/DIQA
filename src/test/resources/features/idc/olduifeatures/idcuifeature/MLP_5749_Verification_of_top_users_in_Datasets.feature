@MLP-5749
Feature: MLP-5749 Verification of Top users of a dataset

  @webtest @MLP-5749 @positive @UI-DataSet @regression
  Scenario: MLP-5749 Verification of last user in dataset
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
    And user "click" on the dropdown and select the menu for "Workflows" and selects "dataset_access_request_single_vote" in catalog advance options panel
    And user enters the search text "sales_fact_dec_1998" and clicks on search
    And user selects the "Table" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "TestDataSets" and description "Test Dataset description"
    And user clicks on home button
    When user clicks On DataSet Dashboard And navigates to The "TESTDATASETS" Dataset
    And user verifies whether top user widget is displayed with mandatory information under dataset overview tab
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Administrator" role
    And user clicks On DataSet Dashboard And navigates to The "TESTDATASETS" Dataset
    And user "verifies displayed" whether the Last user is "TestService" under dataset overview tab
    And user clicks on logout button
    And user get the ID for data set "TestDataSets" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-5749 @positive @UI-DataSet @regression
  Scenario: MLP-5749 Verification of configuration of panel size of Top users widget and no of calls in dataset
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "product_id" and clicks on search
    And user enable first item checkbox from item search results
    And user creates a dataset with name "TestDataSets1" and description "Test Dataset description"
    And user clicks on home button
    And user "click" on "Administration" dashboard
    And User "click" on "ITEM VIEW MANAGER" link on the Dashboard page
    And user clicks on item view "itemView_DataSet" and click on visual composer button
    And user resizes "TOP USERS WIDGET" widget In Visual Composer as "1 x 1" and save it
    And user clicks on home button
    And user clicks On DataSet Dashboard And navigates to The "TESTDATASETS1" Dataset
    And user "verify equals" whether the width of the "TOP USER" widget and "199" are same under dataset overview tab
    And user verifies "0" call is displayed in the Top User widget
    And user clicks on home button
    And user "click" on "Administration" dashboard
    And User "click" on "ITEM VIEW MANAGER" link on the Dashboard page
    And user clicks on item view "itemView_DataSet" and click on visual composer button
    And user resizes "TOP USERS WIDGET" widget In Visual Composer as "1 x 2" and save it
    And user clicks on home button
    And user clicks On DataSet Dashboard And navigates to The "TESTDATASETS1" Dataset
    And user verifies "1" call is displayed in the Top User widget
    And user "verify equals" whether the width of the "TOP USER" widget and "413" are same under dataset overview tab
    And user clicks on home button
    And user selects "DataSets" catalog from catalog list
    And user clicks on "TestDataSets1" in the items listed
    And user verifies "2" call is displayed in the Top User widget

  @webtest @MLP-5749 @positive @UI-DataSet @regression
  Scenario: MLP-5749  Verification of Top users in dataset detail view
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "TESTDATASETS1" Dataset
    And user clicks on home button
    And user clicks On DataSet Dashboard And navigates to The "TESTDATASETS1" Dataset
    And user "verify displayed" whether the top users of the dataset contains "Test Data Consumer" username under dataset overview tab
    And user clicks on logout button
    And user get the ID for data set "TestDataSets1" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"



