#Feature:Veification of Dry run feature test for IDA Plugins
#  Description: MLP-10467 - When the IDA plugin which sets dry as False will collect/Analyze/Assign PII tags in IDC UI
#  - When the IDA plugin which sets dry as True will not collect/Analyze/Assign PII tags in IDC UI
#
#  #6917293
#  @MLP-10467 @dryRun @positive @sanity @webtest
#  Scenario:sc1# Verify the dry run field is available under Advance settings in plugin configuration page
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType  | actionItem            |
#      | mouse hover | Settings Icon         |
#      | click       | Manage Configurations |
#    And user performs "click" operation in Manage Configurations panel
#      | button          | actionItem |
#      | Open Deployment | LocalNode  |
#    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute    |
#      | Type      | Collector    |
#      | Plugin    | GitCollector |
#    And user "click" on "Show Advanced Settings" in Manage Configurations panel
#    Then user "Verify the presnce of captions" in Plugin Configuration page
#      | Dry Run |
#
#  #6925219
#  @MLP-10467 @dryRun @sanity @positive @webtest
#  Scenario:sc2# Verify dry run option is set as False or disabled by default in Manage configuration panel
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType  | actionItem            |
#      | mouse hover | Settings Icon         |
#      | click       | Manage Configurations |
#    And user performs "click" operation in Manage Configurations panel
#      | button          | actionItem |
#      | Open Deployment | LocalNode  |
#    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute    |
#      | Type      | Collector    |
#      | Plugin    | GitCollector |
#    And user "click" on "Show Advanced Settings" in Manage Configurations panel
#    And user verifies "DryRun button" is "disabled" in Add Configuration Page
#
#  #6925220
#  @webtest @MLP-10467 @sanity @positive
#  Scenario:Verify Git collector plugin collects all the items in IDC UI when dry run field is set as False
#    Given I create "Analysis" widget for "TestSystemUser" role
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type | url                                       | body                                                      | response code | response message | jsonPath |
#      | application/json | raw   | false | Put  | settings/credentials/gitCredentials       | ida/MLP-10467_Payloads/Credentials/gitCredentials.json    | 200           |                  |          |
#      |                  |       |       | Get  | settings/credentials/gitCredentials       |                                                           | 200           |                  |          |
#      |                  |       |       | Put  | settings/analyzers/GitCollectorDataSource | ida/MLP-10467_Payloads/Configurations/git_DataSource.json | 204           |                  |          |
#      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                                           | 200           |                  |          |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/gitDryRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                       | body                                                        | response code | response message | jsonPath                                          |
#      |        |       |       | Put          | settings/analyzers/GitCollector                                           | ida/MLP-10467_Payloads/Configurations/gitDryRun_Config.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/GitCollector                                           |                                                             | 200           |                  |                                                   |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  |                                                             | 200           |                  |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                                             | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "Analysis" catalog and search "Analysis" items at top end
#    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
#    And user performs "dynamic item click" on "GitCollector" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem              | metaDataItemValue |
#      | Number of processed items | 3                 |
#
#    #6925221
#  @webtest @MLP-10467 @sanity @positive
#  Scenario:Verify Processed Item count is 0 in metadata section when dry run field is set as True
#    Given I create "Analysis" widget for "TestSystemUser" role
#    Then user "update" the json file "ida/MLP-10467_Payloads/Configurations/gitDryRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | true       |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                       | body                                                        | response code | response message | jsonPath                                          |
#      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                           | ida/MLP-10467_Payloads/Configurations/gitDryRun_Config.json | 204           |                  |                                                   |
#      |                  |       |       | Get          | settings/analyzers/GitCollector                                           |                                                             | 200           |                  |                                                   |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  |                                                             | 200           |                  |                                                   |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                                             | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "Analysis" catalog and search "Analysis" items at top end
#    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
#    And user performs "dynamic item click" on "GitCollector" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem              | metaDataItemValue |
#      | Number of processed items | 0                 |
#
#    #6925223
#  @JGIT @webtest @MLP-10467 @sanity @positive
#  Scenario: Verify the items are collected when incremental run is set as True and dry run is set as True
#    Given I create "Analysis" widget for "TestSystemUser" role
#    Then Clone remote repository "git-collector.git" repository to "local user directory1"
#    And New file has been created in local git and committed.
#    And Changes pushed to "git-collector.git" repository.
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type | url                                       | body                                                                                | response code | response message | jsonPath |
#      | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource | ida/MLP-10467_Payloads/Configurations/gitFolderFilterDryRunScenario_DataSource.json | 204           |                  |          |
#      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                                                                     | 200           |                  |          |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/gitFolderFilterPayloadDryRunScenario.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | true       |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                       | body                                                                            | response code | response message | jsonPath                                          |
#      |        |       |       | Put          | settings/analyzers/GitCollector                                           | ida/MLP-10467_Payloads/Configurations/gitFolderFilterPayloadDryRunScenario.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/GitCollector                                           |                                                                                 | 200           |                  |                                                   |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  |                                                                                 | 200           |                  |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "Analysis" catalog and search "Analysis" items at top end
#    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
#    And user performs "dynamic item click" on "GitCollector" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem              | metaDataItemValue |
#      | Number of processed items | 0                 |
#
#    #6925222
#  @JGIT @webtest @MLP-10467 @sanity @positive
#  Scenario: Verify the items are collected when incremental run is set as True and dry run is set as False
#    Given I create "Analysis" widget for "TestSystemUser" role
#    Then Clone remote repository "git-collector.git" repository to "local user directory1"
#    And New file has been created in local git and committed.
#    And Changes pushed to "git-collector.git" repository.
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type | url                                       | body                                                                                | response code | response message | jsonPath |
#      | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource | ida/MLP-10467_Payloads/Configurations/gitFolderFilterDryRunScenario_DataSource.json | 204           |                  |          |
#      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                                                                     | 200           |                  |          |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/gitFolderFilterPayloadDryRunScenario.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                       | body                                                                            | response code | response message | jsonPath                                          |
#      |        |       |       | Put          | settings/analyzers/GitCollector                                           | ida/MLP-10467_Payloads/Configurations/gitFolderFilterPayloadDryRunScenario.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/GitCollector                                           |                                                                                 | 200           |                  |                                                   |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  |                                                                                 | 200           |                  |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "Analysis" catalog and search "Analysis" items at top end
#    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
#    And user performs "dynamic item click" on "GitCollector" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem              | metaDataItemValue |
#      | Number of processed items | 109               |
#
#  #6925230
#  @webtest @MLP-10467 @sanity @positive
#  Scenario: Verify Source tree is generating for Python parser plugin in IDC UI when dry run field is set as False
#    Given I create "Analysis" widget for "TestSystemUser" role
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type | url                                       | body                                                      | response code | response message | jsonPath |
#      | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource | ida/MLP-10467_Payloads/Configurations/git_DataSource.json | 204           |                  |          |
#      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                                           | 200           |                  |          |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/gitSpark_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                       | body                                                       | response code | response message | jsonPath                                          |
#      |        |       |       | Put          | settings/analyzers/GitCollector                                           | ida/MLP-10467_Payloads/Configurations/gitSpark_Config.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/GitCollector                                           |                                                            | 200           |                  |                                                   |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  |                                                            | 200           |                  |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                                            | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/ParserDryRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                    | body                                                           | response code | response message | jsonPath                                          |
#      |        |       |       | Put          | settings/analyzers/PythonParser                                        | ida/MLP-10467_Payloads/Configurations/ParserDryRun_Config.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/PythonParser                                        |                                                                | 200           | PythonParser     |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser |                                                                | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser  |                                                                | 200           |                  |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser |                                                                | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status |
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "Analysis" catalog and search "Analysis" items at top end
#    Then user "verify displayed" for listed "Type" facet in Search results page
#      | ItemType   |
#      | Class      |
#      | Function   |
#      | SourceTree |
#
#    #6925231
#  @webtest @MLP-10467 @sanity @positive
#  Scenario: Verify Source tree is generating for Python parser plugin in IDC UI when dry run field is set as True
#    Given I create "Analysis" widget for "TestSystemUser" role
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type | url                                       | body                                                      | response code | response message | jsonPath |
#      | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource | ida/MLP-10467_Payloads/Configurations/git_DataSource.json | 204           |                  |          |
#      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                                           | 200           |                  |          |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/gitSpark_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                       | body                                                       | response code | response message | jsonPath                                          |
#      |        |       |       | Put          | settings/analyzers/GitCollector                                           | ida/MLP-10467_Payloads/Configurations/gitSpark_Config.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/GitCollector                                           |                                                            | 200           |                  |                                                   |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  |                                                            | 200           |                  |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                                            | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/ParserDryRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | true       |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                    | body                                                           | response code | response message | jsonPath                                          |
#      |        |       |       | Put          | settings/analyzers/PythonParser                                        | ida/MLP-10467_Payloads/Configurations/ParserDryRun_Config.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/PythonParser                                        |                                                                | 200           | PythonParser     |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser |                                                                | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser  |                                                                | 200           |                  |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser |                                                                | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status |
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "Analysis" catalog and search "Analysis" items at top end
#    Then user "verify not displayed" for listed "Type" facet in Search results page
#      | ItemType   |
#      | Class      |
#      | Function   |
#      | SourceTree |
#
#    #6925232
#  @webtest @MLP-10467 @sanity @positive
#  Scenario: Verify NameSpace for python package linker is generating in IDC UI when dry run field is set as False
#    Given I create "Analysis" widget for "TestSystemUser" role
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type | url                                       | body                                                      | response code | response message | jsonPath |
#      | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource | ida/MLP-10467_Payloads/Configurations/git_DataSource.json | 204           |                  |          |
#      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                                           | 200           |                  |          |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/gitPythonLinker_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                       | body                                                              | response code | response message | jsonPath                                          |
#      |        |       |       | Put          | settings/analyzers/GitCollector                                           | ida/MLP-10467_Payloads/Configurations/gitPythonLinker_Config.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/GitCollector                                           |                                                                   | 200           |                  |                                                   |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  |                                                                   | 200           |                  |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/ParserDryRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                    | body                                                           | response code | response message | jsonPath                                          |
#      |        |       |       | Put          | settings/analyzers/PythonParser                                        | ida/MLP-10467_Payloads/Configurations/ParserDryRun_Config.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/PythonParser                                        |                                                                | 200           | PythonParser     |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser |                                                                | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser  | ida/MLP-10467_Payloads/Configurations/empty.json               | 200           |                  |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser |                                                                | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/PackageLinkerDryRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                             | body                                                                  | response code | response message | jsonPath                                            |
#      |        |       |       | Put          | settings/analyzers/PythonPackageLinker                                          | ida/MLP-10467_Payloads/Configurations/PackageLinkerDryRun_Config.json | 204           |                  |                                                     |
#      |        |       |       | Get          | settings/analyzers/PythonPackageLinker                                          |                                                                       | 200           | Package_Linker   |                                                     |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/Package_Linker |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Package_Linker')].status |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/linker/PythonPackageLinker/Package_Linker  | ida/MLP-10467_Payloads/Configurations/empty.json                      | 200           |                  |                                                     |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/Package_Linker |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Package_Linker')].status |
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "Analysis" catalog and search "Analysis" items at top end
#    Then user "verify displayed" for listed "Type" facet in Search results page
#      | ItemType   |
#      | Class      |
#      | Function   |
#      | SourceTree |
#      | Namespace  |
#
#    #6925233
#  @webtest @MLP-10467 @sanity @positive
#  Scenario: Verify NameSpace for python package linker is generating in IDC UI when dry run field is set as False
#    Given I create "Analysis" widget for "TestSystemUser" role
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type | url                                       | body                                                      | response code | response message | jsonPath |
#      | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource | ida/MLP-10467_Payloads/Configurations/git_DataSource.json | 204           |                  |          |
#      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                                           | 200           |                  |          |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/gitPythonLinker_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                       | body                                                              | response code | response message | jsonPath                                          |
#      |        |       |       | Put          | settings/analyzers/GitCollector                                           | ida/MLP-10467_Payloads/Configurations/gitPythonLinker_Config.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/GitCollector                                           |                                                                   | 200           |                  |                                                   |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  |                                                                   | 200           |                  |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/ParserDryRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                    | body                                                           | response code | response message | jsonPath                                          |
#      |        |       |       | Put          | settings/analyzers/PythonParser                                        | ida/MLP-10467_Payloads/Configurations/ParserDryRun_Config.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/PythonParser                                        |                                                                | 200           | PythonParser     |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser |                                                                | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser  | ida/MLP-10467_Payloads/Configurations/empty.json               | 200           |                  |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser |                                                                | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/PackageLinkerDryRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | true       |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                             | body                                                                  | response code | response message | jsonPath                                            |
#      |        |       |       | Put          | settings/analyzers/PythonPackageLinker                                          | ida/MLP-10467_Payloads/Configurations/PackageLinkerDryRun_Config.json | 204           |                  |                                                     |
#      |        |       |       | Get          | settings/analyzers/PythonPackageLinker                                          |                                                                       | 200           | Package_Linker   |                                                     |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/Package_Linker |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Package_Linker')].status |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/linker/PythonPackageLinker/Package_Linker  | ida/MLP-10467_Payloads/Configurations/empty.json                      | 200           |                  |                                                     |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/Package_Linker |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Package_Linker')].status |
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "Analysis" catalog and search "Analysis" items at top end
#    Then user "verify not displayed" for listed "Type" facet in Search results page
#      | ItemType  |
#      | Namespace |
#
#    #6925234
#  @webtest @MLP-10467 @sanity @positive
#  Scenario: Verify Use functions and import section is generating for python linker in IDC UI when dry run field is set as False
#    Given I create "Analysis" widget for "TestSystemUser" role
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type | url                                       | body                                                      | response code | response message | jsonPath |
#      | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource | ida/MLP-10467_Payloads/Configurations/git_DataSource.json | 204           |                  |          |
#      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                                           | 200           |                  |          |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/gitPythonLinker_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                       | body                                                              | response code | response message | jsonPath                                          |
#      |        |       |       | Put          | settings/analyzers/GitCollector                                           | ida/MLP-10467_Payloads/Configurations/gitPythonLinker_Config.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/GitCollector                                           |                                                                   | 200           |                  |                                                   |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  |                                                                   | 200           |                  |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/ParserDryRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                    | body                                                           | response code | response message | jsonPath                                          |
#      |        |       |       | Put          | settings/analyzers/PythonParser                                        | ida/MLP-10467_Payloads/Configurations/ParserDryRun_Config.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/PythonParser                                        |                                                                | 200           | PythonParser     |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser |                                                                | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser  | ida/MLP-10467_Payloads/Configurations/empty.json               | 200           |                  |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser |                                                                | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/PackageLinkerDryRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                             | body                                                                  | response code | response message | jsonPath                                            |
#      |        |       |       | Put          | settings/analyzers/PythonPackageLinker                                          | ida/MLP-10467_Payloads/Configurations/PackageLinkerDryRun_Config.json | 204           |                  |                                                     |
#      |        |       |       | Get          | settings/analyzers/PythonPackageLinker                                          |                                                                       | 200           | Package_Linker   |                                                     |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/Package_Linker |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Package_Linker')].status |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/linker/PythonPackageLinker/Package_Linker  | ida/MLP-10467_Payloads/Configurations/empty.json                      | 200           |                  |                                                     |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/Package_Linker |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Package_Linker')].status |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/PythonLinkerDryRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                    | body                                                                 | response code | response message | jsonPath                                          |
#      |        |       |       | Put          | settings/analyzers/PythonLinker                                        | ida/MLP-10467_Payloads/Configurations/PythonLinkerDryRun_Config.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/PythonLinker                                        |                                                                      | 200           | PythonLinker     |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonLinker/PythonLinker |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='PythonLinker')].status |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/linker/PythonLinker/PythonLinker  | ida/MLP-10467_Payloads/Configurations/empty.json                     | 200           |                  |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonLinker/PythonLinker |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='PythonLinker')].status |
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "Analysis" catalog and search "Analysis" items at top end
#    Then user "verify displayed" for listed "Type" facet in Search results page
#      | ItemType        |
#      | Class           |
#      | Function        |
#      | SourceTree      |
#      | Namespace       |
#      | ExternalPackage |
#
#    #6925235
#  @webtest @MLP-10467 @sanity @positive
#  Scenario: Verify Use functions and import section is generating for python linker in IDC UI when dry run field is set as True
#    Given I create "Analysis" widget for "TestSystemUser" role
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type | url                                       | body                                                      | response code | response message | jsonPath |
#      | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource | ida/MLP-10467_Payloads/Configurations/git_DataSource.json | 204           |                  |          |
#      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                                           | 200           |                  |          |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/gitPythonLinker_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                       | body                                                              | response code | response message | jsonPath                                          |
#      |        |       |       | Put          | settings/analyzers/GitCollector                                           | ida/MLP-10467_Payloads/Configurations/gitPythonLinker_Config.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/GitCollector                                           |                                                                   | 200           |                  |                                                   |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  |                                                                   | 200           |                  |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/ParserDryRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                    | body                                                           | response code | response message | jsonPath                                          |
#      |        |       |       | Put          | settings/analyzers/PythonParser                                        | ida/MLP-10467_Payloads/Configurations/ParserDryRun_Config.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/PythonParser                                        |                                                                | 200           | PythonParser     |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser |                                                                | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser  | ida/MLP-10467_Payloads/Configurations/empty.json               | 200           |                  |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser |                                                                | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/PackageLinkerDryRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                             | body                                                                  | response code | response message | jsonPath                                            |
#      |        |       |       | Put          | settings/analyzers/PythonPackageLinker                                          | ida/MLP-10467_Payloads/Configurations/PackageLinkerDryRun_Config.json | 204           |                  |                                                     |
#      |        |       |       | Get          | settings/analyzers/PythonPackageLinker                                          |                                                                       | 200           | Package_Linker   |                                                     |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/Package_Linker |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Package_Linker')].status |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/linker/PythonPackageLinker/Package_Linker  | ida/MLP-10467_Payloads/Configurations/empty.json                      | 200           |                  |                                                     |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/Package_Linker |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Package_Linker')].status |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/PythonLinkerDryRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | true       |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                    | body                                                                 | response code | response message | jsonPath                                          |
#      |        |       |       | Put          | settings/analyzers/PythonLinker                                        | ida/MLP-10467_Payloads/Configurations/PythonLinkerDryRun_Config.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/PythonLinker                                        |                                                                      | 200           | PythonLinker     |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonLinker/PythonLinker |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='PythonLinker')].status |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/linker/PythonLinker/PythonLinker  | ida/MLP-10467_Payloads/Configurations/empty.json                     | 200           |                  |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonLinker/PythonLinker |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='PythonLinker')].status |
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "Analysis" catalog and search "Analysis" items at top end
#    Then user "verify not displayed" for listed "Type" facet in Search results page
#      | ItemType        |
#      | ExternalPackage |
#
#    #6925236
#  @webtest @MLP-10467 @sanity @positive
#  Scenario: Verify UDA plugin Assigns PII tags in IDC UI when dry run field is set as False
#    Given I create "Analysis" widget for "TestSystemUser" role
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type | url                                       | body                                                      | response code | response message | jsonPath |
#      | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource | ida/MLP-10467_Payloads/Configurations/git_DataSource.json | 204           |                  |          |
#      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                                           | 200           |                  |          |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/gitUDA_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/UDA_DryRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    Then Execute REST API with following parameters
#      | Header | Query | Param | type | url                                         | body                                                         | response code | response message | jsonPath |
#      |        |       |       | Put  | settings/analyzers/UnstructuredDataAnalyzer | ida/MLP-10467_Payloads/Configurations/UDA_DryRun_Config.json | 204           |                  |          |
#      |        |       |       | Get  | settings/analyzers/UnstructuredDataAnalyzer |                                                              | 200           |                  |          |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                       | body                                                     | response code | response message | jsonPath                                          |
#      |        |       |       | Put          | settings/analyzers/GitCollector                                           | ida/MLP-10467_Payloads/Configurations/gitUDA_Config.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/GitCollector                                           |                                                          | 200           |                  |                                                   |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  |                                                          | 200           |                  |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                                          | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "Analysis" catalog and search "Analysis" items at top end
#    Then user "verify displayed" for listed "Tags" facet in Search results page
#      | ItemType      |
#      | Full Name     |
#      | Address       |
#      | Email Address |
#
#    #6925237
#  @webtest @MLP-10467 @sanity @positive
#  Scenario: Verify UDA plugin not Assigns the PII tags in IDC UI when dry run field is set as True
#    Given I create "Analysis" widget for "TestSystemUser" role
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type | url                                       | body                                                      | response code | response message | jsonPath |
#      | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource | ida/MLP-10467_Payloads/Configurations/git_DataSource.json | 204           |                  |          |
#      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                                           | 200           |                  |          |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/gitUDA_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/UDA_DryRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | true       |
#    Then Execute REST API with following parameters
#      | Header | Query | Param | type | url                                         | body                                                         | response code | response message | jsonPath |
#      |        |       |       | Put  | settings/analyzers/UnstructuredDataAnalyzer | ida/MLP-10467_Payloads/Configurations/UDA_DryRun_Config.json | 204           |                  |          |
#      |        |       |       | Get  | settings/analyzers/UnstructuredDataAnalyzer |                                                              | 200           |                  |          |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                       | body                                                     | response code | response message | jsonPath                                          |
#      |        |       |       | Put          | settings/analyzers/GitCollector                                           | ida/MLP-10467_Payloads/Configurations/gitUDA_Config.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/GitCollector                                           |                                                          | 200           |                  |                                                   |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  |                                                          | 200           |                  |                                                   |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                                          | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "Analysis" catalog and search "Analysis" items at top end
#    Then user "verify not displayed" for listed "Tags" facet in Search results page
#      | ItemType      |
#      | Full Name     |
#      | Address       |
#      | Email Address |
#
#    #6925238
#  @webtest @MLP-10467 @sanity @positive
#  Scenario: Verify Spark Lineage is displayed in IDC UI when dry run field is set as False
#    Given I create "Analysis" widget for "TestSystemUser" role
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type | url                                       | body                                                            | response code | response message | jsonPath |
#      | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource | ida/MLP-10467_Payloads/Configurations/git_DataSource.json       | 204           |                  |          |
#      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                                                 | 200           |                  |          |
#      |                  |       |       | Put  | settings/credentials/snowFlakeCredentials | ida/MLP-10467_Payloads/Credentials/snowFlakeCredentials.json    | 200           |                  |          |
#      |                  |       |       | Get  | settings/credentials/snowFlakeCredentials |                                                                 | 200           |                  |          |
#      |                  |       |       | Put  | settings/analyzers/SnowflakeDataSource    | ida/MLP-10467_Payloads/Configurations/snowFlake_Datasource.json | 204           |                  |          |
#      |                  |       |       | Get  | settings/analyzers/SnowflakeDataSource    |                                                                 | 200           |                  |          |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/gitSpark_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/ParserDryRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/sparkLineagDrynRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    Then Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                                       | body                                                                 | response code | response message   | jsonPath                                                |
#      |        |       |       | Put          | settings/analyzers/GitCollector                                                           | ida/MLP-10467_Payloads/Configurations/gitSpark_Config.json           | 204           |                    |                                                         |
#      |        |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                                      | 200           |                    |                                                         |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector                  |                                                                      | 200           |                    |                                                         |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                 |                                                                      | 200           | IDLE               | $.[?(@.configurationName=='GitCollector')].status       |
#      |        |       |       | Put          | settings/analyzers/PythonParser                                                           | ida/MLP-10467_Payloads/Configurations/ParserDryRun_Config.json       | 204           |                    |                                                         |
#      |        |       |       | Get          | settings/analyzers/PythonParser                                                           |                                                                      | 200           | PythonParser       |                                                         |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser                    |                                                                      | 200           | IDLE               | $.[?(@.configurationName=='PythonParser')].status       |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser                     | ida/MLP-10467_Payloads/Configurations/empty.json                     | 200           |                    |                                                         |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser                    |                                                                      | 200           | IDLE               | $.[?(@.configurationName=='PythonParser')].status       |
#      |        |       |       | Put          | settings/analyzers/SnowflakeJDBCCataloger                                                 | ida/MLP-10467_Payloads/Configurations/snowFlake_Config.json          | 204           |                    |                                                         |
#      |        |       |       | Get          | settings/analyzers/SnowflakeJDBCCataloger                                                 |                                                                      | 200           | SnowFlakeCataloger |                                                         |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeJDBCCataloger/SnowFlakeCataloger |                                                                      | 200           | IDLE               | $.[?(@.configurationName=='SnowFlakeCataloger')].status |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeJDBCCataloger/SnowFlakeCataloger  | ida/MLP-10467_Payloads/Configurations/empty.json                     | 200           |                    |                                                         |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeJDBCCataloger/SnowFlakeCataloger |                                                                      | 200           | IDLE               | $.[?(@.configurationName=='SnowFlakeCataloger')].status |
#      |        |       |       | Put          | settings/analyzers/PythonSparkLineage                                                     | ida/MLP-10467_Payloads/Configurations/sparkLineagDrynRun_Config.json | 204           |                    |                                                         |
#      |        |       |       | Get          | settings/analyzers/PythonSparkLineage                                                     |                                                                      | 200           | SparkLineage       |                                                         |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/PythonSparkLineage/SparkLineage                   |                                                                      | 200           | IDLE               | $.[?(@.configurationName=='SparkLineage')].status       |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/*/PythonSparkLineage/SparkLineage                    | ida/MLP-10467_Payloads/Configurations/empty.json                     | 200           |                    |                                                         |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/PythonSparkLineage/SparkLineage                   |                                                                      | 200           | IDLE               | $.[?(@.configurationName=='SparkLineage')].status       |
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "Analysis" catalog and search "Analysis" items at top end
#    And user performs "facet selection" in "Function" attribute under "Type" facets in Item Search results page
#    And user performs "dynamic item click" on "jdbc_SFtoSF_JDBC_Select_example" item from search results
#    Then user "verify displayed" item "AGE => CUSTOMERS_MANY.AGE" under "Lineage Hops" widget
#
#    #6925239
#  @webtest @MLP-10467 @sanity @positive
#  Scenario: Verify Spark Lineage is displayed in IDC UI when dry run field is set as True
#    Given I create "Analysis" widget for "TestSystemUser" role
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type | url                                       | body                                                            | response code | response message | jsonPath |
#      | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource | ida/MLP-10467_Payloads/Configurations/git_DataSource.json       | 204           |                  |          |
#      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                                                 | 200           |                  |          |
#      |                  |       |       | Put  | settings/analyzers/SnowflakeDataSource    | ida/MLP-10467_Payloads/Configurations/snowFlake_Datasource.json | 204           |                  |          |
#      |                  |       |       | Get  | settings/analyzers/SnowflakeDataSource    |                                                                 | 200           |                  |          |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/gitSpark_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/ParserDryRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#    And user "update" the json file "ida/MLP-10467_Payloads/Configurations/sparkLineagDrynRun_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | true       |
#    Then Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                                       | body                                                                 | response code | response message   | jsonPath                                                |
#      |        |       |       | Put          | settings/analyzers/GitCollector                                                           | ida/MLP-10467_Payloads/Configurations/gitSpark_Config.json           | 204           |                    |                                                         |
#      |        |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                                      | 200           |                    |                                                         |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector                  |                                                                      | 200           |                    |                                                         |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                 |                                                                      | 200           | IDLE               | $.[?(@.configurationName=='GitCollector')].status       |
#      |        |       |       | Put          | settings/analyzers/PythonParser                                                           | ida/MLP-10467_Payloads/Configurations/ParserDryRun_Config.json       | 204           |                    |                                                         |
#      |        |       |       | Get          | settings/analyzers/PythonParser                                                           |                                                                      | 200           | PythonParser       |                                                         |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser                    |                                                                      | 200           | IDLE               | $.[?(@.configurationName=='PythonParser')].status       |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser                     | ida/MLP-10467_Payloads/Configurations/empty.json                     | 200           |                    |                                                         |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser                    |                                                                      | 200           | IDLE               | $.[?(@.configurationName=='PythonParser')].status       |
#      |        |       |       | Put          | settings/analyzers/SnowflakeJDBCCataloger                                                 | ida/MLP-10467_Payloads/Configurations/snowFlake_Config.json          | 204           |                    |                                                         |
#      |        |       |       | Get          | settings/analyzers/SnowflakeJDBCCataloger                                                 |                                                                      | 200           | SnowFlakeCataloger |                                                         |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeJDBCCataloger/SnowFlakeCataloger |                                                                      | 200           | IDLE               | $.[?(@.configurationName=='SnowFlakeCataloger')].status |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeJDBCCataloger/SnowFlakeCataloger  | ida/MLP-10467_Payloads/Configurations/empty.json                     | 200           |                    |                                                         |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeJDBCCataloger/SnowFlakeCataloger |                                                                      | 200           | IDLE               | $.[?(@.configurationName=='SnowFlakeCataloger')].status |
#      |        |       |       | Put          | settings/analyzers/PythonSparkLineage                                                     | ida/MLP-10467_Payloads/Configurations/sparkLineagDrynRun_Config.json | 204           |                    |                                                         |
#      |        |       |       | Get          | settings/analyzers/PythonSparkLineage                                                     |                                                                      | 200           | SparkLineage       |                                                         |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/PythonSparkLineage/SparkLineage                   |                                                                      | 200           | IDLE               | $.[?(@.configurationName=='SparkLineage')].status       |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/*/PythonSparkLineage/SparkLineage                    | ida/MLP-10467_Payloads/Configurations/empty.json                     | 200           |                    |                                                         |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/PythonSparkLineage/SparkLineage                   |                                                                      | 200           | IDLE               | $.[?(@.configurationName=='SparkLineage')].status       |
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "Analysis" catalog and search "Analysis" items at top end
#    And user performs "facet selection" in "Function" attribute under "Type" facets in Item Search results page
#    And user performs "dynamic item click" on "jdbc_SFtoSF_JDBC_Select_example" item from search results
#    Then user "verify not displayed" item "AGE => CUSTOMERS_MANY.AGE" under "Lineage Hops" widget
#
#  @jdbc
#  Scenario: Create Table in Postgres
#    Given user connects to the database and performs the following operation
#      | databaseConnection | Operation    | queryPath     | queryPage       | queryField                  |
#      | postgres           | EXECUTEQUERY | json/IDA.json | postgresQueries | createConstraintTable       |
#      | postgres           | EXECUTEQUERY | json/IDA.json | postgresQueries | createConstraintUniqueTable |
#      | postgres           | EXECUTEQUERY | json/IDA.json | postgresQueries | createEmptyTimeStampTable   |
#
#  @jdbc
#  Scenario: Create Table and insert value for data sampling
#    Given user connects to the database and performs the following operation
#      | databaseConnection | Operation    | queryPath     | queryPage       | queryField    |
#      | postgres           | EXECUTEQUERY | json/IDA.json | postgresQueries | createTable   |
#      | postgres           | EXECUTEQUERY | json/IDA.json | postgresQueries | insertRecord1 |
#      | postgres           | EXECUTEQUERY | json/IDA.json | postgresQueries | insertRecord2 |
#      | postgres           | EXECUTEQUERY | json/IDA.json | postgresQueries | insertRecord3 |
#      | postgres           | EXECUTEQUERY | json/IDA.json | postgresQueries | insertRecord4 |
#
#  @jdbc
#  Scenario: Create Table with Timestamp and insert records for Verification
#    Given user connects to the database and performs the following operation
#      | databaseConnection | Operation    | queryPath     | queryPage       | queryField            |
#      | postgres           | EXECUTEQUERY | json/IDA.json | postgresQueries | createTimeStampTable  |
#      | postgres           | EXECUTEQUERY | json/IDA.json | postgresQueries | insertTimeStampRecord |
#
#  @postgres @precondition
#  Scenario: Update Postgres credentials
#    Given User update the below "Postgres Credentials" in following files using json path
#      | filePath                                                           | username    | password    |
#      | ida/MLP-10467_Payloads/Credentials/PostgresCredentials_Config.json | $..userName | $..password |
#
#  @jdbc
#  Scenario: Catalog creation
#    Given I create "Analysis" widget for "TestSystemUser" role
#
#  @jdbc
#  Scenario: update PostgresCataloger Configuration file
#    Given user "update" the json file "ida/MLP-10467_Payloads/Configurations/PostgresCataloger_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | false      |
#
#  @jdbc
#  Scenario Outline: Run the Plugin configurations
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                               | body                                                                         | response code | response message | jsonPath                                        |
#      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/SampleCredentials?allowUpdate=true                           | ida/MLP-10467_Payloads/Credentials/PostgresCredentials_Config.json           | 200           |                  |                                                 |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/SampleCredentials                                            |                                                                              | 200           |                  |                                                 |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgresJDBCDataSource/SampleDataSource                        | ida/MLP-10467_Payloads/Configurations/postgresDatasourceConfig_positive.json | 204           |                  |                                                 |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgresJDBCDataSource/SampleDataSource                        |                                                                              | 200           | SampleDataSource |                                                 |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgresDB                               | ida/MLP-10467_Payloads/Configurations/PostgresCataloger_Config.json          | 204           |                  |                                                 |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgresDB                               |                                                                              | 200           | PostgresDB       |                                                 |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgresDB |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='PostgresDB')].status |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgresDB  | ida/IDx_jdbcAnalyzerPayloads/postgresCatalogerConfig_empty.json              | 200           |                  |                                                 |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgresDB |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='PostgresDB')].status |
#
#    #6925224
#  @webtest @jdbc @MLP-10467
#  Scenario: Verify the TableName(PostgresDB) should have the appropriate metadata information in IDC UI and Database when dry run is false
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "Analysis" catalog and search "Analysis" items at top end
#    And user performs "facet selection" in "public [Schema]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "postgres_tag_details" item from search results
#    Then user "verify metadata properties" section has following values
#      | Last catalogued at |
#    And user connect to the database and execute query for the following parameters
#      | dataBaseName  | dataBaseType | queryPath     | queryPage       | queryField   | storeResults |
#      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | postgresQueries | getTableType | resultsInMap |
#    Then following "metadata property values" for item "postgres_tag_details" should match with postgres values stored in "hashMap"
#      | Table Type |
#
#  @jdbc
#  Scenario: Create Catalog
#    Given I create "Analysis" widget for "TestSystemUser" role
#
#  @jdbc
#  Scenario: update PostgresCataloger Configuration
#    Given user "update" the json file "ida/MLP-10467_Payloads/Configurations/PostgresCataloger_Config.json" file for following values
#      | jsonPath  | jsonValues |
#      | $..dryRun | true       |
#
#  @jdbc
#  Scenario Outline: Run the Plugin configurations for PostgresSQLDBCataloger
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                               | body                                                                         | response code | response message      | jsonPath                                        |
#      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/SampleCredentials?allowUpdate=true                           | ida/MLP-10467_Payloads/Credentials/PostgresCredentials_Config.json           | 200           |                       |                                                 |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/SampleCredentials                                            |                                                                              | 200           |                       |                                                 |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgresJDBCDataSource/SampleDataSource                        | ida/MLP-10467_Payloads/Configurations/postgresDatasourceConfig_positive.json | 204           |                       |                                                 |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgresJDBCDataSource/SampleDataSource                        |                                                                              | 200           | SampleDataSource      |                                                 |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgresDB                               | ida/MLP-10467_Payloads/Configurations/PostgresCataloger_Config.json          | 204           |                       |                                                 |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgresDB                               |                                                                              | 200           | PostgreSQLDBCataloger |                                                 |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgresDB |                                                                              | 200           | IDLE                  | $.[?(@.configurationName=='PostgresDB')].status |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgresDB  | ida/IDx_jdbcAnalyzerPayloads/postgresCatalogerConfig_empty.json              | 200           |                       |                                                 |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgresDB |                                                                              | 200           | IDLE                  | $.[?(@.configurationName=='PostgresDB')].status |
#
#    #6925225
#  Scenario: Verify the TableName(PostgresDB) should have the appropriate metadata information in IDC UI and Database when dry run is true
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "Analysis" catalog and search "Analysis" items at top end
#    And user performs "facet selection" in "public [Schema]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "postgres_tag_details" item from search results
#    Then user "verify metadata properties" section has following values
#      | Last catalogued at |
#    And user connect to the database and execute query for the following parameters
#      | dataBaseName  | dataBaseType | queryPath     | queryPage       | queryField   | storeResults |
#      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | postgresQueries | getTableType | resultsInMap |
#    Then following "metadata property values" for item "postgres_tag_details" should match with postgres values stored in "hashMap"
#      | Table Type |