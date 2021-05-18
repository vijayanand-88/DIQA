@MLP-5886
Feature: MLP-5886 Verification of a Requester to get a short info about Order Requests and access to the requests item from the data list of the data set

  @webtest @MLP-5886 @positive @UI-DataSet @regression
  Scenario: MLP-5886 Verification of In_progress status pop up information and verify pop up information for Requested status
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Administration" dashboard
    And User "click" on "CATALOG MANAGER" link on the Dashboard page
    And user clicks on mentioned Subject Area in json config file "BigData"
    And user "click" on "Advanced options" from the edit catalog panel
    And user "click" on the dropdown and select the menu for "Workflows" and selects "dataset_access_request_single_vote" in catalog advance options panel
    And user selects "BigData" catalog from catalog list
    And user enters the search text "shippers" and clicks on search
    And user selects the "Table" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "DS_TableAnalysis" and description "DS_TableAnalysis dataset description"
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "DS_TABLEANALYSIS" Dataset "Data" Tab
    And user clicks on the following data item checkbox from the list
      | datasetItems |
      | shippers     |
    And user "click" on "Order List"
    And user "click" on "submit order" button
    And user clicks on the i icon of "shippers" item under My Access under Data tab
    And user "click" on the "View Details" in the popUp under Data tab
    And user verfies whether the following Headers and values are present in the Order Requests panel
      | orderlistHeaders | orderListValues |
      | CATALOG          | BigData         |
      | STATUS           | In progress     |
      | ITEMS            | 1               |
    And user clicks on close button in the Edit Tags page
    And user clicks on the i icon of "shippers" item under My Access under Data tab
    And user "click" on "pop up close" button
#    And user "verify not displayed" for "pop up"
    And user clicks on the i icon of "shippers" item under My Access under Data tab
    And user "verify displayed" for the header and other "pop up parameters" under Data tab in Dataset
      | popUpParameters |
      | In progress     |
      | Request ID      |
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Administrator" role
    And user clicks on notification icon and open first open area link in notifications panel
    And user "APPROVE" the suggested tag
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "DS_TABLEANALYSIS" Dataset "Data" Tab
    And user clicks on the i icon of "shippers" item under My Access under Data tab
    And user "verify displayed" for the header and other "pop up parameters" under Data tab in Dataset
      | popUpParameters |
      | Approved        |
      | Request ID      |
    And user get the ID for data set "DS_TableAnalysis" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-5886 @positive @UI-DataSet @regression
  Scenario: MLP-5886 Verification of Rejected status pop up information
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Transactions" and clicks on search
    And user selects the "Table" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "TableAnalysis" and description "TableAnalysis dataset description"
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "TABLEANALYSIS" Dataset "Data" Tab
    And user clicks on the following data item checkbox from the list
      | datasetItems |
      | Transactions     |
    And user "click" on "Order List"
    And user "click" on "submit order" button
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Administrator" role
    And user clicks on notification icon and open first open area link in notifications panel
    And user "REJECT" the suggested tag
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "TABLEANALYSIS" Dataset "Data" Tab
    And user clicks on the i icon of "shippers" item under My Access under Data tab
    And user "click" on "pop up close" button
#    And user "verify not displayed" for "pop up"
    And user clicks on the i icon of "Transactions" item under My Access under Data tab
    And user "verify displayed" for the header and other "pop up parameters" under Data tab in Dataset
      | popUpParameters |
      | Rejected     |
      | Request ID      |
    And user get the ID for data set "TableAnalysis" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"