@MLP-3097
Feature: MLP-3175 A feature is to verify backward lineage and values in the view submenu

  @MLP-3175 @webtest @regression @positive @Diagramming
  Scenario:MLP-3175: Verification of tab name should not be uppercase
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "employees_full" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user checks the checkbox for "Table" in Type
    When user clicks on first item on the item list page
    And user verifies Tab names are not in uppercase
    And user should be able logoff the IDC

  @MLP-3175 @webtest @regression @positive @Diagramming
  Scenario:MLP-3175: Verification of highlight to the selected tab
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "employees_full" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user checks the checkbox for "Table" in Type
    When user clicks on first item on the item list page
    And user verifies "Overview" Tab is highlighted
    And user clicks on "Lineage" tab displayed
    And user verifies "Lineage" Tab is highlighted
    And user should be able logoff the IDC

  @MLP-3097 @webtest @regression @positive @Diagramming
  Scenario:MLP-3097: Verification of lineage tab in Table,Column and Field
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user clicks on search icon
    And user checks the checkbox for "Column" in Type
    When user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user clicks on close button in the item full view page
    And user clicks on search icon
    And user click Show All button in type facets
    And user checks the checkbox for "Field" in Type
    When user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user clicks on close button in the item full view page
    And user clicks on search icon
    And user click Show All button in type facets
    And user checks the checkbox for "Table" in Type
    When user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user should be able logoff the IDC

  @MLP-3097 @webtest @regression @positive @Diagramming
  Scenario:MLP-3097: Verification of lineage tab for other types
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user clicks on search icon
    And user checks the checkbox for "Directory" in Type
    When user clicks on first item on the item list page
    And user verifies "Lineage" tab not displayed in item full view
    And user clicks on close button in the item full view page
    And user clicks on search icon
    And user click Show All button in type facets
    And user checks the checkbox for "Database" in Type
    When user clicks on first item on the item list page
    And user verifies "Lineage" tab not displayed in item full view
    And user clicks on close button in the item full view page
    And user clicks on search icon
    And user click Show All button in type facets
    And user checks the checkbox for "Function" in Type
    When user clicks on first item on the item list page
    And user verifies "Lineage" tab not displayed in item full view
    And user should be able logoff the IDC

  @MLP-3097 @webtest @regression @positive @Diagramming
  Scenario:MLP-3097: Verification of values removed in lineage diagram
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user clicks on search icon
    And user checks the checkbox for "Column" in Type
    When user clicks on first item on the item list page
    And user clicks on "Lineage" tab displayed
    And user verifies the following options in lineage not displayed
      | Options    |
      | References |
      | Usages     |
    And user should be able logoff the IDC


