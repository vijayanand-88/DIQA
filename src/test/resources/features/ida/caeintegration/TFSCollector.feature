@MLPQA-17752
Feature: CAE TFS Collector features
 #Story ID - MLP-30306

  @CAE_TFS
  Scenario:PreCondition#Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                              | jsonPath                                                   | node            |
      | ida/CAEGitCollector/datasource.json   | $..TFSEntryPointCreateDS.configurations..ServerName        | HeadlessEDINode |
      | ida/CAEGitCollector/datasource.json   | $..TFSFeedLoadDS.configurations..ServerName                | HeadlessEDINode |
      | ida/CAEGitCollector/datasource.json   | $..TFSFeedLoadDS.configurations..ServerName                | HeadlessEDINode |
      | ida/CAEGitCollector/datasource.json   | $..TFSSQLEntryPointDS.configurations..ServerName           | HeadlessEDINode |
      | ida/CAEGitCollector/datasource.json   | $..TFSSQLFeedLoadDS.configurations..ServerName             | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $..TFSCreateEntryPoint.configurations..nodeCondition       | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $..TFSCollector.configurations..nodeCondition              | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $..TFSFeed.configurations..nodeCondition                   | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $..TFSDDLoader.configurations..nodeCondition               | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $..TFSCollectorSingleFile.configurations..nodeCondition    | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $..TFSCollectorProcessAuto.configurations..nodeCondition   | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $..TFSCollectorSubFolderNo.configurations..nodeCondition   | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $..TFSCollectorProcessDelete.configurations..nodeCondition | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $..TFSDDLoaderIncremental.configurations..nodeCondition    | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $..TFSDDLoaderNegativeDelta.configurations..nodeCondition  | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $..TFSDeleteEntryPoint.configurations..nodeCondition       | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $..TFSSQLEntryPoint.configurations..nodeCondition          | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $..TFSSQLFeed.configurations..nodeCondition                | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $..TFSSQLDDLoader.configurations..nodeCondition            | HeadlessEDINode |


  @CAE_TFS
  Scenario Outline:PreCondition1#Update data source and configuration for Entry Point,TFS Collector,Feed and Loader
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                    | bodyFile                                   | path                                       | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/TFSEntryPointServer               | payloads/ida/TFSCollector/credentials.json | $.TFSOracleServer                          | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/TFSEntryPointServer               |                                            |                                            | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource/TFSEntryPointCreateDS | payloads/ida/TFSCollector/datasource.json  | $.TFSEntryPointCreateDS.configurations.[0] | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource/TFSEntryPointCreateDS |                                            |                                            | 200           | TFSEntryPointCreateDS |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/TFSCredentials                    | payloads/ida/TFSCollector/credentials.json | $.TFSCredentials                           | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/TFSCredentials                    |                                            |                                            | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAETFSDataSource/TFSDataSource      | payloads/ida/TFSCollector/datasource.json  | $.TFSDataSource.configurations.[0]         | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAETFSDataSource/TFSDataSource      |                                            |                                            | 200           | TFSDataSource         |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/TFSEntryPoint                     | payloads/ida/TFSCollector/credentials.json | $.TFSEntryPoint                            | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/TFSEntryPoint                     |                                            |                                            | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource/TFSFeedLoadDS         | payloads/ida/TFSCollector/datasource.json  | $.TFSFeedLoadDS.configurations.[0]         | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource/TFSFeedLoadDS         |                                            |                                            | 200           | TFSFeedLoadDS         |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/TFSInvalidCredentials             | payloads/ida/TFSCollector/credentials.json | $.TFSInvalidCredentials                    | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/TFSInvalidCredentials             |                                            |                                            | 200           |                       |          |

  @CAE_TFS
  Scenario Outline:PreCondition2#Configure and run Create Entry Point,TFS Collector,Feed,Load Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                          | bodyFile                                    | path                                 | response code | response message    | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/TFSCreateEntryPoint                                                   | payloads/ida/TFSCollector/pluginconfig.json | $.TFSCreateEntryPoint.configurations | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/TFSCreateEntryPoint                                                   |                                             |                                      | 200           | TFSCreateEntryPoint |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/tools/CAECreateEntryPoint/TFSCreateEntryPoint |                                             |                                      | 200           | IDLE                | $.[?(@.configurationName=='TFSCreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/tools/CAECreateEntryPoint/TFSCreateEntryPoint  |                                             |                                      | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/tools/CAECreateEntryPoint/TFSCreateEntryPoint |                                             |                                      | 200           | IDLE                | $.[?(@.configurationName=='TFSCreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/TFSCollector/TFSCollector                                                                 | payloads/ida/TFSCollector/pluginconfig.json | $.TFSCollector.configurations        | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/TFSCollector/TFSCollector                                                                 |                                             |                                      | 200           | TFSCollector        |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/TFSCollector/TFSCollector                 |                                             |                                      | 200           | IDLE                | $.[?(@.configurationName=='TFSCollector')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/TFSCollector/TFSCollector                  |                                             |                                      | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/TFSCollector/TFSCollector                 |                                             |                                      | 200           | IDLE                | $.[?(@.configurationName=='TFSCollector')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/TFSFeed                                                                           | payloads/ida/TFSCollector/pluginconfig.json | $.TFSFeed.configurations             | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/TFSFeed                                                                           |                                             |                                      | 200           | TFSFeed             |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/CAEFeed/TFSFeed                           |                                             |                                      | 200           | IDLE                | $.[?(@.configurationName=='TFSFeed')].status             |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/CAEFeed/TFSFeed                            |                                             |                                      | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/CAEFeed/TFSFeed                           |                                             |                                      | 200           | IDLE                | $.[?(@.configurationName=='TFSFeed')].status             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/TFSDDLoader                                                                   | payloads/ida/TFSCollector/pluginconfig.json | $.TFSDDLoader.configurations         | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/TFSDDLoader                                                                   |                                             |                                      | 200           | TFSDDLoader         |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/bulk/CAEDDLoader/TFSDDLoader                  |                                             |                                      | 200           | IDLE                | $.[?(@.configurationName=='TFSDDLoader')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/bulk/CAEDDLoader/TFSDDLoader                   |                                             |                                      | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/bulk/CAEDDLoader/TFSDDLoader                  |                                             |                                      | 200           | IDLE                | $.[?(@.configurationName=='TFSDDLoader')].status         |

  #7264988 #7264974 #7264973 #7264975  #7264976
  @CAE_TFS @TEST_MLPQA-3186 @TEST_MLPQA-3185 @TEST_MLPQA-3184 @TEST_MLPQA-3173 @TEST_MLPQA-3175 @TEST_MLPQA-3187 @MLPQA-17486
  Scenario:SC1#Verify the processed count in CAE Collector analysis log
    Given Verify Analysis log "cae/TFSCollector/TFSCollector%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                             |
      | should contain | info | VHC-INF-300905 | VHC-INF-300905 : Generating DES file = |
    Then Analysis log "tools/CAECreateEntryPoint/TFSCreateEntryPoint%" should display below info/error/warning
      | type | logValue                                                                                                                                  | logCode       | pluginName          | removableText |
      | INFO | Plugin CAECreateEntryPoint Start Time:2020-11-05 15:24:02.101, End Time:2020-11-05 15:26:28.529, Processed Count:0, Errors:0, Warnings:90 | ANALYSIS-0072 | TFSCreateEntryPoint |               |
    Then Analysis log "cae/TFSCollector/TFSCollector%" should display below info/error/warning
      | type | logValue                                                                                                                          | logCode       | pluginName   | removableText |
      | INFO | Plugin TFSCollector Start Time:2020-11-18 08:13:49.956, End Time:2020-11-18 08:14:10.291, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | TFSCollector |               |
    Then Analysis log "cae/CAEFeed/TFSFeed%" should display below info/error/warning
      | type | logValue                                                                                                                      | logCode       | pluginName | removableText |
      | INFO | Plugin CAEFeed Start Time:2020-11-18 08:14:30.915, End Time:2020-11-18 08:14:52.602, Processed Count:0, Errors:0, Warnings:17 | ANALYSIS-0072 | TFSFeed    |               |
    Then Analysis log "bulk/CAEDDLoader/TFSDDLoader%" should display below info/error/warning
      | type | logValue                                                                                                                           | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-11-18 08:15:13.034, End Time:2020-11-18 08:15:20.476, Processed Count:208, Errors:0, Warnings:0 | ANALYSIS-0072 | TFSDDLoader |               |

  #7264977 #7247322
  @webtest @CAE_TFS @TEST_MLPQA-3183 @MLPQA-17486
  Scenario:SC2#Verify if all directory and files are loaded when running CAEDD Loader plugin for TFS data.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CollectorTestData" and clicks on search
    And user performs "facet selection" in "BEC" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "CollectorTestData [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
      |              |              |           |           |            |            |                | Metadata Type | Function   | 118   |
      |              |              |           |           |            |            |                | Metadata Type | Directory  | 5     |
      |              |              |           |           |            |            |                | Metadata Type | File       | 10    |
      |              |              |           |           |            |            |                | Metadata Type | Class      | 8     |
      |              |              |           |           |            |            |                | Metadata Type | SourceTree | 10    |


  @webtest @CAE_TFS @TEST_MLPQA-3181 @TEST_MLPQA-3182 @MLPQA-17486
  Scenario:SC3#_Verify TFS technology tag and becubic asset tags are available for items.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CollectorTestData" and clicks on search
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                      | fileName               | userTag |
      | Default     | Directory  | Metadata Type | Team Foundation Version Control,BEC      | CollectorTestData      |         |
      | Default     | File       | Metadata Type | Team Foundation Version Control,BEC,Java | AbstractCollector.java |         |
      | Default     | SourceTree | Metadata Type | Team Foundation Version Control,BEC,Java | AbstractCollector      |         |
      | Default     | Class      | Metadata Type | BEC,Java                                 | AbstractCollector      |         |
      | Default     | Function   | Metadata Type | BEC,Java                                 | AbstractCollector()    |         |

    #7264980
  @webtest  @CAE_TFS @TEST_MLPQA-3180 @MLPQA-17486
  Scenario: SC4#:#Verify breadcrumb hierarchy for items collected from CAE TFS Collector
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Team Foundation Version Control" and clicks on search
    And user performs "facet selection" in "Team Foundation Version Control" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "CollectorTestData [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "QA_java" item from search results
    And user performs click and verify in new window
      | Table       | value                  | Action               | RetainPrevwindow | indexSwitch |
      | Files       | AbstractCollector.java | click and switch tab | No               |             |
      | Source Tree | AbstractCollector      | click and switch tab | No               |             |
      | Classes     | AbstractCollector      | click and switch tab | No               |             |
      | Functions   | AbstractCollector()    | click and switch tab | No               |             |
    Then user "verify presence" of following "hierarchy" in Item View Page
      | DEFAULT                |
      | CollectorTestData      |
      | QA_java                |
      | AbstractCollector.java |
      | AbstractCollector      |
      | AbstractCollector      |

   #7264981 #7264982 #7264983 #7264989
  @webtest  @CAE_TFS @TEST_MLPQA-3172 @TEST_MLPQA-3177 @TEST_MLPQA-3178 @TEST_MLPQA-3179 @MLPQA-17486
  Scenario: SC5#:#Verify appropriate metadata values are present for Directory,File,Source Tree,Class and Functions
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Team Foundation Version Control" and clicks on search
    And user performs "facet selection" in "Team Foundation Version Control" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "CollectorTestData [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "QA_java" item from search results
    And user performs click and verify in new window
      | Table | value                  | Action               | RetainPrevwindow | indexSwitch |
      | Files | AbstractCollector.java | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue      | widgetName  |
      | Description       | Source Java        | Description |
      | MIME type         | text/x-java-source | Description |
    And user performs click and verify in new window
      | Table       | value                  | Action                 | RetainPrevwindow | indexSwitch |
      | Data        | AbstractCollector.java | verify widget contains | No               |             |
      | Source Tree | AbstractCollector      | click and switch tab   | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Source Java   | Description |
    And user performs click and verify in new window
      | Table   | value             | Action               | RetainPrevwindow | indexSwitch |
      | Classes | AbstractCollector | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Java          | Description |
      | startLine         | 32            | Description |
      | endLine           | 32            | Description |
    And user performs click and verify in new window
      | Table     | value               | Action               | RetainPrevwindow | indexSwitch |
      | Functions | AbstractCollector() | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Java          | Description |
      | startLine         | 61            | Description |
      | endLine           | 61            | Description |

  @CAE_TFS
  Scenario:PostCondition#1:Delete TFS Project Directory of previously loaded data
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name              | type      | query | param |
      | MultipleIDDelete | Default | CollectorTestData | Directory |       |       |

  @CAE_TFS
  Scenario Outline:PreCondition3#Configure and run Create Entry Point,TFS Collector config pointing to single file with Feed and Load Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                          | bodyFile                                    | path                                    | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/TFSCreateEntryPoint                                                   | payloads/ida/TFSCollector/pluginconfig.json | $.TFSCreateEntryPoint.configurations    | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/TFSCreateEntryPoint                                                   |                                             |                                         | 200           | TFSCreateEntryPoint    |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/tools/CAECreateEntryPoint/TFSCreateEntryPoint |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='TFSCreateEntryPoint')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/tools/CAECreateEntryPoint/TFSCreateEntryPoint  |                                             |                                         | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/tools/CAECreateEntryPoint/TFSCreateEntryPoint |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='TFSCreateEntryPoint')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/TFSCollector/TFSCollectorSingleFile                                                       | payloads/ida/TFSCollector/pluginconfig.json | $.TFSCollectorSingleFile.configurations | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/TFSCollector/TFSCollectorSingleFile                                                       |                                             |                                         | 200           | TFSCollectorSingleFile |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/TFSCollector/TFSCollectorSingleFile       |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='TFSCollectorSingleFile')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/TFSCollector/TFSCollectorSingleFile        |                                             |                                         | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/TFSCollector/TFSCollectorSingleFile       |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='TFSCollectorSingleFile')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/TFSFeed                                                                           | payloads/ida/TFSCollector/pluginconfig.json | $.TFSFeed.configurations                | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/TFSFeed                                                                           |                                             |                                         | 200           | TFSFeed                |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/CAEFeed/TFSFeed                           |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='TFSFeed')].status                |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/CAEFeed/TFSFeed                            |                                             |                                         | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/CAEFeed/TFSFeed                           |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='TFSFeed')].status                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/TFSDDLoader                                                                   | payloads/ida/TFSCollector/pluginconfig.json | $.TFSDDLoader.configurations            | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/TFSDDLoader                                                                   |                                             |                                         | 200           | TFSDDLoader            |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/bulk/CAEDDLoader/TFSDDLoader                  |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='TFSDDLoader')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/bulk/CAEDDLoader/TFSDDLoader                   |                                             |                                         | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/bulk/CAEDDLoader/TFSDDLoader                  |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='TFSDDLoader')].status            |

    #7264985
  @webtest  @CAE_TFS @TEST_MLPQA-3175 @MLPQA-17486
  Scenario:SC#6:Verify if only the TFS file provided in config line  is collected and loaded in DD.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CollectorTestData" and clicks on search
    And user performs "facet selection" in "CollectorTestData [Directory]" attribute under "Hierarchy" facets in Item Search results page
    Then user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
      |              |              |           |           |            |            |                | Metadata Type | Function   | 39    |
      |              |              |           |           |            |            |                | Metadata Type | Directory  | 2     |
      |              |              |           |           |            |            |                | Metadata Type | File       | 1     |
      |              |              |           |           |            |            |                | Metadata Type | Class      | 1     |
      |              |              |           |           |            |            |                | Metadata Type | SourceTree | 1     |

  @CAE_TFS
  Scenario Outline:PreCondition4#Replace the file name in same config and run along with Feed and Loader with INCREMENTAL=TRUE
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                    | bodyFile                                    | path                                     | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/TFSCollector/TFSCollectorSingleFile                                                 | payloads/ida/TFSCollector/pluginconfig.json | $.TFSCollectorProcessAuto.configurations | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/TFSCollector/TFSCollectorSingleFile                                                 |                                             |                                          | 200           | TFSCollectorSingleFile |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/TFSCollector/TFSCollectorSingleFile |                                             |                                          | 200           | IDLE                   | $.[?(@.configurationName=='TFSCollectorSingleFile')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/TFSCollector/TFSCollectorSingleFile  |                                             |                                          | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/TFSCollector/TFSCollectorSingleFile |                                             |                                          | 200           | IDLE                   | $.[?(@.configurationName=='TFSCollectorSingleFile')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/TFSFeed                                                                     | payloads/ida/TFSCollector/pluginconfig.json | $.TFSFeed.configurations                 | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/TFSFeed                                                                     |                                             |                                          | 200           | TFSFeed                |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/CAEFeed/TFSFeed                     |                                             |                                          | 200           | IDLE                   | $.[?(@.configurationName=='TFSFeed')].status                |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/CAEFeed/TFSFeed                      |                                             |                                          | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/CAEFeed/TFSFeed                     |                                             |                                          | 200           | IDLE                   | $.[?(@.configurationName=='TFSFeed')].status                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/TFSDDLoaderIncremental                                                  | payloads/ida/TFSCollector/pluginconfig.json | $.TFSDDLoaderIncremental.configurations  | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/TFSDDLoaderIncremental                                                  |                                             |                                          | 200           | TFSDDLoaderIncremental |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/bulk/CAEDDLoader/TFSDDLoaderIncremental |                                             |                                          | 200           | IDLE                   | $.[?(@.configurationName=='TFSDDLoaderIncremental')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/bulk/CAEDDLoader/TFSDDLoaderIncremental  |                                             |                                          | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/bulk/CAEDDLoader/TFSDDLoaderIncremental |                                             |                                          | 200           | IDLE                   | $.[?(@.configurationName=='TFSDDLoaderIncremental')].status |

    #7265525
  @webtest  @CAE_TFS @TEST_MLPQA-3171 @MLPQA-17486
  Scenario:SC#7:Verify if only the new TFS file provided in config line  is collected and loaded in DD.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CollectorTestData" and clicks on search
    And user performs "facet selection" in "CollectorTestData [Directory]" attribute under "Hierarchy" facets in Item Search results page
    Then user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
      |              |              |           |           |            |            |                | Metadata Type | Function   | 51    |
      |              |              |           |           |            |            |                | Metadata Type | Directory  | 2     |
      |              |              |           |           |            |            |                | Metadata Type | File       | 2     |
      |              |              |           |           |            |            |                | Metadata Type | Class      | 2     |
      |              |              |           |           |            |            |                | Metadata Type | SourceTree | 2     |


  @CAE_TFS
  Scenario Outline:PreCondition5#Replace the file name in same previous config with PROCESS=DELETE and run along with Feed and Loader with INCR=TRUE NEGATIVE=TRUE
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                      | bodyFile                                    | path                                       | response code | response message         | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/TFSCollector/TFSCollectorSingleFile                                                   | payloads/ida/TFSCollector/pluginconfig.json | $.TFSCollectorProcessDelete.configurations | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/TFSCollector/TFSCollectorSingleFile                                                   |                                             |                                            | 200           | TFSCollectorSingleFile   |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/TFSCollector/TFSCollectorSingleFile   |                                             |                                            | 200           | IDLE                     | $.[?(@.configurationName=='TFSCollectorSingleFile')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/TFSCollector/TFSCollectorSingleFile    |                                             |                                            | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/TFSCollector/TFSCollectorSingleFile   |                                             |                                            | 200           | IDLE                     | $.[?(@.configurationName=='TFSCollectorSingleFile')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/TFSFeed                                                                       | payloads/ida/TFSCollector/pluginconfig.json | $.TFSFeed.configurations                   | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/TFSFeed                                                                       |                                             |                                            | 200           | TFSFeed                  |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/CAEFeed/TFSFeed                       |                                             |                                            | 200           | IDLE                     | $.[?(@.configurationName=='TFSFeed')].status                  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/CAEFeed/TFSFeed                        |                                             |                                            | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/CAEFeed/TFSFeed                       |                                             |                                            | 200           | IDLE                     | $.[?(@.configurationName=='TFSFeed')].status                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/TFSDDLoaderNegativeDelta                                                  | payloads/ida/TFSCollector/pluginconfig.json | $.TFSDDLoaderNegativeDelta.configurations  | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/TFSDDLoaderNegativeDelta                                                  |                                             |                                            | 200           | TFSDDLoaderNegativeDelta |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/bulk/CAEDDLoader/TFSDDLoaderNegativeDelta |                                             |                                            | 200           | IDLE                     | $.[?(@.configurationName=='TFSDDLoaderNegativeDelta')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/bulk/CAEDDLoader/TFSDDLoaderNegativeDelta  |                                             |                                            | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/bulk/CAEDDLoader/TFSDDLoaderNegativeDelta |                                             |                                            | 200           | IDLE                     | $.[?(@.configurationName=='TFSDDLoaderNegativeDelta')].status |

   #7264984
  @webtest  @CAE_TFS @TEST_MLPQA-3176 @MLPQA-17486
  Scenario:SC#8:Verifyif TFS collector generates .des file and .vso file for PROCESS=DELETE in config line [TFS, CollectorTestData/*.java,TYPE=JAVA,PROCESS=DELETE,SUBF=Y]
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CollectorTestData" and clicks on search
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | File       |
      | SourceTree |


  @CAE_TFS
  Scenario Outline:PreCondition6#Configure and run TFS Collector with SUBF=N along with feed and DD Loader
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                     | bodyFile                                    | path                                     | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/TFSCollector/TFSCollectorSubFolderNo                                                 | payloads/ida/TFSCollector/pluginconfig.json | $.TFSCollectorSubFolderNo.configurations | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/TFSCollector/TFSCollectorSubFolderNo                                                 |                                             |                                          | 200           | TFSCollectorSubFolderNo |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/TFSCollector/TFSCollectorSubFolderNo |                                             |                                          | 200           | IDLE                    | $.[?(@.configurationName=='TFSCollectorSubFolderNo')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/TFSCollector/TFSCollectorSubFolderNo  |                                             |                                          | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/TFSCollector/TFSCollectorSubFolderNo |                                             |                                          | 200           | IDLE                    | $.[?(@.configurationName=='TFSCollectorSubFolderNo')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/TFSFeed                                                                      | payloads/ida/TFSCollector/pluginconfig.json | $.TFSFeed.configurations                 | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/TFSFeed                                                                      |                                             |                                          | 200           | TFSFeed                 |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/CAEFeed/TFSFeed                      |                                             |                                          | 200           | IDLE                    | $.[?(@.configurationName=='TFSFeed')].status                 |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/CAEFeed/TFSFeed                       |                                             |                                          | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/CAEFeed/TFSFeed                      |                                             |                                          | 200           | IDLE                    | $.[?(@.configurationName=='TFSFeed')].status                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/TFSDDLoader                                                              | payloads/ida/TFSCollector/pluginconfig.json | $.TFSDDLoader.configurations             | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/TFSDDLoader                                                              |                                             |                                          | 200           | TFSDDLoader             |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/bulk/CAEDDLoader/TFSDDLoader             |                                             |                                          | 200           | IDLE                    | $.[?(@.configurationName=='TFSDDLoader')].status             |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/bulk/CAEDDLoader/TFSDDLoader              |                                             |                                          | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/bulk/CAEDDLoader/TFSDDLoader             |                                             |                                          | 200           | IDLE                    | $.[?(@.configurationName=='TFSDDLoader')].status             |

    #7264986
  @webtest  @CAE_TFS @TEST_MLPQA-3174 @MLPQA-17486
  Scenario:SC#9:Verify  no sub folders and its files are collected from TFS  in DD UI when SUBF=N in collector configuration line.["TFS,CollectorTestData/*.java,TYPE=JAVA,PROCESS=LOAD,SUBF=N"]
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CollectorTestData" and clicks on search
    And user performs "facet selection" in "CollectorTestData [Directory]" attribute under "Hierarchy" facets in Item Search results page
    Then user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
      |              |              |           |           |            |            |                | Metadata Type | Function   | 70    |
      |              |              |           |           |            |            |                | Metadata Type | Directory  | 2     |
      |              |              |           |           |            |            |                | Metadata Type | File       | 6     |
      |              |              |           |           |            |            |                | Metadata Type | Class      | 4     |
      |              |              |           |           |            |            |                | Metadata Type | SourceTree | 6     |

  @CAE_TFS
  Scenario:PostCondition#2:Delete TFS Project Directory of previously loaded data
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name              | type      | query | param |
      | MultipleIDDelete | Default | CollectorTestData | Directory |       |       |

  # 7264971 #7264972
  @webtest @TEST_MLPQA-3189 @MLPQA-17486
  Scenario:SC#10:Verify data source connection is successful for SVN Data source with valid and Invalid credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Data Sources" in "Add Data source Configuration"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data source Configuration"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName         | attribute        |
      | Data Source Type* | CAETFSDataSource |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName       | attribute                                       |
      | Name*           | A                                               |
      | SCMSDir*        | gechcae-col1.asg.com:8080/tfs/DefaultCollection |
      | SCMSExecutable* | D:\TFS\Common7\Tools\vsvars32.bat               |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute      |
      | Credential | TFSCredentials |
      | Node       |                |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    Then user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute             |
      | Credential | TFSInvalidCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    Then user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"

  @CAE_TFS
  Scenario Outline:PostCondition#3:Delete all TFS credentials,data source and plugin configurations.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                        | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAECreateEntryPoint/TFSCreateEntryPoint |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/TFSCollector/TFSCollectorSingleFile     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/TFSCollector/TFSCollectorSubFolderNo    |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/TFSCollector/TFSCollector               |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEFeed/TFSFeed                         |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDDLoader/TFSDDLoader                 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDDLoader/TFSDDLoaderIncremental      |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDDLoader/TFSDDLoaderNegativeDelta    |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDataSource/TFSEntryPointCreateDS     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDataSource/TFSFeedLoadDS             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAETFSDataSource/TFSDataSource          |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/TFSEntryPoint                         |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/TFSInvalidCredentials                 |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/TFSCredentials                        |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/TFSEntryPointServer                   |          |      | 200           |                  |          |


  @CAE_TFS
  Scenario:PostCondition#3:Delete TFS Project Directory of previously loaded data from Oracle server
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name              | type      | query | param |
      | MultipleIDDelete | Default | CollectorTestData | Directory |       |       |


  @CAE_TFS
  Scenario Outline:PreCondition#Update data source and configuration for Entry Point,TFS Collector,Feed and Loader for CAE SQL Server
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                 | bodyFile                                   | path                                    | response code | response message   | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/TFSSQLEntryPointServer         | payloads/ida/TFSCollector/credentials.json | $.TFSSQLServer                          | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/TFSSQLEntryPointServer         |                                            |                                         | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource/TFSSQLEntryPointDS | payloads/ida/TFSCollector/datasource.json  | $.TFSSQLEntryPointDS.configurations.[0] | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource/TFSSQLEntryPointDS |                                            |                                         | 200           | TFSSQLEntryPointDS |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/TFSCredentials                 | payloads/ida/TFSCollector/credentials.json | $.TFSCredentials                        | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/TFSCredentials                 |                                            |                                         | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAETFSDataSource/TFSDataSource   | payloads/ida/TFSCollector/datasource.json  | $.TFSDataSource.configurations.[0]      | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAETFSDataSource/TFSDataSource   |                                            |                                         | 200           | TFSDataSource      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/TFSEntryPoint                  | payloads/ida/TFSCollector/credentials.json | $.TFSEntryPoint                         | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/TFSEntryPoint                  |                                            |                                         | 200           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource/TFSSQLFeedLoadDS   | payloads/ida/TFSCollector/datasource.json  | $.TFSSQLFeedLoadDS.configurations.[0]   | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource/TFSSQLFeedLoadDS   |                                            |                                         | 200           | TFSSQLFeedLoadDS   |          |


  @CAE_TFS
  Scenario Outline:PreCondition#Configure and run Create Entry Point,TFS Collector,Feed,Load Plugins for CAE SQL Server
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                          | bodyFile                                    | path                              | response code | response message    | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/TFSCreateEntryPoint                                                   | payloads/ida/TFSCollector/pluginconfig.json | $.TFSSQLEntryPoint.configurations | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/TFSCreateEntryPoint                                                   |                                             |                                   | 200           | TFSCreateEntryPoint |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/tools/CAECreateEntryPoint/TFSCreateEntryPoint |                                             |                                   | 200           | IDLE                | $.[?(@.configurationName=='TFSCreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/tools/CAECreateEntryPoint/TFSCreateEntryPoint  |                                             |                                   | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/tools/CAECreateEntryPoint/TFSCreateEntryPoint |                                             |                                   | 200           | IDLE                | $.[?(@.configurationName=='TFSCreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/TFSCollector/TFSCollector                                                                 | payloads/ida/TFSCollector/pluginconfig.json | $.TFSCollector.configurations     | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/TFSCollector/TFSCollector                                                                 |                                             |                                   | 200           | TFSCollector        |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/TFSCollector/TFSCollector                 |                                             |                                   | 200           | IDLE                | $.[?(@.configurationName=='TFSCollector')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/TFSCollector/TFSCollector                  |                                             |                                   | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/TFSCollector/TFSCollector                 |                                             |                                   | 200           | IDLE                | $.[?(@.configurationName=='TFSCollector')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/TFSFeed                                                                           | payloads/ida/TFSCollector/pluginconfig.json | $.TFSSQLFeed.configurations       | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/TFSFeed                                                                           |                                             |                                   | 200           | TFSFeed             |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/CAEFeed/TFSFeed                           |                                             |                                   | 200           | IDLE                | $.[?(@.configurationName=='TFSFeed')].status             |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/CAEFeed/TFSFeed                            |                                             |                                   | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/cae/CAEFeed/TFSFeed                           |                                             |                                   | 200           | IDLE                | $.[?(@.configurationName=='TFSFeed')].status             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/TFSDDLoader                                                                   | payloads/ida/TFSCollector/pluginconfig.json | $.TFSSQLDDLoader.configurations   | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/TFSDDLoader                                                                   |                                             |                                   | 200           | TFSDDLoader         |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/bulk/CAEDDLoader/TFSDDLoader                  |                                             |                                   | 200           | IDLE                | $.[?(@.configurationName=='TFSDDLoader')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/bulk/CAEDDLoader/TFSDDLoader                   |                                             |                                   | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/MOBIQPLUGIN01V.MOBIQ.QA.ASGINT.LOC/bulk/CAEDDLoader/TFSDDLoader                  |                                             |                                   | 200           | IDLE                | $.[?(@.configurationName=='TFSDDLoader')].status         |


  Scenario:SC11#Verify if all directory and files are loaded when running CAEDD Loader plugin for TFS data from SQL Server.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CollectorTestData" and clicks on search
    And user performs "facet selection" in "BEC" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "CollectorTestData [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
      |              |              |           |           |            |            |                | Metadata Type | Function   | 118   |
      |              |              |           |           |            |            |                | Metadata Type | Directory  | 5     |
      |              |              |           |           |            |            |                | Metadata Type | File       | 10    |
      |              |              |           |           |            |            |                | Metadata Type | Class      | 8     |
      |              |              |           |           |            |            |                | Metadata Type | SourceTree | 10    |


  @CAE_TFS
  Scenario:PostCondition#4:Delete TFS Project Directory of previously loaded data from SQL server
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name              | type      | query | param |
      | MultipleIDDelete | Default | CollectorTestData | Directory |       |       |

  @CAE_TFS
  Scenario Outline:PostCondition#5:Delete all TFS credentials,data source and plugin configurations.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                        | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAECreateEntryPoint/TFSCreateEntryPoint |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/TFSCollector/TFSCollector               |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEFeed/TFSFeed                         |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDDLoader/TFSDDLoader                 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDataSource/TFSSQLEntryPointDS        |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDataSource/TFSSQLFeedLoadDS          |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAETFSDataSource/TFSDataSource          |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/TFSEntryPoint                         |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/TFSCredentials                        |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/TFSSQLEntryPointServer                |          |      | 200           |                  |          |
