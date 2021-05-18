#@MLP-17331
#Feature: MLP-17331: This feature is to verify Manage Access -Add, Edit popover for Local Users
#
  #descoped

#  ##6925263##6925270##
#  @MLP-17331 @webtest @regression @positive
#  Scenario:SC#1:MLP-17331: Verification of mandatory field vallidations on Add Local User pop over.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem    |
#      | click      | Settings Icon |
#      | click      | Manage Access |
#    And user "click" on "Manage Access title" button in "Manage Access Page"
#    And user "click" on "Manage Access tab" for "Users" in "Manage Access Page"
#    And user "click" on "Add Local User" button in "Manage Access Page"
#    And user verifies the "Add Local User" pop up is "displayed"
#    And user "Verify Text" in the "Manage Access" Page
#      | fieldName          | attribute                          |
#      | Contextual message | Enter details to add a local user. |
#    And user verifies "validation message" is displayed under the fields in "Run Save Search" Popup
#      | fieldName | validationMessage               |
#      | Name      | Name field should not be empty  |
#      | Email     | Email field should not be empty |
#    And user "enter text" in the "Add Local User" Page
#      | fieldName | attribute |
#      | Email     | testing   |
#    And user verifies "validation message" is displayed under the fields in "Run Save Search" Popup
#      | fieldName | validationMessage                                          |
#      | Email     | Invalid email address. Please enter a valid email address. |
#    And user verifies "Save button" is "disabled" in "Add Local User pop up"
#
#  ##6925271##
#  @MLP-17331 @webtest @regression @positive
#  Scenario:SC#2:MLP-17331: Verification of mandatory field vallidations on Add Local User pop over.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem    |
#      | click      | Settings Icon |
#      | click      | Manage Access |
#    And user "click" on "Manage Access title" button in "Manage Access Page"
#    And user "click" on "Manage Access tab" for "Users" in "Manage Access Page"
#    And user "click" on "Add Local User" button in "Manage Access Page"
#    And user verifies "Save button" is "disabled" in "Add Local User pop up"
#
#  ##6925275##
#  @MLP-17331 @webtest @regression @positive
#  Scenario:SC#3:MLP-17331: Verification of Canel functionality in the Add local user pop over.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem    |
#      | click      | Settings Icon |
#      | click      | Manage Access |
#    And user "click" on "Manage Access title" button in "Manage Access Page"
#    And user "click" on "Manage Access tab" for "Users" in "Manage Access Page"
#    And user "click" on "Add Local User" button in "Manage Access Page"
#    And user "enter text" in the "Add Local User" Page
#      | fieldName | attribute         |
#      | Name      | testing           |
#      | Email     | testing@gmail.com |
#    And user "click" on "Cancel button" button in "Add Local User popup"
#    And user verifies the "Unsaved Changes" pop up is "displayed"
#    And user clicks on "No" link in the "Add Local User PopUp"
#    And user verifies the "Add Local User" pop up is "displayed"
#    And user "click" on "Cancel button" button in "Add Local User popup"
#    And user clicks on "Yes" link in the "Unsaved Changes popup"
#    And user verifies the "Add Local User" pop up is "not displayed"
#
#  ##6925280##
#  @MLP-17331 @webtest @regression @positive
#  Scenario:SC#4:MLP-17331: Verification of close(x) button functionality in the Add local user pop over.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem    |
#      | click      | Settings Icon |
#      | click      | Manage Access |
#    And user "click" on "Manage Access title" button in "Manage Access Page"
#    And user "click" on "Manage Access tab" for "Users" in "Manage Access Page"
#    And user "click" on "Add Local User" button in "Manage Access Page"
#    And user "enter text" in the "Add Local User" Page
#      | fieldName | attribute         |
#      | Name      | testing           |
#      | Email     | testing@gmail.com |
#    And user "click" on "PopUp X" button in "Manage Bundles popup"
#    And user verifies the "Unsaved Changes" pop up is "displayed"
#    And user clicks on "No" link in the "Add Local User PopUp"
#    And user verifies the "Add Local User" pop up is "displayed"
#    And user "click" on "PopUp X" button in "Manage Bundles popup"
#    And user clicks on "Yes" link in the "Unsaved Changes popup"
#    And user verifies the "Add Local User" pop up is "not displayed"

#  ##6925283##
#  @MLP-17331 @webtest @regression @positive
#  Scenario:SC#5:MLP-17331: Verification of contextual message on Edit Local User pop over.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem    |
#      | click      | Settings Icon |
#      | click      | Manage Access |
#    And user "click" on "Manage Access title" button in "Manage Access Page"
#    And user "click" on "Manage Access tab" for "Users" in "Manage Access Page"
#    And user "click" in "Manage Bundles Page"
#      | fieldName                 | actionItem                |
#      | Manage Access Edit Button | Test System Administrator |
#    And user "Verify Text" in the "Manage Access" Page
#      | fieldName          | attribute                     |
#      | Contextual message | Edit details of a local user. |
#
#  ##6925284##
#  @MLP-17331 @webtest @regression @positive
#  Scenario:SC#6:MLP-17331: Verification of Canel functionality in the Edit local user pop over.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem    |
#      | click      | Settings Icon |
#      | click      | Manage Access |
#    And user "click" on "Manage Access title" button in "Manage Access Page"
#    And user "click" on "Manage Access tab" for "Users" in "Manage Access Page"
#    And user "click" in "Manage Bundles Page"
#      | fieldName                 | actionItem                |
#      | Manage Access Edit Button | Test System Administrator |
#    And user "enter text" in the "Add Local User" Page
#      | fieldName | attribute |
#      | Name      | testing   |
#    And user "click" on "Cancel button" button in "Add Local User popup"
#    And user verifies the "Unsaved Changes" pop up is "displayed"
#    And user clicks on "No" link in the "Add Local User PopUp"
#    And user verifies the "Unsaved Changes" pop up is "displayed"
#
#  ##6925286##
#  @MLP-17331 @webtest @regression @positive
#  Scenario:SC#7:MLP-17331: Verification of close(x) button functionality in the Edit local user pop over.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem    |
#      | click      | Settings Icon |
#      | click      | Manage Access |
#    And user "click" on "Manage Access title" button in "Manage Access Page"
#    And user "click" on "Manage Access tab" for "Users" in "Manage Access Page"
#    And user "click" in "Manage Bundles Page"
#      | fieldName                 | actionItem                |
#      | Manage Access Edit Button | Test System Administrator |
#    And user "click" on "PopUp X" button in "Manage Bundles popup"
#    And user verifies the "Unsaved Changes" pop up is "displayed"
#    And user clicks on "No" link in the "Add Local User PopUp"
#    And user verifies the "Unsaved Changes" pop up is "displayed"
#

