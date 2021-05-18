@MLP-3296
Feature:MLP-3296 Configuration of Dataset

  @webtest @MLP-3296 @positive @UI-DataSet @sanity
  Scenario: MLP-3296_ Verification of presence of DataSets for System Admin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    Then subject area "DataSets" should be available in SubjectArea management
    And user clicks on logout button

#  @webtest @MLP-3296 @positive @UI-DataSet @sanity
#  Scenario: MLP-3296_Verification of presence of DataSets for Data Admin
#    Given User launch browser and traverse to login page
#    And user enter credentials for "Data Administrator" role
#    When user clicks on Administration widget
#    And User click on Subject Area Manager link on the Dashboard page
#    Then subject area "DataSets" should be available in SubjectArea management
#    And user should be able logoff the IDC

  @webtest @MLP-3296 @positive @UI-DataSet @regression
  Scenario: MLP-3296_Verification of Adding a DataSets widget to new dashboard
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When User clicks on Add(+) button
    And user enters "Data Analysis" in the name field in the New Dashboard panel
    And User drag and drop a "DATASETS" widget to the page from the displayed widget sets
    And user clicks on save button on the dashboard
    And user clicks on "Data Analysis" dashboard
    And user clicks on the "DATASETS" widget
    And user clicks on home button
    Then user clicks on "Data Analysis" dashboard
    And user clicks on "Data Analysis" dashboard
    And user clicks on Delete button
    And user clicks on logout button

  @webtest @MLP-3296 @positive @UI-DataSet @regression
  Scenario: MLP-3296 Verifcation of DataSets catalog for TestInfo user
    Given User launch browser and traverse to login page
    And user enter credentials for "Information User" role
    And user clicks on Quickstart Dashoboard
    When User clicks on Edit button
    And User drag and drop a "DATASETS" widget to the page from the displayed widget sets
    And user clicks on save button on the dashboard
    And user clicks on home button
    And user clicks on the "DATASETS" widget
    And user clicks on home button
    And user removes "DATASETS" widget from dashboard
    And user should be able logoff the IDC

  @webtest @MLP-3296 @positive @UI-DataSet @regression
  Scenario: MLP-3296-Verification of DataSets ItemView
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on "itemView_DataSet" from item view list
    And user should be able logoff the IDC

  @webtest @MLP-3296 @positive @UI-DataSet @regression
  Scenario: MLP-3296-Verification of itemView
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on item view "itemView_DataSet" and click on visual composer button
    Then user verifies whether following widgets are displayed
      | widgetList    |
      | TAGS WIDGET   |
      | RATING WIDGET |
    And user clicks on "Data" tab on visual composer
    And user verifies whether following widgets are displayed
      | widgetList  |
      | LINK WIDGET |
    And user clicks on "Overview" tab on visual composer
    And user should be able logoff the IDC

  @webtest @MLP-3296 @positive @UI-DataSet @regression
  Scenario: MLP-3296- Verification of non editablity of DataSets catalog
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on "DataSets" catalog in catalog management
    And Delete button should be disabled
    And user clicks on logout button














