@MLP-920
Feature:MLP-920: This feature is to verify Quality label

  @MLP-920 @webtest @qualitylabelverification @sanity @positive
  Scenario:MLP-920: Verification of Quality label is present or not
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "sales_fact" and clicks on search
    And user clicks on first item on the item list page
    Then user should be able to see quality label
    And user should be able logoff the IDC

  @MLP-920 @webtest @qualitylabelverification @sanity @positive
  Scenario:MLP-920: Verification of Quality label is present or not in preview item page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "sales_fact" and clicks on search
    And user clicks on first item on the item list page
    Then user should be able to see quality label in preview page
    And user should be able logoff the IDC

  @MLP-920 @webtest @qualitylabelverification @sanity @positive
  Scenario: MLP-920: Verification of Quality label Bad
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "photopath" and clicks on search
    And user clicks on first item on the item list page
    Then user should be able to see quality label in preview page as Red and Quality control as Bad
    And user should be able logoff the IDC

  @MLP-920 @webtest @qualitylabelverification @sanity @positive
  Scenario:MLP-920: Verification of Quality Good
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "catmapping" and clicks on search
    And user clicks on first item on the item list page
    Then user should be able to see quality label in preview page as Yellow and Quality label as Good
    And user should be able logoff the IDC

  @MLP-920 @webtest @qualitylabelverification @sanity @positive
  Scenario:MLP-920: Verification of Quality Excellent
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "shippers" and clicks on search
    And user clicks on first item on the item list page
    Then user should be able to see quality label in preview page as Green and Quality label as Excellent
    And user should be able logoff the IDC

  @MLP-920 @webtest @qualitylabelverification @sanity @negative
  Scenario:MLP-920: Verification of Quality which doesn't have any information
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user enters the search text "Loyalty" and clicks on search
    And user clicks on first item on the item list page
#    Then user should be able to see quality label in preview page as Green and Quality label as Not Applicable
    Then user verifies quality label is not present
    And user should be able logoff the IDC