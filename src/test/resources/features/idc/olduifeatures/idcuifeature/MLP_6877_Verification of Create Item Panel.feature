@MLP-6877
Feature: MLP-6877 Verification of Create Item Panel

  @webtest @MLP-6877 @positive @regression @report
  Scenario: MLP-6877 Verification of Create Item Panel
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Create button" from global header
    And user verifies create item panel is displayed
    And user "verifies disabled" on "Save button" in create item panel
    And user "verifies disabled" on "Save and open button" in create item panel
    And user "click" on "Create panel close button" in create item panel

  @webtest @MLP-6877 @positive @regression @report
  Scenario: MLP-6877 Verification of clicking on create with specific catalog
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user selects catalog "Business Glossary" and type "BusinessTerm" in create item panel
    And user enters the following values in create item panel fields
      | createItemFieldName   | createItemFieldValue      |
      | NAME                  | Business Card             |
      | DESCRIPTION           | This is part of testing   |
    And user "click" on "Save" in create item panel

