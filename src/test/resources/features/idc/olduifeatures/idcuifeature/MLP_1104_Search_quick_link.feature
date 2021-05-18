@MLP-1104
Feature:MLP-1104: Save current context and actual navigation panel parameters and selections and add it as quick link

  @MLP-1104 @quicklink @regression @sanity @positive
  Scenario: Deleteing all existing quicklinks from postgres db
    Given When query is ran to delete all quicklinks in "public" schema of "V_Setting" table
    Then Quicklink should not be found in "public" schema of "V_Setting" table

  @MLP-1104 @quicklink @regression @sanity @positive
  Scenario: Deleteing all existing quicklinks from postgres db for Test Data
    Given When query is ran to delete all quicklinks in "public" schema of "V_Setting" table for Test Data
    Then Quicklink should not be found in "public" schema of "V_Setting" table

  @MLP-1104 @Quicklink @regression @sanity @positive
  Scenario:MLP-1104: To verify catalog is created with supplied payload for search catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1104_CreateSecondCatalog.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 204 must be returned
    And verify created schema "search catalog" exists in database

  @MLP-1104 @Quicklink @regression @sanity @positive
  Scenario:MLP-1104: To verify catalog is created with supplied payload
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1104_CreateCatalog.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 204 must be returned
    And verify created schema "quicklink" exists in database

  @MLP-1104 @Quicklink @regression @sanity @webtest @positive
  Scenario: MLP-1104 Creating a quick link dashboard for System Admin user
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And User clicks on Add(+) button
    When user enters "QUICK LINK" in the name field in the New Dashboard panel
    And User drag and drop a "QUICK LINK" widget to the page from the displayed widget sets
    Then user clicks on save button on the dashboard
    And user clicks on logout button

  @MLP-1104 @Quicklink @regression @sanity @webtest @positive
  Scenario: MLP-1104 Adding a search catalog in quick link dashboard for System Admin user
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on home button and clicks on QUICK LINK dashboard
    And User clicks on active tab on the dashboard
    When User clicks on Edit button
    And User drag and drop a "SEARCH CATALOG" widget to the page from the displayed widget sets
    Then user clicks on save button on the dashboard
    And user clicks on logout button

  @MLP-1104 @Quicklink @regression @sanity @webtest
  Scenario: MLP-1104 Creating a quick link dashboard for Data Admin user
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    And User clicks on Add(+) button
    When user enters "QUICK LINK" in the name field in the New Dashboard panel
    And User drag and drop a "QUICK LINK" widget to the page from the displayed widget sets
    Then user clicks on save button on the dashboard
    And user clicks on logout button

  @MLP-1104 @Quicklink @regression @sanity @webtest @positive
  Scenario: MLP-1104 Creating a search catalog widget for Data Admin user
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    And user clicks on home button and clicks on QUICK LINK dashboard
    And User clicks on active tab on the dashboard
    And User clicks on Edit button
    When User drag and drop a "SEARCH CATALOG" widget to the page from the displayed widget sets
    Then user clicks on save button on the dashboard
    And user clicks on logout button

  @MLP-1104 @Quicklink @regression @sanity @webtest @positive
  Scenario: MLP-1104 Verification of Creating a quiclk link for search
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    When user enters the search text for table and clicks on search
    And user selects the "Table" from the Type
    And user clicks the save search button
#    And User enters the search name, Description and choose the widget QUICK LINK
    And User enters quicklink search name, Description and choose the widget and click save
      | searchName                           | searchDes                            | widgetOne  |
      | Search for sales_fact_dec_1998 table | sales_fact_dec_1998 table data items | Quick Link |
    And user clicks on home button and clicks on QUICK LINK dashboard
    And user refreshes the application
    And user edits the "Quick Link" Widget and search in quicklinks
    And user should be able to choose the "Search for sales_fact_dec_1998 table" and save it
    Then user should be able to see the quick link "Search for sales_fact_dec_1998 table" in Quick link Widget
    And user clicks on a sales fact quicklink
    And "BigData" and "Table" facets should be checked and top search box should have a catalog as All
    And search should be retruing only one table result
    And user clicks on logout button

  @MLP-1104 @Quicklink @regression @sanity @webtest @positive
  Scenario: MLP-1104 Verfication of Created solr syntaxed quicklink in BigData Widget
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
#    And user clicks on Profile Settings button
#    And user clicks on advanced tab and choose advanced solr syntax checkbox
    When user enters the search solr syntaxed text for table and clicks on search
#    And user should be seeing the search result and saves the solr search in BigData Widget
#    And user should be able to save the search
    And user clicks the save search button
    And User enters quicklink search name, Description and choose the widget and click save
      | searchName                        | searchDes | WidgetOne |
      | Database list through solr syntax | Db list   | Quick Link   |
    And user clicks on home button and clicks on QUICK LINK dashboard
    And user refreshes the application
    And user edits the "Quick Link" Widget and search in quicklinks
    And user should be able to choose the "Database list through solr syntax" and save it
    Then user should be able to see the quick link "Database list through solr syntax" in Quick link Widget
    And user clicks on a solr search databse link
    And list of databases should be available
    And user clicks on logout button

  @MLP-1104 @Quicklink @regression @webtest @sanity @positive
  Scenario: MLP-1104 Verification of adding a quickink to multiple Widget
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    When User searches database by entering a text and choosing the Database facet
#    And User enters the search name, Description and choose the widget BigData and Search Catalog widget and click save
    And user clicks the save search button
    And User enters quicklink search name, Description and choose the widgets and click save
      | searchName            | searchDes                 | widgetOne  | widgetTwo      |
      | List of all Databases | DB list from Cluster Demo | Quick Link | Search Catalog |
    And user clicks on home button and clicks on QUICK LINK dashboard
    And user refreshes the application
    And user edits "Search Catalog" catalog widget and choose "List of all Databases"
    And user edits "Quick Link" catalog widget and choose "List of all Databases"
    Then user should be able to see the quicklink in both widgets
    And user clicks on quicklink should show same result from two widget
    And user clicks on logout button

  @MLP-1104 @quicklink @regression @webtest @positive
  Scenario: MLP-1104 Verification of Duplicate quicklink
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    And login must be successful for all users
    When user enters the search text "northwind" and clicks on search
    And user clicks the save search button
#    And User enters the search name "northwind data items", Description "Db, Tables and column data items" and choose the widget "Quick Link" and click save
    And User enters quicklink search name, Description and choose the widget and click save
      | searchName           | searchDes                        | WidgetOne  |
      | northwind data items | Db Tables, and column data items | Quick Link |
    And user clicks on home button
    And user enters the search text "northwind" and clicks on search
    And user clicks the save search button
#    And User enters the search name "northwind data items", Description "Db, Tables and column data items" and choose the widget "Quick Link" and click save
    And User enters quicklink search name, Description and choose the widget and click save
      | searchName           | searchDes                        | WidgetOne  |
      | northwind data items | Db Tables, and column data items | Quick Link |
    Then user should be seeing a alert saying that duplicate link exist
    And user clicks on logout button

  @MLP-1104 @quicklink @webtest @positive
  Scenario: MLP-1104 Verification of tooltip from quicklink
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    When user enters the search text "healthcare" and clicks on search
    And user clicks the save search button
#    And User enters the search name "healthcare data items", Description "Healthcare Db, Tables and column data items" and choose the widget "Search Catalog" and click save
    And User enters quicklink search name, Description and choose the widget and click save
      | searchName            | searchDes                                   | WidgetOne      |
      | healthcare data items | Healthcare Db, Tables and column data items | Search Catalog |
    And user clicks on home button and clicks on QUICK LINK dashboard
    And user edits "Search Catalog" catalog widget and choose "healthcare data items"
    And user moves the cursor too link "healthcare data items"
    Then Description "Healthcare Db, Tables and column data items" should be showing as tooltip for link "healthcare data items"
    And user clicks on logout button

  @MLP-1104 @quicklink @webtest @positive
  Scenario: MLP-1104 Verification of assigning empty link
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user enters the search text "column" and clicks on search
    And user clicks the save search button
#    And User enters the search name "list of columns", Description "column data items" and choose the widget "Quick Link" and click save
    And User enters quicklink search name, Description and choose the widget and click save
      | searchName      | searchDes         | WidgetOne  |
      | list of columns | column data items | Quick Link |
    And user clicks on home button and clicks on QUICK LINK dashboard
    And user refreshes the application
    And user edits "Quick Link" catalog widget and choose "list of columns"
    Then user edits "Quick Link" catalog widget and choose "<empty>"
    And user clicks on logout button

  @MLP-1104 @quicklink @webtest @positive
  Scenario: MLP-1104 Verification of assigning empty link for Data Admin
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    When user enters the search text "table" and clicks on search
    And user clicks the save search button
#+    And User enters the search name "list of tables", Description "table data items" and choose the widget "Quick Link" and click save
    And User enters quicklink search name, Description and choose the widget and click save
      | searchName     | searchDes        | WidgetOne  |
      | list of tables | table data items | Quick Link |
    And user clicks on home button and clicks on QUICK LINK dashboard
    And user edits "Quick Link" catalog widget and choose "list of tables"
    Then user edits "Quick Link" catalog widget and choose "<empty>"
    And user clicks on logout button


  @MLP-2977 @quicklink @webtest
  Scenario: MLP-2977 Verification of deleting the quick link from Widget
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user enters the search text "healthcare" and clicks on search
    And user clicks the save search button
#    And User enters the search name "Health care DB items", Description "DB, tables and columns" and choose the widget "Quick Link" and click save
    And User enters quicklink search name, Description and choose the widget and click save
      | searchName           | searchDes              | WidgetOne  |
      | Health care DB items | DB, tables and columns | Quick Link |
    And user clicks on home button and clicks on QUICK LINK dashboard
    And user refreshes the application
    And user edits "Quick Link" catalog widget and choose "Health care DB items"
    And user edits "Quick Link" catalog widget and click on delete icon from "Health care DB items" link item
    And user clicks on Yes button in alert message
    Then Quick link should be deleted from Widget and empty link should be showing


  @MLP-2977 @quicklink @webtest
  Scenario: MLP-2977 Verification of deleting the quicklink from one widget which was assigned from multi widget
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    When User searches database by entering a text and choosing the Database facet
#    And User enters the search name, Description and choose the widget BigData and Search Catalog widget and click save
    And user clicks the save search button
    And User enters quicklink search name, Description and choose the widgets and click save
      | searchName      | searchDes                 | widgetOne  | widgetTwo      |
      | List of all DBs | DB list from Cluster Demo | Quick Link | Search Catalog |
    And user clicks on home button and clicks on QUICK LINK dashboard
    And user refreshes the application
    And user edits "Search Catalog" catalog widget and choose "List of all DBs"
    And user edits "Quick Link" catalog widget and choose "List of all DBs"
    And user edits "Quick Link" catalog widget and click on delete icon from "List of all DBs" link item
    And user clicks on Yes button in alert message
    Then Quick link should be deleted from Widget "Quick Link" and empty link should be showing
    And the user clicks on Save button in the widget
    And Quick link "List of all DBs"should be present in Widget "Search Catalog"

  @MLP-2977 @quicklink @webtest @negativetest
  Scenario: MLP-2977_Verification of Unassigning a Quick link without Saving the change in Widget
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user enters the search text "operation" and clicks on search
    And user clicks the save search button
#    And User enters the search name "list of operations", Description "operations, Queries and Lineage" and choose the widget "Quick Link" and click save
    And User enters quicklink search name, Description and choose the widget and click save
      | searchName         | searchDes                       | WidgetOne  |
      | list of operations | operations, Queries and Lineage | Quick Link |
    And user clicks on home button and clicks on QUICK LINK dashboard
    And user refreshes the application
    And user edits "Quick Link" catalog widget and choose "list of operations"
    And user edits "Quick Link" catalog widget and click on delete icon from "list of operations" link item
    And user clicks No on the alert window
    And the user clicks on Save button in the widget
    Then Quick link "list of operations"should be present in Widget "Quick Link"

  @MLP-3130 @quicklink @webtest @postivetest
  Scenario: MLP-3130 Veriifcation of My Searches button in item list result page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user enters the search text "operation" and clicks on search
    Then user should be able to see the "My Searches" button

  @MLP-3130 @quicklink @webtest @postivetest
  Scenario: MLP-3130_Verification of My Searches panel
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user enters the search text "DataType" and clicks on search
    And user clicks the save search button
#    And User enters the search name "list of DataType", Description "DataType from all catalog" and choose the widget "Quick Link" and click save
    And User enters quicklink search name, Description and choose the widget and click save
      | searchName       | searchDes                 | WidgetOne  |
      | list of DataType | DataType from all catalog | Quick Link |
    And user clicks on "My Searches" button from search result page
    Then user should be seeing My Searches label

  @MLP-3130 @quicklink @webtest @postivetest
  Scenario:  MLP-3130_Verification of chekcing a created quicklinks in My Searches panel
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user enters the search text "DbSystem" and clicks on search
    And user clicks the save search button
#    And User enters the search name "list of all Items", Description "All Items from BigData" and choose the widget "Quick Link" and click save
    And User enters quicklink search name, Description and choose the widget and click save
      | searchName        | searchDes              | WidgetOne  |
      | list of all Items | All Items from BigData | Quick Link |
    And user clicks on home button
    When user enters the search text "xademo" and clicks on search
    And user clicks the save search button
#    And User enters the search name "xademo Items", Description "All Items from xademo DB" and choose the widget "BigData" and click save
    And User enters quicklink search name, Description and choose the widget and click save
      | searchName   | searchDes                | WidgetOne      |
      | xademo Items | All Items from xademo DB | Search Catalog |
    And user clicks on "My Searches" button from search result page
    Then user should be seeing the quick link "list of all Items" and "xademo Items" in My Search panel

  @MLP-3130  @quicklink @webtest @postivetest
  Scenario: MLP-3130_Verification of Opening a Quick Link via My Searches panel
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user enters the search text "Execution" and clicks on search
    And user clicks the save search button
#    And User enters the search name "Execution List", Description "Queries ran on Hive" and choose the widget "Search Catalog" and click save
    And User enters quicklink search name, Description and choose the widget and click save
      | searchName     | searchDes           | WidgetOne      |
      | Execution List | Queries ran on Hive | Search Catalog |
    And user clicks on "My Searches" button from search result page
    Then user should be seeing the quick link "Execution List"
    And user cliks on quick link "Execution List"
    Then search should be opening and search should be same

  @MLP-3130 @quicklink @webtest @postivetest
  Scenario:  MLP-3130_Verification of editing a quicklinks in My Searches panel
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user enters the search text "default" and clicks on search
    And user clicks the save search button
#    And User enters the search name "default DB data items", Description "All Items from default DB" and choose the widget "BigData" and click save
    And User enters quicklink search name, Description and choose the widget and click save
      | searchName            | searchDes                 | WidgetOne  |
      | default DB data items | All Items from default DB | Quick Link |
    And user clicks on "My Searches" button from search result page
    And user clicks on "pencil" icon for quick link "default DB data items"
#    And User enters the search name "Default db search name is updated", Description "All Items from default DB" and choose the widget "Search Catalog" and click save
    And User enters quicklink search name, Description and choose the widget and click save
      | searchName                       | searchDes                 | WidgetOne      |
      | default DB data items is updated | All Items from default DB | Search Catalog |
    Then user should be seeing the quick link "default DB data items is updated" in My Search panel


  @MLP-3130 @quicklink @webtest @postivetest
  Scenario:  MLP-3130_Verification of Deleting a quicklinks in My Searches panel
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user enters the search text "employees" and clicks on search
    And user clicks the save search button
#    And User enters the search name "employee data items", Description "All Items related to employess" and choose the widget "Search Catalog" and click save
    And User enters quicklink search name, Description and choose the widget and click save
      | searchName          | searchDes                      | WidgetOne      |
      | employee data items | All Items related to employess | Search Catalog |
    And user clicks on "My Searches" button from search result page
    And user clicks on "trash" icon for quick link "employee data items"
    And user clicks on Yes button in alert message
    Then user should be seeing the quick link "employee data items" not present in My Search panel

  @MLP-3130 @quicklink @webtest @postivetest
  Scenario:  MLP-3130_Verification of deleteing a quicklinks in edit search panel
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user enters the search text "sales_fact_dec_1998" and clicks on search
    And user clicks the save search button
#    And User enters the search name "sales_fact_dec_1998 table items", Description "All Items from sales_fact_dec_1998" and choose the widget "Quick Link" and click save
    And User enters quicklink search name, Description and choose the widget and click save
      | searchName                      | searchDes                          | WidgetOne  |
      | sales_fact_dec_1998 table items | All Items from sales_fact_dec_1998 | Quick Link |
    And user clicks on "My Searches" button from search result page
    And user clicks on "pencil" icon for quick link "sales_fact_dec_1998 table items"
    And user clicks on Delete button on Quick link edit page
    And user clicks on Yes button in alert message
    Then user should be seeing the quick link "sales_fact_dec_1998 table items" not present in My Search panel

  @MLP-1104 @quicklink
  Scenario:MLP-1667: To delete the catalog search catalog
    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "/settings/catalogs/Search%20Catalog"
    Then Status code 204 must be returned
#    And response message contains value "CONFIG-0008"
    And verify created schema "Search Catalog" doesn't exists in database

  @MLP-1104 @quicklink @positive
  Scenario:MLP-1667: To delete the quick link catalog
    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "/settings/catalogs/Quick%20Link"
    Then Status code 204 must be returned
#    And response message contains value "CONFIG-0008"
    And verify created schema "quicklink" doesn't exists in database

  @MLP-1104 @quicklink @webtest @positive
  Scenario: MLP-1104 To delete the QUICK LINK dashboard for Data Admin user
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    When user clicks on home button and clicks on QUICK LINK dashboard
    And User clicks on active tab on the dashboard
    And user clicks on Delete button
    Then Dashboard "QuickStart" should be active TAB

  @MLP-1104 @quicklink @webtest @positive
  Scenario: MLP-1104 To delete the QUICK LINK dashboard for System Admin user
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on home button and clicks on QUICK LINK dashboard
    And User clicks on active tab on the dashboard
    And user clicks on Delete button
    Then Dashboard "QuickStart" should be active TAB
