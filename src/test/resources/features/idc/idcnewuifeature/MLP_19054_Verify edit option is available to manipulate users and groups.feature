#Feature: MLP_19054_To verify users and groups able to edit and modify existing users and groups
#
#Descoped
#    # 6978496   # 6978497# 6978501 # 6978493 # 6978494# 6978495
#  @MLP-19054 @webtest @regression @positive
#  Scenario:MLP-19054:SC#1_Verify if user can add a new role and save it. Verify if the User/Group modified is displayed with modified changes in user and group list
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Admin Link" for "Manage Users & Groups" in "Landing page"
#    And user "click" on "Click Filter" in Manage Access page
#    And users performs following actions in Manage access
#      | Actiontype      | ItemName | Section  |
#      | Select Dropdown | Group    | As Input |
#    And user performs "click" operation in Manage Access Roles and Users list
#      | button    | roleName |
#      | Edit Icon | Service  |
#    And users performs following actions in Manage access
#      | Actiontype                        | ActionItem                              |
#      | Verify Header                     | Edit user or group                      |
#      | Verify Users and groups help text | Enter details to edit an user or group. |
#    And user "verifies not displayed" on "Username textbox is disabled" in Manage Access page
#    And user "click" on "Click remove role" in Manage Access page
#    And users performs following actions in Manage access
#      | Actiontype      | ItemName   | Section          |
#      | Select Dropdown | Guest User | In Mapping Value |
#    And user "click" on "Add Roles" in Manage Access page
#    And user "click" on "No" button in "Popup Window"
#    And user "click" on "Save" button in "Add users and groups"
#    And users performs following actions in Manage access
#      | Actiontype          | ActionItem | ItemName                         |
#      | Verify Groups,roles | Service    | Guest User, System Administrator |
#    And user performs "click" operation in Manage Access Roles and Users list
#      | button    | roleName |
#      | Edit Icon | Service  |
#    And user "click" on "Click remove role" in Manage Access page
#    And user "click" on "Click remove role" in Manage Access page
#    And user verifies "Save button" is "disabled" in "Add users and groups"
#    And users performs following actions in Manage access
#      | Actiontype      | ItemName             | Section          |
#      | Select Dropdown | System Administrator | In Mapping Value |
#    And user "click" on "Add Roles" in Manage Access page
#    And user "click" on "No" button in "Popup Window"
#    And user "click" on "Save" button in "Add users and groups"
#    And users performs following actions in Manage access
#      | Actiontype          | ActionItem | ItemName             |
#      | Verify Groups,roles | Service    | System Administrator |
#
#
#
#
#
#
#
