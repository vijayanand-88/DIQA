@MLP-5884
Feature: MLP-5884 Verification of to see which data elements have already an approved access in the Data table within the datasets

  @webtest @MLP-5884 @positive @UI-DataSet @regression
  Scenario: MLP-5884 Verification of My Access column
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "sales_fact_dec_1998" and clicks on search
    And user selects the "Table" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "SalesDataSets12" and description "Sales Fact description"
    And user clicks on home button
    When user clicks On DataSet Dashboard And navigates to The "SALESDATASETS12" Dataset "Data" Tab
    And user "verify displayed" on "MY ACCESS" column in the table under data tab
    And user get the ID for data set "SalesDataSets12" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-5891 @positive @UI-DataSet @regression
  Scenario: MLP-5891 Verification of icons for In progress or requested item status and Verification of My Access status Requested
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Administration" dashboard
    And User "click" on "CATALOG MANAGER" link on the Dashboard page
    And user clicks on mentioned Subject Area in json config file "BigData"
    And user "click" on "Advanced options" from the edit catalog panel
    And user "click" on the dropdown and select the menu for "Workflows" and selects "dataset_access_request_single_vote" in catalog advance options panel
    And user enters the search text "sales_fact_dec_1998" and clicks on search
    And user selects the "Table" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "SampleDS" and description "SampleDS description"
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    When user clicks On DataSet Dashboard And navigates to The "SAMPLEDS" Dataset "Data" Tab
    And user clicks on the following data item checkbox from the list
      | datasetItems        |
      | sales_fact_dec_1998 |
    And user "click" on "Order List"
    And user "click" on "submit order" button
#    And user verifies whether the status text color and given color are same
#      | status      | color                  |
#      | In progress | rgba(153, 153, 153, 1) |
    And user clicks on the i icon of "sales_fact_dec_1998" item under My Access under Data tab
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Administrator" role
    And user clicks on notification icon and open first open area link in notifications panel
    And user "APPROVE" the suggested tag
    And user clicks on logout button

  @webtest @MLP-5891 @positive @UI-DataSet @regression
  Scenario: MLP-5891 Verification of icons for Approved item status
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "SAMPLEDS" Dataset "Data" Tab
    And user verifies whether the status text color and given color are same
      | status   | color               |
      | Approved | rgba(3, 145, 12, 1) |
    And user get the ID for data set "SampleDS" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-5884 @positive @UI-DataSet @regression
  Scenario: MLP-5884 Verification of Approving the order list
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Administration" dashboard
    And User "click" on "CATALOG MANAGER" link on the Dashboard page
    And user clicks on mentioned Subject Area in json config file "BigData"
    And user "click" on "Advanced options" from the edit catalog panel
    And user "click" on the dropdown and select the menu for "Workflows" and selects "dataset_access_request_2_step_voting" in catalog advance options panel
    And user selects the BigData catalog from catalog list
    And user enters the search text "_c17" and clicks on search
    And user enable first item checkbox from item search results
    And user creates a dataset with name "TestDS" and description "TestDS description"
    And user enters the search text "_c18" and clicks on search
    And user enable first item checkbox from item search results
    And user assigns "TestDS" dataset from the Assign data set panel
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "TESTDS" Dataset "Data" Tab
    And user clicks on the following data item checkbox from the list
      | datasetItems |
      | _c17         |
      | _c18         |
    And user "click" on "Order List"
    And user "click" on "submit order" button
    And user verifies MYACCESS status for item is displayed under Data tab
      | itemName | myAccessStatus |
      | _c17     | Requested      |
      | _c18     | Requested      |
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Custodian" role
    And user clicks on notification icon and open first open area link in notifications panel
    And user "APPROVE" the suggested tag
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "TESTDS" Dataset "Data" Tab
    And user verifies MYACCESS status for item is displayed under Data tab
      | itemName | myAccessStatus |
      | _c17     | In Progress    |
      | _c18     | In Progress    |
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Administrator" role
    And user clicks on notification icon and open first open area link in notifications panel
    And user "APPROVE" the suggested tag
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "TESTDS" Dataset "Data" Tab
    And user verifies MYACCESS status for item is displayed under Data tab
      | itemName | myAccessStatus |
      | _c17     | Approved       |
      | _c18     | Approved       |
    And user clicks on logout button
    And user get the ID for data set "TestDS" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-5884 @positive @UI-DataSet @regression
  Scenario: MLP-5884 Verification of Rejecting the the order list
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects the BigData catalog from catalog list
    And user enters the search text "facebookmedia" and clicks on search
    And user selects the "Database" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "DatabaseAnalysis" and description "DatabaseAnalysis description"
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "DATABASEANALYSIS" Dataset "Data" Tab
    And user clicks on the following data item checkbox from the list
      | datasetItems  |
      | facebookmedia |
    And user "click" on "Order List"
    And user "click" on "submit order" button
    And user verifies MYACCESS status for item is displayed under Data tab
      | itemName      | myAccessStatus |
      | facebookmedia | Requested      |
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Custodian" role
    And user clicks on notification icon and open first open area link in notifications panel
    And user "REJECT" the suggested tag
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "DATABASEANALYSIS" Dataset "Data" Tab
    And user verifies MYACCESS status for item is displayed under Data tab
      | itemName      | myAccessStatus |
      | facebookmedia | Rejected       |
    And user clicks on logout button
    And user get the ID for data set "DatabaseAnalysis" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-5884 @positive @UI-DataSet @regression
  Scenario: MLP-5884 Verification of getting one rejection and one approval for an item
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects the BigData catalog from catalog list
    And user enters the search text "sales_fact_dec_1998" and clicks on search
    And user selects the "Table" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "Test1DS" and description "Test1DS description"
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "TEST1DS" Dataset "Data" Tab
    And user clicks on the following data item checkbox from the list
      | datasetItems        |
      | sales_fact_dec_1998 |
    And user "click" on "Order List"
    And user "click" on "submit order" button
    And user verifies MYACCESS status for item is displayed under Data tab
      | itemName            | myAccessStatus |
      | sales_fact_dec_1998 | Requested      |
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Custodian" role
    And user clicks on notification icon and open first open area link in notifications panel
    And user "APPROVE" the suggested tag
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "TEST1DS" Dataset "Data" Tab
    And user verifies MYACCESS status for item is displayed under Data tab
      | itemName            | myAccessStatus |
      | sales_fact_dec_1998 | In Progress    |
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Administrator" role
    And user clicks on notification icon and open first open area link in notifications panel
    And user "REJECT" the suggested tag
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "TEST1DS" Dataset "Data" Tab
    And user verifies MYACCESS status for item is displayed under Data tab
      | itemName            | myAccessStatus |
      | sales_fact_dec_1998 | In Progress    |
    And user clicks on logout button
    And user get the ID for data set "Test1DS" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-5891 @positive @UI-DataSet @regression
  Scenario: MLP-5891 Verification of requesting access for items from 2 different catalogs
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "Business Glossary" catalog from catalog list
    And user enters the search text "Postal Code" and clicks on search
    And user enable first item checkbox from item search results
    And user creates a dataset with name "MixedCatalogDS" and description "MixedCatalogDS description"
    And user selects "BigData" catalog from catalog list
    And user enters the search text "sales_fact_dec_1998" and clicks on search
    And user selects the "Table" from the Type
    And user enable first item checkbox from item search results
    And user assigns "MixedCatalogDS" dataset from the Assign data set panel
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "MIXEDCATALOGDS" Dataset "Data" Tab
    And user clicks on the following data item checkbox from the list
      | datasetItems        |
      | sales_fact_dec_1998 |
      | Postal Code         |
    And user get the ID for data set "MixedCatalogDS" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"
