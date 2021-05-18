#Feature:MLP-3692 Verification of Data Analysis tab within in the Dataset itemview and show list of existing notebooks
#
#  @webtest @MLP-3692 @positive @regression @UI-DataSet
#  Scenario: MLP-3692_Verification of Data Analysis in Data set item view and notebook count if there is no item
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user enters the search text "Sales_fact" and clicks on search
#    And user enable first item checkbox from item search results
#    And user click on Assign DataSet button
#    And user click on Create New DataSet button in Assign Data Set panel
#    And user enter name field values as "DataNew Sets" in New Data set panel
#    When user enter description field values as "Sales Fact description" in New Data set panel
#    And user click Submit button in New Data Set panel
#    And user select "DataNew Sets" in Data Set dropdown in Assign data set panel
#    And user click on Assign button in Assign Data Set panel
#    And user clicks on home button
#    Then user clicks on DataSet dashboard
#    And user clicks on "DATANEW SETS" data set
#    And user clicks on Data Analysis tab
#    And verify notebook count is displayed as "0 Item"
#    And user clicks on logout button
#
#  @webtest @MLP-3692 @positive @regression @UI-DataSet
#  Scenario: MLP-3692_Verification of Notebook count,headings and list of existing notebooks are displayed
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user clicks on DataSet dashboard
#    And user clicks on "DATANEW SETS" data set
#    And user clicks on Data Analysis tab
#    And user clicks on New Notebook button
#    When user enters Notebook title as "NewNotebook" and description as "Notebook"
#    And user clicks on "Create" button in notebook
#    Then user clicks on "Save" button in notebook
#    And user clicks on home button
#    And user clicks on DataSet dashboard
#    And user clicks on "DATANEW SETS" data set
#    And user clicks on Data Analysis tab
#    And verify notebook count is displayed as "1 Notebook"
#    And user verifies the following headings of notebook
#      | notebookHeaders |
#      | NAME            |
#      | LANGUAGE        |
#      | AUTHOR          |
#      | RATING          |
#      | TAGS            |
#    And user verifies list of notebooks under DataAnalysis
#    And user clicks on logout button
#
#  @webtest @MLP-3692 @positive @regression @UI-DataSet
#  Scenario: MLP-3692 Verification of rating a notebook
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user clicks on DataSet dashboard
#    And user clicks on "DATANEW SETS" data set
#    And user clicks on Data Analysis tab
#    And user clicks on "NewNotebook" notebook in DataAnalysis Tab
#    And user clicks on "Details" tab under Notebook
#    And user gives "five" rating for notebook
#    And user clicks on home button
#    Then user clicks on DataSet dashboard
#    And user clicks on "DATANEW SETS" data set
#    And user clicks on Data Analysis tab
#    And user verifies "five" rating is displayed for "NewNotebook" notebook
#    And user clicks on logout button
#
#  @webtest @MLP-3692 @MLP-3695 @positive @regression  @UI-DataSet
#  Scenario: MLP-3692_MLP-3695_Verification of adding Tag to a notebook and added tag is displayed
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "tags/DataSets/tags/QAAUTOMATION%20TAG"
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user clicks on DataSet dashboard
#    And user clicks on "DATANEW SETS" data set
#    And user clicks on Data Analysis tab
#    And user clicks on "NewNotebook" notebook in DataAnalysis Tab
#    When user clicks on "Details" tab under Notebook
#    And user clicks on Add tag in notebook
#    And user click on create new tag in edit tags page
#    And user enters tag details and click save
##    And user assign tag "QAAUTOMATION TAG" and clicks on save
#    And user clicks on save button
#    And user clicks on "Details" tab under Notebook
#    And user verifies added tag "QAAUTOMATION TAG" in details
#    And user clicks on home button
#    Then user clicks on DataSet dashboard
#    And user clicks on "DATANEW SETS" data set
#    And user clicks on Data Analysis tab
#    And user verifies "QAAUTOMATION TAG" tag is displayed for "NewNotebook" notebook
#    And user clicks on logout button
#
#  @webtest @MLP-3695 @positive @regression @UI-DataSet
#  Scenario: MLP-3695_Verification of Details tab for notebook full view and header actions
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user clicks on DataSet dashboard
#    And user clicks on "DATANEW SETS" data set
#    And user clicks on Data Analysis tab
#    And user clicks on "NewNotebook" notebook in DataAnalysis Tab
#    And user verifies "Delete" button is displayed
#    When user clicks on "Details" tab under Notebook
#    And user verifies "DESCRIPTION" label and its widget
#    And user verifies "RATING" label and its widget
#    And user verifies "TAG" label and its widget
#    And user clicks on logout button
#
##  @webtest @MLP-3707 @positive @regression @UI-DataSet
##  Scenario: MLP-3707_Verification of edit button,editing a description and cancel button functionality
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator" role
##    And user clicks on DataSet dashboard
##    When user clicks on "DATANEW SETS" data set
##    And user mouse hovers on edit button in description and clicks it
##    Then user verifies "SAVE" button under description widget
##    And user verifies "CANCEL" button under description widget
##    And user edits description text as "Edited"
##    And user clicks on "SAVE" button in description
##    And user verifies description text "Edited" is displayed
##    And user mouse hovers on edit button in description and clicks it
##    And user edits description text as "EditedNew"
##    And user clicks on "CANCEL" button in description
##    And user verifies description text "Edited" is displayed
##    And user should be able logoff the IDC
#
#  @webtest @MLP-3695 @positive @regression @UI-DataSet
#  Scenario: MLP-3695_Verification of Deleting a Notebook
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user clicks on DataSet dashboard
#    And user clicks on "DATANEW SETS" data set
#    And user clicks on Data Analysis tab
#    When user selects "NewNotebook" notebook in DataAnalysis Tab
#    And user clicks on "Delete Notebooks" button in notebook
#    And user clicks on No button in alert message
#    Then user clicks on "Delete Notebooks" button in notebook
#    And user clicks on Yes button in warning message
#    And user refreshes the application
#    And user clicks on Data Analysis tab
#    And verify notebook count is displayed as "0 Item"
#    And user get the ID for data set "DataNew Sets" from below query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | DataSets   | V_DataSet | ID         | name         |
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"
#
#
#
#
#
