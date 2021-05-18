@MLP-5981
Feature: MLP-5981 Verification of all the notes of the approvers in the request view

  @webtest @MLP-5981 @positive @UI-DataSet @regression
  Scenario: MLP-5981 Verification of setting the advanced options panel for single vote user
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Administration" dashboard
    And User "click" on "CATALOG MANAGER" link on the Dashboard page
    And user clicks on mentioned Subject Area in json config file "BigData"
    And user "click" on "Advanced options" from the edit catalog panel
    And user "click" on the dropdown and select the menu for "Workflows" and selects "dataset_access_request_single_vote" in catalog advance options panel
    And user should be able logoff the IDC

  @webtest @MLP-5981 @positive @UI-DataSet @regression
  Scenario: MLP-5981 Verification of adding Notes in the Order List Panel for dataset access request for single vote
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
    And user clicks on the i icon of "shippers" item under My Access under Data tab
    And user "click" on the "View Details" in the popUp under Data tab
    And user "click" on the "first item from the Order Request Panel"
    And user "click" on "PROGRESS" in the Order Request Panel
    And user clicks on the note icon displayed under the progress tab for the "Request submitted by"
    And user verifies whether the following is displayed in the comment
      | commentText             |
      | Please approve the item |

  @webtest @MLP-5981 @positive @UI-DataSet @regression
  Scenario: MLP-5981 Verification of workflow diagram by an approver for dataset access request for single vote
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    And user clicks on notification icon and open first open area link in notifications panel
    And user "APPROVE" the suggested tag
    And user clicks on home button
    And user clicks On DataSet Dashboard And navigates to The "WORKFLOWANALYSIS" Dataset "Order Requests" Tab
    And user clicks on "TestDataConsumer" order from the list under Order Request tab
    And user "click" on the "first item from the Order Request Panel"
    And user "click" on "PROGRESS" in the Order Request Panel
    And user "verify displayed" for the workflow "Diagram progress" in the order request panel
      | stepPerformedBy   | user             |
      | Request submitted | TestDataConsumer |
      | Approved by       | TestDataSteward  |

  @webtest @MLP-5981 @positive @UI-DataSet @regression
  Scenario: MLP-5981 Verification of opening the Notes panel through workflow diagram for dataset access request for single vote
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "WORKFLOWANALYSIS" Dataset "Data" Tab
    And user clicks on the i icon of "shippers" item under My Access under Data tab
    And user "click" on the "View Details" in the popUp under Data tab
    And user "click" on the "first item from the Order Request Panel"
    And user "click" on "PROGRESS" in the Order Request Panel
    And user clicks on the note icon displayed under the progress tab for the "Request submitted by"
    And user verifies whether the following is displayed in the comment
      | commentText             |
      | Please approve the item |
    And user clicks on Full view icon in Datasets page
    And user clicks on exit button in notebook full view

  @webtest @MLP-5981 @positive @UI-DataSet @regression
  Scenario: MLP-5981 Verification of removing an approver note by a requester for dataset access request for single vote
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    And user clicks On DataSet Dashboard And navigates to The "WORKFLOWANALYSIS" Dataset "Order Requests" Tab
    And user clicks on "TestDataConsumer" order from the list under Order Request tab
    And user "click" on the "first item from the Order Request Panel"
    And user "click" on "PROGRESS" in the Order Request Panel
    And user clicks on the note icon displayed under the progress tab for the "Request submitted by"
    And user "verifies not displayed" on "delete" button in the Order Request panel for the "TestDataConsumer" user
    And user get the ID for data set "workflowAnalysis" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-5981 @positive @UI-DataSet @regression
  Scenario: MLP-5981 Verification of adding a notes by a requester from Notes panel from the workflow diagram for dataset access request for single vote
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "shippers" and clicks on search
    And user selects the "Table" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "workflowDatasets" and description "workflowDatasets description"
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Consumer" role
    And user clicks On DataSet Dashboard And navigates to The "WORKFLOWDATASETS" Dataset "Data" Tab
    And user clicks on the following data item checkbox from the list
      | datasetItems |
      | shippers     |
    And user "click" on "Order List"
    And user "enters text" "Please approve the item" comment in the "Leave comment" section
    And user "click" on "submit order" button
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Administrator" role
    And user clicks On DataSet Dashboard And navigates to The "WORKFLOWDATASETS" Dataset "Order Requests" Tab
    And user clicks on the first order from the list in the Order Request Panel
    And user "click" on the "first item from the Order Request Panel"
    And user "click" on "PROGRESS" in the Order Request Panel
    And user verifies the note count of the workflow Diagram in the Order Request Panel
      | stepPerformedBy   | noteCount       |
      | Request submitted | 1               |
    And user clicks on the note icon displayed under the progress tab for the "Request submitted by"
    And user clicks on Full view icon in Datasets page
    And user "enters text" "Please Approve" comment in the "Leave comment" section
    And user "click" on "Post Comment" button in the Notes panel
    And user clicks on exit button in notebook full view
    And user verifies the note count of the workflow Diagram in the Order Request Panel
      | stepPerformedBy   | noteCount       |
      | Request submitted | 2               |

  @webtest @MLP-5981 @positive @UI-DataSet @regression
  Scenario: MLP-5981 Verification of adding a notes by an approver from Notes panel from the workflow diagram for dataset access request for single vote
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    And user clicks on notification icon and open first open area link in notifications panel
    And user "APPROVE" the suggested tag
    And user clicks on home button
    And user clicks On DataSet Dashboard And navigates to The "WORKFLOWDATASETS" Dataset "Order Requests" Tab
    And user clicks on "TestDataConsumer" order from the list under Order Request tab
    And user "click" on the "first item from the Order Request Panel"
    And user "click" on "PROGRESS" in the Order Request Panel
    And user verifies the note count of the workflow Diagram in the Order Request Panel
      | stepPerformedBy   | noteCount |
      | Request submitted | 2         |
    And user clicks on the note icon displayed under the progress tab for the "Request submitted by"
    And user clicks on Full view icon in Datasets page
    And user "enters text" "Approved" comment in the "Leave comment" section
    And user "click" on "Post Comment" button in the Notes panel
    And user clicks on exit button in notebook full view
    And user verifies the note count of the workflow Diagram in the Order Request Panel
      | stepPerformedBy   | noteCount |
      | Request submitted | 3         |
    And user get the ID for data set "workflowDatasets" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-5981 @positive @UI-DataSet @regression
  Scenario: MLP-5981 Verification of Cancelling an Order List
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "shippers" and clicks on search
    And user selects the "Table" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "newworkflowDatasets" and description "newworkflowDatasets description"
    And user clicks on home button
    And user clicks On DataSet Dashboard And navigates to The "NEWWORKFLOWDATASETS" Dataset "Data" Tab
    And user clicks on the following data item checkbox from the list
      | datasetItems |
      | shippers     |
    And user "click" on "Order List"
    And user "click" on "submit order" button
    And user clicks on the i icon of "shippers" item under My Access under Data tab
    And user "click" on the "View Details" in the popUp under Data tab
    And user "click" for "Cancel Request Button" in the Order request panel
    And user verifies MYACCESS status for item is displayed under Data tab
      | itemName | myAccessStatus |
      | shippers | Canceled       |
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Administrator" role
    And user clicks on notification icon and open first open area link in notifications panel
    Then Accept/Reject button should not be displayed for already approved/rejected tags.
    And user verfies whether the following Headers and values are present in the Order Requests panel
      | orderlistHeaders | orderListValues |
      | CATALOG          | BigData         |
      | STATUS           | Canceled        |
      | ITEMS            | 1               |

  @webtest @MLP-5981 @positive @UI-DataSet @regression
  Scenario: MLP-5981 Verification of Cancel button for an Approver and Verification of status for a cancelled order under Order Request tab
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    And user clicks on notification icon and open first open area link in notifications panel
    And user "click" "newworkflowDatasets" link under deatils label under open notification panel
    And user "verify not displayed" for "Cancel Request Button" in the Order request panel
    And user clicks on home button
    And user clicks On DataSet Dashboard And navigates to The "NEWWORKFLOWDATASETS" Dataset "Order Requests" Tab
    And user verfies whether the following labels and values are present in the Order Requests tab
      | orderlistLabels | orderListValues |
      | NAME            | TestService     |
      | REQUESTED AT    |                 |
      | STATUS          | Canceled        |
      | ITEMS           | 1               |
    And user get the ID for data set "newworkflowDatasets" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"
