@MLP-1507
Feature:MLP-1507: This feature is to verify rating facet

#  @MLP-1507 @webtest @subjectArea @smoke @regression
#  Scenario:MLP-1507: To Verify that rating facet is displayed on facet list
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Bigdata widget title link in the dashboard page
#    Then rating facet for five stars and count should be displayed

  @MLP-1507 @webtest @subjectArea @smoke @regression @positive
  Scenario:MLP-1507: To Verify facet for rating five
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on randon item name link on the item list page
    And user gives "5" rating to the clicked item
    And user clicks on close button in the item preview page
    And user refreshes the application
    And user clicks on rating 5 checkbox and get item count
    Then solr search count should be matched for rating 5
    And solr item names should be matched for rating 5

  @MLP-1507 @webtest @subjectArea @regression @positive
  Scenario:MLP-1507: To Verify facet for rating four
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on randon item name link on the item list page
    And user gives "4" rating to the clicked item
    And user clicks on close button in the item preview page
    And user refreshes the application
    And user clicks on rating 4 checkbox and get item count
    Then solr search count should be matched for rating 4
    And solr item names should be matched for rating 4

  @MLP-1507 @webtest @subjectArea @regression @positive
  Scenario:MLP-1507: To Verify facet for rating three
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on randon item name link on the item list page
    And user gives "3" rating to the clicked item
    And user clicks on close button in the item preview page
    And user refreshes the application
    And user clicks on rating 3 checkbox and get item count
    Then solr search count should be matched for rating 3
    And solr item names should be matched for rating 3


  @MLP-1507 @webtest @subjectArea @regression @positive
  Scenario:MLP-1507: To Verify facet for rating two
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on randon item name link on the item list page
    And user gives "2" rating to the clicked item
    And user clicks on close button in the item preview page
    And user refreshes the application
    And user clicks on rating 2 checkbox and get item count
    Then solr search count should be matched for rating 2
    And solr item names should be matched for rating 2

  @MLP-1507 @webtest @subjectArea @positive
  Scenario:MLP-1507: To Verify facet for rating one
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on randon item name link on the item list page
    And user gives "1" rating to the clicked item
    And user clicks on close button in the item preview page
    And user refreshes the application
    And user clicks on rating 1 checkbox and get item count
    Then solr search count should be matched for rating 1
    And solr item names should be matched for rating 1


  @MLP-1507 @webtest @subjectArea @positive
  Scenario:MLP-1507: To Verify facet search result with OR condition
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on randon item name link on the item list page
    And user gives "5" rating to the clicked item
    And user clicks on close button in the item preview page
    And user refreshes the application
    And user clicks on rating 4 checkbox and get item count
    And user clicks on rating 5 checkbox and get item count
    Then search count and facet list count should be matched