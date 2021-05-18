#@MLP-2529
#  Feature: MLP-2529 This feature is to verify the options available for an existing node or new node in Plugin Manager
#
#    @webtest @MLP-2529 @negative
#    Scenario: MLP-2529 Verification of leading and trailing blanks error message while adding a new node
#      Given User launch browser and traverse to login page
#      When user enter credentials for "System Administrator1" role
#      And user clicks on Administration widget
#      And user clicks on Plugin Manager in Administration dashboard
#      And user clicks on Add new node Button in Plugin Management page
#      And user enters "LeadingSpace" in the name field in New node panel
#      Then Error message should get displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
#      And user enters "TrailingSpace" in the name field in New node panel
#      And Error message should get displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
#      And user should be able logoff the IDC
#
#    @webtest @MLP-2529 @negative
#    Scenario: MLP-2529 Verification of Slash and Backslash error message while adding a new node
#      Given User launch browser and traverse to login page
#      When user enter credentials for "System Administrator1" role
#      And user clicks on Administration widget
#      And user clicks on Plugin Manager in Administration dashboard
#      And user clicks on Add new node Button in Plugin Management page
#      And user enters "Forwardslash" in the name field in New node panel
#      Then Error message should get displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
#      And user enters "Backslash" in the name field in New node panel
#      And Error message should get displayed as "Invalid name. Leading/trailing blanks and slash/backslash are forbidden."
#      And user should be able logoff the IDC
#
#    @webtest @MLP-2529 @negative
#    Scenario: MLP-2529 Verification of adding Duplicate Node
#      Given User launch browser and traverse to login page
#      When user enter credentials for "System Administrator1" role
#      And user clicks on Administration widget
#      And user clicks on Plugin Manager in Administration dashboard
#      And user clicks on Add new node Button in Plugin Management page
#      And user enters the node name "Cluster Demo" in the name field
#      Then Error message should get displayed as "This name already exists. Please enter a different one." when duplicate node name is given
#      And user should be able logoff the IDC
#
#    @webtest @MLP-2529 @positive
#    Scenario: MLP-2529 Verification of Unsaved changes notification for a Node
#      Given User launch browser and traverse to login page
#      When user enter credentials for "System Administrator1" role
#      And user clicks on Administration widget
#      And user clicks on Plugin Manager in Administration dashboard
#      And user clicks on Add new node Button in Plugin Management page
#      And user enters the node name "Test Node1" in the name field
#      And user clicks on close button in the panel
#      And user sees pop up content as "You have unsaved changes. Are you sure you want to discard the changes?"
#      Then user clicks on No button in alert message
#      And user verifies new node panel is "Displayed"
#      And user clicks on close button in the panel
#      And user sees pop up content as "You have unsaved changes. Are you sure you want to discard the changes?"
#      And user clicks on Yes button in alert message
#      And user verifies new node panel is "Not Displayed"
#      And user clicks the "Cluster Demo" node in plugin manager panel
#      And user enters the node name "Test Node1" in the name field
#      And user clicks on close button in the panel
#      And user sees pop up content as "You have unsaved changes. Are you sure you want to discard the changes?"
#      And user clicks on No button in alert message
#      And user clicks on close button in the panel
#      And user sees pop up content as "You have unsaved changes. Are you sure you want to discard the changes?"
#      And user clicks on Yes button in alert message
#      And user verifies node "Cluster Demo" is present in the panel without any change
#      And user should be able logoff the IDC
#
#    @webtest @MLP-2529 @positive
#    Scenario: MLP-2529 Verification of available options in Add New Node panel
#      Given User launch browser and traverse to login page
#      When user enter credentials for "System Administrator1" role
#      And user clicks on Administration widget
#      And user clicks on Plugin Manager in Administration dashboard
#      And user clicks on Add new node Button in Plugin Management page
#      Then user verifies the label "NAME" in New node panel
#      And user verifies the label "CATALOG" in New node panel
#      And user verifies the catalog selection box is displayed with text "Please, select catalog"
#      And user verifies the label "AVAILABLE PLUGINS" in New node panel
#      And list of follwoing Plugins should be available
#        | PluginList          |
#        | HiveMonitor         |
#        | HiveCataloger       |
#        | HdfsMonitor         |
#        | HdfsCataloger       |
#        | BigDataAnalyzer     |
#        | HiveDirectoryLinker |
#        | CommonLineage       |
#        | CommonLinker        |
#        | QueryParser         |
#        | MLAnalyzer          |
#        | PythonParser        |
#        | SimilarityLinker    |
#      And user clicks on Plugin checkbox
#      And user verifies whether all the checkboxes are selected under Plugins
#      And user clicks on Assign Button
#      And user verifies the available plugins table is empty
#      And verify all the plugins are displayed under assigned plugins
#      And user should be able logoff the IDC
#
#    @webtest @MLP-2529 @positive
#    Scenario: MLP-2529 Verification of deleting an assigned plugin via Assigned Plugin Table
#      Given User launch browser and traverse to login page
#      When user enter credentials for "System Administrator1" role
#      And user clicks on Administration widget
#      And user clicks on Plugin Manager in Administration dashboard
#      And user clicks on Add new node Button in Plugin Management page
#      And user enters the node name "Test Node" in the name field
#      And user enable "HiveMonitor" plugin check box and click Assign button
#      And user navigate to "HiveMonitor" plugin configuration page
#      And user add button in "HIVE MONITOR CONFIGURATIONS" section
#      And user enters the following values in Plugin Configuration fields
#        | pluginConfigFieldName        | pluginConfigFieldValue |
#        | NAME                         | HiveMonitor            |
#        | LABEL                        | HiveMonitor            |
#        | CATALOG NAME                 | BigData                |
#        | CATALOGER CONFIGURATION NAME | HiveMonitor            |
#      And user enables "AUTO START" checkbox in plugin configuration panel
##      And user enables "ENABLE QUERY PARSER" checkbox in plugin configuration panel
#      And user click Apply button in "PLUGIN CONFIGURATION" page
#      And user click Apply button in "HIVE MONITOR CONFIGURATIONS" page
#      And user click save button in Create New Node page
#      And user clicks on "Test Node" from nodes list
#      And user enable "HiveDirectoryLinker" plugin check box and click Assign button
#      And user navigate to "HiveDirectoryLinker" plugin configuration page
#      And user add button in "HIVE DIRECTORY LINKER CONFIGURATIONS" section
#      And user enters the following values in Plugin Configuration fields
#        | pluginConfigFieldName | pluginConfigFieldValue |
#        | NAME                  | HiveDirectoryLinker    |
#        | LABEL                 | HiveDirectoryLinker    |
#        | CATALOG NAME          | BigData                |
#      And user enables "AUTO START" checkbox in plugin configuration panel
#      And user click Apply button in "PLUGIN CONFIGURATION" page
#      And user click Apply button in "HIVE DIRECTORY LINKER CONFIGURATIONS" page
#      And user click save button in Create New Node page
#      Then user verifies the plugin count for node "Test Node" is displayed as "2"
#      And user clicks on "Test Node" from nodes list
#      And user clicks on x button for any of the plugin under assigned plugins
#      And user clicks on Yes button in alert message
#      And user click save button in Create New Node page
#      And user verifies the plugin count for node "Test Node" is displayed as "1"
#
#    @webtest @MLP-2529 @positive
#    Scenario: MLP-2529 Verification of deleting an existing node
#      Given User launch browser and traverse to login page
#      When user enter credentials for "System Administrator1" role
#      And user clicks on Administration widget
#      And user clicks on Plugin Manager in Administration dashboard
#      And user clicks on Add new node Button in Plugin Management page
#      And user enters the node name "Test Node" in the name field
#      And user click save button in Create New Node page
#      And user clicks on "Test Node" from nodes list
#      And user sees panel with "TEST NODE" node name on header
#      And user clicks on Delete button in the Edit Node panel
#      Then user sees pop up content as "Are you sure you want to delete?"
#      And user clicks on No button in alert message
#      And user verifies new node panel is "Displayed"
#      And user clicks on Delete button in the Edit Node panel
#      And user clicks on Yes button in alert message
#      And user verifies the node "Test Node" is not displayed under NODES list
#
#    @webtest @MLP-2529 @positive
#    Scenario: MLP-2529 Verification of editing an existing node
#      Given User launch browser and traverse to login page
#      When user enter credentials for "System Administrator1" role
#      And user clicks on Administration widget
#      And user clicks on Plugin Manager in Administration dashboard
#      And user clicks on Add new node Button in Plugin Management page
#      And user enters the node name "Test Node" in the name field
#      And user select "BigData" from Catalog list
#      And user click save button in Create New Node page
#      And user verifies the node "Test Node" is displayed under NODES list
#      And user clicks on "Test Node" from nodes list
#      And user sees panel with "TEST NODE" node name on header
#      And user enters the node name "Sample Test Node" in the name field
#      And user select "DataSets" from Catalog list
#      And user click save button in Create New Node page
#      And user clicks on "Sample Test Node" from nodes list
#      And user sees panel with "SAMPLE TEST NODE" node name on header
#      And user clicks on Delete button in the Edit Node panel
#      And user clicks on Yes button in alert message