#@MLP-18957@MLP-18959
#Feature: MLP-18957: As an IDA Admin I want to have an option to add user or group so that user can add the users and groups
#
## 6977925
#  @MLP-18957 @webtest @regression @positive
#  Scenario: SC#1:18957:  VVerify if cancel and close does not retain the form elements
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Admin Link" for "Manage Users & Groups" in "Landing page"
#    And user "click" on "Add users" in Manage Access page
#    And users performs following actions in Manage access
#      | Actiontype                    | ActionItem        | ItemName             | Section             |
#      | Verify Header                 | Add user or group |                      |                     |
#      | Enter Text in User and Groups |                   | DIQAALL              | Usersandgroups      |
#      | User/groups dropdown          |                   | DIQAALL              |                     |
#      | Select Dropdown               | DIQAALL           |                      | User dropdown Value |
#      | Select Dropdown               |                   | System Administrator | In Mapping Value    |
#    And user verifies "Save Button" is "disabled" in "Manage users and groups Page"
#    And user "click" on "Add Roles" in Manage Access page
#    And user "click" on "Cancel button" button in "Manage Testusers Page"
#    And user "click" on "Yes" button in "Unsaved changes pop up"
#    And users performs following actions in Manage access
#      | Actiontype                  | ActionItem | ItemName | Section |
#      | Verifies User not Displayed |            | DIQAALL  |         |
#
#    # 6977908# 6977914# 6977924# 6977922# 6977921# 6977911# 6977926# 6977910
#  @MLP-18957 @webtest @regression @positive
#  Scenario: SC#2:18957:  Verify if 'Add user or group' screen is displayed on clicking 'Add user or group'
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Admin Link" for "Manage Users & Groups" in "Landing page"
#    And user "click" on "Add users" in Manage Access page
#    And users performs following actions in Manage access
#      | Actiontype                    | ActionItem        | ItemName             | Section             |
#      | Verify Header                 | Add user or group |                      |                     |
#      | Enter Text in User and Groups |                   | DIQAALL              | Usersandgroups      |
#      | User/groups dropdown          |                   | DIQAALL              |                     |
#      | Select Dropdown               | DIQAALL           |                      | User dropdown Value |
#      | Select Dropdown               |                   | System Administrator | In Mapping Value    |
#    And user verifies "Save Button" is "disabled" in "Manage users and groups Page"
#    And user "click" on "Add Roles" in Manage Access page
#    And user "click" on "Save" button in "Manage users and groups Page"
#    And users performs following actions in Manage access
#      | Actiontype              | ActionItem | ItemName | Section |
#      | Verifies User Displayed | DIQAALL    |          |         |
#
## 6977913
#  @MLP-18957 @webtest @regression @positive
#  Scenario: SC#3:18957: Verify if LDAP user name is listed when a LDAP user name is entered in search field. For eg - enter any asg username'
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Admin Link" for "Manage Users & Groups" in "Landing page"
#    And user "click" on "Add users" in Manage Access page
#    And users performs following actions in Manage access
#      | Actiontype                    | ActionItem        | ItemName          | Section        |
#      | Verify Header                 | Add user or group |                   |                |
#      | Enter Text in User and Groups |                   | Balasubramanian G | Usersandgroups |
#      | User/groups dropdown          |                   | Balasubramanian G |                |
#
#  @MLP-18959 @regression @positive
#  Scenario Outline:MLP-18959:SC#4 Delete Usergroups
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | bodyFile | path | response code | response message | jsonPath |
#      | IDC         | TestSystemUser | application/json |       |       | Delete | rolemappings/tenant?usergroup=DIQAALL |          |      | 204           |                  |          |
#
## 6978487 # 6978490
#  @MLP-18959 @webtest @regression @positive
#  Scenario: SC#5:18959:Verify if "Create Test User" form cannot be saved, if valid role is not assigned to the user
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Admin Link" for "Manage Test Users" in "Landing page"
#    And user "click" on "Add users" in Manage Access page
#    And users performs following actions in Manage access
#      | Actiontype                    | ActionItem          | ItemName  | Section             |
#      | Enter Text in User and Groups | Enter name          | TestUSER  |                     |
#      | Enter Text in User and Groups | Enter username      | TestUSER1 |                     |
#      | Enter Text in User and Groups | Enter password      | system123 |                     |
#      | Enter Text in User and Groups | Enter email address | asa@a     |                     |
#      | Verify Header                 | Create test user    |           |                     |
#      | Enter Text in User and Groups | group               | Guest     | Assigned Roles      |
#      | Select Dropdown               | Guest               |           | User dropdown Value |
#    And user verifies "Save Button" is "disabled" in "Manage Testusers Page"
#    And user "click" on "Add Roles" in Manage Access page
#    And user "click" on "Cancel button" button in "Manage Testusers Page"
#    And user "click" on "Yes" button in "Unsaved changes pop up"
#    And users performs following actions in Manage access
#      | Actiontype                  | ActionItem | ItemName | Section |
#      | Verifies User not Displayed |            | TestUSER |         |
#
#
#    # 6978487# 6973216# 6980216
#  @MLP-18959 @webtest @regression @positive
#  Scenario: SC#6:18959:   Verify if "Create Test User" form cannot be saved, if valid role is not assigned to the user
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Admin Link" for "Manage Test Users" in "Landing page"
#    And user "click" on "Add users" in Manage Access page
#    And users performs following actions in Manage access
#      | Actiontype                    | ActionItem          | ItemName  | Section             |
#      | Enter Text in User and Groups | Enter name          | TestUSER  |                     |
#      | Enter Text in User and Groups | Enter username      | TestUSER1 |                     |
#      | Enter Text in User and Groups | Enter password      | system123 |                     |
#      | Enter Text in User and Groups | Enter email address | asa@a     |                     |
#      | Verify Header                 | Create test user    |           |                     |
#      | Enter Text in User and Groups | group               | Guest     | Assigned Roles      |
#      | Select Dropdown               | Guest               |           | User dropdown Value |
#    And user verifies "Save Button" is "disabled" in "Manage Testusers Page"
#    And user "click" on "Add Roles" in Manage Access page
#    And user "click" on "Save" button in "Manage users and groups Page"
#    And users performs following actions in Manage access
#      | Actiontype              | ActionItem | ItemName | Section   |
#      | Verifies User Displayed |            | TestUSER | Displayed |
#
#    # 6978489
#  @MLP-18959 @webtest @regression @positive
#  Scenario: SC#718959:Verify if existing username cannot be used for New test user creation. verify if system throws "User 'username' already exists" popup
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Admin Link" for "Manage Test Users" in "Landing page"
#    And user "click" on "Add users" in Manage Access page
#    And users performs following actions in Manage access
#      | Actiontype                    | ActionItem     | ItemName  | Section |
#      | Enter Text in User and Groups | Enter name     | TestUSER  |         |
#      | Enter Text in User and Groups | Enter username | TestUSER1 |         |
#    And user "Validate the field Error Message" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute                                          | pageName         |
#      | Username  | Username already exists. Specify a different value | Create test user |
#
# # 6978484
#  @MLP-18959 @webtest @regression @positive
#  Scenario: SC#8:18959:Verify if the newly created test user can login to IDx
#    Given User launch browser and traverse to login page
#    When user enter credentials for "TestUSER" role
#    And user validates profile icon is Highlighted after click
#
## 6973217
#  @MLP-18959 @webtest @regression @positive
#  Scenario: SC#9:18959: Verify if user can edit the test user and save them with new changes
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Admin Link" for "Manage Test Users" in "Landing page"
#    And user performs "click" operation in Manage Access Roles and Users list
#      | button | roleName |
#      | Edit   | TestUSER |
#    And users performs following actions in Manage access
#      | Actiontype                    | ActionItem     | ItemName  | Section |
#      | Enter Text in User and Groups | Enter name     | UserTest  | Edit    |
#      | Enter Text in User and Groups | Enter password | system456 |         |
#    And user "click" on "Save" button in "Manage users and groups Page"
#    And users performs following actions in Manage access
#      | Actiontype              | ActionItem | ItemName | Section |
#      | Verifies User Displayed |            | UserTest |         |
#
#  @MLP-18959 @webtest @regression @positive
#  Scenario: SC#10:18959:Verify if the newly created test user can login to IDx
#    Given User launch browser and traverse to login page
#    When user enter credentials for "UserTest" role
#    And users performs following actions in Manage access
#      | Actiontype                        | ActionItem | ItemName | Section |
#      | Verifies Profile Icon Highlighted |            |          |         |
#
#    # 6973218
#  @MLP-18959 @webtest @regression @positive
#  Scenario: SC#11:18959: Verify if user can see the Create Test User form fields
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Admin Link" for "Manage Test Users" in "Landing page"
#    And user "click" on "Add users" in Manage Access page
#    Then user "Verify the presnce of captions" in Plugin Configuration page
#      | Name*           |
#      | Username*       |
#      | Password*       |
#      | Email*          |
#      | Assigned Roles* |
#      | Role*           |
#
#
#  @MLP-18959 @webtest @regression @positive
#  Scenario: SC#12:18959:   Delete Test user
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Admin Link" for "Manage Test Users" in "Landing page"
#    And user performs "click" operation in Manage Access Roles and Users list
#      | button | roleName |
#      | Delete | UserTest |
#    And user "click" on "Confirm" button in "Delete Role Popup"