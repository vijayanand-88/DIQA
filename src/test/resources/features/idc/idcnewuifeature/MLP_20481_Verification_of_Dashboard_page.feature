@MLP-20481 @MLP-20482 @MLP-20483 @MLP-20484
Feature:MLP-20481: This feature is to verify the List available dashboards and show a dashboard in readOnly mode

  ##7042678##
  @MLP-20481 @webtest @regression @positive
  Scenario:MLP-20481: Create Dashboard
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Add Dashboard" in "Landing page"
    And user "enter text" in "Landing Page"
      | fieldName      | actionItem    |
      | Dashboard Name | TestDashboard |
    And user "click" in "Landing Page"
      | fieldName              | actionItem            |
      | Dashboard toolbar Icon | Add Widget            |
      | Select Widget          | Business Applications |
      | Dashboard toolbar Icon | Add Widget            |
      | Select Widget          | Most Used Tags        |
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"

   ##7032372##7032373##7032374##7032375##7032376##7032377##7042677##
  @MLP-20481 @webtest @regression @positive
  Scenario: SC1#:MLP-20481: Verify the all the existing Dashboard is listed in the dashboard dropdown list
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard dropdown" button in "Dashboard page"
    And user "verifies presence" of following "Dashboard dropdown list" in "Dashboard" page
      | Data Landscape |
      | TestDashboard  |
    And user "verifies presence" of following "preselected Dashboard is the first option" in "Dashboard" page
      | Data Landscape |
    And user "click" on "Dashboard list" for "TestDashboard" in "Dashboard page"
    And user "verifies presence" of following "Dashboard widget count" in "Dashboard" page
      | 2 |
    And user "verifies widgets" in "Dashboard Page"
      | fieldName             |
      | Business Applications |
      | Most Used Tags        |
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" in "Landing Page"
      | fieldName              | actionItem                       |
      | Dashboard toolbar Icon | Add Widget                       |
      | Select Widget          | Number of Tags for each Category |
    And user "verifies presence" of following "Dashboard widget count" in "Dashboard" page
      | 3 |
    And user "click" on "Widget settings Icon" for "Most Used Tags" in "Dashboard page"
    And user "enter text" in "Widget Edit Page"
      | fieldName            | actionItem            |
      | Widget title textbox | Most Used Tags Edited |
    And user "click" on "SAVE" button in "Widget edit page"
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user "verifies widgets" in "Dashboard Page"
      | fieldName             |
      | Most Used Tags Edited |


  ##7034143##7034145##7034147##7034148##7034150##7042681## ##7032530##7032531##
  @MLP-20482 @webtest @regression @positive
  Scenario: SC2#:MLP-20482: Verify the edit/remove feature of Dashboard
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard dropdown" button in "Dashboard page"
    And user "click" on "Dashboard list" for "TestDashboard" in "Dashboard page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" on "Widget Remove Icon" for "Most Used Tags" in "Dashboard page"
    And user verifies the "Delete Widget" pop up is "displayed"
    And user "click" on "CANCEL" button in "Unsaved changes pop up"
    And user "click" on "Dashboard toolbar Icon" for "Reset Dashboard" in "Landing page"
    And user "verifies widgets" in "Dashboard Page"
      | fieldName                        |
      | Most Used Tags Edited            |
      | Number of Tags for each Category |
      | Business Applications            |
    And user "click" on "Dashboard settings Icon" button in "Dashboard page"
    And user "enter text" in "Landing Page"
      | fieldName      | actionItem           |
      | Dashboard Name | TestDashboard Edited |
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user "click" on "Dashboard dropdown" button in "Dashboard page"
    And user "verifies presence" of following "Dashboard dropdown list" in "Dashboard" page
      | TestDashboard Edited |
    And user "click" on "Dashboard list" for "TestDashboard Edited" in "Dashboard page"
    And user "click" on "Dashboard settings Icon" button in "Dashboard page"
    And user "enter text" in "Landing Page"
      | fieldName      | actionItem    |
      | Dashboard Name | TestDashboard |
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" on "Widget Remove Icon" for "Most Used Tags Edited" in "Dashboard page"
    And user verifies the "Delete Widget" pop up is "displayed"
    And user "click" on "DELETE" button in "Unsaved changes pop up"
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user "verifies widgets absence" in "Dashboard Page"
      | fieldName             |
      | Most Used Tags Edited |
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" on "Widget Remove Icon" for "Number of Tags for each Category" in "Dashboard page"
    And user verifies the "Delete Widget" pop up is "displayed"
    And user "click" on "DELETE" button in "Unsaved changes pop up"
    And user "click" on "Widget Remove Icon" for "Business Applications" in "Dashboard page"
    And user verifies the "Delete Widget" pop up is "displayed"
    And user "click" on "DELETE" button in "Unsaved changes pop up"
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user "verifies widgets absence" in "Dashboard Page"
      | fieldName                        |
      | Business Applications            |
      | Number of Tags for each Category |

    ##7032528##7032532##
  @MLP-20483 @webtest @regression @positive
  Scenario:SC4#:MLP-20483: Verify the user is able to delete the dashboard with widgets
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard dropdown" button in "Dashboard page"
    And user "click" on "Dashboard list" for "TestDashboard" in "Dashboard page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" in "Landing Page"
      | fieldName              | actionItem            |
      | Dashboard toolbar Icon | Add Widget            |
      | Select Widget          | Business Applications |
      | Dashboard toolbar Icon | Add Widget            |
      | Select Widget          | Most Used Tags        |
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" on "Dashboard toolbar Icon" for "Remove Dashboard" in "Landing page"
    And user "click" on "DELETE" button in "Delete Dashboard pop up"
    And user "click" on "Dashboard dropdown" button in "Dashboard page"
    And user "verifies dashboard absence in dropdown" in "Dashboard Page"
      | fieldName     |
      | TestDashboard |

  @MLP-20484 @webtest @regression @positive
  Scenario:MLP-20484: Create Sample Dashboard
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Add Dashboard" in "Landing page"
    And user "enter text" in "Landing Page"
      | fieldName      | actionItem      |
      | Dashboard Name | SampleDashboard |
    And user "click" in "Landing Page"
      | fieldName              | actionItem            |
      | Dashboard toolbar Icon | Add Widget            |
      | Select Widget          | Business Applications |
      | Dashboard toolbar Icon | Add Widget            |
      | Select Widget          | Most Used Tags        |
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"

 ##7042674##7042675##7042676##7042679##7042680##7042686##
  @MLP-20484 @webtest @regression @positive
  Scenario:SC5#:MLP-20484: Verify the save button is enabled only after entering the details in add widget panel
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard dropdown" button in "Dashboard page"
    And user "click" on "Dashboard list" for "SampleDashboard" in "Dashboard page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user verifies "Dashboard Save Button" is "disabled" in "Dashboard Configuration page"
    And user "enter text" in "Landing Page"
      | fieldName      | actionItem             |
      | Dashboard Name | Sampledashboard Edited |
    And user verifies "Dashboard Save Button" is "enabled" in "Dashboard Configuration page"
    And user verifies "Configuration dashboard widget panel" is "displayed" in "Dashboard Configuration page"
    And user "click" on "Close popup" button in "UnSaved Changes pop up"
    And user verifies "Configuration dashboard widget panel" is "displayed" in "Dashboard Configuration page"

  ##7042685##
  @MLP-20484 @webtest @regression @positive
  Scenario:SC6#:MLP-20484: Verify the user is able to view the Pre configured widgets as Table, Count and chart widget"
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard dropdown" button in "Dashboard page"
    And user "click" on "Dashboard list" for "SampleDashboard" in "Dashboard page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" in "Landing Page"
      | fieldName              | actionItem |
      | Dashboard toolbar Icon | Add Widget |
    And user "verifies preconfigured widgets" in "Dashboard Page"
      | fieldName     |
      | Count Widgets |
      | Table Widgets |
      | Chart Widgets |

  @MLP-20484 @webtest @regression @positive
  Scenario:SC7#:MLP-20484: Delete SampleDashboard
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard dropdown" button in "Dashboard page"
    And user "click" on "Dashboard list" for "SampleDashboard" in "Dashboard page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" on "Dashboard toolbar Icon" for "Remove Dashboard" in "Landing page"
    And user "click" on "DELETE" button in "Delete Dashboard popup"
    And user "click" on "Dashboard dropdown" button in "Dashboard page"
    And user "verifies dashboard absence in dropdown" in "Dashboard Page"
      | fieldName       |
      | SampleDashboard |
