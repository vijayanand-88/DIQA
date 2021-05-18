@MLP-5899
Feature: MLP-5899 Verification of reusable accordion component inside "Request Access item view"

  @webtest @MLP-5899 @positive @UI-DataSet @regression
  Scenario: MLP-5899 Verification of Request flow diagram for a Rejected item, complete and incomplete request flow
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "product_id" and clicks on search
    And user enable first item checkbox from item search results
    And user creates a dataset with name "WorkflowDataSets" and description "WorkflowDataSets description"
    And user clicks on home button
    And user clicks On DataSet Dashboard And navigates to The "WORKFLOWDATASETS" Dataset "Data" Tab
    Then user clicks on the following data item checkbox from the list
      | datasetItems |
      | product_id   |
    And user "click" on "Order List"
    And user "click" on "submit order" button
    And user verifies MYACCESS status for item is displayed under Data tab
      | itemName   | myAccessStatus |
      | product_id | Requested      |
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "Data Administrator" role
    And user clicks on notification icon and open first open area link in notifications panel
    And user "REJECT" the suggested tag
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And user enter credentials for "System Administrator1" role
    And user clicks On DataSet Dashboard And navigates to The "WORKFLOWDATASETS" Dataset "Data" Tab
    And user verifies MYACCESS status for item is displayed under Data tab
      | itemName   | myAccessStatus |
      | product_id | Rejected       |

  @webtest @MLP-5899 @positive @UI-DataSet @regression
  Scenario: MLP-5899 Verification of order status for a complete request flow
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks On DataSet Dashboard And navigates to The "WORKFLOWDATASETS" Dataset "Order Requests" Tab
    And user verfies whether the following labels and values are present in the Order Requests tab
      | orderlistLabels | orderListValues |
      | NAME            | TestService     |
      | REQUESTED AT    |                 |
      | STATUS          | Completed       |
      | ITEMS           | 1               |

  @webtest @MLP-5899 @positive @UI-DataSet @regression
  Scenario: MLP-5899 Verification of request status diagram in full view
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks On DataSet Dashboard And navigates to The "WORKFLOWDATASETS" Dataset "Data" Tab
    And user clicks on the i icon of "product_id" item under My Access under Data tab
    And user "click" on the "View Details" in the popUp under Data tab
    And user "click" on the "first item from the Order Request Panel"
    And user "click" on "PROGRESS" in the Order Request Panel
    And user "verify displayed" for "Workflow diagram" with all the details in both preview and full view in the Order Request Panel
    And user clicks on Full view icon in Datasets page
    And user "verify displayed" for "Workflow diagram" with all the details in both preview and full view in the Order Request Panel
    And user clicks on logout button
    And user get the ID for data set "WorkflowDataSets" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"



