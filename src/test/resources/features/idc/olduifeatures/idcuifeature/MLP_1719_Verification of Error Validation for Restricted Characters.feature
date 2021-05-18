@MLP-1719
Feature:MLP-1719: This feature is to verify Error validation for Restricted Characters

  @MLP-1719 @webtest @subjectArea @regression @negative
  Scenario:MLP-1719: Verification of error message handling while creating a catalog with leading blanks
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user enters leading space in the name field
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and special characters are forbidden."
    And The user verifies the Save button is disabled on the New Catalog panel
    And user clicks on logout button
    And user clicks on Yes button in warning message

  @MLP-1719 @webtest @subjectArea @sanity @negative
  Scenario:MLP-1719: Verification of error message handling while creating a catalog with Trailing blanks
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user enters trailing space in the name field
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and special characters are forbidden."
    And The user verifies the Save button is disabled on the New Catalog panel
    And user clicks on logout button
    And user clicks on Yes button in warning message

  @MLP-1719 @webtest @subjectArea @regression @negative
  Scenario:MLP-1719: Verification of error message handling while creating a Tag for a catalog with leading blanks
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    When User clicks on the Add button in the Tag section
    And user click on create new tag in the Add tags panel
    And user enters leading space in the name field in the New Tag panel
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
    And user clicks on logout button
    And user clicks on Yes button in warning message

  @MLP-1719 @webtest @subjectArea @sanity @negative
  Scenario:MLP-1719: Verification of error message handling while creating a Tag for a catalog with Trailing blanks
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    When User clicks on the Add button in the Tag section
    And user click on create new tag in the Add tags panel
    And user clicks on "Escape" key
    And user enters trailing space in the name field in the New Tag panel
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
    And user clicks on logout button
    And user clicks on Yes button in warning message

#  @MLP-1719 @webtest @ingestionconfiguration @regression
#  Scenario:MLP-1719: Verification of error message handling while creating an Ingestion with Leading blanks
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user click on Ingestion Configurations link
#    And user click on create button
#    And user enters leading space in the name field in the New Ingestion Configuration panel
#    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
#    And user clicks on logout button
#    And user clicks on Yes button in warning message

#  @MLP-1719 @webtest @ingestionconfiguration @sanity
#  Scenario:MLP-1719: Verification of error message handling while creating an Ingestion with Trailing blanks
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user click on Ingestion Configurations link
#    And user click on create button
#    And user enters trailing space in the name field in the New Ingestion Configuration panel
#    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
#    And user clicks on logout button
#    And user clicks on Yes button in warning message

  @MLP-1719 @webtest @dashboard @regression @negative
  Scenario:MLP-1719: Verification of error message handling while creating a Dashboard with Leading blanks
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When User clicks on Add(+) button
    And user enters leading space in the name field in the New Dashboard panel
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
    And user clicks on logout button

  @MLP-1719 @webtest @dashboard @sanity @negative
  Scenario:MLP-1719: Verification of error message handling while creating a Dashboard with Trailing blanks
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When User clicks on Add(+) button
    And user enters trailing space in the name field in the New Dashboard panel
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
    And user clicks on logout button

  @MLP-1719 @webtest @subjectArea @regression @negative
  Scenario:MLP-1719: Verification of error message handling while creating a catalog with Forward Slash
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And User enters Slash in the name field in the New Catalog panel
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and special characters are forbidden."
    And The user verifies the Save button is disabled on the New Catalog panel
    And user clicks on logout button
    And user clicks on Yes button in warning message

  @MLP-1719 @webtest @subjectArea @sanity @negative
  Scenario:MLP-1719: Verification of error message handling while creating a catalog with Backslash
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user enters Backslash in the name field in the New Catalog panel
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and special characters are forbidden."
    And The user verifies the Save button is disabled on the New Catalog panel
    And user clicks on logout button
    And user clicks on Yes button in warning message

#  @MLP-1719 @webtest @ingestionconfiguration @regression
#  Scenario:MLP-1719: Verification of error message handling while creating an Ingestion with Forward Slash
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user click on Ingestion Configurations link
#    And user click on create button
#    And user enters Slash in the name field in the New Ingestion Configuration panel
#    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
#    And user clicks on logout button
#    And user clicks on Yes button in warning message
#
#  @MLP-1719 @webtest @ingestionconfiguration @sanity
#  Scenario:MLP-1719: Verification of error message handling while creating an Ingestion with Backslash
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user click on Ingestion Configurations link
#    And user click on create button
#    And user enters Backslash in the name field in the New Ingestion Configuration panel
#    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
#    And user clicks on logout button
#    And user clicks on Yes button in warning message

  @MLP-1719 @webtest @dashboard @regression @negative
  Scenario:MLP-1719: Verification of error message handling while creating a Dashboard with Forward Slash
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When User clicks on Add(+) button
    And user enters Slash in the name field in the New Dashboard panel
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
    And user clicks on logout button

  @MLP-1719 @webtest @dashboard @sanity @negative
  Scenario:MLP-1719: Verification of error message handling while creating a Dashboard with Backslash
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When User clicks on Add(+) button
    And user enters Backslash in the name field in the New Dashboard panel
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
    And user clicks on logout button

  @MLP-1719 @webtest @subjectArea @sanity @negative
  Scenario:MLP-1719: Verification of error message handling while creating a Tag for a catalog with Forward Slash
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    When User clicks on the Add button in the Tag section
    And user click on create new tag in the Add tags panel
    And user clicks on "Escape" key
    And user enters Backslash in the name field in the New Tag panel
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
    And user clicks on logout button
    And user clicks on Yes button in warning message

  @MLP-1719 @webtest @subjectArea @regression @negative
  Scenario:MLP-1719: Verification of error message handling while creating a Tag for an item with leading blanks
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user clicks on first item on the item list page
    And user "click" for "add tag button" in search view
    And user click on create new tag in the Add tags panel
    And user enters leading space in the name field in the New Tag panel
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
    And user clicks on logout button
    And user clicks on Yes button in warning message

  @MLP-1719 @webtest @subjectArea @sanity @negative
  Scenario:MLP-1719: Verification of error message handling while creating a Tag for an item with Trailing blanks
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user clicks on first item on the item list page
    And user "click" for "add tag button" in search view
    And user click on create new tag in the Add tags panel
    And user enters trailing space in the name field in the New Tag panel
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
    And user clicks on logout button
    And user clicks on Yes button in warning message

  @MLP-1719 @webtest @subjectArea @regression @negative
  Scenario:MLP-1719: Verification of error message handling while creating a Tag for an item with Forward Slash
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user clicks on first item on the item list page
    And user "click" for "add tag button" in search view
    And user click on create new tag in the Add tags panel
    And user enters Slash in the name field in the New Tag panel
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
    And user clicks on logout button
    And user clicks on Yes button in warning message

  @MLP-1719 @webtest @subjectArea @sanity @negative
  Scenario:MLP-1719: Verification of error message handling while creating a Tag for an item with Forward Slash
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "BigData" catalog from catalog list
    And user clicks on first item on the item list page
    And user "click" for "add tag button" in search view
    And user click on create new tag in the Add tags panel
    And user enters Backslash in the name field in the New Tag panel
    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
    And user clicks on logout button
    And user clicks on Yes button in warning message


#  @MLP-1719 @webtest @subjectArea @regression
#  Scenario Outline: MLP-1719: Verification of error message handling while creating a catalog with lamda special characters
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And User click on Subject Area Manager link on the Dashboard page
#    And user clicks on Create Button in Subject Area Management page
#    And user enter special character "<specialcharacters>" in the name field
#    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and special characters are forbidden."
#    And The user verifies the Save button is disabled on the New Catalog panel
#    Examples:
#      | specialcharacters |
#      | ~                 |
#      | #                 |
#      | %                 |
#      | '                 |
#      | ;                 |
#      | :                 |
#      | .                 |
#      | ,                 |
#      | *                 |
#
#
#  @MLP-1719 @webtest @subjectArea @regression
#  Scenario:MLP-1719: Verification of error message handling while creating a catalog with double quotes
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And User click on Subject Area Manager link on the Dashboard page
#    And user clicks on Create Button in Subject Area Management page
#    And user enter double quotes in the name field in the New Tag panel
#    Then Error message should be displayed as "Invalid name. Leading/trailing blanks and special characters are forbidden."
#    And The user verifies the Save button is disabled on the New Catalog panel
#    And user clicks on logout button
#    And user clicks on Yes button in warning message
