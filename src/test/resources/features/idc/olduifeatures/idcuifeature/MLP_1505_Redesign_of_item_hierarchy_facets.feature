Feature: MLP-1505: Redesign of item hierarchy facets

  @webtest  @positive
  Scenario:Validate the search returns only column and table
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user selects "BigData" catalog from catalog list
    And user checks the checkbox for "foodmart [Database]" in Catalog
    And user selects the "Column" from the Type
#    And user checks column checkbox and validates only item with type "Column" alone is displayed
    Then search result table should have only column and table values in type column

  @webtest @positive
  Scenario: Verification of confirm delete pop up for dismissing a notification
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user enters Name and Description of New Subject Area using json config "Test Data3"
    And user clicks on choose icon button in new Subject Area page
    And user selects any icon for the subject area in Subject Area Icon page
    And user clicks on save button in New Subject Area page
    And user clicks on notification icon in the left panel
    And user get the count of total notifications
    And user clicks on dismiss link in the notification
    And user clicks No on the alert window
    And notification count should not be reduced when user click No in dismiss alert
    And user clicks on dismiss link in the notification
    And user clicks Yes on the alert window
    Then notification should be removed from notification list
    And user clicks on home button
    And user clicks on mentioned Catalog Manager to be deleted "Test Data3" in json config file
    And user clicks on Delete button in the New Subject Area page

  @MLP-4464 @webtest
  Scenario: Verification of selected items of Parent Hierarchy facet to search results
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Consumer" role
    And user selects "BigData" catalog from catalog list
    Then user checks the checkbox for "demographics [Table]" in Catalog
    And search result table should have only column and table values in type column

  @MLP-4464 @webtest
  Scenario: MLP:4464 Verification of selected items of Parent Hierarchy facet filtered by column
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Consumer" role
    And user selects "BigData" catalog from catalog list
    Then user checks the checkbox for "demographics [Table]" in Catalog
    And search result table should have only column and table values in type column
    And user selects the "Column" from the Type
    And user gets the count and item names from UI
    And user clicks on logout button
    Then compare the count between UI and solr
      | queryName                                                                                             | filterQuery |
      | asg.parentTypeNamePath_ss: "Cluster/Cluster Demo/Service/HIVE/Database/healthcare/Table/demographics" |             |


  @MLP-4464 @webtest
  Scenario: MLP:4464 Verification of selected items of Parent Hierarchy facet filtered by table
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Consumer" role
    And user selects "BigData" catalog from catalog list
    Then user checks the checkbox for "demographics [Table]" in Catalog
    And search result table should have only column and table values in type column
    And user selects the "Table" from the Type
    And user gets the count and item names from UI
    And user clicks on logout button
    Then compare the count between UI and solr
      | queryName             | filterQuery |
      | name_s:"demographics" |             |

  @MLP-4464 @webtest
  Scenario: MLP-4464_Verification of multiple selected items of Parent Hierarchy facet to search results
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Consumer" role
    And user selects "BigData" catalog from catalog list
    Then user checks the checkbox for "demographics [Table]" in Catalog
    Then user checks the checkbox for "measuresofbirthanddeath [Table]" in Catalog
    And search result table should have only column and table values in type column

  @MLP-4464 @webtest
  Scenario: Verification of multiple selected items(Database,DataType) of Parent Hierarchy facet to search results
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user selects "BigData" catalog from catalog list
    Then user checks the checkbox for "media.invoicespart.countryname [DataType]" in Catalog
    Then user checks the checkbox for "media [Database]" in Catalog
    And search result table should have only column and table values in type column







