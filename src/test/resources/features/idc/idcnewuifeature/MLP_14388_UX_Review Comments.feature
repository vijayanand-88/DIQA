@MLP-14388
Feature: MLP-14388 UX Review Comments

  Description:
  To Verify the color codes and styles

##6828799####6828801####6828802##
  @MLP-14388 @webtest @positive
  Scenario: SC#1:To Verify the background color of manage Admin sub menu pages
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Source page"
    And user verifies the background color of the page
      | StyleType        | ColorCode              | Page                |
      | background-color | rgba(255, 255, 255, 1) | Manage Data Sources |
    And user "click" on "Close" button in "Manage Data Sources page"
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user verifies the background color of the page
      | StyleType        | ColorCode              | Page                  |
      | background-color | rgba(255, 255, 255, 1) | Manage Configurations |
    And user "click" on "Close" button in "Manage Configurations page"
    And user "click" on "Capture and Import Data Link" for "Manage Credentials" in "Landing page"
    And user "click" on "Add Credentials Button in Manage Credentials Page" button in "Manage Credentials page"
    And user verifies the background color of the page
      | StyleType        | ColorCode              | Page               |
      | background-color | rgba(255, 255, 255, 1) | Manage Credentials |
    And user "click" on "Close" button in "Manage Credentials page"


##6828792####6828793##
  @MLP-14388 @webtest @positive
  Scenario: SC#2: To Verify the focus of view/hide icon
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Credentials" in "Landing page"
    And user "click" on "Add Credentials Button in Manage Credentials Page" button in "Manage Credentials page"
    And user "select dropdown" in Add Credentials Page
      | fieldName | attribute         |
      | Type      | Username/Password |
    And user "enter text" in Add Credentials Page
      | fieldName | attribute        |
      | Name      | TestCredential11 |
      | User Name | postgres         |
    And user "verifies not displayed" on "view" icon on password field
    And user "enter text" in Add Credentials Page
      | fieldName | attribute |
      | Password  | postgres  |
    And user "verifies displayed" on "view" icon on password field