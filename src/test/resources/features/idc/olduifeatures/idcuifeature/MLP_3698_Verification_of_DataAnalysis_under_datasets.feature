#Feature:MLP-3698 Verification of Content tab for a notebook
#
#  @webtest @MLP-3698 @positive @UI-DataSet @regression
#  Scenario: MLP-3698_Verification of existence of content tab
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user enters the search text "health" and clicks on search
#    And user enable first item checkbox from item search results
#    And user click on Assign DataSet button
#    And user click on Create New DataSet button in Assign Data Set panel
#    And user enter name field values as "Healthcare DataSets" in New Data set panel
#    When user enter description field values as "Healthcare description" in New Data set panel
#    And user click Submit button in New Data Set panel
#    And user select "Healthcare DataSets" in Data Set dropdown in Assign data set panel
#    And user click on Assign button in Assign Data Set panel
#    And user clicks on home button
#    And user clicks on DataSet dashboard
#    And user clicks on "HEALTHCARE DATASETS" data set
#    And user clicks on "Data" tab under Notebook
##    And user clicks on "Overview" tab under Notebook
##    And user clicks on "Comments" tab under Notebook
#    And user clicks on Data Analysis tab
#    And user clicks on New Notebook button
#    And user enters Notebook title as "HealthNotebook" and description as "Notebook"
#    And user clicks on "Create" button in notebook
#    Then user clicks on "Save" button in notebook
#    And user clicks on home button
#    And user clicks on DataSet dashboard
#    And user clicks on "HEALTHCARE DATASETS" data set
#    And user clicks on Data Analysis tab
#    And user clicks on "HealthNotebook" notebook in DataAnalysis Tab
#    And user clicks on "Details" tab under Notebook
#    And user clicks on "Content" tab under Notebook
##    And user clicks on "Comments" tab under Notebook
#    And user clicks on logout button
#
#  @webtest @MLP-3698 @positive @UI-DataSet @regression
#  Scenario: MLP-3698_Verification of edit Notebook button and action of edit Notebook,Save Notebook and Run
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user clicks on DataSet dashboard
#    And user clicks on "HEALTHCARE DATASETS" data set
#    And user clicks on Data Analysis tab
#    And user clicks on "HealthNotebook" notebook in DataAnalysis Tab
#    And user clicks on Insert cell in notebook
#    And user selects "PYTHON" language from dropdown
#    And user enters code as "Test" for "PYTHON" language
#    And user clicks on "Save" button in notebook
#    And user verifies Edit button is displayed in notebook
#    And user verifies "Run" button is displayed
#    And user clicks on logout button
#
#  @webtest @MLP-3698 @positive @UI-DataSet @regression
#  Scenario: MLP-3698_Verification of Checking of newly added notebooks under Data Analysis
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user clicks on DataSet dashboard
#    And user clicks on "HEALTHCARE DATASETS" data set
#    And user clicks on New Notebook button
#    And user enters Notebook title as "Column Notebook" and description as "Column Notebook"
#    And user clicks on Insert cell in notebook
#    And user selects "PYTHON" language from dropdown
#    And user enters code as "Test" for "PYTHON" language
#    And user clicks on "Create" button in notebook
#    When user clicks on "Save" button in notebook
#    And user clicks on home button
#    And user clicks on DataSet dashboard
#    And user clicks on "HEALTHCARE DATASETS" data set
#    And user clicks on Data Analysis tab
#    And user clicks on New Notebook button
#    And user enters Notebook title as "Table Notebook" and description as "Table Notebook"
#    And user clicks on Insert cell in notebook
#    And user selects "PYTHON" language from dropdown
#    And user enters code as "Test" for "PYTHON" language
#    And user clicks on "Create" button in notebook
#    Then user clicks on "Save" button in notebook
#    And user clicks on home button
#    And user clicks on DataSet dashboard
#    And user clicks on "HEALTHCARE DATASETS" data set
#    And user clicks on Data Analysis tab
#    And user verifies the following notebook is displayed
#      | notebookNames   |
#      | Column Notebook |
#      | Table Notebook  |
#    And user clicks on logout button
#    And user get the ID for data set "Healthcare DataSets" from below query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | DataSets   | V_DataSet | ID         | name         |
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"
