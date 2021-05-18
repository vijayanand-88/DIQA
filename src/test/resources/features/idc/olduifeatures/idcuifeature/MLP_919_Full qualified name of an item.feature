@MLP-919
Feature: MLP-919: As a User I want to see item content
  Decription: new widget for itemview: full qulified name of an item
              In the prototype we display on the names. We don't support hyperlinks for each level of the item path.
              The absname and abspath of an item is avaliable if you add "absname" and "abspath" in the what parameter of the stored query.
              Example:
                  Hive.10.33.6.133-->media-->media-->Employee
              For the first without hyperlinks.

  @MLP-919 @webtest @itemlist @sanity @positive
  Scenario:MLP-919: Verify the full qualified name of an item in the item preview page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user click Show All button in type facets
    And user checks the checkbox for "Table" in Type
    And user gets the firt item title
    And user clicks on first item on the item list page
    And user clicks on resize button in item full view page
    Then full qualified name of the item should get displayed in the item preview page
    And user should be able logoff the IDC

  @MLP-919 @webtest @itemlist @sanity @positive
  Scenario:MLP-919: Verify the full qualified name of an item in the item full view page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user selects "BigData" catalog from catalog list
    And user click Show All button in type facets
    And user checks the checkbox for "Table" in Type
    And user gets the firt item title
    And user clicks on first item name link on the item list page
    Then full qualified name of the item should get displayed in the item full view page
    And user should be able logoff the IDC