Feature:20981: This feature is to verify Default Dashboard widgets which show tag metrics

# 7053219 # 7053222 # 7053223
  @MLP-20981 @webtest @regression @positive
  Scenario:MLP-20981:SC#1_Verify the user is able to configure the count widgets for Tagged Items in add and Edit Dashboard
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" in "Landing Page"
      | fieldName                   | actionItem    | itemName       |
      | Select preconfigured Widget | Table Widgets | Most Used Tags |
    Then user validtes widget present in DashBoard
      | actionType               | elementName            |
      | Validate DashBoardWidget | MostUsedTagsDescending |

    # 7053226 # 7053227
  @MLP-20981 @webtest @regression @positive
  Scenario:MLP-20981:SC#2_Verify the user is able to configure the count widgets for Tagged Items in add and Edit Dashboard
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" in "Landing Page"
      | fieldName                   | actionItem    | itemName        |
      | Select preconfigured Widget | Table Widgets | Least Used Tags |
    And user validtes widget present in DashBoard
      | actionType               | elementName             |
      | Validate DashBoardWidget | LeastUsedTagsDescending |
    And user "click" in "Landing Page"
      | fieldName                   | actionItem    | itemName                         |
      | Select preconfigured Widget | Table Widgets | Number of Tags for each Category |
    Then user validtes widget present in DashBoard
      | actionType               | elementName   | ItemName                         |
      | Validate DashBoardWidget | Verify Widget | Number of Tags for each Category |


    # 7053228
  @MLP-20981 @webtest @regression @positive
  Scenario:MLP-20981:SC#3_Verify Most Used Tags are limited to 10
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" in "Landing Page"
      | fieldName                   | actionItem    | itemName       |
      | Select preconfigured Widget | Table Widgets | Most Used Tags |
    Then user validtes widget present in DashBoard
      | actionType               | elementName      |
      | Validate DashBoardWidget | MostUsedTagsSize |

    # 7053228
  @MLP-20981 @webtest @regression @positive
  Scenario:MLP-20981:SC#4_Verify Most Used Tags are limited to 10
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" in "Landing Page"
      | fieldName                   | actionItem    | itemName        |
      | Select preconfigured Widget | Table Widgets | Least Used Tags |
    Then user validtes widget present in DashBoard
      | actionType               | elementName       |
      | Validate DashBoardWidget | LeastUsedTagsSize |
