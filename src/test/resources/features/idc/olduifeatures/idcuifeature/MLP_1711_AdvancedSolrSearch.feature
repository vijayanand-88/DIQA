#@MLP-1711
#Feature:MLP-1711: This feature is to verify Solr search implementation in UI
#
#  @MLP-1711 @webtest @positive
#  Scenario: @MLP-1711 Verify that the Advance search option with solr is displayed in the preference tab as a System Admin
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    And user clicks on Profile Settings button
#    And user clicks on Preference Tab
#    Then user verifies the advanced solr search option displayed as "Advanced: Support full Solr syntax."
#    And user clicks on logout button
#
#  @MLP-1711 @webtest @positive
#  Scenario: @MLP-1711 Verify that the Advance search option with solr is displayed in the preference tab as a Data Admin
#    Given User launch browser and traverse to login page
#    When user enter credentials for "Data Administrator" role
#    And user clicks on Profile Settings button
#    And user clicks on Preference Tab
#    Then user verifies the advanced solr search option displayed as "Advanced: Support full Solr syntax."
#    And user clicks on logout button
#
#  @MLP-1711 @webtest @positive
#  Scenario: @MLP-1711 Verify that the Advance search option with solr is displayed in the preference tab
#    Given User launch browser and traverse to login page
#    When user enter credentials for "Information User" role
#    And user clicks on Profile Settings button
#    And user clicks on Preference Tab
#    Then user verifies the advanced solr search option displayed as "Advanced: Support full Solr syntax."
#    And user clicks on logout button
#
#  @MLP-1711 @webtest @positive
#  Scenario: @MLP-1711 Verify that the application displays the exact match for the items searched with name for sys admin.
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
#    And user clicks on Profile Settings button
##    And user configure the advance search for the login
#    When user enters the search solr syntaxed text for exact match for name and clicks on search
#    And the search result matches with the search query
#    Then Solr search count should me matched for exact name search
#    And item name should be matched
#
#  @MLP-1711 @webtest @positive
#  Scenario: @MLP-1711 Verify that the application displays the exact match for the items searched with name for Data Admin.
#    Given User launch browser and traverse to login page
#    And user enter credentials for "Data Administrator" role
#    And login must be successful for all users
#    And user clicks on Profile Settings button
##    And user configure the advance search for the login
#    When user enters the search solr syntaxed text for exact match for name and clicks on search
#    And the search result matches with the search query
#    Then Solr search count should me matched for exact name search
#    And item name should be matched
#
#  @MLP-1711 @webtest @positive
#  Scenario: @MLP-1711 Verify that the application displays the exact match for the items searched with name for info user.
#    Given User launch browser and traverse to login page
#    And user enter credentials for "Information User" role
#    And login must be successful for all users
#    And user clicks on Profile Settings button
##    And user configure the advance search for the login
#    When user enters the search solr syntaxed text for exact match for name and clicks on search
#    And the search result matches with the search query
#    Then Solr search count should me matched for exact name search
#    And item name should be matched
#
#  @MLP-1711 @webtest @negative
#  Scenario: @MLP-1711 Verification of Error Message for invalid Solr search query
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
##    And user clicks on Profile Settings button
##    And user configure the advance search for the login
#    When user enters the solr search query name and clicks on search
#      | queryName        |
#      | name:s_customers |
#    Then error message for invalid solr search should be displayed as "Search failed: Error from server at http://solr:8983/solr/idc-core: undefined field name"
#    And user clicks on logout button
#
#  @MLP-1711 @webtest @positive
#  Scenario: @MLP-1711 Verification of Solr search associated with Schema value as SystemAdmin
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
##    And user clicks on Profile Settings button
##    And user configure the advance search for the login
#    When user enters the solr search query name and clicks on search
#      | queryName         |
#      | catalog_s:BigData |
#    And user gets the count and item names from UI
#    And user clicks on logout button
#    Then compare the count between UI and solr
#      | queryName         | filterQuery |
#      | catalog_s:BigData |             |
#    And compare the item names between UI and solr
#      | queryName         | filterQuery |
#      | catalog_s:BigData |             |
#
#  @MLP-1711 @webtest @positive
#  Scenario: @MLP-1711 Verification of Solr search associated with Schema value as DataAdmin
#    Given User launch browser and traverse to login page
#    And user enter credentials for "Data Administrator" role
#    And login must be successful for all users
##    And user clicks on Profile Settings button
##    And user configure the advance search for the login
#    When user enters the solr search query name and clicks on search
#      | queryName         |
#      | catalog_s:BigData |
#    And user gets the count and item names from UI
#    And user clicks on logout button
#    Then compare the count between UI and solr
#      | queryName         | filterQuery |
#      | catalog_s:BigData |             |
#    And compare the item names between UI and solr
#      | queryName         | filterQuery |
#      | catalog_s:BigData |             |
#
#  @MLP-1711 @webtest @positive
#  Scenario: @MLP-1711 Verification of Solr search associated with Schema value as Info
#    Given User launch browser and traverse to login page
#    And user enter credentials for "Information User" role
#    And login must be successful for all users
##    And user clicks on Profile Settings button
##    And user configure the advance search for the login
#    When user enters the solr search query name and clicks on search
#      | queryName        |
#      | catalog_s:BigData |
#    And user gets the count and item names from UI
#    And user clicks on logout button
#    Then compare the count between UI and solr
#      | queryName        | filterQuery |
#      | catalog_s:BigData |             |
#    And compare the item names between UI and solr
#      | queryName        | filterQuery |
#      | catalog_s:BigData |             |
#
#  @MLP-1711 @webtest @positive
#  Scenario: @MLP-1711 Verification of Solr search with Item Type
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
##    And user clicks on Profile Settings button
##    And user configure the advance search for the login
#    When user enters the solr search query name and clicks on search
#      | queryName    |
#      | type_s:Field |
#    And user gets the count and item names from UI
#    And user clicks on logout button
#    Then compare the count between UI and solr
#      | queryName    | filterQuery |
#      | type_s:Field |             |
#    And compare the item names between UI and solr
#      | queryName    | filterQuery |
#      | type_s:Field |             |
#
#  @MLP-1711 @webtest @positive
#  Scenario: MLP-1711_Verification of Solr search with Logical AND(&&)
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
##    And user clicks on Profile Settings button
##    And user configure the advance search for the login
#    When user enters the solr search query name and clicks on search
#      | queryName                        |
#      | name_s:customers && type_s:Table |
#    And user gets the count and item names from UI
#    And user clicks on logout button
#    Then compare the count between UI and solr
#      | queryName                        | filterQuery |
#      | name_s:customers && type_s:Table |             |
#    And compare the item names between UI and solr
#      | queryName                        | filterQuery |
#      | name_s:customers && type_s:Table |             |
#
#  @MLP-1711 @webtest @positive
#  Scenario: MLP-1711_Verification of Solr search with Logical NOT(!)
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
##    And user clicks on Profile Settings button
##    And user configure the advance search for the login
#    When user enters the solr search query name and clicks on search
#      | queryName                             |
#      | name_s:customers !type_s:BusinessTerm |
#    And user gets the count and item names from UI
#    And user clicks on logout button
#    Then compare the count between UI and solr
#      | queryName                             | filterQuery |
#      | name_s:customers !type_s:BusinessTerm |             |
#    And compare the item names between UI and solr
#      | queryName                             | filterQuery |
#      | name_s:customers !type_s:BusinessTerm |             |
#
#  @MLP-1711 @webtest @positive
#  Scenario: MLP-1711_Verification of Solr search with Logical OR(||)
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
##    And user clicks on Profile Settings button
##    And user configure the advance search for the login
#    When user enters the solr search query name and clicks on search
#      | queryName                               |
#      | name_s:customers OR type_s:BusinessTerm |
#    And user gets the count and item names from UI
#    And user clicks on logout button
#    Then compare the count between UI and solr
#      | queryName                               | filterQuery |
#      | name_s:customers OR type_s:BusinessTerm |             |
#    And compare the item names between UI and solr
#      | queryName                               | filterQuery |
#      | name_s:customers OR type_s:BusinessTerm |             |
#
#  @MLP-1711 @webtest @positive
#  Scenario: MLP-1711_Verification of search header accept simple solr syntax as SystemAdmin
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
##    And user clicks on Profile Settings button
##    And user configure the advance search for the login
#    When user enters the solr search query name and clicks on search
#      | queryName   |
#      | *customers* |
#    And user gets the count and item names from UI
#    And user clicks on logout button
#    Then compare the count between UI and solr
#      | queryName   | filterQuery |
#      | *customers* |             |
#    And compare the item names between UI and solr
#      | queryName   | filterQuery |
#      | *customers* |             |
#
#  @MLP-1711 @webtest @positive
#  Scenario: MLP-1711_Verification of search header accept simple solr syntax as Data Admin
#    Given User launch browser and traverse to login page
#    And user enter credentials for "Data Administrator" role
#    And login must be successful for all users
##    And user clicks on Profile Settings button
##    And user configure the advance search for the login
#    When user enters the solr search query name and clicks on search
#      | queryName   |
#      | *customers* |
#    And user gets the count and item names from UI
#    And user clicks on logout button
#    Then compare the count between UI and solr
#      | queryName   | filterQuery |
#      | *customers* |             |
#    And compare the item names between UI and solr
#      | queryName   | filterQuery |
#      | *customers* |             |
#
#  @MLP-1711 @webtest @positive
#  Scenario: MLP-1711_Verification of search header accept simple solr syntax as Info User
#    Given User launch browser and traverse to login page
#    And user enter credentials for "Information User" role
#    And login must be successful for all users
##    And user clicks on Profile Settings button
##    And user configure the advance search for the login
#    When user enters the solr search query name and clicks on search
#      | queryName   |
#      | *customers* |
#    And user gets the count and item names from UI
#    And user clicks on logout button
#    Then compare the count between UI and solr
#      | queryName   | filterQuery |
#      | *customers* |             |
#    And compare the item names between UI and solr
#      | queryName   | filterQuery |
#      | *customers* |             |
#
#  @MLP-1711 @webtest @positive
#  Scenario: MLP-1711_Verification of a simple search as SystemAdmin
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
#    When user enters the solr search query name and clicks on search
#      | queryName |
#      | India     |
#    And user selects the "DataDomain" from the Type
#    Then user verifies breadcrumb list contains search text "India"
#    And user clicks on logout button
#
#  @MLP-1711 @webtest @positive
#  Scenario: MLP-1711_Verification of a simple search as Data Admin
#    Given User launch browser and traverse to login page
#    And user enter credentials for "Data Administrator" role
#    And login must be successful for all users
#    When user enters the solr search query name and clicks on search
#      | queryName |
#      | India     |
#    And user selects the "DataDomain" from the Type
#    Then user verifies breadcrumb list contains search text "India"
#    And user clicks on logout button
#
#  @MLP-1711 @webtest @positive
#  Scenario:  MLP-1711_Verification of a simple search as Info User
#    Given User launch browser and traverse to login page
#    And user enter credentials for "Information User" role
#    And login must be successful for all users
#    When user enters the solr search query name and clicks on search
#      | queryName |
#      | India     |
#    And user selects the "DataDomain" from the Type
#    Then user verifies breadcrumb list contains search text "India"
#    And user clicks on logout button
#
#
#
#
#
#
#
