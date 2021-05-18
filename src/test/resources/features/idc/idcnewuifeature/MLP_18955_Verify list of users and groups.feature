#@MLP-18955 @MLP-18972
#Feature: MLP-18955: To verify List of usersand groups,roles
#Descoped
#
#  ##6977639##6977640##6977641##6977642##6977643##6977644##
#  @MLP-18955 @webtest @regression @positive
#  Scenario: SC#1:18955: Verify if Users and Groups tab is displayed.
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user "click" on "Admin Link" for "Manage Users & Groups" in "Landing page"
#    And user "verifies presence" of following "Admin page Title" in "" page
#      | Manage Users & Groups |
#    And user "verifies presence" of following "Landed page Title is Bold" in "" page
#      | Manage Users & Groups |
#    And user "verifies presence" of following "Page Subtitle" in "Manage Users & Groups" page
#      | Add/Edit a user or group, to assign roles |
#    And user "verifies presence" of following "Column Names" in "Manage Excel Imports" page
#      | Name     |
#      | Username |
#      | Role(s)  |
#      | Type     |
#    And users performs following actions in Manage access
#      | Actiontype                                  | ActionItem       |
#      | Verify Header and Count of Users and Groups | Users and Groups |
#      | Verifies Item Displayed                     | Service          |
#      | Verifies Item Displayed                     | System           |
#      | Verifies Item Displayed                     | Guest Users      |
#    And user "click" on "Sort Icon" button in "Manage Users and Groups for Name"
#    And user "verifies sorting order" of following "Users and Groups are in decending order" in "Manage Users and Groups" page
#      |  |
#    And user "click" on "Sort Icon" button in "Manage Users and Groups for Name"
#    And user "verifies sorting order" of following "Users and Groups are in ascending order" in "Manage Users and Groups" page
#      |  |
#    And user "click" on "Filter Icon" button in "Manage Users and Groups Page"
#    And user "select DS filter dropdown" in "Manage Users and Groups page"
#      | fieldName | actionItem |
#      | Type      | Group      |
#    And users performs following actions in Manage access
#      | Actiontype              | ActionItem                        |
#      | Verifies Item Displayed | Service                           |
#      | Verifies Item Displayed | System                            |
#      | Verifies Item Displayed | Guest Users                       |
#      | Verifies Item Displayed | Data Admins                       |
#      | Verifies Item Displayed | All Data Intelligence Development |
#
#    ##6972779##6973208##6973209##6973210##
#  @MLP-18972 @webtest @regression @positive
#  Scenario: SC#1:18972: Verify if Test Users tab is displayed.
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user "click" on "Admin Link" for "Manage Test Users" in "Landing page"
#    And user "verifies presence" of following "Admin page Title" in "" page
#      | Manage Test Users |
#    And user "verifies presence" of following "Landed page Title is Bold" in "" page
#      | Manage Test Users |
#    And user "verifies presence" of following "Page Subtitle" in "Manage Test Users" page
#      | Create/Edit a test user |
#    And user "verifies presence" of following "Column Names" in "Manage Test Users" page
#      | Name     |
#      | Username |
#      | Role(s)  |
#      | Type     |
#    And users performs following actions in Manage access
#      | Actiontype                            | ActionItem                |
#      | Verify Header and Count of Test Users | Test Users                |
#      | Verifies Item Displayed               | Test System Administrator |
#      | Verifies Item Displayed               | Test Guest User           |
#      | Verifies Item Displayed               | Test Data Admin           |
#    And user "click" on "Filter Icon" button in "Manage Test Users Page"
#    And user "select DS filter dropdown" in "Manage Test Users page"
#      | fieldName | actionItem |
#      | Role      | Guest User |
#    And users performs following actions in Manage access
#      | Actiontype              | ActionItem      |
#      | Verifies Item Displayed | Test Guest User |
