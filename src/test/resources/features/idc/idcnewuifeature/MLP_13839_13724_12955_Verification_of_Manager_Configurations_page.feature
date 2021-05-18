@MLP-13839 @MLP-13724 @MLP-12955
Feature:MLP-13839 MLP-13724 MLP-12955: This feature is to verify whether as an IDA ADMIN I want to see in my monitoring (to be described in UX) color indicators that I can quickly determine if an error exists and what the severity
  As an IDA ADMIN I want to monitor the status of all levels including; IDA deployments (Deployments), and plugins so that I can have a single view of the state of my IDA ECO system
  As an IDA Admin, I want see completion messages with result for all plugin execution actions without navigation so that I can know immediately if there is success or failure


  ##6810680##6810681## Descoped
#  @MLP-13839 @webtest @regression @positive
#  Scenario:SC#1:MLP-13839: Verify the color indicators depending on the plugin running status
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
#    And user verifies the status of the deployment in Manage Configurations panel
#      | pluginName | status  |
#      | LocalNode  | running |
#    And user "click" on "Filter Icon" in Manage Configurations panel
#    And user selects dropdown in Manage Configurations panel
#      | filterName | attribute |
#      | Deployment | All       |
#    And user performs "click" operation in Manage Configurations panel
#      | button              | actionItem |
#      | Collapse Deployment | LocalNode  |
#      | Open Deployment     | LocalNode  |
#    And user verifies "Table view of configs" is "displayed" in Manage Configurations panel

  @git @precondition
  Scenario: Update Git Cataloger with
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                             | username    | password    |
      | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | $..userName | $..password |
    And Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                | body                                                                 | response code | response message   | jsonPath |
      | application/json | raw   | false | Delete | settings/credentials/GitCred                       |                                                                      |               |                    |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS    |                                                                      |               |                    |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/GitCollectorConfig |                                                                      |               |                    |          |
      |                  |       |       | Put    | settings/credentials/GitCred                       | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | 200           |                    |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/GitDS    | idc/IDX_PluginPayloads/MLP-14102_GitCollector_DataSource_Config.json | 204           |                    |          |
      |                  |       |       | Put    | settings/analyzers/GitCollector/GitCollectorConfig | idc/IDX_PluginPayloads/MLP-15889_GitCollector_Plugin_Config.json     | 204           |                    |          |
      |                  |       |       | Get    | settings/analyzers/GitCollector/GitCollectorConfig |                                                                      | 200           | GitCollectorConfig |          |

    ##Bug id
    ##7108493##7108494##7108499##7108500##7108501##
  @MLP-23675 @webtest @regression @positive
  Scenario:MLP-23675: Verify the discard popup works as expected in manage configurations
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem | attribute          |
      | LocalNode | Collector  | GitCollectorConfig |
    And user "click configuration menu buttons" in "Manage Configurations" Page
      | fieldName              | option             |
      | Edit the configuration | GitCollectorConfig |
    And user "Verifies popup" is "displayed" for "Edit Configuration to LocalNode"
    And user clicks on "Escape" key
    And user "Verifies popup" is "not displayed" for "Unsaved changes"
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And user "click configuration menu buttons" in "Manage Data Sources" Page
      | fieldName            | option |
      | Edit the data source | GitDS  |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                  |
      | URL       | https://source-team.asg.com/scm/di/pythonanalyzerdemo1.git |
    And user clicks on "Escape" key
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Edit Data Source popup"
    And user "click" on "Popup Cancel" button in "Edit Data Source popup"
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Edit Data Source popup"
    And user "click" on "Popup Close" button in "Edit Data Source popup"
    And user "Verifies popup" is "displayed" for "Unsaved changes"

  ##6820190##6820191##6820192##6820193##6820195##
  @MLP-13724 @webtest @regression @positive
  Scenario:SC#2:MLP-13724: Verify the status of all levels including; IDA deployments (Deployments), and plugins so that I can have a single view
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user verifies the status of the deployment in Manage Configurations panel
      | pluginName | status  |
      | LocalNode  | running |
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem | attribute          |
      | LocalNode | Collector  | GitCollectorConfig |
    And user verifies "Staus count and Staus Indicator" is "displayed" in Manage Configurations panel
    And user "click configuration menu buttons" in "Manage Configurations" Page
      | fieldName             | option             |
      | Run the configuration | GitCollectorConfig |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations


  @MLP-12955 @regression @positive
  Scenario:MLP-12955: Configure the Git Collector
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                             | body                                                             | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/GitCollector | idc/IDX_PluginPayloads/MLP-12955_GitCollector_Plugin_Config.json | 204           |                  |          |

   ##6832660##6832661##6832663##6832664##6832665##6832666##6832667##
  @MLP-12955 @webtest @regression @positive
  Scenario:SC#3:MLP-12955: Verify the pop up is displayed after the plugin execution is over
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem | attribute    |
      | LocalNode | Collector  | GitCollector |
    And user "verifies presence" of following "Popup message" in Manage Configurations Page
      | GitCollector has been changed by TestSystem. |
    And user performs "Expand accordion" operation in Manage Configurations panel
      | button    | actionItem | attribute             |
      | LocalNode | Linker     | SimilarityLinkerTable |
    And user "click" on "Capture and Import Data Link" for "Manage Data Sources" in "Landing page"
    And user verifies "plugin completion popup" is "displayed" in "Manage Data Sources Page"
    And user "verifies presence" of following "Popup message" in Manage Configurations Page
      | GitCollector has been changed by TestSystem.          |
      | SimilarityLinkerTable has been changed by TestSystem. |
    And user "click" on "popup close button" in Manage Configurations panel


  Scenario:Delete plugin Configurations ,credentials
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                | body | response code | response message | jsonPath |
      | application/json | raw   | false | Delete | settings/credentials/GitCred                       |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS    |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/GitCollectorConfig |      |               |                  |          |

