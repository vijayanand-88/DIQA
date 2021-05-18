@MLP-5891 @MLP-5983
Feature: MLP-5891 Verification of multiple support in the search result list and MLP-5983 verification of Multi select search

  @webtest @MLP-5891 @positive @UI-DataSet @regression
  Scenario: MLP-5891 Verification of Order Requests tab in the itemview
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
    And user creates a dataset with name "SalesDataSets1" and description "SalesDataSets1 Dataset description"
    And user clicks on home button
    And user clicks On DataSet Dashboard And navigates to The "SALESDATASETS1" Dataset "Order Requests" Tab
    Then user verifies "Order Requests" tab is displayed and active in the item full view

  @webtest @MLP-5891 @positive @UI-DataSet @regression
  Scenario: MLP-5891 Verification of Order Requests panel in the itemview
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "employeeterritories" and clicks on search
    And user selects the "Table" from the Type
    And user enable first item checkbox from item search results
    And user assigns "SalesDataSets1" dataset from the Assign data set panel
    And user enters the search text "shippers" and clicks on search
    And user selects the "Table" from the Type
    And user enable first item checkbox from item search results
    And user assigns "SalesDataSets1" dataset from the Assign data set panel
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "SALESDATASETS1" Dataset "Data" Tab
    And user clicks on the following data item checkbox from the list
      | datasetItems        |
      | employeeterritories |
      | shippers            |
    And user "click" on "Order List"
    And user "click" on "submit order" button
    And user clicks on notification icon
    And "Request for Access for SalesDataSets1 DataSet and BigData Catalog has been sent by TestDataConsumer" notification content should get displayed in the requests tab
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "System Administrator1" role
    And user clicks On DataSet Dashboard And navigates to The "SALESDATASETS1" Dataset "Order Requests" Tab
    And user verfies whether the following labels and values are present in the Order Requests tab
      | orderlistLabels | orderListValues  |
      | NAME            | TestDataConsumer |
      | REQUESTED AT    |                  |
      | STATUS          | Requested        |
      | ITEMS           | 2                |

  @webtest @MLP-5891 @positive @UI-DataSet @regression
  Scenario: MLP-5891 Verification of Order Requests panel in fullview
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks On DataSet Dashboard And navigates to The "SALESDATASETS1" Dataset "Order Requests" Tab
    Then user verifies "Order Requests" tab is displayed and active in the item full view
    And user clicks on the first order from the list in the Order Request Panel
    And user clicks on Full view icon in Datasets page
    And full view page of that item should get displayed

  @webtest @MLP-5891 @positive @UI-DataSet @regression
  Scenario: MLP-5891 Verification of Order details table in the Order request panel
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks On DataSet Dashboard And navigates to The "SALESDATASETS1" Dataset "Order Requests" Tab
    And user clicks on the first order from the list in the Order Request Panel
    And user verfies whether the following Headers and values are present in the Order Requests panel
      | orderlistHeaders | orderListValues |
      | CATALOG          | BigData         |
      | STATUS           | In progress     |
      | ITEMS            | 2               |
    And user "click" on the "first item from the Order Request Panel"
    Then user "verify displayed" for the following "data items" in the order requests panel
      | orderRequestItems   |
      | shippers            |
      | employeeterritories |

  @webtest @MLP-5891 @positive @UI-DataSet @regression
  Scenario: MLP-5891 Verification of viewing specific approver notes
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "product_id" and clicks on search
    And user enable first item checkbox from item search results
    And user assigns "SalesDataSets1" dataset from the Assign data set panel
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    When user clicks On DataSet Dashboard And navigates to The "SALESDATASETS1" Dataset "Data" Tab
    And user clicks on the following data item checkbox from the list
      | datasetItems |
      | product_id   |
    And user "click" on "Order List"
    And user "enters text" "Test Comment" comment in the "Leave comment" section
    And user "click" on "submit order" button
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Administrator" role
    When user clicks On DataSet Dashboard And navigates to The "SALESDATASETS1" Dataset "Order Requests" Tab
    And user clicks on "TestDataConsumer" order from the list under Order Request tab
    And user "click" on the "first item from the Order Request Panel"
    And user "click" on "PROGRESS" in the Order Request Panel
    And user clicks on the note icon displayed under the progress tab for the "Request submitted by"
    And user "click" "TestDataConsumer" option in "show comments from dropdown"
    And user verifies whether the following is displayed in the comment
      | commentText      |
      | TestDataConsumer |
    And user get the ID for data set "SalesDataSets1" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-5983 @positive @UI-DataSet @regression
  Scenario: MLP-5983 Verify if DataSets Visibility can be modified and users and groups can be selected from the multi select search component
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Sales_fact" and clicks on search
    And user selects the "Table" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "TestSalesDataSets3" and description "TestSalesDataSets1 Dataset description"
    And user clicks on home button
    When user clicks On DataSet Dashboard And navigates to The "TESTSALESDATASETS3" Dataset
    And user verifies whether the status of Dataset status is "public" under dataset overview tab
    And user mouse hovers on edit button in header and clicks it
    And user "click" on "arrow icon" of the drop down in the panel
    And user "click" "Public" option from the dropdown for Data Visibility
    And user "verify not displayed" for "multiple select serach" field under edit visibility panel
    And user "click" on "arrow icon" of the drop down in the panel
    And user "click" "Restricted" option from the dropdown for Data Visibility
    And user "verify displayed" for "multiple select serach" field under edit visibility panel
    And user enters the user name and selects the option from the dropdown list in the edit visibility panel
      | userNames |
      | Service   |
    And user "click" on "save button"
    And user verifies whether the status of Dataset status is "restricted" under dataset overview tab
    And user mouse hovers on edit button in header and clicks it
    And user enters the user name and selects the option from the dropdown list in the edit visibility panel
      | userNames                |
      | Saranya Sankar           |
      | Thirveni Moganlal        |
      | Muthuraja Ramakrishnan   |
      | Sivanandam Meiyappaswamy |
      | Divya Bharathi           |
      | Bharathi R               |
      | Raghavendiran A          |
      | Devi Niranjani           |
      | Siddharthan Gunaseelan   |
      | Sivaprakash Ramasethu    |
    And user "verifies enabled" on "save button"
    And user clicks on close button in the Edit Tags page
    And user clicks on Yes button in alert message
    And user mouse hovers on edit button in header and clicks it
    And user enters the user name and selects the option from the dropdown list in the edit visibility panel
      | userNames |
      | Service   |
    And user "click" on "save button"
    And user "click" on "item full view close button"
    And user mouse hovers on "TESTSALESDATASETS3" and verifies title
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Information User" role
    And user clicks on DataSet dashboard
    And user verifies "TESTSALESDATASETS3" dataset is not displayed
    And user get the ID for data set "TestSalesDataSets3" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-6813 @positive @UI-DataSet @regression
  Scenario: MLP-6813 Verification of Uploading Treadata jar
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Bundle Manager link in administration tab
    And user clicks on bundle upload button and click browse button
    And user upload file
      | Method         | Action       |
      | setAutoDelay   | 1000         |
      | selectOSGIFile | teradata.jar |
      | setAutoDelay   | 1000         |
      | keyPress       | CONTROL      |
      | keyPress       | V            |
      | keyRelease     | CONTROL      |
      | keyRelease     | V            |
      | setAutoDelay   | 1000         |
      | keyPress       | ENTER        |
      | keyRelease     | ENTER        |
    And user clicks on submit button in the upload bundle page
    And user click on close button in bundle details page
    And user clicks on bundle name "JDBC"
    Then upload plugin "com.teradata.jdbc.TeraDriver" should be displayed in "JDBC" bundle

  @webtest @MLP-6813 @positive @UI-DataSet @regression
  Scenario: MLP-6813 Verification of run button for item types from Teradata database other than Table and column
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Marketplace" and clicks on search
    And user selects the "Function" from the Type
    And user enables the following item checkboxes
      | itemName    |
      | Marketplace |
    And user creates a dataset with name "NonTableItems" and description "NonTableItems description"
    And user clicks on cross button in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user enters the search text "healthcare" and clicks on search
    And user selects the "Database" from the Type
    And user enable first item checkbox from item search results
    And user assigns "NonTableItems" dataset from the Assign data set panel
    And user clicks on home button
    When user clicks On DataSet Dashboard And navigates to The "NONTABLEITEMS" Dataset "Data" Tab
    And user clicks on the following data item checkbox from the list
      | datasetItems |
      | Marketplace  |
      | healthcare   |
    And user "click" on "Run button" in notebook
    And user "verify not displayed" for "Run button" for "TableauConnector" under Run Dataset actions panel
    And user get the ID for data set "NonTableItems" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @positive @UI-DataSet @regression
  Scenario: Verification of "Assign Dataset" button displayed in Item detail page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Sales_fact" and clicks on search
    And user selects the "Table" from the Type
    And user enables the following item checkboxes
      | itemName            |
      | sales_fact_dec_1998 |
    And user creates a dataset with name "SalesFactSampleDataset" and description "SalesFactSampleDataset description"
    And user clicks on home button
    When user clicks On DataSet Dashboard And navigates to The "SALESFACTSAMPLEDATASET" Dataset "Data" Tab
    And user clicks on the following data item checkbox from the list
      | datasetItems        |
      | sales_fact_dec_1998 |
    And user get the ID for data set "SalesFactSampleDataset" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @positive @UI-DataSet @regression
  Scenario: Verification of Tableau template text field is changed to dynamic field
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Administration" dashboard
    And User "click" on "PLUGIN MANAGER" link on the Dashboard page
    And user "click" on "Dataset plugin label" in Plugin management panel
    And user "click" on "TableauConnector" from "list of Plugins"
    And user add button in "TABLEAUCONNECTOR CONFIGURATIONS" section
    And user clicks on Add button near to field "TABLEAU TEMPLATES"
    And user enters text in the dynamic field and verifies whether Horizontal scroll will be displayed
    And user clicks on logout button

  @webtest @MLP-5903 @positive @UI-DataSet @regression
  Scenario: MLP-5903 Verification of Dataset link available in the notification and opening Order Request panel from notification
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "employeeterritories" and clicks on search
    And user selects the "Table" from the Type
    And user enables the following item checkboxes
      | itemName            |
      | employeeterritories |
    And user creates a dataset with name "TableAnalysisDataSets" and description "TableAnalysisDataSets description"
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    When user clicks On DataSet Dashboard And navigates to The "TABLEANALYSISDATASETS" Dataset "Data" Tab
    And user clicks on the following data item checkbox from the list
      | datasetItems        |
      | employeeterritories |
    And user "click" on "Order List"
    And user "click" on "submit order" button
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "System Administrator1" role
    And user clicks on notification icon
    And "Request for Access for TableAnalysisDataSets DataSet and BigData Catalog has been sent by TestDataConsumer" notification content should get displayed in the requests tab
    And user clicks on first open area link in all notification
    And user "verifies" "TableAnalysisDataSets" link under deatils label under open notification panel
    And user "click" "TableAnalysisDataSets" link under deatils label under open notification panel
    And user "click" on the "first item from the Order Request Panel"
    Then user "verify displayed" for the following "data items" in the order requests panel
      | orderRequestItems   |
      | employeeterritories |
    And user get the ID for data set "TableAnalysisDataSets" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-5891 @positive @UI-DataSet @regression
  Scenario: MLP-5891 Verification of viewing Approvers note by a Requester and sending reply
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "shippers" and clicks on search
    And user selects the "Table" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "workflowAnalysis" and description "workflowAnalysis description"
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "WORKFLOWANALYSIS" Dataset "Data" Tab
    And user clicks on the following data item checkbox from the list
      | datasetItems |
      | shippers     |
    And user "click" on "Order List"
    And user "enters text" "Please approve the item" comment in the "Leave comment" section
    And user "click" on "submit order" button
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Administrator" role
    And user clicks on notification icon and open first open area link in notifications panel
    And user "APPROVE" the suggested tag
    And user clicks on home button
    And user clicks On DataSet Dashboard And navigates to The "WORKFLOWANALYSIS" Dataset "Order Requests" Tab
    And user clicks on "TestDataConsumer" order from the list under Order Request tab
    And user "click" on the "first item from the Order Request Panel"
    And user "click" on "PROGRESS" in the Order Request Panel
    And user clicks on the note icon displayed under the progress tab for the "Approved by"
    And user clicks on Full view icon in Datasets page
    And user "enters text" "Approved" comment in the "Leave comment" section
    And user "click" on "Post Comment" button in the Notes panel
    And user clicks on exit button in notebook full view
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "WORKFLOWANALYSIS" Dataset "Data" Tab
    And user clicks on the i icon of "shippers" item under My Access under Data tab
    And user "click" on the "View Details" in the popUp under Data tab
    And user "click" on the "first item from the Order Request Panel"
    And user "click" on "PROGRESS" in the Order Request Panel
    And user verifies the note count of the workflow Diagram in the Order Request Panel
      | stepPerformedBy   | noteCount |
      | Request submitted | 1         |
      | Approved by       | 1         |
    And user clicks on the note icon displayed under the progress tab for the "Request submitted by"
    And user clicks on Full view icon in Datasets page
    And user "click" "TestDataSteward" option in "show comments from dropdown"
    And user "click" "All" option in "show comments from dropdown"
    And user verifies whether the following is displayed in the comment
      | commentText             |
      | Please approve the item |
    And user "click" on "reply" button in the Order Request panel for the "TestDataSteward" user
    And user "enters text" "Thanks for approving the item" comment in the "Write a reply" section
    And user "click" on "SEND" button in the Notes panel
    And user clicks on exit button in notebook full view
    And user verifies the note count of the workflow Diagram in the Order Request Panel
      | stepPerformedBy   | noteCount       |
      | Request submitted | 1               |

  @webtest @MLP-5891 @positive @UI-DataSet @regression
  Scenario: MLP-5891 Verification of All the notes received for an item by a Requester
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "WORKFLOWANALYSIS" Dataset "Data" Tab
    And user clicks on the i icon of "shippers" item under My Access under Data tab
    And user "click" on the "View Details" in the popUp under Data tab
    And user "click" on the "first item from the Order Request Panel"
    And user "click" on "PROGRESS" in the Order Request Panel
    And user clicks on the note icon displayed under the progress tab for the "Request submitted by"
    And user clicks on Full view icon in Datasets page
    And user "click" "TestDataConsumer" option in "show comments from dropdown"
    And user verifies whether the following is displayed in the comment
      | commentText                   |
      | Please approve the item       |
    And user "click" "TestDataSteward" option in "show comments from dropdown"
    And user verifies whether the following is displayed in the comment
      | commentText                   |
      | Approved                      |

  @webtest @MLP-5891 @positive @UI-DataSet @regression
  Scenario: MLP-5891 Verification of editing a note added by a requester
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Consumer" role
    When user clicks On DataSet Dashboard And navigates to The "WORKFLOWANALYSIS" Dataset "Data" Tab
    And user clicks on the i icon of "shippers" item under My Access under Data tab
    And user "click" on the "View Details" in the popUp under Data tab
    And user "click" on the "first item from the Order Request Panel"
    And user "click" on "PROGRESS" in the Order Request Panel
    And user clicks on the note icon displayed under the progress tab for the "Request submitted by"
    And user clicks on Full view icon in Datasets page
    And user "click" on "edit" button in the Order Request panel for the "TestDataConsumer" user
    And user "enters text" "Edited the requester comment" comment in the "edit" section
    And user "click" on "save" button in the Notes panel
    And user verifies whether the following is displayed in the comment
      | commentText                  |
      | Edited the requester comment |

  @webtest @MLP-5891 @positive @UI-DataSet @regression
  Scenario: MLP-5891 Verification of editing a note added by an approver by a requester
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Consumer" role
    When user clicks On DataSet Dashboard And navigates to The "WORKFLOWANALYSIS" Dataset "Data" Tab
    And user clicks on the i icon of "shippers" item under My Access under Data tab
    And user "click" on the "View Details" in the popUp under Data tab
    And user "click" on the "first item from the Order Request Panel"
    And user "click" on "PROGRESS" in the Order Request Panel
    And user clicks on the note icon displayed under the progress tab for the "Request submitted by"
    And user "click" "TestDataSteward" option in "show comments from dropdown"
    And user "verifies not displayed" on "edit" button in the Order Request panel for the "TestDataSteward" user
    And user get the ID for data set "workflowAnalysis" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"