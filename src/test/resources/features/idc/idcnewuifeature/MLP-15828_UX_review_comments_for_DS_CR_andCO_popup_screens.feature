@MLP-15828 @MLP-15939
Feature: A_MLP-15828: To address UX review comments for data source, credential and
  configuration popup screens.Manage DataSource & Credentials - Search UX review and Manage DataSource & Credentials - Search UX review

  @git
  Scenario: Create Datasource Credentials and Configuration for GitCollector
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                             | username    | password    |
      | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | $..userName | $..password |
    And Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                | body                                                                 | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/credentials/GitCred                       |                                                                      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS    |                                                                      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/GitCollectorConfig |                                                                      |               |                  |          |              |          |
      |                  |       |       | Put    | settings/credentials/GitCred                       | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | 200           |                  |          |              |          |
      |                  |       |       | Get    | settings/credentials/GitCred                       |                                                                      | 200           |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/GitDS    | idc/IDX_PluginPayloads/MLP-14102_GitCollector_DataSource_Config.json | 204           |                  |          |              |          |
      |                  |       |       | Get    | settings/analyzers/GitCollectorDataSource/GitDS    |                                                                      | 200           |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollector/GitCollectorConfig | idc/IDX_PluginPayloads/MLP-14104_GitCollector_Plugin_Config.json     | 204           |                  |          |              |          |

  ##6874954##
  @MLP-15828 @webtest @positive
  Scenario: SC#1:Verify that "Edit Configuration" is displayed as header in the configuration edit pop over instead of "Update Configuration".
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion and click menu option" operation in Manage Configurations panel
      | button    | actionItem | attribute          | itemName               |
      | LocalNode | Collector  | GitCollectorConfig | Edit the configuration |
    And user verifies "Edit Configuration to LocalNode Page" is "displayed"

  ##6875698##
  @MLP-15828 @webtest @positive
  Scenario: SC#2:Verify that cloned configuration pop over header is displayed as "Clone Configuration".
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion and click menu option" operation in Manage Configurations panel
      | button    | actionItem | attribute          | itemName                |
      | LocalNode | Collector  | GitCollectorConfig | Clone the configuration |
    And user verifies "Clone Configuration to LocalNode" is "displayed"

   ##6874419##
  @MLP-15828 @webtest @positive
  Scenario: SC#3:Verify that the label "Plugin" is displayed instead of "Plugin Name" in the Add Configuration pop over.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Type      | Cataloger |
    And user verifies "Plugin" is "displayed"

   ##6886918##
  @MLP-15828 @webtest @positive
  Scenario: SC#4:Verify that cloned Credential pop over header is displayed as "Clone Credential".
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Credentials" in "Landing page"
    And user "click" on "Add Credentials Button in Manage Credentials Page" button in "Manage Data Source page"
    And user "select dropdown" in Add Credentials Page
      | fieldName | attribute         |
      | Type      | Username/Password |
    And user "enter text" in Add Credentials Page
      | fieldName | attribute     |
      | Name      | QA Credential |
      | User Name | postgres      |
      | Password  | postgres      |
    And user "click" on "Save" button in "Add Credential pop up"
    And user "click configuration menu buttons" in "Manage Configurations" Page
      | fieldName            | option        |
      | Clone the credential | QA Credential |
    And user verifies "Clone Credential" is "displayed"

   ##6875721##
  @MLP-15828 @webtest @positive
  Scenario: SC#5:Verify that "Edit Credential" is displayed as header in the configuration edit pop over instead of "Update Credential".
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Credentials" in "Landing page"
    And user "click configuration menu buttons" in "Manage Configurations" Page
      | fieldName            | option        |
      | Edit the credential | QA Credential |
    And user verifies "Edit Credential" is "displayed"

   ##6874526##
  @MLP-15828 @webtest @positive
  Scenario: SC#6:Verify that the type dropdown items are displayed in Alphabetical Order in Add Configuration pop over .
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "verifies sorting order" of following "Configuration Types are in Ascending Order" in "Manage Configuration" page
      |  |

    ##6874594##
  @MLP-15828 @webtest @positive
  Scenario: SC#7:Verify that the plugin dropdown items are displayed in Alphabetical Order in Add Configuration pop over.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Type      | Cataloger |
    And user "verifies sorting order" of following "Plugins are in Ascending Order" in "Manage Configuration" page
      |  |

    ##6874808##
  @MLP-15828 @webtest @positive
  Scenario: SC#8:Verify that the Data Source Type dropdown items are displayed in Alphabetical Order Add Data Source pop over.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Source page"
    And user "verifies sorting order" of following "Data Source Types are in Ascending Order" in "Manage DataSource" page
      |  |

#    ##6878419## ##Issue is there need to provide the fix##
#  @MLP-15828 @webtest @positive
#  Scenario: SC#9:Verify that the Type DD in the Manage Credentails page displays the items in Alphabetical Order.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType  | actionItem          |
#      | click | Settings Icon       |
#      | click       | Manage Credentials |
#    And user "click" on "Add Credentials Button in Manage Credentials Page" button in "Manage Data Source page"
#    And user "verifies sorting order" of following "Credentials Types are in Ascending Order" in "Manage DataSource" page
#      |  |


  ##6875680##
  @MLP-15828 @webtest @positive
  Scenario: SC#10:Verify that the contextual message on Add Configuration is displayed as "Select the plugin type and enter details to add a configuration."
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user verifies "Select the plugin type and enter details to add a configuration." is "displayed"

  ##6874644##
  @MLP-15828 @webtest @positive
  Scenario: SC#11:Verify that the contextual message on Add data Source is displayed as "Enter details for a data source and credential. Then test that connection."
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Source page"
    And user verifies "Enter details for a data source and credential. Then test that connection." is "displayed"

    ##6875669##
  @MLP-15828 @webtest @positive
  Scenario: SC#12:Verify that "Edit Data Source" is displayed as header in the data source edit pop over instead of "Update Data Source".
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollectorDataSource/TestDS"
    And supply payload with file name "/idc/IDx_DataSource_Credentials_Payloads/MLP-15828_GitCollectorDS_Config.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/GitCollectorDataSource/TestDS" with the following query param
      | raw | false |
    And Status code 204 must be returned
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And user "click configuration menu buttons" in "Manage Configurations" Page
      | fieldName            | option |
      | Edit the data source | TestDS |
    And user verifies "Edit Data Source" is "displayed"

   ##6875676##
  @MLP-15828 @webtest @positive
  Scenario: SC#13:Verify that cloned data source pop over header is displayed as "Clone Data Source".
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And user "click configuration menu buttons" in "Manage Configurations" Page
      | fieldName             | option |
      | Clone the data source | TestDS |
    And user verifies "Clone Data Source" is "displayed"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/GitCollectorDataSource/TestDS"

   ##6874481##
  @MLP-15828 @webtest @positive
  Scenario: SC#14:Verify that the place holder text is displayed as "Select plugin" in the Add Configuration pop over for Plugin DD.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Type      | Cataloger |
    And user verifies "Select plugin" is "displayed"

  ##6874779##
  @MLP-15828 @webtest @positive
  Scenario: SC#15:Verify that the place holder text is displayed as "Select data source type" in the Add data Source pop over.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Source page"
    And user verifies "Select data source type" is "displayed"

  ##6878466##
  @MLP-15939 @webtest @positive
  Scenario: SC#1:Verify that the Data Sources table header color is #F5F8FB.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And user "click" on "Filter Icon" button in "Manage Data Sources Page"
    And user verifies the background color of the header
      | StyleType        | ColorCode              | Header       |
      | background-color | rgba(245, 248, 251, 1) | Data Sources |

    ##6888696##
  @MLP-15939 @webtest @positive
  Scenario: SC#2:Verify that the Manage Credentials table header color is #F5F8FB.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Credentials" in "Landing page"
    And user "click" on "Filter Icon" button in "Manage Credentials Page"
    And user verifies the background color of the header
      | StyleType        | ColorCode              | Header      |
      | background-color | rgba(245, 248, 251, 1) | Credentials |

# ##6878469##   ##Descoped##
#  @MLP-15939 @webtest @regression @positive
#  Scenario: SC#3: MLP-13774: Verification of search results with ALL catalog
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#      | click      | Catalog Drop down  |
#    And user verifies "All Catalogs" is "displayed"
#    And user "click" on "Type Drop Down" button in "Add Configurations pop up"
