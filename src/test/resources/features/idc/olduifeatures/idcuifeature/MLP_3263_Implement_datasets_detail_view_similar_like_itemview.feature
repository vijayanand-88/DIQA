@MLP-3263
Feature: MLP-3263 Implement datasets detail view similar like itemview

  @webtest @MLP-3263 @positive @regression @UI-DataSet
  Scenario: MLP-3263_Verification of Overview tab for Data set item view
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "address" and clicks on search
    And user selects the "Column" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "Sales Fact Test Data Sets two" and description "Sales Fact Test Data Sets description"
    And user clicks on home button
    And user clicks on DataSet dashboard
    And user clicks on "SALES FACT TEST DATA SETS TWO" data set
    And user validate data set full view window is displayed and following sections are available
      | dataSetOverViewSections |
      | DESCRIPTION             |
      | METADATA                |
      | TAG                     |
      | RATING                  |
    And user get the ID for data set "Sales Fact Test Data Sets two" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-3263 @positive @sanity @UI-DataSet
  Scenario: MLP-3263_Verification of Deleting a Data set
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "address" and clicks on search
    And user selects the "Column" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "Sales Fact Test Data Sets three" and description "Sales Fact Test Data Sets description"
    And user selects "DataSets" catalog from catalog list
    And user enters the search text "Sales Fact Test Data Sets three" and clicks on search
    And user clicks on "Sales Fact Test Data Sets three" item from search results
    And user clicks on Delete button in Data Set page
    And user clicks Yes on the alert window
    And user selects "DataSets" catalog from catalog list
    And user clicks on search icon
    Then Deleted dataset "Sales Fact Test Data Sets three" should not get displayed in data set list

  @webtest @MLP-3263 @positive @regression @UI-DataSet
  Scenario: MLP-3263_Verification of dataset items as table
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "address" and clicks on search
    And user selects the "Column" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "Sales Fact Test Data Sets Four" and description "Sales Fact Test Data Sets description"
    And user clicks on home button
    And user clicks On DataSet Dashboard And navigates to The "SALES FACT TEST DATA SETS FOUR" Dataset "Data" Tab
    Then data tab table header column name should be in upper case
    And user clicks on Delete button in Data Set page
    And user clicks Yes on the alert window

  @webtest @MLP-3263 @positive @regression @UI-DataSet
  Scenario: MLP-3263_Verification of handling larger descriptions for Dataset
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "address" and clicks on search
    And user selects the "Column" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "Sales Fact Test Data Sets FIVE" and description "Sales Fact Test Data Sets description"
    And user clicks on home button
    And user clicks on DataSet dashboard
    And user clicks on "SALES FACT TEST DATA SETS FIVE" data set
    And user clicks on "Data" tab displayed
    Then data tab table header column name should be in upper case
    And user clicks on Delete button in Data Set page
    And user clicks Yes on the alert window
