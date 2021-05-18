@MLP-3249
Feature: MLP-3249 Create/Assign Dataset from search result

  @webtest @MLP-3249 @positive @sanity @UI-DataSet
  Scenario: MLP-3249-Verification of Assign DataSets button in search panel
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Sales_fact" and clicks on search
    Then Assign Data set button should be visible in search result page

  @webtest @MLP-3249 @positive @sanity @UI-DataSet
  Scenario: MLP-3249 Verification of creating a new DataSet
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "sales_fact_dec_1998" and clicks on search
    And user selects the "Table" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "Sales Fact Test Data one one" and description "Sales Fact Test Data one one description"
    And user clicks on notification icon in the left panel
    And notification "DataSet Sales Fact Test Data one one has been created by TestService" should be displayed
    And user enters the search text "Sales_fact" and clicks on search
    And user enable first item checkbox from item search results
    And user click on Assign DataSet button
    And user select "Sales Fact Test Data one one" in Data Set dropdown in Assign data set panel
    And user click on Assign button in Assign Data Set panel
    And user clicks on notification icon in the left panel
    Then notification "DataSet Sales Fact Test Data one one has been updated by TestService" should be displayed
    And user selects "DataSets" catalog from catalog list
    And user enters the search text "Sales Fact Test Data one one" and clicks on search
    And user clicks on "Sales Fact Test Data one one" item from search results
    And user clicks on Delete button in Data Set page
    And user clicks Yes on the alert window


  @webtest @MLP-3249 @positive @sanity @UI-DataSet
  Scenario: MLP-3249 Verification of Assign DataSet panel
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "customer_id" and clicks on search
    And user selects the "Column" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "Sales Fact Test Data Sets 11" and description "Sales Fact Test Data Sets 11 description"
    And user get the ID for data set "Sales Fact Test Data Sets 11" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for the data set with id "datasets/DataSets.DataSet:::" and get the values of "dataElements"
    Then user makes a REST Call with url "items/BigData/" to get item "name" and compare with below names
      | itemName    |
      | customer_id |
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"


  @webtest @MLP-3249 @positive @regression @UI-DataSet
  Scenario: MLP-3249 Verification of removing an old item from DataSet and assigning a new items
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "firstname" and clicks on search
    And user selects the "Column" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "Employee Data Set" and description "Sales Fact Test Data Sets 31 description"
    And user enters the search text "firstname" and clicks on search
    And user selects the "Column" from the Type
    And user enables the following item checkboxes
      | itemName  |
      | firstname |
    And user click on Assign DataSet button
    And user select "Employee Data Set" in Data Set dropdown in Assign data set panel
    And user click on Assign button in Assign Data Set panel
    And user enters the search text "country" and clicks on search
    And user selects the "Column" from the Type
    And user enables the following item checkboxes
      | itemName |
      | country  |
    And user click on Assign DataSet button
    And user select "Employee Data Set" in Data Set dropdown in Assign data set panel
    And user remove the following data element from dataset
      | dataElements |
      | firstname    |
    And user click on Assign button in Assign Data Set panel
    And user get the ID for data set "Employee Data Set" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for the data set with id "datasets/DataSets.DataSet:::" and get the values of "dataElements"
#    Then user makes a REST Call with url "items/BigData/" to get item "name" and compare with below names
#      | itemName |
#      | country  |
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-3249 @positive @regression @UI-DataSet
  Scenario:  MLP-3249 Verification of creating a data set with empty data elements
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "firstname" and clicks on search
    And user selects the "Column" from the Type
    And user enable first item checkbox from item search results
    And user click on Assign DataSet button
    And user click on Create New DataSet button in Assign Data Set panel
    And user enter name field values as "Sales Fact Test Data one one" in New Data set panel
    And user enter description field values as "Sales Fact Test Data Sets description" in New Data set panel
    And user click Submit button in New Data Set panel
    And user remove the following data element from dataset
      | dataElements |
      | firstname    |
    And user click on Assign button in Assign Data Set panel
    And user clicks on notification icon in the left panel
    Then notification "DataSet Sales Fact Test Data one one has been created by TestService" should be displayed
    And user get the ID for data set "Sales Fact Test Data one one" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-3249 @positive @regression @UI-DataSet
  Scenario:  MLP-3249 Veriifcation of Assigning a new item in Existing DataSets
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "firstname" and clicks on search
    And user selects the "Column" from the Type
    And user enable first item checkbox from item search results
    And user click on Assign DataSet button
    And user click on Create New DataSet button in Assign Data Set panel
    And user enter name field values as "Sales Fact Test Data Sets 13" in New Data set panel
    And user enter description field values as "Sales Fact Test Data Sets description" in New Data set panel
    And user click Submit button in New Data Set panel
    And user click on Assign button in Assign Data Set panel
    And user get the ID for data set "Sales Fact Test Data Sets 13" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for the data set with id "datasets/DataSets.DataSet:::" and get the values of "dataElements"
    And user makes a REST Call with url "items/BigData/" to get item "name" and compare with below names
      | itemName  |
      | firstname |
    And user enters the search text "email" and clicks on search
    And user selects the "Column" from the Type
    And user enable first item checkbox from item search results
    And user click on Assign DataSet button
    And user select "Sales Fact Test Data Sets 13" in Data Set dropdown in Assign data set panel
    And user click on Assign button in Assign Data Set panel
    And user makes a REST Call for the data set with id "datasets/DataSets.DataSet:::" and get the values of "dataElements"
#    Then user makes a REST Call with url "items/BigData/" to get item "name" and compare with below names
#      | itemName  |
#      | firstname |
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-3249 @positive @regression @UI-DataSet
  Scenario: MLP-3249 Verification of removing all DataElememts from DataSet
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "firstname" and clicks on search
    And user selects the "Column" from the Type
    And user enable first item checkbox from item search results
    And user click on Assign DataSet button
    And user click on Create New DataSet button in Assign Data Set panel
    And user enter name field values as "Sales Fact Test Data Sets 14" in New Data set panel
    And user enter description field values as "Sales Fact Test Data Sets description" in New Data set panel
    And user click Submit button in New Data Set panel
    And user remove the following data element from dataset
      | dataElements |
      | firstname    |
    And user click on Assign button in Assign Data Set panel
    And user clicks on home button
    And user clicks on DataSet dashboard
    And user clicks on "SALES FACT TEST DATA SETS 14" data set
    And user navigate to data tab
    Then No data should be displayed in data tab
    And user get the ID for data set "Sales Fact Test Data Sets 14" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-3249 @positive @regression @UI-DataSet
  Scenario: MLP-3249 - Verification of creating a duplicate DataSet
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "sales_fact_dec_1998" and clicks on search
    And user enable first item checkbox from item search results
    And user click on Assign DataSet button
    And user click on Create New DataSet button in Assign Data Set panel
    And user enter name field values as "Sales Fact Test Data Sets 15" in New Data set panel
    And user enter description field values as "Sales Fact description" in New Data set panel
    And user click Submit button in New Data Set panel
    And user click on Create New DataSet button in Assign Data Set panel
    And user enter name field values as "Sales Fact Test Data Sets 15" in New Data set panel
    Then " A Data Set with this name already exists. Please enter a different name." alert should be displayed
    And user get the ID for data set "Sales Fact Test Data Sets 15" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-3249 @positive @regression @UI-DataSet
  Scenario:  MLP-3249 Verification of UnAssigining pop up for Data Elements
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "firstname" and clicks on search
    And user selects the "Column" from the Type
    And user enables the following item checkboxes
      | itemName  |
      | firstname |
    And user click on Assign DataSet button
    And user click on Create New DataSet button in Assign Data Set panel
    And user enter name field values as "Sales Fact Test Data Sets 16" in New Data set panel
    And user enter description field values as "Sales Fact Test Data Sets description" in New Data set panel
    And user click Submit button in New Data Set panel
    And user remove the data element "firstname" from dataset
    Then Alert modal should display "Are you sure you want to unassign this data element?"
    And user get the ID for data set "Sales Fact Test Data Sets 16" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"


  @webtest @MLP-3249 @positive @regression @UI-DataSet
  Scenario: MLP-3249 Verification of UnSaved changes pop up for data set
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "firstname" and clicks on search
    And user enables the following item checkboxes
      | itemName  |
      | firstname |
    And user click on Assign DataSet button
    And user click on Create New DataSet button in Assign Data Set panel
    And user enter name field values as "Sales Fact Test Data Sets 17" in New Data set panel
    And user enter description field values as "Sales Fact Test Data Sets description" in New Data set panel
    And user click Submit button in New Data Set panel
    And user clicks on close button in the Assign Data Set panel
    And user clicks No on the alert window
    Then Assign Data Set Panel should be displayed
    And user clicks on close button in the Assign Data Set panel
    And user clicks Yes on the alert window
    And Assign Data Set Panel should not be displayed
    And user get the ID for data set "Sales Fact Test Data Sets 17" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-3249 @positive @regression @UI-DataSet
  Scenario: MLP-3249 Verification of restricted characters validation during the creation of dataset
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "firstname" and clicks on search
    And user selects the "Column" from the Type
    And user enables the following item checkboxes
      | itemName  |
      | firstname |
    And user click on Assign DataSet button
    And user click on Create New DataSet button in Assign Data Set panel
    And "Invalid name. Leading/trailing blanks and special characters are forbidden." should be displayed when user enters blank space
    Then "Invalid name. Leading/trailing blanks and special characters are forbidden." should be displayed for below values
      | dataSetName |
      | \           |
      | /           |
