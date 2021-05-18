#@MLP-6425
#Feature: MLP-6425_Edit PII items in Business Catalog
#
#  @webtest @MLP-6425 @positive @regression @report
#  Scenario: MLP-6425 Verification of Edit button for PII items in Business Catalog
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user selects catalog "Business Catalog" and type "PIIEntity" in create item panel
#    And user enters the following values in create item panel fields
#      | createItemFieldName | createItemFieldValue    |
#      | NAME                | Entity                  |
#      | DESCRIPTION         | This is part of testing |
#    And user "click" on "Save and open" in create item panel
#    Then user "verifies displayed" "widget edit button" displayed for item widgets
#
#  @webtest @MLP-6425 @positive @regression @report
#  Scenario: MLP-6425 Verification of Edit button for items other than Business Catalog
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user selects "BigData" catalog from catalog list
#    And user selects the "Table" from the Type
#    When user clicks on first item on the item list page
#    Then user "verifies displayed" "widget edit button" displayed for item widgets
#
#  @webtest @MLP-6425 @positive @regression @report
#  Scenario: MLP-6425 Verify if Technical Details of an item cannot be edited
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user selects "Business Catalog" catalog from catalog list
#    And user selects the "PIIProperty" from the Type
#    When user clicks on first item on the item list page
#    Then user "verifies displayed" "widget edit button" displayed for item widgets
#    Then user "verifies disabled" "Technical details" for item in search results page
#
#  @webtest @MLP-6425 @positive @regression @report
#  Scenario: MLP-6425 Verify if Enabling Items Editable option for a Catalog
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user clicks on Administration widget
#    And user clicks on Catalog manager
#    And user clicks on "Business Catalog" catalog in catalog management
#    And user "click" on "Advanced options" from the edit catalog panel
#    And user "click" on the dropdown and select the menu for "Schemas" and selects "BusinessCatalog" in catalog advance options panel
