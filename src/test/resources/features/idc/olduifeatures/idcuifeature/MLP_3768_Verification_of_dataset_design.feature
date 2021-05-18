Feature: MLP-3768 Visual Design for Dataset

  @webtest @MLP-3768 @positive @UI-DataSet @regression
  Scenario: MLP-3768_Verification of "Search a dataset" text inside search area
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on DataSet dashboard
    Then user verifies search text inside search area

  @webtest @MLP-3768 @positive @UI-DataSet @regression
  Scenario: MLP-3768 Verification of dataset title on hover
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Sales_fact" and clicks on search
    And user enable first item checkbox from item search results
    And user click on Assign DataSet button
    And user click on Create New DataSet button in Assign Data Set panel
    And user enter name field values as "Sales Data Sets" in New Data set panel
    And user enter description field values as "Sales Fact description" in New Data set panel
    And user click Submit button in New Data Set panel
    And user select "Sales Data Sets" in Data Set dropdown in Assign data set panel
    And user click on Assign button in Assign Data Set panel
    And user clicks on home button
    When user clicks on DataSet dashboard
    And user mouse hovers on "SALES DATA SETS" and verifies title
    And user get the ID for data set "Sales Data Sets" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-5153 @positive @webtest
  Scenario: MLP_5153_Verification of panels functionality
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "customerid" and clicks on search
    And user enable first item checkbox from item search results
    And user click on Assign DataSet button
    And user click on Create New DataSet button in Assign Data Set panel
    And user enter name field values as "Customer Data Sets" in New Data set panel
    And user enter description field values as "Customer Data description" in New Data set panel
    And user click Submit button in New Data Set panel
    And user click on Assign button in Assign Data Set panel
    And user clicks on home button
    And user clicks on DataSet dashboard
    When user clicks on "CUSTOMER DATA SETS" data set
    And user "click" on "DatasetDetailsImageicon" on DatasetPage
    And user "verifies disabled" "DataSetpanel" on DatasetPage
    And user "click" on "DATA SET ICON" close button in active panel on DatasetPage
    And user mouse hovers on edit button in description and clicks it
    And user "verifies disabled" "DataSetpanel" on DatasetPage
    And user "click" on "EDIT VISIBILITY" close button in active panel on DatasetPage
    And user clicks on Yes button in alert message
    And user clicks on "Link Report" button
    And user "verifies disabled" "DataSetpanel" on DatasetPage
    And user "click" on "LINK REPORT" close button in active panel on DatasetPage
    And user clicks on "New Notebook" button
    #And user "verifies disabled" "NoteBook" on DatasetPage -
    And user get the ID for data set "Customer Data Sets" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"


