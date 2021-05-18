#Feature: MLP-3696 Verification of Creating a notebook and deleting a notebook
#
#  @webtest @MLP-3696 @positive @regression @UI-DataSet
#  Scenario: MLP-3696_Verification of creating a notebook with blank name
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user enters the search text "health" and clicks on search
#    And user enable first item checkbox from item search results
#    And user creates a dataset with name "Sample DataSets" and description "Sample Dataset description"
#    And user clicks on home button
#    And user clicks On DataSet Dashboard And navigates to The "SAMPLE DATASETS" Dataset "Data Analysis" Tab
#    And user clicks on New Notebook button
#    And user clears the text in notebook title
#    And error message "Name can not be empty. Please enter a name." should be displayed in notebook
#    And user clicks on logout button
#
#  @webtest @MLP-3696 @positive @regression @UI-DataSet
#  Scenario: MLP-3696_Verification of creating a notebook with duplicate name
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user clicks on DataSet dashboard
#    And user clicks on "SAMPLE DATASETS" data set
#    And user clicks on Data Analysis tab
#    And user clicks on New Notebook button
#    And user enters Notebook title as "Test Notebook" and description as "Test Notebook"
#    And user clicks on "Create" button in notebook
##    When user clicks on "Save" button in notebook
#    And user clicks on home button
#    And user clicks On DataSet Dashboard And navigates to The "SAMPLE DATASETS" Dataset "Data Analysis" Tab
#    Then user clicks on New Notebook button
#    And user enters Notebook title as "Test Notebook" and description as "Test Notebook"
#    And error message "This name already exists. Please enter a different one." for duplicate notebook should be displayed
#    And user should be able logoff the IDC
#
##  @webtest @MLP-3696 @positive @regression @UI-DataSet
##  Scenario: MLP-3696_Verification of inserting Cell option for Notebook
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator" role
##    And user clicks on DataSet dashboard
##    And user clicks on "SAMPLE DATASETS" data set
##    When user clicks on Data Analysis tab
##    And user clicks on New Notebook button
##    Then user enters Notebook title as "New Notebook" and description as "New Notebook"
##    And user clicks on Insert cell in notebook
#
##  @webtest @MLP-3696 @positive @regression @UI-DataSet
##  Scenario: MLP-3696_Verifcation of Unsaved changes popup during the creation of notebook
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator" role
##    And user clicks on DataSet dashboard
##    And user clicks on "SAMPLE DATASETS" data set
##    And user clicks on Data Analysis tab
##    And user clicks on New Notebook button
##    And user enters Notebook title as "New Notebook" and description as "New Notebook"
##    And user clicks on exit button in notebook full view
##    And user clicks on No button in alert message
##    And user clicks on Insert cell in notebook
##    And user clicks on exit button in notebook full view
##    And user clicks on Yes button in warning message
##    And user verifies the following notebook is displayed
##      | notebookNames |
##      | Test Notebook |
##    And user clicks on logout button
#
#  @webtest @MLP-3696 @positive @regression @UI-DataSet
#  Scenario: MLP-3696_Verification of restricted characters during the creation of notebook
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user clicks On DataSet Dashboard And navigates to The "SAMPLE DATASETS" Dataset "Data Analysis" Tab
#    And user clicks on New Notebook button
#    And user clears the text with the following character and verifies error
#      | notebookTitle | errorMessage                                                             |
#      |               | Invalid name. Leading/trailing blanks and slash/backslash are forbidden. |
#      | /             | Invalid name. Leading/trailing blanks and slash/backslash are forbidden. |
#      | \             | Invalid name. Leading/trailing blanks and slash/backslash are forbidden. |
#    And user should be able logoff the IDC
#
##  @webtest @MLP-3696 @positive @regression @UI-DataSet
##  Scenario: MLP-3696_Verification of Markdown preview button and deleting an inserted cell
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator" role
##    And user clicks on DataSet dashboard
##    And user clicks on "SAMPLE DATASETS" data set
##    And user clicks on Data Analysis tab
##    And user clicks on New Notebook button
##    When user enters Notebook title as "New Notebook" and description as "New Notebook"
##    And user clicks on Insert cell in notebook
##    And user selects "MARKDOWN" language from dropdown
##    And user enters "*Testing*" in textarea of "MARKDOWN" language
##    And user verifies pencil icon for "MARKDOWN" language
##    And user verifies text for "MARKDOWN" is displayed in "italic"
##    And user clicks on pencil icon for "MARKDOWN" language
##    And user enters "**Testing**" in textarea of "MARKDOWN" language
##    And user verifies text for "MARKDOWN" is displayed in "bold"
##    Then user clicks on Delete button for "MARKDOWN"
##    And user verifies "MARKDOWN" cell is deleted
##    And user should be able logoff the IDC
#
##  @webtest @MLP-3696 @positive @regression @UI-DataSet
##  Scenario: MLP-3696_Verification of Up and Down arrow for insert cell
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator" role
##    And user clicks on DataSet dashboard
##    And user clicks on "SAMPLE DATASETS" data set
##    And user clicks on Data Analysis tab
##    And user clicks on New Notebook button
##    When user enters Notebook title as "New Notebook" and description as "New Notebook"
##    And user clicks on Insert cell in notebook
##    And user selects "MARKDOWN" language from dropdown
##    And user enters "*Testing*" in textarea of "MARKDOWN" language
##    And user verifies text for "MARKDOWN" is displayed in "italic"
##    And user verifies Up arrow is disabled for "MARKDOWN"
##    And user clicks on second Insert cell in notebook
##    And user selects "PYTHON" language for second dropdown
##    And user enters code as "print('Hello World')" for "PYTHON" language
##    And user verifies Down arrow is disabled for "PYTHON"
##    And user clicks on Up arrow for "PYTHON"
##    And user verifies "PYTHON" is displayed at top
##    And user should be able logoff the IDC
#
#
##  @webtest @MLP-3696 @positive @regression @UI-DataSet
##  Scenario:MLP-3696-MLP-3703_Verification of Deleting a Note book via Notebook full view and export button
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator" role
##    And user clicks on DataSet dashboard
##    And user clicks on "SAMPLE DATASETS" data set
##    And user clicks on Data Analysis tab
##    When user clicks on "Test Notebook" notebook in DataAnalysis Tab
##    And user verifies export button is displayed
##    And user clicks on "Delete" button in notebook full view
##    And user clicks on No button in alert message
##    And user clicks on Insert cell in notebook
##    Then user clicks on "Delete" button in notebook full view
##    And user clicks on Yes button in warning message
##    And verify notebook count is displayed as "0 Item"
##    And user clicks on logout button
##    And user get the ID for data set "Sample DataSets" from below query
##      | description | schemaName | tableName | columnName | criteriaName |
##      | SELECT      | DataSets   | V_DataSet | ID         | name         |
##    And A query param with "" and "" and supply authorized users, contentType and Accept headers
##    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"
#
#  @webtest @MLP-3703 @positive @regression @UI-DataSet
#  Scenario:MLP-3703_Verification of Plugin support for Notebook export
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on "InternalNode" from nodes list
#    When user enable "NotebookAnalyzer" plugin check box and click Assign button
#    And user navigate to "NotebookAnalyzer" plugin configuration page
#    And user add button in "NOTEBOOK ANALYZER CONFIGURATIONS" section
##    And user verifies the validation message is displayed under the Plugin configuration fields
##      | pluginConfigFieldName | validationMessage              |
##      | NAME                  | Name field should not be empty |
#    And user enters the following values in Plugin Configuration fields
#      | pluginConfigFieldName | pluginConfigFieldValue |
#      | NAME                  | NotebookAnalyzer       |
#      | LABEL                 | Notebook               |
#      | PIPPATH               | pip3.6                 |
#    And user click Apply button in "PLUGIN CONFIGURATION" page
#    And user click Apply button in "NOTEBOOK ANALYZER CONFIGURATIONS" page
#    And user click save button in Create New Node page
#    And user clicks on plugin monitor icon for Node "InternalNode"
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                                        | body | response code | response message |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/NotebookAnalyzer/NotebookAnalyzer |      | 200           | IDLE             |
#    And user clicks on "start" button for "NOTEBOOKANALYZER" Plugin
#    And user clicks on notification icon in the left panel
#    And "Analysis started!" notification should have content "Analysis NotebookAnalyzer on InternalNode has started" in the notifications tab
#    And user clicks on home button
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on "InternalNode" from nodes list
#    And user navigate to "NotebookAnalyzer" plugin configuration page
#    And user clicks on Unassign Plugin Button
#    And user clicks on Yes button in warning message
#    And user click save button in Create New Node page
#    And user clicks on logout button
#
##  @webtest @MLP-3696 @positive @regression @UI-DataSet
##  Scenario:MLP-3696_Verification of running a notebook with Python Script
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator" role
##    And user clicks on DataSet dashboard
##    And user clicks on "SAMPLE DATASETS" data set
##    And user clicks on Data Analysis tab
##    And user clicks on New Notebook button
##    And user enters Notebook title as "Python Notebook" and description as "Python Notebook"
##    And user clicks on Insert cell in notebook
##    And user selects "PYTHON" language from dropdown
##    And user enters code from "notebook/PythonFile.txt" for "PYTHON" language
##    And user clicks on "Create" button in notebook
##    When user clicks on "Save" button in notebook
##    And user clicks on home button
##    And user clicks on DataSet dashboard
##    And user clicks on "SAMPLE DATASETS" data set
##    And user clicks on Data Analysis tab
##    And user clicks on "Python Notebook" notebook in DataAnalysis Tab
##    Then user clicks on Run button in notebook
##    And user clicks on home button
##    And user clicks on DataSet dashboard
##    And user clicks on "SAMPLE DATASETS" data set
##    And user clicks on Data Analysis tab
##    And user clicks on "Python Notebook" notebook in DataAnalysis Tab
##    And user verifies output image is displayed
