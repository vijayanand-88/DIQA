@MLP-1864
Feature: MLP-1864: Creation of Quick link via service and validating it on UI and API

    @MLP-1864 @quicklink @sanity @regression @webtest @positive
    Scenario: Creation of a quick link and verifying it in database and idc UI
        Given A query param with "" and "" and supply authorized users, contentType and Accept headers
        And When query is ran to delete all quicklinks in "public" schema of "V_Setting" table
        And supply payload with file name "idc/MLP-1104_quicklink_singlewidget.json"
        When user makes a REST Call for POST request with url "quicklinks"
        Then Status code 200 must be returned
        And verify created quicklink is available for TestSystem User
            | description | schemaName | tableName | columnName | criteriaName |
            | SELECT      | public     | V_Setting | data       | path         |
        And User launch browser and traverse to login page
        And user enter credentials for "System Administrator" role
        And login must be successful for all users
        When user edits the BigData Widget and search in quicklinks
        Then Quicklink of "list of Tables" should be available
        And user should be able to choose the quicklink and save it
        And Quicklink will be visible in Widget
        And user clicks on logout button
        And When query is ran to delete all quicklinks in "public" schema of "V_Setting" table
        And Quicklink should not be found in "public" schema of "V_Setting" table

