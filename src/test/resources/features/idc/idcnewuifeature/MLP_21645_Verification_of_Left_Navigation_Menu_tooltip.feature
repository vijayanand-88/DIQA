@MLP-21645 @MLP-21827 @MLP-21736 @MLP-21644
Feature:MLP-21645: This feature is to verify the left side menu links

  ##7059284##7059285##
  @webtest @regression @positive
  Scenario: SC#1: Verify if after login the Left Navigational Menus are collapsed by default
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "mouse hover" on "Sidebar Link" for "Home" in "Landing page"
    Then "Left Menu tootip" should be "displayed" as "Home" in "Landing page"
    And user "mouse hover" on "Sidebar Link" for "Admin" in "Landing page"
    And user verifies "Sidebar Admin Links" is "not displayed" in "Landing page"
    And "Left Menu tootip" should be "displayed" as "Admin" in "Landing page"
    And user "mouse hover" on "Sidebar Link" for "Dashboard" in "Landing page"
    And "Left Menu tootip" should be "displayed" as "Dashboard" in "Landing page"

    ##7066735##7064582##7064585##
  @MLP-21827 @webtest @regression @positive
  Scenario: SC#2: MLP-21827: To Verify the user is able to add/Edit the Profile Date for BA item
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                      | body                                                                                      | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/TestGitDS      |                                                                                           |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/BAGitCollector           |                                                                                           |               |                  |          |
      |                  |       |       | Delete | settings/credentials/TestGitCredential                   |                                                                                           |               |                  |          |
      |                  |       |       | Put    | settings/credentials/TestGitCredential?allowUpdate=false | idc/IDx_DataSource_Credentials_Payloads/MLP-14658_Username_Pasword_Credential_Config.json | 200           |                  |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/TestGitDS      | idc/IDX_PluginPayloads/MLP-18457_GitCollector_DataSource_Config.json                      | 204           |                  |          |
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute   | option        |
      | BusinessApplication | SampleGitBA | Save and Open |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem            |
      | Click      | Item view Edit Button |
    And user "Default BA Option selected" in "Item View" Page
      | fieldName    | option  |
      | Profile Date | <empty> |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem              |
      | Click      | Item view Cancel Button |
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And user "click" on "Add Plugin Configuration button" button in "Item View page"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName            | attribute         |
      | Node                 | LocalNode         |
      | Type                 | Collector         |
      | Plugin               | GitCollector      |
      | Data Source          | TestGitDS         |
      | Credential           | TestGitCredential |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute      |
      | Name      | BAGitCollector |
    And user "click" on "Add attribute for Branch" button under "Filter" in Manage Configurations
    And user "click" on "Add entered attribute" button under "FILTERS" in Manage Configurations
    And user "click" on "Test Connection" button in "Add Configuration page"
    And user verifies "Successful datasource connection" is "displayed" in Add Configuration Page
    And user "click" on "ConfigSave" button in "Add Configuration page"

   ##7066736##
  @MLP-21827 @regression @positive @webtest
  Scenario:SC#3:MLP-21827: To Verify the profile date of BA item is updated only after successful run of data plugins
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                         | body | response code | response message |
      | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/BAGitCollector |      | 200           | IDLE             |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/BAGitCollector  |      | 200           |                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/BAGitCollector |      | 200           | IDLE             |
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "SampleGitBA" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "Default BA Option selected" in "Item View" Page
      | fieldName    | option |
      | Profile Date |        |

    ##7067683##7067680##
  @MLP-21736 @webtest @regression @positive
  Scenario:SC#4:MLP-21736: Verify if Manage Access > manage Roles > 'Add Role' screen does not have the below permissions
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Roles" in "Landing page"
    And user "click" on "Add Role" button in "Manage Roles page"
    Then user "verify non presence" of following "permissions" in "Add Role" Page
      | TAG_APPROVE | DATA_APPROVE | DATASET_APPROVE | DATASET_CREATE | ADMIN_WORKFLOW | ADMIN_DATASET | DATASET_DELETE | TAG_SUGGEST | DATASET_MODIFY | UPLOAD_APPROVE | DATASET_REQUEST_ACCESS | ADMIN_CATALOG | DATA_APPROVE | ADMIN_ISSUES | ISSUE_DELETE | ISSUE_CREATE | DATA_ALLVISIBLE |
    And user clicks on "Close popup" link in the "Add Role Popup"
    And user "click" on "Manage Roles Edit Button" for "System Administrator" in "Manage Roles page"
    Then user "verify non presence" of following "permissions" in "Add Role" Page
      | TAG_APPROVE | DATA_APPROVE | DATASET_APPROVE | DATASET_CREATE | ADMIN_WORKFLOW | ADMIN_DATASET | DATASET_DELETE | TAG_SUGGEST | DATASET_MODIFY | UPLOAD_APPROVE | DATASET_REQUEST_ACCESS | ADMIN_CATALOG | DATA_APPROVE | ADMIN_ISSUES | ISSUE_DELETE | ISSUE_CREATE | DATA_ALLVISIBLE |
    And user clicks on "Close popup" link in the "Add Role Popup"
    And user "click" on "Manage Roles Edit Button" for "Guest User" in "Manage Roles page"
    Then user "verify non presence" of following "permissions" in "Add Role" Page
      | TAG_APPROVE | DATA_APPROVE | DATASET_APPROVE | DATASET_CREATE | ADMIN_WORKFLOW | ADMIN_DATASET | DATASET_DELETE | TAG_SUGGEST | DATASET_MODIFY | UPLOAD_APPROVE | DATASET_REQUEST_ACCESS | ADMIN_CATALOG | DATA_APPROVE | ADMIN_ISSUES | ISSUE_DELETE | ISSUE_CREATE | DATA_ALLVISIBLE |
    And user clicks on "Close popup" link in the "Add Role Popup"
    And user "click" on "Manage Roles Edit Button" for "Data Administrator" in "Manage Roles page"
    Then user "verify non presence" of following "permissions" in "Add Role" Page
      | TAG_APPROVE | DATA_APPROVE | DATASET_APPROVE | DATASET_CREATE | ADMIN_WORKFLOW | ADMIN_DATASET | DATASET_DELETE | TAG_SUGGEST | DATASET_MODIFY | UPLOAD_APPROVE | DATASET_REQUEST_ACCESS | ADMIN_CATALOG | DATA_APPROVE | ADMIN_ISSUES | ISSUE_DELETE | ISSUE_CREATE | DATA_ALLVISIBLE |

  ##7058464##7058467##7058480##7058528##7058529##7058530##
  @MLP-21818 @webtest @regression @positive
  Scenario:SC#5:MLP-21818: Verify the user is able to View Department and Business line attributes under Business tab of Details Widgets
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "SampleGitBA" and clicks on search
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem            |
      | Click      | Item view Edit Button |
    Then user "verify Item View page attributes" section has following values
      | Department | Business Line |
    And User performs following actions in the Item view Page
      | Actiontype                | ActionItem           | ItemName      | Section |
      | Click                     | Completeness         | Details       |         |
      | Store Completeness width  | Business             |               |         |
      | Enter Text                | BA Attribute textbox | Business Line | Field   |
      | verifies field is textbox | Department           |               |         |
      | verifies field is textbox | Business Line        |               |         |
    And User performs following actions in the Item view Page
      | Actiontype                             | ActionItem            |
      | Click                                  | Item view Save Button |
      | verify Completeness width is increased | Business              |
    And User performs following actions in the Item view Page
      | Actiontype               | ActionItem            | ItemName   | Section              |
      | Click                    | Item view Edit Button |            |                      |
      | Store Completeness width | Business              |            |                      |
      | Enter Text               | BA Attribute textbox  | Department | Field for Department |
    And User performs following actions in the Item view Page
      | Actiontype                             | ActionItem            |
      | Click                                  | Item view Save Button |
      | verify Completeness width is increased | Business              |

  @MLP-19024 @regression @positive
  Scenario:Delete the BA
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name        | type                | query | param |
      | SingleItemDelete | Default | SampleGitBA | BusinessApplication |       |       |