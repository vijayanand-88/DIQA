@MLP-1176
Feature:MLP-1176: This feature is to verify that Welcome widget contents is displayed on the default dashboard

#  @MLP-1176 @webtest @welcomewidget @sanity
#  Scenario:MLP-1176: To Verify that Quick Links is displayed in welcome widget
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    Then Quick links for WELCOME WIDGET should be displayed on the Dashboard
#    And user should be able logoff the IDC


  @MLP-1176 @webtest @welcomewidget @sanity @positive
  Scenario:MLP-1176: To Verify that definition is displayed in welcome widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then definition for WELCOME WIDGET should be displayed on the Dashboard
    And user clicks on logout button

  @MLP-1176 @webtest @welcomewidget @sanity @positive
  Scenario:MLP-1176: To Verify that brand image is displayed in welcome widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then brand image for WELCOME WIDGET should be displayed on the Dashboard
    And description for WELCOME WIDGET should be displayed on the Dashboard
    And title for WELCOME WIDGET should be displayed on the Dashboard
    And user clicks on logout button