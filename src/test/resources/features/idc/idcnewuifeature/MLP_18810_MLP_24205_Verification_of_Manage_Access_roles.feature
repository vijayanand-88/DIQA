@MLP-18810
Feature:MLP-18810: This feature is to verify the roles of manage access

   ##7108493##7108494##7108499##7108500##7108501##
  @MLP-23675 @webtest @regression @positive
  Scenario:SC#1: MLP-23675: Verify the discard popup works as expected in manage roles
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Roles" in "Landing page"
    And user "click" on "Add Role" button in "Manage Roles"
    And user "Verifies popup" is "displayed" for "Add Role"
    And user clicks on "Escape" key
    And user "Verifies popup" is "not displayed" for "Unsaved changes"
    And user "click" on "Add Role" button in "Manage Roles"
    And user "enter text" in "Add Roles" Manage Access Page
      | fieldName | actionItem  |
      | roleName  | Sample Role |
    And user clicks on "Escape" key
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Unsaved changes popup"
    And user "click" on "Popup Cancel" button in "Edit Data Source popup"
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Unsaved changes popup"
    And user "click" on "Popup Close" button in "Edit Data Source popup"
    And user "Verifies popup" is "displayed" for "Unsaved changes"

       ##7108493##7108494##7108499##7108500##7108501##
  @MLP-23675 @webtest @regression @positive
  Scenario:SC#2: MLP-23675: Verify the discard popup works as expected in manage test users
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Test Users" in "Landing page"
    And user "click" on "Add Role" button in "Manage Test Users"
    And user "Verifies popup" is "displayed" for "Create test user"
    And user clicks on "Escape" key
    And user "Verifies popup" is "not displayed" for "Unsaved changes"
    And user "click" on "Add Role" button in "Manage Test Users"
    And user "enter text" in "Create test user popup"
      | fieldName      | actionItem |
      | Test User Name | Customer   |
    And user clicks on "Escape" key
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Unsaved changes popup"
    And user "click" on "Popup Cancel" button in "Edit Data Source popup"
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Unsaved changes popup"
    And user "click" on "Popup Close" button in "Edit Data Source popup"
    And user "Verifies popup" is "displayed" for "Unsaved changes"

   ##7108493##7108494##7108499##7108500##7108501##
  @MLP-23675 @webtest @regression @positive
  Scenario:SC#3: MLP-23675: Verify the discard popup works as expected in Manage Users & Groups
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Users & Groups" in "Landing page"
    And user "click" on "Add User Or Group" button in "Manage Users & Groups page"
    And user "Verifies popup" is "displayed" for "Add user or group"
    And user clicks on "Escape" key
    And user "Verifies popup" is "not displayed" for "Unsaved changes"
    And user "click" on "Add Role" button in "Manage Users & Groups"
    And user "enter text" in "Add user or group popup"
      | fieldName       | actionItem |
      | User/Group Name | Customer   |
    And user clicks on "Escape" key
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Unsaved changes popup"
    And user "click" on "Popup Cancel" button in "Edit Data Source popup"
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Unsaved changes popup"
    And user "click" on "Popup Close" button in "Edit Data Source popup"
    And user "Verifies popup" is "displayed" for "Unsaved changes"

  ##6982669##
  @MLP-18810 @webtest @regression @positive
  Scenario: SC1#:MLP-18810: Verify if Roles tab displays only 3 roles "System Administrator", "Guest User", "Data Administrator"
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Roles" in "Landing page"
    And user "verifies presence" of following "Manage Access default roles list" in "Manage Bundles" page
      | Technology Owner     |
      | System Administrator |
      | Security Owner       |
      | Relationship Owner   |
      | Guest User           |
      | Data Administrator   |
      | Compliance Owner     |
      | Business Owner       |

#  ##6982676## ###### DeScoped ##############
#  @MLP-18810 @webtest @regression @positive
#  Scenario: SC2#:MLP-18810:Login as TestGuestUser and verify if the user cannot Add contents
#    Given User launch browser and traverse to login page
#    When user enter credentials for "Information User" role
#    And user clicks on "Close popup" link in the "Landing page"
#    And user "click" on "Admin Link" for "Manage Roles" in "Landing page"
#    And user "click" on "Add Role" in Manage Access page
#    And user "enter text" in "Add Roles" Manage Access Page
#      | fieldName | actionItem |
#      | roleName  | Admin Role |
#    And user "click" on "Save Role" in Manage Access page
#    And user verifies the "ERROR" pop up is "displayed"

#      ##6982676##  ###### DeScoped ##############
#  @MLP-18810 @webtest @regression @positive
#  Scenario: SC3#:MLP-18810:Login as TestGuestUser and verify if the user cannot Edit contents
#    Given User launch browser and traverse to login page
#    When user enter credentials for "Information User" role
#    And user clicks on "Close popup" link in the "Landing page"
#    And user performs following actions in the sidebar
#      | actionType | actionItem    |
#      | click      | Settings Icon |
#      | click      | Manage Roles  |
#    And user "click" on "Manage Access title" button in "Manage Access Page"
#    And user "click" in "Manage Bundles Page"
#      | fieldName                 | actionItem           |
#      | Manage Access Edit Button | System Administrator |
#    And user "enter text" in "Add Roles" Manage Access Page
#      | fieldName | actionItem |
#      | roleName  | Admin Role |
#    And user "click" on "Save Role" in Manage Access page
#    And user verifies the "ERROR" pop up is "displayed"
#
#  ##6982676##  ###### DeScoped ##############
#  @MLP-18810 @webtest @regression @positive
#  Scenario: SC4#:MLP-18810:Login as TestGuestUser and verify if the user cannot Deelte contents
#    Given User launch browser and traverse to login page
#    When user enter credentials for "Information User" role
#    And user clicks on "Close popup" link in the "Landing page"
#    And user performs following actions in the sidebar
#      | actionType | actionItem    |
#      | click      | Settings Icon |
#      | click      | Manage Roles  |
#    And user "click" on "Manage Access title" button in "Manage Access Page"
#    And user "click" in "Manage Bundles Page"
#      | fieldName                   | actionItem           |
#      | Manage Access Delete Button | System Administrator |
#    And user clicks on "Yes" link in the "popup"
#    And user verifies the "ERROR" pop up is "displayed"

  @MLP-18810 @webtest @regression @positive
  Scenario:MLP-18810:SC#5: Login as TestDataAdmin and verify if the user can add Tag to an item and create a new tag and add it
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDxPayloads/MLP-18810_Create_Item.json"
    And user makes a REST Call for POST request with url "items/Default/root" and store the response
#    And Status code 200 must be returned
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "SampleTest" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "SampleTest" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     |
      | Click      | Add Tag Button |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem          |
      | Click      | Create a tag Button |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem |
      | Enter Text | Sample_Tag |
    And user "click" on "Save" button in "Create Tag Page"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "tags/Default/tags/Sample_Tag"
    And Status code 204 must be returned

#  ##6982715## ### DeScoped ###
#  @MLP-18810 @webtest @regression @positive
#  Scenario: SC6#:MLP-18810: Login as TestDataAdmin and verify if the user cannot Delete/Add contents like Credentials
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollector/TestGitDS"
#    And user makes a REST Call for DELETE request with url "settings/credentials/TestGitCredential"
#    And supply payload with file name "/idc/IDx_DataSource_Credentials_Payloads/MLP-14658_GitCollectorDS_Config.json"
#    When user makes a REST Call for PUT request with url "settings/analyzers/GitCollector/TestGitDS" with the following query param
#      | raw | false |
#    And Status code 204 must be returned
#    And supply payload with file name "/idc/IDx_DataSource_Credentials_Payloads/MLP-14658_Username_Pasword_Credential_Config.json"
#    When user makes a REST Call for PUT request with url "settings/credentials/TestGitCredential" with the following query param
#      | raw | false |
#    And Status code 200 must be returned
#    Given User launch browser and traverse to login page
#    When user enter credentials for "Data Admin" role
#    And user clicks on "Close popup" link in the "Landing page when logged in as Data Admin"
#    And user performs following actions in the sidebar
#      | actionType | actionItem         |
#      | click      | Settings Icon      |
#      | click      | Manage Credentials |
#    And user "click" on "Filter Icon" button in "Manage Credentials Page"
#    And user "click" in "Manage Credentials Page"
#      | fieldName                        | actionItem        |
#      | Manage Credentials Delete Button | TestGitCredential |
#    And user "click" on "DELETE" button in "the popup"
#    And user verifies the "ERROR" pop up is "displayed"
#
#      ##6982715##### DeScoped ###
#  @MLP-18810 @webtest @regression @positive
#  Scenario: SC7#:MLP-18810: Login as TestDataAdmin and verify if the user cannot Delete/Add contents like Bundles
#    Given User launch browser and traverse to login page
#    When user enter credentials for "Data Admin" role
#    And user clicks on "Close popup" link in the "Landing page when logged in as Data Admin"
#    And user performs following actions in the sidebar
#      | actionType | actionItem     |
#      | click      | Settings Icon  |
#      | click      | Manage Bundles |
#    And user "click" on "Filter Icon" button in "Manage Bundles Page"
#    And user "click" in "Manage Credentials Page"
#      | fieldName                        | actionItem                   |
#      | Manage Credentials Delete Button | com.asg.dis.SimilarityLinker |
#    And user "click" on "DELETE" button in "the popup"
#    And user verifies the "ERROR" pop up is "displayed"
#
#      ##6982715##### DeScoped ###
#  @MLP-18810 @webtest @regression @positive
#  Scenario: SC8#:MLP-18810: Login as TestDataAdmin and verify if the user cannot Delete/Add contents like Configurations
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollector/GitCollectorConfig"
#    And supply payload with file name "/idc/IDX_PluginPayloads/MLP-14104_GitCollector_Plugin_Config.json"
#    When user makes a REST Call for PUT request with url "settings/analyzers/GitCollector/GitCollectorConfig" with the following query param
#      | raw | false |
#    And Status code 204 must be returned
#    Given User launch browser and traverse to login page
#    When user enter credentials for "Data Admin" role
#    And user clicks on "Close popup" link in the "Landing page when logged in as Data Admin"
#    And user performs following actions in the sidebar
#      | actionType | actionItem            |
#      | click      | Settings Icon         |
#      | click      | Manage Configurations |
#    And user verifies the "ERROR" pop up is "displayed"
#
#  @git### DeScoped ###
#  Scenario: Delete Plugin Configuration
#    Given  Execute REST API with following parameters
#      | Header           | Query | Param | type   | url                                                | body | response code | response message | jsonPath |
#      | application/json |       |       | Delete | settings/analyzers/GitCollector/TestGitDS          |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/credentials/TestGitCredential             |      | 200           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/GitCollector/GitCollectorConfig |      | 204           |                  |          |

  @MLP-18810 @webtest @regression @positive
  Scenario:MLP-18810:Create an BA Item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute     |
      | Item Name | Test_SampleBA |
    And user "click" on "Save" button in "Create Item Page"

#    ##6982740##
#  @MLP-18010 @webtest @regression @positive
#  Scenario:MLP-18010:SC#9 Login as TestDataAdmin and verify if the user can edit Business Application contents only
#    Given User launch browser and traverse to login page
#    When user enter credentials for "Data Admin" role
#    And user clicks on "Close popup" link in the "Landing page when logged in as Data Admin"
#    And user enters the search text "Test_SampleBA" and clicks on search
#    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "Test_SampleBA" item from search results
#    And User performs following actions in the Item view Page
#      | Actiontype      | ActionItem     |
#      | Click Edit Icon | Business Owner |
#    And User performs following actions in the Item view Page
#      | Actiontype               | ActionItem     | ItemName        |
#      | Verify Edit Widget value | Business Owner | Start typing... |
#    And User performs following actions in the Item view Page
#      | Actiontype           | ActionItem     | ItemName        |
#      | Enter Business Owner | Business Owner | Test Data Admin |
#    And user clicks on first item in Business Owner list
#    And User performs following actions in the Item view Page
#      | Actiontype | ActionItem     | ItemName |
#      | Click      | Business Owner | Save     |
#    And User performs following actions in the Item view Page
#      | Actiontype                         | ActionItem     | ItemName        |
#      | Verify Business Owner Widget value | Business Owner | Test Data Admin |

   ##7115865##
  @MLP-24202 @webtest @regression @positive
  Scenario: SC1#:MLP-24202: Verify if Roles tab displays only new roles "Technical Owner", "Security Owner", "Relationship Owner" ,"Compliance Owner", "Business Owner"
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Roles" in "Landing page"
    And user "verifies presence" of following "Manage Access default roles list" in "Manage Bundles" page
      | Technology Owner     |
      | System Administrator |
      | Security Owner       |
      | Relationship Owner   |
      | Guest User           |
      | Data Administrator   |
      | Compliance Owner     |
      | Business Owner       |

  ##7118545##7118546##7118547##7118548##7118549##7118550##
  @MLP-24205 @regression @positive
  Scenario Outline:SC#2_Create BusinessApplication
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc/BusinessApplication/BAOwnerAssignment.json | 200           |                  |          |

  ##7115871##7118550##
  @MLP-24205 @webtest @regression @positive
  Scenario: SC2#:MLP-24205: Verify the user is able to view the roles assigned during the creation of BA item
    Given User launch browser and traverse to login page
    When user enter credentials for "Becubic User" role
    And user performs following actions in the sidebar
      | actionType         | actionItem         |
      | click              | Profile Icon       |
      | verifies displayed | Business Owner     |
      | verifies displayed | Compliance Owner   |
      | verifies displayed | Relationship Owner |
      | verifies displayed | Technology Owner   |
      | verifies displayed | Security Owner     |

  ##7115868##
  @MLP-24205 @webtest @regression @positive
  Scenario: SC3#:MLP-24205: Verify the User with New roles is able to create a Tag
    Given User launch browser and traverse to login page
    When user enter credentials for "Becubic User" role
    And user enters the search text "BAROLETEST1" and clicks on search
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Tags" in "Search results page"
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem          |
      | Click      | Create a tag Button |
      | Enter Text | Test_Add_Tag1       |
    And user "click" on "Save" button in "Create Tag Page"
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type   | url                             | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | tags/Default/tags/Test_Add_Tag1 |      | 204           |                  |          |

      ##7115867####7115869##
  @MLP-24205 @webtest @regression @positive
  Scenario:MLP-24205:SC#4 verify if the user can edit& Delete Business Application
    Given User launch browser and traverse to login page
    When user enter credentials for "Becubic User" role
    And user enters the search text "BAROLETEST1" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BAROLETEST1" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem |
      | Click      | EditBAName |
      | Click      | SaveBAName |
#    And user "Deletes" BA Item "BAROLETEST1" in Item View Page
#    And user "click" on "Confirm" button in "Delete Role Popup"

  ##7115870##
  @MLP-24205 @webtest @regression @positive
  Scenario:SC4#:MLP-24205: Verify that the user can ASSIGN an existing Tag for a Column Item.
    Given User launch browser and traverse to login page
    When user enter credentials for "Becubic User" role
    And user clicks on search icon
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype    | ActionItem     | Section   |
      | Click         | Add Tag Button |           |
      | Tag Selection | State          | Available |
    And user "click" on "Assign" button in "Create Item Page"
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     |
      | Click      | Add Tag Button |
    Then user verify "Presence of Assigned Tag" with following values under "Assigned" section in item search results page
      | State |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name        | type                | query | param |
      | SingleItemDelete | Default | BAROLETEST1 | BusinessApplication |       |       |
