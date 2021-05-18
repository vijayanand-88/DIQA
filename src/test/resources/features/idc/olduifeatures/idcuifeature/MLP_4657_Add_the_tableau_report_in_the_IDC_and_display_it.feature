@MLP-4657
Feature: MLP-4657 Verification of creating a Report in a DataSet for tableau integration

  @webtest @MLP-4657 @positive @regression @report
  Scenario: MLP-4657 Verification of creating a DataSet
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "sales_fact_dec_1998" and clicks on search
    And user selects the "Table" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "Sales DataSet" and description "Sales fact table and its columns"
    And user clicks on home button
    And user clicks on DataSet dashboard
    And user clicks on "My Data Sets" tab
    Then "SALES DATASET" data set should be available in My DataSet tabs

  @webtest @MLP-4657 @positive @regression @report
  Scenario: MLP-4657 Verification of existence of New Report button in a DataSet
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on DataSet dashboard
    When user clicks on "SALES DATASET" data set
    Then "Link Report" button should be available in DataSet

  @webtest @MLP-4657 @positive @regression @report
  Scenario: MLP-4657 Verification of New Report panel
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on DataSet dashboard
    When user clicks on "SALES DATASET" data set
    And user clicks on "Link Report" button
    Then "LINK REPORT" panel should be opening
    And panel should have "NAME" field
    And panel should have "DESCRIPTION" fields
    And panel should have "REPORT URL" fields

  @webtest @MLP-4657 @positive @regression @report
  Scenario: MLP-4657 Verification of creating a new report
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on DataSet dashboard
    When user clicks on "SALES DATASET" data set
    And user clicks on "Link Report" button
    And user enters the report "NAME" as "Sales Report Q1"
    And user enters the reports "DESCRIPTION" as "This reports has a Quarter 1 results of 2018"
    And user enters the "REPORT URL" as "https://SalesReportQ1.com"
    And user clicks on save button
    Then user clicks on "Reports" tab in DataSet item view
    And report "Sales Report Q1" should  be displayed in tab

  @webtest @MLP-4657 @positive @regression @report
  Scenario: MLP-4657 Verification of creating a new report with special characters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on DataSet dashboard
    When user clicks on "SALES DATASET" data set
    And user clicks on "Link Report" button
    And user enters the report "NAME" as "!@#$%^&*()_+=11"
    And user enters the reports "DESCRIPTION" as "This report is to check a name with special charcaters"
    And user enters the "REPORT URL" as "https://SalesReportQ1.com"
    And user clicks on save button
    Then user clicks on "Reports" tab in DataSet item view
    And report "!@#$%^&*()_+=11" should  be displayed in tab

  @webtest @MLP-4657 @positive @regression @report
  Scenario: MLP-4657 Verification of creating a new report with duplicate name
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on DataSet dashboard
    When user clicks on "SALES DATASET" data set
    And user clicks on "Link Report" button
    And user enters the report "NAME" as "Sales Report Q1"
    Then Error message " A report with this name already exists. Please enter a different name. " should be displayed for duplicate report

  @webtest @MLP-4657 @positive @regression @report
  Scenario: MLP-4657 Verification of creating a new report with an empty name
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on DataSet dashboard
    When user clicks on "SALES DATASET" data set
    And user clicks on "Link Report" button
    And user enters the report "NAME" as ""
    And user enters the reports "DESCRIPTION" as "This report is to check a report with empty name"
    Then Error message "This field is required" should be displayed in report

  @webtest @MLP-4657 @positive @regression @report
  Scenario: MLP-4657 Verification of creating a new report with an empty description
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on DataSet dashboard
    When user clicks on "SALES DATASET" data set
    And user clicks on "Link Report" button
    And user enters the report "NAME" as "Report with empty description"
    And user enters the reports "DESCRIPTION" as ""
    And user enters the "REPORT URL" as "https://SalesReportQ1.com"
    #Then Error message "This field is required" should be displayed in report

  @webtest @MLP-4657 @positive @regression @report
  Scenario: MLP-4657 Verification of creating a new report with an empty URL
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on DataSet dashboard
    When user clicks on "SALES DATASET" data set
    And user clicks on "Link Report" button
    And user enters the "REPORT URL" as ""
    And user enters the report "NAME" as "empty URL check"
    And user enters the reports "DESCRIPTION" as "This report is to check a name with special charcaters"
    #Then Error message "This field is required" should be displayed in report


  @webtest @MLP-4657 @positive @regression @report
  Scenario: MLP-4657 Verification of creating a new report with slash
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on DataSet dashboard
    When user clicks on "SALES DATASET" data set
    And user clicks on "Link Report" button
    And user enters the report "NAME" as "Sales Report /"
    And user enters the reports "DESCRIPTION" as "This report is to check a name with slash"
    Then Error message "Invalid name. Leading/trailing blanks and slash/backslash are forbidden." should be displayed in report panel

  @webtest @MLP-4657 @positive @regression @report
  Scenario: MLP-4657 Verification of creating a new report with backward slash
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on DataSet dashboard
    When user clicks on "SALES DATASET" data set
    And user clicks on "Link Report" button
    And user enters the report "NAME" as "Sales \ Report"
    And user enters the reports "DESCRIPTION" as "This report is to check a name with slash"
    Then Error message "Invalid name. Leading/trailing blanks and slash/backslash are forbidden." should be displayed in report panel

  @webtest @MLP-4657 @positive @regression @report
  Scenario: MLP-4657 Verification of creating a new report with leading space
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on DataSet dashboard
    When user clicks on "SALES DATASET" data set
    And user clicks on "Link Report" button
    And user enters the report "NAME" as " Sales Report"
    And user enters the reports "DESCRIPTION" as "This report is to check a name with slash"
    Then Error message "Invalid name. Leading/trailing blanks and slash/backslash are forbidden." should be displayed in report panel

  @webtest @MLP-4657 @positive @regression @report
  Scenario: MLP-4657 Verification of creating a new report with trailing space
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on DataSet dashboard
    When user clicks on "SALES DATASET" data set
    And user clicks on "Link Report" button
    And user enters the report "NAME" as "Sales Report "
    And user enters the reports "DESCRIPTION" as "This report is to check a name with slash"
    Then Error message "Invalid name. Leading/trailing blanks and slash/backslash are forbidden." should be displayed in report panel

  @webtest @MLP-4657 @positive @regression @report
  Scenario: MLP-4657 Verification of type Report in facet
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on DataSet dashboard
    When user clicks on "SALES DATASET" data set
    And user clicks on "Link Report" button
    And user enters the report "NAME" as "Sales Report for June"
    And user enters the reports "DESCRIPTION" as "This is a sales report for June"
    And user enters the "REPORT URL" as "https://SalesReportQ1.com"
    And user clicks on save button
    And user selects "DataSets" catalog from catalog list
    And user clicks on search icon
    Then user selects the "Report" from the Type

    @webtest @MLP-4657 @positive @regression @report
      Scenario: MLP-4657 Verification of deleting a sales fact dataset
      Given User launch browser and traverse to login page
      And user enter credentials for "System Administrator1" role
      And user clicks on DataSet dashboard
      When user clicks on "SALES DATASET" data set
      And user clicks on Delete button in Data Set page
      Then user clicks Yes on the alert window
