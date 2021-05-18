#@MLP-13734
#Feature:MLP-13734: This feature is to verify as an IDA ADMIN I want to see a total number of tasks by state
# Descoped- Because Fliter is removed in configuration page
#  ##6811235##
#  @MLP-13734 @webtest @regression @positive
#  Scenario: Verify that the status and count is displayed for the plugin state IDLE for any deployment
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
#    And user "click" on "Filter Icon" in Manage Configurations panel
#    And user selects dropdown in Manage Configurations panel
#      | filterName | attribute |
#      | Deployment | All       |
#      | Status     | IDLE      |
#    And user verifies "Staus count and Staus Indicator" is "displayed" in Manage Configurations panel
#
#    ##6811232##
#  @MLP-13734 @webtest @regression @positive
#  Scenario: Verify that the status and count is displayed for the plugin state RUNNING for a particular deployment
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
#    And user "click" on "Filter Icon" in Manage Configurations panel
#    And user selects dropdown in Manage Configurations panel
#      | filterName | attribute |
#      | Deployment | All       |
#      | Status     | RUNNING   |
#    And user verifies "Staus count and Staus Indicator" is "displayed" in Manage Configurations panel
#
###6811236##
#  @MLP-13734 @webtest @regression @positive
#  Scenario: Verify that the status and count is displayed for the plugin state STOPPED for a particular deployment
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
#    And user "click" on "Filter Icon" in Manage Configurations panel
#    And user selects dropdown in Manage Configurations panel
#      | filterName | attribute |
#      | Deployment | All       |
#      | Status     | STOPPED   |
#    And user verifies "Staus count and Staus Indicator" is "displayed" in Manage Configurations panel
#
#    ##6811237 ##
#  @MLP-13734 @webtest @regression @positive
#  Scenario: Verify that the status and count is displayed for the plugin state UNKNOWN for a particular deployment
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
#    And user "click" on "Filter Icon" in Manage Configurations panel
#    And user selects dropdown in Manage Configurations panel
#      | filterName | attribute |
#      | Deployment | All       |
#      | Status     | UNKNOWN   |
#    And user verifies "Staus count and Staus Indicator" is "displayed" in Manage Configurations panel