@MLP-24164 @MLP-24165
Feature:MLP_24164_MLP_24165: This feature is to verify the notifications page

  ##7118946##7119006##7119007##7119008##7119009##7245693
  @MLP-24164 @webtest @regression @positive @e2e
  Scenario:SC#1:MLP-24164:Verify user able to see the show more icon and Edit icon in BA Item view for TestSystem Administrator
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And User performs following actions in the Manage Notifications Page
      | Actiontype      | ActionItem                                     | ItemName |
      | Verify Presence | Notification bell Icon with notification count |          |
      | Click           | Notification bell Icon                         |          |
      | Verify Presence | Manage Notifications page                      |          |
      | Verify Presence | Left panel with Notifications list             |          |
      | Verify Presence | Right Panel with Notification content          | content  |

  ##7119010##7119011##7119012##7245694
  @MLP-24164 @webtest @regression @positive @e2e
  Scenario:SC#2:MLP-24164:Verify the new or unread notifications are displayed with a unread icon(blue circle icon)
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And User performs following actions in the Manage Notifications Page
      | Actiontype      | ActionItem                                |
      | Click           | Notification bell Icon                    |
      | Verify Presence | Blue circle Icon for unread notifications |
    And user "verifies presence" of following "Notification Filter Labels" in "Notifications" page
      | Viewing |
      | Sort By |
    And User performs following actions in the Manage Notifications Page
      | Actiontype      | ActionItem            |
      | Verify Presence | Mark As read Dropdown |

  ##7119013##7119014##7119015##  @e2e
  @MLP-24164 @webtest @regression @positive @e2e
  Scenario:SC#3:MLP-24164: Verify when clicking on any of the new notification from the list, the unread icon will be disappeared
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                             | body                                                                 | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/credentials/GitCred                    |                                                                      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS |                                                                      |               |                  |          |              |          |
      |                  |       |       | Put    | settings/credentials/GitCred                    | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | 200           |                  |          |              |          |
      |                  |       |       | Get    | settings/credentials/GitCred                    |                                                                      | 200           |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/GitDS | idc/IDX_PluginPayloads/MLP-14102_GitCollector_DataSource_Config.json | 204           |                  |          |              |          |
      |                  |       |       | Get    | settings/analyzers/GitCollectorDataSource/GitDS |                                                                      | 200           | GitDS            |          |              |          |
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And User performs following actions in the Manage Notifications Page
      | Actiontype      | ActionItem                              | ItemName                                                                                                             |
      | Click           | Notification bell Icon                  |                                                                                                                      |
      | Click           | First notification in List              |                                                                                                                      |
      | Verify Absence  | Blue circle Icon for first notification |                                                                                                                      |
      | Verify Presence | Active Green label for notification     |                                                                                                                      |
      | Verify Presence | Notification Title and Content          | Analyser Configuration GitCollectorDataSource changed,Analyser Configuration GitCollectorDataSource has been changed |

  ##7119016##7119017##7119018##  @e2e
  @MLP-24164 @webtest @regression @positive  @e2e
  Scenario:SC#4:MLP-24164: Verify clicking the link from the notification content, takes the user to the appropriate item view
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute    | option        |
      | BusinessApplication | Test BA Item | Save and Open |
    And User performs following actions in the Manage Notifications Page
      | Actiontype      | ActionItem                                        | ItemName                             |
      | Click           | Notification bell Icon                            |                                      |
      | Verify Presence | Default Notification content                      |                                      |
      | Verify Presence | Profile Icon                                      | Invitation to a Business Application |
      | Click           | Notification                                      | Invitation to a Business Application |
      | Click           | Business Application Link in notification content |                                      |
    And user verifies whether "Item view page title" is "displayed" for "Test BA Item" Item view page

  @e2e
  Scenario:Delete the BA Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name         | type                | query | param |
      | SingleItemDelete | Default | Test BA Item | BusinessApplication |       |       |

    ## MLP-24165 - To the integrate notification related services for Manage Notification screen. and verifying the filter options

  ##7119281##7119282##7119285##7119287##7119288##
  @MLP-24165 @webtest @regression @positive  @e2e
  Scenario:SC#5:MLP-24165: Verify clicking the link from the notification content, takes the user to the appropriate item view
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And User performs following actions in the Manage Notifications Page
      | Actiontype                                    | ActionItem             | ItemName | Attribute |
      | Click                                         | Notification bell Icon |          |           |
      | Click                                         | Notification Filters   | Viewing  | Unread    |
      | Verify List contains only unread notification |                        |          |           |
      | Store notification count                      |                        |          |           |
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute    | option |
      | BusinessApplication | Test BA Item | Save   |
    And User performs following actions in the Manage Notifications Page
      | Actiontype                                    | ActionItem                            | ItemName             | Attribute        |
      | Click                                         |                                       | Mark As read/Refresh | Refresh          |
      | Verify the notification with the stored count |                                       |                      |                  |
      | Click                                         |                                       | Mark As read/Refresh | Mark All as Read |
      | Verify Absence                                | Blue Circle Icon in All Notifications |                      |                  |
      | Verify Presence                               | Label in Notification list panel      | From Last 30 Days    |                  |

  @e2e
  Scenario:Delete the BA Item for Test BA Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name         | type                | query | param |
      | SingleItemDelete | Default | Test BA Item | BusinessApplication |       |       |