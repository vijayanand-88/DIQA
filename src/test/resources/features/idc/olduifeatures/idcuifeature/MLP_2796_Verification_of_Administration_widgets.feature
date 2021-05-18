@MLP-2796
Feature:MLP-2796: This feature is to verify the removing the widgets for different users

  @MLP-2796 @webtest @regression @positive @administration
  Scenario: MLP-2796 Verification of removing Administrative widgets from Quick Start page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And Dashboard "QuickStart" should be active TAB
    Then user verifies whether the "CATALOG MANAGER" widget is not displayed in the QuickStart Dashboard
    And user verifies whether the "PLUGIN MANAGER" widget is not displayed in the QuickStart Dashboard
    And user clicks on logout button

  @MLP-2796 @webtest @regression @positive @administration
  Scenario: MLP-2796 Verification of removing Administrative widgets from Quick Start page for Data Admin
    Given User launch browser and traverse to login page
    When user enter credentials for "Data Administrator1" role
    And Dashboard "QuickStart" should be active TAB
    Then user verifies whether the "CATALOG MANAGER" widget is not displayed in the QuickStart Dashboard
    And user verifies whether the "PLUGIN MANAGER" widget is not displayed in the QuickStart Dashboard
    And user clicks on logout button

#  @MLP-2796 @webtest @regression @positive @administration
#  Scenario: MLP-2796 Verification of Administration Tab for Data Administrator
#    Given User launch browser and traverse to login page
#    When user enter credentials for "Data Administrator" role
#    And user clicks on Administration widget
#    Then Dashboard "Administration" should be active TAB
#    And user clicks on logout button
#
#  @MLP-2796 @webtest @regression @positive @administration
#  Scenario: MLP-2796 Verification of Catalog and Plugin widget for Data Admin
#    Given User launch browser and traverse to login page
#    When user enter credentials for "Data Administrator" role
#    And user clicks on Administration widget
#    And Dashboard "Administration" should be active TAB
#    Then user verifies whether the "CATALOG MANAGER" widget is displayed in the current tab
#    And user verifies whether the "PLUGIN MANAGER" widget is displayed in the current tab
#    And user clicks on logout button