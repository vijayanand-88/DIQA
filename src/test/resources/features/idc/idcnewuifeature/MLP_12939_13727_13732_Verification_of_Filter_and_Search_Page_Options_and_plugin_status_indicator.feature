#@MLP-12939 @MLP-13727 @MLP-13732 @MLP-14104
#Feature:MLP-12939 MLP-13727 MLP-13732 MLP-14104: This feature is to verify whether as an IDA Admin, I want to be able to select from a filtered list of available plugins by plugin type  so that I can easily see what I have by type and also easily select for configuration
#  As an IDA ADMIN I want a monitor filter by deployment (Deployment), type, plugin name, catalog, status so that I can have a filtered view of the state of my environment
#  Descoped
#  ##6787932##6787933##6787934##6787935##6787936##6787936##
#  @MLP-12939 @webtest @regression @positive
#  Scenario: SC#1: MLP-12939: Verification of licensing button pops up when user logins for first time
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
#    And user "click" on "Filter Icon" in Manage Configurations panel
#    And user "verifies presence" of following "labels" in Manage Configurations Page
#      | Deployment |
#      | Type       |
#      | Status     |
#    And user selects dropdown in Manage Configurations panel
#      | filterName | attribute |
#      | Deployment | LocalNode |
#    And user "verifies presence" of following "Items displayed for Deployment filter" in Manage Configurations Page
#      | LocalNode |
#    And user selects dropdown in Manage Configurations panel
#      | filterName | attribute |
#      | Deployment | All       |
#    And user "verifies presence" of following "Items displayed for Deployment filter" in Manage Configurations Page
#      | InternalNode |
#      | LocalNode    |
#    And user selects dropdown in Manage Configurations panel
#      | filterName | attribute    |
#      | Type       | All          |
#      | Deployment | InternalNode |
#    And user "verifies presence" of following "Items displayed for Deployment filter" in Manage Configurations Page
#      | InternalNode |
#    And user selects dropdown in Manage Configurations panel
#      | filterName | attribute |
#      | Deployment | All       |
#    And user "click" on "Filter/Search Close Button" in Manage Configurations panel
#    And user "click" on "Search Icon" in Manage Configurations panel
#    And user "enters text" in Manage Configurations panel
#      | TextBox    | Text                  |
#      | Search Box | SimilarityLinkerTable |
#    And user "verifies presence" of following "Items displayed for Configuration Filter" in Manage Configurations Page
#      | SimilarityLinkerTable |
#    And user "enters text" in Manage Configurations panel
#      | TextBox    | Text                  |
#      | Search Box | similaritylinkertable |
#    And user "verifies presence" of following "Items displayed for Configuration Filter" in Manage Configurations Page
#      | SimilarityLinkerTable |
#    And user "enters text" in Manage Configurations panel
#      | TextBox    | Text                  |
#      | Search Box | SIMILARITYLINKERTABLE |
#    And user "verifies presence" of following "Items displayed for Configuration Filter" in Manage Configurations Page
#      | SimilarityLinkerTable |
#    And user "verifies presence" of following "Items displayed for Deployment filter" in Manage Configurations Page
#      | InternalNode |
#      | LocalNode    |
#
##  ##6811213##6811214###descoped
##  @MLP-13727 @webtest @regression @positive
##  Scenario:SC#3: MLP-13727: Verfiy the Filter by catalog and status can be applied to the configurations
##    Given User launch browser and traverse to login page
##    When user enter credentials for "System Administrator1" role
##    And user performs following actions in the sidebar
##      | actionType  | actionItem            |
##      | click | Settings Icon         |
##      | click       | Manage Configurations |
##    And user "click" on "Filter Icon" in Manage Configurations panel
##    And user selects dropdown in Manage Configurations panel
##      | filterName | attribute |
##      | Catalog    | Default   |
##    And user "verifies presence" of following "Items displayed for Catalog Filter" in Manage Configurations Page
##      | Default |
##    And user selects dropdown in Manage Configurations panel
##      | filterName | attribute |
##      | Catalog    | All       |
##      | Status     | STOPPED   |
##    And user verifies "Configuration tables" is "not displayed" in Manage Configurations panel
##    And user selects dropdown in Manage Configurations panel
##      | filterName | attribute |
##      | Status     | All       |
##    And user verifies "Table view of configs" is "displayed" in Manage Configurations panel
#
#    ##6802706##6811142##6802707##
#  @MLP-13732 @webtest @regression @positive
#  Scenario:SC#2:MLP-13732: Verification of plugin and deployment indicator
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
#    And user "click" on "Filter Icon" in Manage Configurations panel
#    And user verifies "Staus count and Staus Indicator" is "displayed" in Manage Configurations panel
#    And user verifies the status of the deployment in Manage Configurations panel
#      | pluginName   | status  |
#      | InternalNode | running |
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for Get request with url "extensions/analyzers/status/InternalNode"
#    Then Status code 200 must be returned
#    Then user compares the following value from response using json path
#      | jsonValues | jsonPath          |
#      | UP         | $..['nodeStatus'] |
#    And user verifies "Status Indicators" is "displayed" in Manage Configurations panel
#
#  ##6802708##
#  @MLP-13732 @webtest @regression @positive
#  Scenario:SC#3:MLP-13732:  Verify whether the count of any status increases/decreases when the status of any of the plugin in the config table gets changed
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type   | url                                                | body                                                              | response code | response message | jsonPath |
#      | application/json | raw   | false | Delete | settings/analyzers/GitCollector/GitCollectorConfig | /idc/IDX_PluginPayloads/MLP-14104_GitCollector_Plugin_Config.json |               |                  |          |
#      |                  |       |       | Put    | settings/analyzers/GitCollector/GitCollectorConfig | /idc/IDX_PluginPayloads/MLP-14104_GitCollector_Plugin_Config.json | 204           |                  |          |
#    And User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
#    And user performs "Expand accordion and click menu option" operation in Manage Configurations panel
#      | button    | actionItem | attribute          | itemName              |
#      | LocalNode | Collector  | GitCollectorConfig | Run the configuration |
#    And user verifies the status count for the deployment "LocalNode" in Manage Configurations page
#      | status  | count |
#      | running | 1     |