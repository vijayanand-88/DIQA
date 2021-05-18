@MLP-1178
Feature:MLP-1178: This feature is to verify the widget for Subject Area Manager

  @MLP-1178 @webtest @subjectArea @sanity @positive
  Scenario:MLP-1178: To Verify that the title Subject Area Manager is displayed in the widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    Then widget for Subject Area Manager should be displayed on the Dashboard
    And user should be able logoff the IDC

  @MLP-1178 @webtest @subjectArea @sanity @positive
  Scenario:MLP-1178: To Verify that the description for Subject Area manager is displayed in the widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    Then description for SUBJECT AREA MANAGER should be displayed on the Dashboard
    And user should be able logoff the IDC

  @MLP-1178 @webtest @subjectArea @sanity @positive
  Scenario:MLP-1178: To Verify that the image icon for Subject Area manager is displayed in the widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    Then image icon for SUBJECT AREA MANAGER should be displayed on the Dashboard
    And user should be able logoff the IDC

  @MLP-1178 @webtest @subjectArea @sanity @positive
  Scenario:MLP-1178: To Verify that the Definition for Subject Area manager is displayed in the widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    Then Definition for SUBJECT AREA MANAGER should be displayed on the Dashboard
    And user should be able logoff the IDC

  @MLP-1178 @webtest @subjectArea @sanity @positive
  Scenario:MLP-1178: To Verify that label QUICK LINKS label is displayed for Subject Area Manager in the widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    Then Quick Links for SUBJECT AREA MANAGER should be displayed on the Dashboard
    And user should be able logoff the IDC

  @MLP-1178 @webtest @subjectArea @sanity @positive
  Scenario:MLP-1178: To Verify that label RECENT label is displayed for Subject Area Manager in the widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    Then RECENT label for SUBJECT AREA MANAGER should be displayed on the Dashboard
    And user should be able logoff the IDC

#  @MLP-1178 @webtest @subjectArea @sanity
#  Scenario:MLP-1178: To Verify that Open management quick link is displayed for Subject Area Manager in the widget
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    Then Open management quick link for SUBJECT AREA MANAGER should be displayed on the Dashboard
#    And user should be able logoff the IDC

@MLP-1178 @webtest @subjectArea @sanity @positive
  Scenario:MLP-1178: To Verify that Create New Configuration quick link is displayed for Subject Area Manager in the widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    Then Create New Area quick link for SUBJECT AREA MANAGER should be displayed on the Dashboard
    And user should be able logoff the IDC

  @MLP-2588 @webtest @subjectArea @regression @positive
  Scenario:MLP_2588_Verification of Add Widget button functionality on an empty dashboard
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    When User clicks on Add(+) button
    And User types title for the new dashboard
    And user clicks on save button on the dashboard
    And user clicks on plus button for adding a new dashboard page
    And User drag and drop a widget to the page from the displayed widget list
    And user clicks on save button on the dashboard
    And user verifies plus button for adding a new widget is not displayed
    And user clicks on "QAAutDashBoard" dashboard
    And user clicks on Delete button
    And user should be able logoff the IDC

