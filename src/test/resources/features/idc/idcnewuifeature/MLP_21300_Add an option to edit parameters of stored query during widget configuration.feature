Feature:MLP_21300 Verify Run Excel mappings configuration

# 7095782# 7095783# 7095784# 7095785
  @MLP-21300 @webtest @regression @positive
  Scenario:MLP-21300:SC#1_verify the user is able to edit the parameters (Item type) of query in count widget configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Dashboard page"
    And user "click" on "Widget settings Icon" for "Application by Business Criticality" in "Dashboard page"
    And user "Select dropdown in Dashboard Config" in "Dashboard Page"
      | fieldName | actionItem                               |
      | Query     | Return tagged items grouped by item type |
    And user "click" on "SAVE" button in "Widget edit page"
    And user "click" on "Widget settings Icon" for "Application by Business Criticality" in "Dashboard page"
    And user "verify Widget Dropdown Values" in "Landing Page"
      | fieldName | actionItem                               |
      | Query     | Return tagged items grouped by item type |
    And user "click" on "SAVE" button in "Widget edit page"
    And user "click" on "Widget settings Icon" for "Business Applications with Trust Score" in "Dashboard page"
    And user "Select dropdown in Dashboard Config" in "Dashboard Page"
      | fieldName | actionItem                                        |
      | Query     | Return Trust score of items of specific item type |
    And user "click" on "SAVE" button in "Widget edit page"
    And user "click" on "Widget settings Icon" for "Business Applications with Trust Score" in "Dashboard page"
    And user "verify Widget Dropdown Values" in "Landing Page"
      | fieldName | actionItem                                        |
      | Query     | Return Trust score of items of specific item type |
    And user "click" on "SAVE" button in "Widget edit page"
    And user "click" on "Widget settings Icon" for "Application by Business Criticality" in "Dashboard page"
    And user "Select dropdown in Dashboard Config" in "Dashboard Page"
      | fieldName | actionItem                      |
      | Query     | Return items count by attribute |
    And user "click" on "SAVE" button in "Widget edit page"
    And user "click" on "Widget settings Icon" for "Application by Business Criticality" in "Dashboard page"
    And user "verify Widget Dropdown Values" in "Landing Page"
      | fieldName | actionItem                      |
      | Query     | Return items count by attribute |
    And user "click" on "SAVE" button in "Widget edit page"

