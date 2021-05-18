@MLP-2513
Feature: MLP-2513 Verification Of Plugin Manager

  @webtest @MLP-2513 @positive @pluginManager
  Scenario: MLP-2513_Verification of Plugin Manger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user validate Plugin Manager widget is displayed
    And Definition "Manage your nodes and plugins here" should be displayed in Plugin Manager
#    And Description "Plugin manager: assign and configure plugins" should be displayed under Plugin Manager
    And Quick Links for Plugin Manager should be displayed on the Dashboard
    And RECENT label for Plugin Manager should be displayed on the Dashboard
    And user click Plugin Manager resize button
    And user select "1 x 2" from resize widget list
    And user click Plugin Manager resize button
    And Widget size "1 x 2" should be highlighted in widget resize menu list
    And user select "1 x 1" from resize widget list
    And user click Plugin Manager resize button
    Then Widget size "1 x 1" should be highlighted in widget resize menu list

#  @webtest @MLP-2513 @positive @regression @pluginManager
#  Scenario: MLP-2513 Verification of Node monitor showing all configs of selected plugin
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on plugin monitor icon for Node "Cluster Demo"
#    And verify "CLUSTER DEMO" node name is displayed under node configuration panel
#    Then user validates the label in the node configuration panel
#      | configurationLabelList |
#      | FILTER  BY             |
#      | Plugin                 |
#      | Type                   |
#      | Status                 |
#    And user verifies the label "CONFIGURATIONS" in New node panel
#    And user should be able logoff the IDC

#  @webtest @MLP-2513 @positive @regression @pluginManager
#  Scenario: MLP-2513 Verification of filter by Type functionality in node monitor panel
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on plugin monitor icon for Node "Cluster Demo"
#    And user selects the following values in the Node monitor panel
#      | configurationPluginField | configurationFieldValue |
#      | Type                     | cataloger               |
#    Then user verifies the displayed plugin list with "HDFSCATALOGER" type
#    And user verifies the displayed plugin list with "HIVECATALOGER" type
#    And user should be able logoff the IDC

#  @webtest @MLP-2513 @positive @regression @pluginManager
#  Scenario: MLP-2513 Verification of filter by Status functionality in node monitor panel
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on plugin monitor icon for Node "Cluster Demo"
#    And user selects the following values in the Node monitor panel
#      | configurationPluginField | configurationFieldValue |
#      | Status                   | IDLE                    |
#    Then user verifies the displayed plugin list with "IDLE" Status
#    And user selects the following values in the Node monitor panel
#      | configurationPluginField | configurationFieldValue |
#      | Status                   | RUNNING                 |
#    And user verifies the displayed plugin list with "RUNNING" Status
#    And user clicks on logout button

#  @webtest @MLP-2513 @positive @regression @pluginManager
#  Scenario: MLP-2513 Verification of filter by Plugin name functionality in node monitor panel
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on plugin monitor icon for Node "Cluster Demo"
#    And user selects the following values in the Node monitor panel
#      | configurationPluginField | configurationFieldValue |
#      | Plugin                   | HdfsCataloger           |
##    Then user verifies the "Plugin Name" field is read only
##    And user verifies the "Plugin Type" field is read only
#    Then user verifies the following in the Plugin monitor
#      | status | pluginName    |
#      | IDLE   | HDFSCATALOGER |
#    And user verifies whether the "start" button is "enabled" for "HDFSCATALOGER" Plugin
#    And user verifies whether the "stop" button is "disabled" for "HDFSCATALOGER" Plugin
#    And user clicks on "start" button for "HDFSCATALOGER" Plugin
##    And user verifies whether the "stop" button is "enabled" for "HDFSCATALOGER" Plugin
#    And user clicks on logout button

#  @webtest @MLP-2513 @positive @regression @pluginManager
#  Scenario: MLP-2513 Verification of the status count displayed on the panel
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on plugin monitor icon for Node "Cluster Demo"
#    And user verifies the count for the status "RUNNING"
#    And user verifies the count for the status "IDLE"
#    And user clicks on "start" button for "HIVECATALOGER" Plugin
#    Then Status for "RUNNING" count should be changed when plugin starts
#    And Status for "IDLE" count should be changed when plugin starts
#    And user clicks on logout button

#  @webtest @MLP-2513 @positive @regression @pluginManager
#  Scenario: MLP-2513 Verification of filtering the ALL plugins by changing the status
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user gets the plugin count from the node list for "Cluster Demo"
#    And user clicks on plugin monitor icon for Node "Cluster Demo"
#    And user selects the following values in the Node monitor panel
#      | configurationPluginField | configurationFieldValue |
#      | Plugin                   | All                     |
#      | Type                     | All                     |
#    Then user verifies that both the plugins count and displayed plugins in monitor panel are same
#    And user clicks on logout button

#  @webtest @MLP-2513 @positive @regression @pluginManager
#  Scenario: MLP-2513 Verification of selecting a plugin with different type
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user gets the plugin count from the node list for "Cluster Demo"
#    And user clicks on plugin monitor icon for Node "Cluster Demo"
#    And user selects the following values in the Node monitor panel
#      | configurationPluginField | configurationFieldValue |
#      | Plugin                   | HdfsCataloger           |
#    Then user verifies the displayed plugin list with "HDFSCATALOGER" type
#    And user selects the following values in the Node monitor panel
#      | configurationPluginField | configurationFieldValue |
#      | Type                     | parser                  |
#    And user verifies that the monitor panel should be empty
#    And user selects the following values in the Node monitor panel
#      | configurationPluginField | configurationFieldValue |
#      | Type                     | All                     |
#    And user selects the following values in the Node monitor panel
#      | configurationPluginField | configurationFieldValue |
#      | Plugin                   | All                     |
#    And user verifies that both the plugins count and displayed plugins in monitor panel are same
#    And user selects the following values in the Node monitor panel
#      | configurationPluginField | configurationFieldValue |
#      | Type                     | cataloger               |
#    And user verifies the displayed plugin list with "HDFSCATALOGER" type
#    And user verifies the displayed plugin list with "HIVECATALOGER" type
#    And user selects the following values in the Node monitor panel
#      | configurationPluginField | configurationFieldValue |
#      | Type                     | All                     |
#    And user selects the following values in the Node monitor panel
#      | configurationPluginField | configurationFieldValue |
#      | Plugin                   | HiveQueryParser         |
#    And user verifies the displayed plugin list with "QUERYPARSER" type
#    And user selects the following values in the Node monitor panel
#      | configurationPluginField | configurationFieldValue |
#      | Type                     | dataanalyzer            |
#    And user verifies that the monitor panel should be empty
#    And user clicks on logout button