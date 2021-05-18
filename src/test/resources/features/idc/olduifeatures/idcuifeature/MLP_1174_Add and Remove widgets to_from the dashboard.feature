@MLP-1174
Feature: MLP-1174: This feature is to verify adding/removing widget as Administrator/Data Administrator/User

  @MLP-1174 @webtest @dashboard @regression  @positive
  Scenario:MLP-1174: To Verify that System Administrator can add a widget to the dashboard
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When User clicks on active tab on the dashboard
    And User clicks on Edit button
#    And User drag and drop a widget to the page from the displayed widget list
    And User drag and drop a "BigData" widget to the page from the displayed widget sets
    And user clicks on save button on the dashboard
    Then Newly added widget should be displayed on the dashboard
    And user should be able logoff the IDC

#  @MLP-1174 @webtest @dashboard @regression
#  Scenario:MLP-1174 To Verify that System Administrator remove a widget from the dashboard
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When User clicks on active tab on the dashboard
#    And User clicks on the drop down button in the widget
#    And User clicks on the Remove button
#    Then removed widget should not be displayed on the dashboard
#    And user should be able logoff the IDC

#    @MLP-1174 @webtest @dashboard @regression
#    Scenario:MLP-1174 To Verify that Data Administrator can add a widget to the dashboard
#    Given User launch browser and traverse to login page
#    And user enter credentials for "Data Administrator" role
#   When User clicks on active tab on the dashboard
#    And User clicks on Edit button
#    And User drag and drop a widget to the page from the displayed widget list
#    And user clicks on save button on the dashboard
#    Then Newly added widget should be displayed on the dashboard
#    And user should be able logoff the IDC

#  @MLP-1174 @webtest @dashboard @regression
#  Scenario:MLP-1174 To Verify that System Administrator remove a widget from the dashboard
#    Given User launch browser and traverse to login page
#    And user enter credentials for "Data Administrator" role
#    When User clicks on active tab on the dashboard
#    And User clicks on the drop down button in the widget
#    And User clicks on the Remove button
#    Then removed widget should not be displayed on the dashboard
#    And user should be able logoff the IDC
#
#   @MLP-1174 @webtest @dashboard @regression
#   Scenario:MLP-1174 To Verify that Information User can add a widget to the dashboard
#    Given User launch browser and traverse to login page
#    And user enter credentials for "Information User" role
#    When User clicks on active tab on the dashboard
#    And User clicks on Edit button
#    And User drag and drop a widget to the page from the displayed widget list
#    And user clicks on save button on the dashboard
#    Then Newly added widget should be displayed on the dashboard
#    And user should be able logoff the IDC
#
#  @MLP-1174 @webtest @dashboard @regression
#  Scenario:MLP-1174 To Verify that System Administrator remove a widget from the dashboard
#    Given User launch browser and traverse to login page
#    And user enter credentials for "Information User" role
#    When User clicks on active tab on the dashboard
#    And User clicks on the drop down button in the widget
#    And User clicks on the Remove button
#    Then removed widget should not be displayed on the dashboard

