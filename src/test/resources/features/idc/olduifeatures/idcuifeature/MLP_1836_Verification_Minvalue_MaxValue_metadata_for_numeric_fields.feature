@MLP-1836

Feature:MLP-1836: Show full qualified name in tooltip in result item list
  Description: The item name tooltip in itemlist should show the whole qualified item name instead of the local name. This should be work for all tables presenting items (also inside itemview pages).
# Author: Venkata Sai

  @MLP-1836 @webtest @sanity @positive
  Scenario:MLP-1836: Verification of Minvalue and MaxValue meta data for numeric fields
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "_c8" and clicks on search
#    And user checks the checkbox for "File" in Type
    And user clicks on first item on the item list page
    And user verifies whether "Minimum value" is present under "METADATA" container
    And user verifies whether "Maximum value" is present under "METADATA" container

  @MLP-1836 @webtest @sanity @positive
  Scenario:MLP-1836: Verification of Minvalue and MaxValue meta data not present for string fields
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "_c1" and clicks on search
#    And user checks the checkbox for "File" in Type
    And user clicks on first item on the item list page
    Then the metadata should get displayed without "Minimum value" and "Maximum value" attributes
