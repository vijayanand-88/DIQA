@MLP-2528
  Feature: This feature is to verify the existing nodes in Plugin Manager


    @webtest @MLP-2528 @positive
      Scenario: This feature is to verify the existing nodes in Plugin Manager
      Given User launch browser and traverse to login page
      And user enter credentials for "System Administrator1" role
      And user clicks on Administration widget
      And user clicks on Plugin Manager in Administration dashboard
#      Then user validates the following nodes are available by default

  @webtest @MLP-2528
    Scenario: MLP-2528 Verification of existing nodes in the Plugin Manager panel
      Given User launch browser and traverse to login page
      When user enter credentials for "System Administrator1" role
      And user clicks on Administration widget
      And user clicks on Plugin Manager in Administration dashboard
      Then user verifies "NODES" label with number of nodes displayed
      And user verifies the existing nodes are listed in Plugin Manager panel
      And verify the number of plugins for "Cluster Demo" is displayed
      And user should be able logoff the IDC