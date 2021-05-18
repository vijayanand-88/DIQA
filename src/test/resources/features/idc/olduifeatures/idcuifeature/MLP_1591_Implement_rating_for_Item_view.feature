@MLP-1591
Feature:MLP-1591: This feature is to verifying rating for Item view

  @MLP-1591 @webtest @Views @regression @positive
  Scenario:MLP-1591: Verification of rating average in item view
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user click Show All button in type facets
    And user checks the checkbox for "File" in Type
    And user checks the facets of BigData catalog and Type as Table
    And user clicks on randon item name link on the item list page
    And user verifies rating section in item preview panel
    And user clicks on logout button


