
@MLP-22966
Feature:MLP_22966 Discard popup is not displayed when clicking Other link in the page(Eg: Left menu, Search, profile)

  # 7096251# 7096252
  @MLP-22966 @webtest @regression @positive
  Scenario:MLP_22966:SC#1_Verify the user is able to select the view the multi select drop down for Environment,Platforms, Languages, SDLC Environments, Interfaces Protocol EnvironmentType
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And user "click" on "Add New Rule" button in "Tagging Policy page"
    And user "click" on "TaggingPolicyIgnoreEmptyandNull" button in "Tagging Policy page"
    And user "click" on "ProfileLogOut" button in "Tagging Policy page"
    And user "verify presence" in "Trust Policy page"
      | fieldName | actionItem      |
      | Popup     | Unsaved changes |
    And user "click" on "No" button in "Unsaved changes pop up"
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And user "verify presence" in "Trust Policy page"
      | fieldName | actionItem      |
      | Popup     | Unsaved changes |
    And user "click" on "No" button in "Unsaved changes pop up"
    And user "click" on "Admin Link" for "Trust Policy" in "Landing page"
    And user "verify presence" in "Trust Policy page"
      | fieldName | actionItem      |
      | Popup     | Unsaved changes |
    And user "click" on "No" button in "Unsaved changes pop up"