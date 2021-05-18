@MLP-917 @MLP-2012
Feature: MLP-917: new widget for itemview:  group a set of properties
  Decription: new widget for itemview: group a set of properties.
              This widget needs following settings:
              Label, set of properties
             Implementation of story MLP-2012 is done by changing the webElement. Properties title is renamed as METADATA.

  @MLP-917 @webtest @itemproperties @regression @positive
  Scenario:MLP-917: verify the set of properties in the item preview page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user click Show All button in type facets
    And user checks the BigData checkbox in the BigData Subject Area Structure page
    And user clicks on first item on the item list page
    Then set of properties of the item should get displayed in the item preview page
    And user clicks on logout button

  @MLP-917 @webtest @itemlist @sanity @positive
  Scenario:MLP-917: verify the set of properties in the item fullview page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user click Show All button in type facets
    And user checks the BigData checkbox in the BigData Subject Area Structure page
    And user clicks on first item name link on the item list page
    Then set of properties of the item should get displayed in the item full view page
    And user clicks on logout button