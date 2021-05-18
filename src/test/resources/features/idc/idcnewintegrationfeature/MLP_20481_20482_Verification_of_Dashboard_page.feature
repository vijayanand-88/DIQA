@MLP-20481 @MLP-20482
Feature: MLP-20481: Verification of api calls against dashboards

  @MLP-20481 @webtest @regression @positive
  Scenario:MLP-20481: Create Dashboard
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Add Dashboard" in "Landing page"
    And user "enter text" in "Landing Page"
      | fieldName      | actionItem     |
      | Dashboard Name | Auto_Dashboard |
    And user "click" in "Landing Page"
      | fieldName              | actionItem    |
      | Dashboard toolbar Icon | Add Widget    |
      | Select Widget          | Data Elements |
      | Dashboard toolbar Icon | Add Widget    |
      | Select Widget          | Tagged Items  |
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"

  ##7032378##
  @MLP-20481 @regression @positive @dashboard
  Scenario: SC#1: MLP-20481: To get the Dashboard list in Application using swagger-ui GET/dashboards
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/dashboards"
    Then Status code 200 must be returned
    Then Json response message should contains the following value
      | responseMessage |
      | Data Landscape  |
      | Auto_Dashboard  |

   ##7032380##
  @MLP-20481 @regression @positive @dashboard
  Scenario: SC#2: MLP-20481: To verify the specific of  widget of dahbaord by dashboard name
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "dashboards/Auto_Dashboard"
    Then Status code 200 must be returned
    And user verifies whether the value is present in response using json path "$..['title']"
      | jsonValues    |
      | Data Elements |
      | Tagged Items  |

  ##7032379##
  @MLP-20481 @regression @positive @dashboard
  Scenario: SC#3: MLP-20481: To get the list of Widgets in all dashboard by API
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | dashboards/widgets |      | 200           |                  |          |

    ##7034151##
  @MLP-20482 @regression @positive @dashboard
  Scenario:SC#4: MLP-20482: To verify the PUT dashboards
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                       | body                                           | response code | response message | jsonPath |
      | application/json |       |       | Put  | dashboards/Auto_Dashboard | idc/IDxPayloads/MLP_20482_Update_dashoard.json | 200           |                  |          |

    ##7034152##
  @MLP-20481 @webtest @regression @positive
  Scenario:MLP-20481: To Verify the edited Dashboard and its widget is reflected in API , is reflected in UI
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard dropdown" button in "Dashboard page"
    And user "click" on "Dashboard list" for "Auto_Dashboard" in "Dashboard page"
    And user "verifies widgets" in "Dashboard Page"
      | fieldName            |
      | Data Elements Edited |
