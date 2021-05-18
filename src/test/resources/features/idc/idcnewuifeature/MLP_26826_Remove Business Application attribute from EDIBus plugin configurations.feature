Feature: MLP_26826_Remove Business Application attribute from EDIBus plugin configurations

  ## 7179484 ##
  @MLP-26826 @positive @regression @webtest
  Scenario:MLP-26826:SC#1_Verify if Business Application attribute not available for Plugin type BULK of EDI Bus plugin configurations
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Add Data source Configuration"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "verifies not presence" of following "BA Attribute of Type BULK" in Manage Configurations Page
      | Business Application |


