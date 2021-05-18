@MLP-1067
Feature:MLP-1067: This feature is to verify that the Administartors and User can access the Documentation
  via Login page and Welcome widget

  @MLP-1067 @webtest @documentation
  Scenario:MLP-1067: To verify that the everyone can access the Documentation via Login page
    Given User launch browser and traverse to login page
    When User clicks on Documentation link link in the Login page
    Then User should traverse to Documentation page in another window

#  @MLP-1067 @webtest @documentation
#  Scenario:MLP-1067: To verify the Administrator can access the Documentation page via welcome page
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And User clicks on Documentation link in the Dashboard page
#    Then User should traverse to Documentation page in another window
#
#  @MLP-1067 @webtest @documentation @sanity
#  Scenario:MLP-1067: To verify the Information User can access the Documentation page via welcome page
#    Given User launch browser and traverse to login page
#    When user enter credentials for "Information User" role
#    And User clicks on Documentation link in the Dashboard page
#    Then User should traverse to Documentation page in another window

#  @MLP-1067 @webtest @documentation @sanity
#  Scenario:MLP-1067: To verify the Information User can access the Documentation page via welcome page
#    Given User launch browser and traverse to login page
#    When user enter credentials for "Data Administrator" role
#    And User clicks on Documentation link in the Dashboard page
#    Then User should traverse to Documentation page in another window

  @MLP-4689 @webtest
    Scenario: Verification of new changes in Login page
    Given User launch browser and traverse to login page
    Then login page should display with all labels

  @MLP-5165 @webtest
  Scenario:Verification of text change in global search area
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user verifies the Search text box placeholder

  @MLP-5165 @webtest
  Scenario:Verification of copyrights in Login page
    Given User launch browser and traverse to login page
    Then user verifies the coyprights as "Copyright © 2019 ASG Technologies. All rights reserved." on login page


