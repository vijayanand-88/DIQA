#@MLP-3402
#Feature: mlp-3402: This feature is to verify the searching of top values using solr search
#
#  @MLP-3402 @webtest @regression @positive @solr
#  Scenario: MLP-3402 Verification of searching top values
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
##    And user configure the advance search for the login
#    And user enters the solr search query name and clicks on search
#      | queryName |
#      | 182.5     |
#    And user gets the count and item names from UI
#    And user clicks on first item on the item list page
#    And user verifies "182.5" value is displayed in most frequent values
#    Then compare the count between UI and solr
#      | queryName | filterQuery |
#      | 182.5     |             |
#    And user clicks on logout button
#
#  @MLP-3402 @webtest @regression @positive @solr
#  Scenario: MLP-3402 Verification of searching negative top values
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
##    And user configure the advance search for the login
#    And user enters the solr search query name and clicks on search
#      | queryName |
#      | \-2222.2  |
#    And user gets the count and item names from UI
#    And user clicks on "first" button in the pagination
#    And user clicks on first item on the item list page
#    And user verifies "-2222.2" value is displayed in most frequent values
#    Then compare the count between UI and solr
#      | queryName | filterQuery |
#      | \-2222.2  |             |
#    And user clicks on logout button
#
#  @MLP-3402 @webtest @regression @positive @solr
#  Scenario: MLP-3402 Verification of searching top values using solr search
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
##    And user configure the advance search for the login
#    And user enters the solr search query name and clicks on search
#      | queryName                    |
#      | asg.indexedTopValues_ss:14.7 |
#    And user gets the count and item names from UI
#    And user clicks on first item on the item list page
#    And user verifies "14.7" value is displayed in most frequent values
#    Then compare the count between UI and solr
#      | queryName | filterQuery                  |
#      | *:*       | asg.indexedTopValues_ss:14.7 |
#    And user clicks on logout button
#
#  @MLP-3402 @webtest @regression @positive @solr
#  Scenario: MLP-3402 Verification of searching negative top values with solr
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
##    And user configure the advance search for the login
#    And user enters the solr search query name and clicks on search
#      | queryName                         |
#      | asg.indexedTopValues_ss:"-2222.2" |
#    And user gets the count and item names from UI
#    And user clicks on first item on the item list page
#    And user verifies "-2222.2" value is displayed in most frequent values
#    Then compare the count between UI and solr
#      | queryName | filterQuery                       |
#      | *:*       | asg.indexedTopValues_ss:"-2222.2" |
#    And user clicks on logout button
#
#  @MLP-3402 @webtest @regression @positive @solr
#  Scenario: MLP-3402 Verification of searching top values using solr search AND operator
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
##    And user configure the advance search for the login
#    And user enters the solr search query name and clicks on search
#      | queryName                                                    |
#      | asg.indexedTopValues_ss:10.0 && asg.indexedTopValues_ss:10.1 |
#    And user gets the count and item names from UI
#    And user clicks on first item on the item list page
#    And user verifies "10.1" value is displayed in most frequent values
#    And user verifies "10.0" value is displayed in most frequent values
#    Then compare the count between UI and solr
#      | queryName | filterQuery                                                  |
#      | *:*       | asg.indexedTopValues_ss:10.0 && asg.indexedTopValues_ss:10.1 |
#    And user clicks on logout button
#
#  @MLP-3402 @webtest @regression @positive @solr
#  Scenario: MLP-3402 Verification of searching top values using solr search OR operator
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
##    And user configure the advance search for the login
#    And user enters the solr search query name and clicks on search
#      | queryName                                                    |
#      | asg.indexedTopValues_ss:10.0 OR asg.indexedTopValues_ss:10.1 |
#    And user gets the count and item names from UI
#    And user clicks on first item on the item list page
#    And user verifies either "10.0" or "10.1" value should be displayed in most frequent values
#    Then compare the count between UI and solr
#      | queryName | filterQuery                                                  |
#      | *:*       | asg.indexedTopValues_ss:10.0 OR asg.indexedTopValues_ss:10.1 |
#    And user clicks on logout button
#
#  @MLP-3402 @webtest @regression @positive @solr
#  Scenario: MLP-3402 Verification of searching top values using solr search Not operator
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
##    And user configure the advance search for the login
#    And user enters the solr search query name and clicks on search
#      | queryName                                                  |
#      | asg.indexedTopValues_ss:10.0 !asg.indexedTopValues_ss:10.1 |
#    And user gets the count and item names from UI
#    And user clicks on first item on the item list page
#    And user verifies "10.0" value is displayed in most frequent values
#    And user verifies whether "10.1" is not displayed in most frequent values
#    Then compare the count between UI and solr
#      | queryName                                                  | filterQuery |
#      | asg.indexedTopValues_ss:10.0 !asg.indexedTopValues_ss:10.1 |             |
#    And user clicks on logout button
#
#  @MLP-3080 @webtest @regression @positive @solr
#  Scenario: MLP-3080 Verification of search Solr search in UI after changing Solr index to catalog
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    And user selects the BigData catalog from catalog list
#    And user clicks on search icon
#    And user gets the items search count
##    And user clicks on Profile Settings button
##    And user clicks on advanced tab and choose advanced solr syntax checkbox
#    And user enters the solr search query name and clicks on search
#      | queryName         |
#      | catalog_s:BigData |
#    Then user verifies whether the global search count and solr search count are same
#    And user clicks on logout button
#
#  @MLP-2977 @webtest @regression @positive @quicklink
#  Scenario: MLP-2977 Verification of delete button for empty quick link
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
##    And user configure the advance search for the login
##    And the user clicks on edit button on the widget
##    Then user verifies Delete button is not present
#    And user clicks on logout button
#
#
