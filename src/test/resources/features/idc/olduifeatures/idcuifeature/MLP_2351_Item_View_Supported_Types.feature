@MLP-2351
Feature: Verification of Item types in Item View management panel

  @2351 @webtest @positive
  Scenario: MLP-2351_Verification of Item types in Item View management panel
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "Supported Type Item View" and definition as "Test Attribute View" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Column" for Item View and click add button
    And user clicks on Save button in the Create New Item View panel
    Then Item view "Supported Type Item View" should have supported type value as "Column"
    And user clicks on "Supported Type Item View" from item view list
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on Yes button in alert message

  @2351 @webtest @positive
  Scenario: MLP-2351_Verification o f Tool tip for larger supported types values
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "Supported Type Item View" and definition as "Test Attribute View" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "ClusterServiceRole" for Item View and click add button
    And user enters the Supported Type as "Configuration" for Item View and click add button
    And user enters the Supported Type as "DataRecordType" for Item View and click add button
    And user clicks on Save button in the Create New Item View panel
    Then Item view "Supported Type Item View" should have list of supported types as "ClusterServiceRole,Configuration,DataRecordType"
    And user clicks on "Supported Type Item View" from item view list
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on Yes button in alert message

  @2351 @webtest @negative
  Scenario: MLP-2351_Verification of item views with no supported type
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "Supported Type Item View" and definition as "Test Attribute View" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user clicks on Save button in the Create New Item View panel
    Then Item view "Supported Type Item View" should have supported type value as ""
    And user clicks on "Supported Type Item View" from item view list
    And user clicks on Delete button in the  Edit Item View panel
    And user clicks on Yes button in alert message

    @2351 @webtest @positive
    Scenario: MLP-2351_Verification o f Tool tip for supported types selection box
      Given User launch browser and traverse to login page
      And user enter credentials for "System Administrator1" role
      And user clicks on Administration widget
      And user clicks on Item View Management
      And user clicks on Create button in ItemView Management Panel
      And user mouse hovers the supported type help icon
      Then "Item types that will be rendered using current Item View" text should be displayed