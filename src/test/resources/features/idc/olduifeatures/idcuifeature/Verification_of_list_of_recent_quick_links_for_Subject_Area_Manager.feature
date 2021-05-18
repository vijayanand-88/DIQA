@loginfeature
Feature: Verify that the recent quick links for Subject Area Manager is redirecting to Edit Subject Area panel.
  #Author: Venkata Sai

  @webtest @quicklink @positive
  Scenario:Verification of list of recent quick links for Subject Area Manager
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on any recent link in Catalog Manager widget
    Then edit catalog page should get displayed
