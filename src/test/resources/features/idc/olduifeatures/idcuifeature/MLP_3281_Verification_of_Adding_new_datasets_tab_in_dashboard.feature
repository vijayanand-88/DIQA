@MLP-3281
Feature: MLP-3281 Implement datasets detail view similar like itemview

  @webtest @MLP-3281 @positive @sanity @UI-DataSet
  Scenario: MLP-3281 Verification of DataSets Dashboard for System Admin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on DataSet dashboard
    Then Dashboard "Data Sets" should be active TAB

  @webtest @MLP-3281 @positive @sanity @UI-DataSet
  Scenario: MLP-3281 Verification of DataSets Dashboard for Data Admin
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    And user clicks on DataSet dashboard
    Then Dashboard "Data Sets" should be active TAB

  @webtest @MLP-3281 @positive @sanity @UI-DataSet
  Scenario: MLP-3281 Verification of DataSets Dashboard for TestInfo user
    Given User launch browser and traverse to login page
    And user enter credentials for "Information User" role
    And user clicks on DataSet dashboard
    Then Dashboard "Data Sets" should be active TAB

  @webtest @MLP-3281 @positive @regression @UI-DataSet
  Scenario: MLP-3281 Verification of Filter bar for DataSet Dashboard
    Given User launch browser and traverse to login page
    And user enter credentials for "Information User" role
    And user clicks on DataSet dashboard
    Then following filter sections values and tag filter should be displayed
      | dataSetFilters |
      | All            |
      | My Data Sets   |

  @webtest @MLP-3281 @positive @regression @UI-DataSet
  Scenario:  MLP-3281 Verification of MyDataSets filter for TestService user
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "address" and clicks on search
    And user selects the "Column" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "Sales Fact Test Data Sets 31" and description "Sales Fact Test Data Sets 31 description"
    And user clicks on home button
    And user clicks on DataSet dashboard
    And user clicks on "My Data Sets" tab
    Then "SALES FACT TEST DATA SETS 31" data set should be available in My DataSet tabs
    And user get the ID for data set "Sales Fact Test Data Sets 31" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-3281 @positive @regression @UI-DataSet
  Scenario:  MLP-3281 Verification of MyDataSets filter for TestData user
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "address" and clicks on search
    And user selects the "Column" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "Sales Fact Test Data Sets 41" and description "Sales Fact Test Data Sets 41 description"
    And user clicks on home button
    And user clicks on DataSet dashboard
    And user clicks on "My Data Sets" tab
    Then "SALES FACT TEST DATA SETS 41" data set should be available in My DataSet tabs
    And user get the ID for data set "Sales Fact Test Data Sets 41" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-3281 @positive @regression @UI-DataSet
  Scenario:  MLP-3281 Verification of MyDataSets filter for Info user
    Given User launch browser and traverse to login page
    And user enter credentials for "Information User" role
    And user clicks on DataSet dashboard
    And user clicks on "My Data Sets" tab
    And data set "SALES FACT TEST DATA SETS THREE" should not be displayed in "My Datasets" tab

  @webtest @MLP-3281 @positive @regression @UI-DataSet
  Scenario:  MLP-3282 Verification of Rating in DataSet tile
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "address" and clicks on search
    And user selects the "Column" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "Sales Fact Test Data Sets 51" and description "Sales Fact Test Data Sets 51 description"
    And user clicks on home button
    And user clicks on DataSet dashboard
    And user selects dataset rating as "4" in rating section
    And user get the ID for data set "Sales Fact Test Data Sets 51" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    Then selected rating "4" should be updated in database
      | description | schemaName | tableName | columnName | criteriaName        |
      | SELECT      | DataSets   | E_rating  | rating     | DataSets.DataSet__I |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

#  @webtest @MLP-3281 @positive @regression @UI-DataSet
#  Scenario:   MLP-3281 Verification of Favorites filter in DataSets
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user selects "BigData" catalog from catalog list
#    And user enters the search text "address" and clicks on search
#    And user selects the "Column" from the Type
#    And user enable first item checkbox from item search results
#    And user creates a dataset with name "Sales Fact Test Data Sets 61" and description "Sales Fact Test Data Sets 61 description"
#    And user clicks on home button
#    And user clicks on DataSet dashboard
#    And data set "SALES FACT TEST DATA SETS 61" should not be displayed in "Favorites" tab
#    And user clicks on "My Data Sets" tab
#    And user selects dataset rating as "5" in rating section
#    And data set "SALES FACT TEST DATA SETS 61" should  be displayed in "Favorites" tab
#    And user clicks on "My Data Sets" tab
#    And user selects dataset rating as "3" in rating section
#    And data set "SALES FACT TEST DATA SETS 61" should not be displayed in "Favorites" tab
#    And user get the ID for data set "Sales Fact Test Data Sets 61" from below query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | DataSets   | V_DataSet | ID         | name         |
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-3281 @positive @regression @UI-DataSet
  Scenario: MLP-3281 Verification of Search for DataSets
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "address" and clicks on search
    And user selects the "Column" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "Sales Fact Test Data Sets 71" and description "Sales Fact Test Data Sets 71 description"
    And user clicks on home button
    And user clicks on DataSet dashboard
    And user enters "Sales Fact Test Data Sets 71" in search text box
    And data set "SALES FACT TEST DATA SETS 71" should  be displayed in "All" tab
    And data set "SALES FACT TEST DATA SETS 71" should not be displayed in "Favorites" tab
    And user clear search dataset textbox
    And data set "SALES FACT TEST DATA SETS 71" should  be displayed in "All" tab
    And user get the ID for data set "Sales Fact Test Data Sets 71" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

  @webtest @MLP-3281 @positive @regression @UI-DataSet
  Scenario: MLP-3281 Verification of Tags filter in DataSets dashboard
    Given A query param with "keepOld" and "true" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for POST request with url "/tags/DataSets/structures/Data%20Analysis"
    And Status code 204 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "address" and clicks on search
    And user selects the "Column" from the Type
    And user enable first item checkbox from item search results
    And user creates a dataset with name "Sales Fact Test Data Sets 81" and description "Sales Fact Test Data Sets 81 description"
    And user selects "DataSets" catalog from catalog list
    And user enters the search text "Sales Fact Test Data Sets 81" and clicks on search
    And user selects the "DataSet" from the Type
    And user clicks on first item on the item list page
    And user "click" for "add tag button" in search view
    And user assign the following tags to item
      | tagName       |
      | Email Address |
      | Phone Number  |
    And user clicks on the Save button in the Assign/UnAssign panel
    And user clicks on home button
    And user clicks on DataSet dashboard
    Then added tag values should be displayed in tag list box
    And user select "Email Address" in tag dropdown
    And data set "SALES FACT TEST DATA SETS 81" should  be displayed in "All" tab
    And user get the ID for data set "Sales Fact Test Data Sets 81" from below query
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | ID         | name         |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call to DELETE "datasets/DataSets.DataSet:::"

