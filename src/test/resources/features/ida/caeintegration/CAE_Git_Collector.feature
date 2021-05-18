@MLPQA-17472
Feature: CAE Git Collector
  # Story ID - MLP-30254

  @CAE_Git
  Scenario:PreCondition#Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                              | jsonPath                                           | node            |
      | ida/CAEGitCollector/datasource.json   | $..GitEntryPointDS.configurations..ServerName      | HeadlessEDINode |
      | ida/CAEGitCollector/datasource.json   | $..GitSQLFeedLoadDS.configurations..ServerName     | HeadlessEDINode |
      | ida/CAEGitCollector/datasource.json   | $..GitSQLEntryPointDS.configurations..ServerName   | HeadlessEDINode |
      | ida/CAEGitCollector/datasource.json   | $..GitFeedLoadDS.configurations..ServerName        | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $.CAEGitSingleFile.configurations.nodeCondition    | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $.GitLoadIncrTrue.configurations.nodeCondition     | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $.GitCollector.configurations.nodeCondition        | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $.GitLoad.configurations.nodeCondition             | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $.CAEGitCollectorIncr.configurations.nodeCondition | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $.GitSubfFalse.configurations.nodeCondition        | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $.GitProcessDelete.configurations.nodeCondition    | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $.DeleteEntryPoint.configurations.nodeCondition    | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $.GitFeed.configurations.nodeCondition             | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $.GitEntryPoint.configurations.nodeCondition       | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $.GitEntryPointSQL.configurations.nodeCondition    | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $.GitSQLLoad.configurations.nodeCondition          | HeadlessEDINode |
      | ida/CAEGitCollector/pluginconfig.json | $.GitSQLFeed.configurations.nodeCondition          | HeadlessEDINode |


  @CAE_Git
  Scenario Outline:PreCondition#Update data source and configuration for Entry Point,Git Collector,Feed and Loader
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                              | bodyFile                                      | path                                 | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/GitEntryPointServer         | payloads/ida/CAEGitCollector/credentials.json | $.CAEOracleServer                    | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/GitEntryPointServer         |                                               |                                      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/GitEntryPoint               | payloads/ida/CAEGitCollector/credentials.json | $.GitEntryPoint                      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/GitEntryPoint               |                                               |                                      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource/GitEntryPointDS | payloads/ida/CAEGitCollector/datasource.json  | $.GitEntryPointDS.configurations.[0] | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource/GitEntryPointDS |                                               |                                      | 200           | GitEntryPointDS  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource/GitFeedLoadDS   | payloads/ida/CAEGitCollector/datasource.json  | $.GitFeedLoadDS.configurations.[0]   | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource/GitFeedLoadDS   |                                               |                                      | 200           | GitFeedLoadDS    |          |

  @CAE_Git
  Scenario Outline: Precondition2#Create BusinessApplication tag for CAE Git Collector
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                 | body                                         | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | /items/Default/root | ida/CAEGitCollector/BusinessApplication.json | 200           |                  |          |


  @CAE_Git
  Scenario Outline:PreCondition#Configure and run Create Entry Point,GIT Collector,Feed,Load Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                             | bodyFile                                       | path                           | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/GitEntryPoint                            | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitEntryPoint.configurations | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/GitEntryPoint                            |                                                |                                | 200           | GitEntryPoint    |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/GitEntryPoint |                                                |                                | 200           | IDLE             | $.[?(@.configurationName=='GitEntryPoint')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAECreateEntryPoint/GitEntryPoint  |                                                |                                | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/GitEntryPoint |                                                |                                | 200           | IDLE             | $.[?(@.configurationName=='GitEntryPoint')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/GitCAECollector/CAEGitCollector                              | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitCollector.configurations  | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/GitCAECollector/CAEGitCollector                              |                                                |                                | 200           | CAEGitCollector  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/GitCAECollector/CAEGitCollector     |                                                |                                | 200           | IDLE             | $.[?(@.configurationName=='CAEGitCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/GitCAECollector/CAEGitCollector      |                                                |                                | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/GitCAECollector/CAEGitCollector     |                                                |                                | 200           | IDLE             | $.[?(@.configurationName=='CAEGitCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/GitFeed                                              | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitFeed.configurations       | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/GitFeed                                              |                                                |                                | 200           | GitFeed          |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/GitFeed                     |                                                |                                | 200           | IDLE             | $.[?(@.configurationName=='GitFeed')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/GitFeed                      |                                                |                                | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/GitFeed                     |                                                |                                | 200           | IDLE             | $.[?(@.configurationName=='GitFeed')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/GitLoad                                          | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitLoad.configurations       | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/GitLoad                                          |                                                |                                | 200           | GitLoad          |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/GitLoad                |                                                |                                | 200           | IDLE             | $.[?(@.configurationName=='GitLoad')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/GitLoad                 |                                                |                                | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/GitLoad                |                                                |                                | 200           | IDLE             | $.[?(@.configurationName=='GitLoad')].status         |


  @TEST_MLPQA-17473 @MLPQA-17471 @CAE_Git
  Scenario: Verify if .des file is generated for CAE Git Collector
    Given Verify Analysis log "cae/GitCAECollector/CAEGitCollector%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                             |
      | should contain | info | VHC-INF-300905 | VHC-INF-300905 : Generating DES file = |


  @TEST_MLPQA-17474 @MLPQA-17471 @CAE_Git
  Scenario: Verify CAE Create Entry Point,Collector,Feeder logs are generated without error
    Given Analysis log "tools/CAECreateEntryPoint/GitEntryPoint%" should display below info/error/warning
      | type | logValue                                                                                                                                  | logCode       | pluginName    | removableText |
      | INFO | Plugin CAECreateEntryPoint Start Time:2020-11-05 15:24:02.101, End Time:2020-11-05 15:26:28.529, Processed Count:0, Errors:0, Warnings:90 | ANALYSIS-0072 | GitEntryPoint |               |
    Then Analysis log "cae/GitCAECollector/CAEGitCollector%" should display below info/error/warning
      | type | logValue                                                                                                                             | logCode       | pluginName      | removableText |
      | INFO | Plugin GitCAECollector Start Time:2020-11-05 15:27:16.836, End Time:2020-11-05 15:27:25.230, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | GitCAECollector |               |
    Then Analysis log "cae/CAEFeed/GitFeed%" should display below info/error/warning
      | type | logValue                                                                                                                      | logCode       | pluginName | removableText |
      | INFO | Plugin CAEFeed Start Time:2020-11-05 15:27:50.581, End Time:2020-11-05 15:28:13.567, Processed Count:0, Errors:0, Warnings:14 | ANALYSIS-0072 | GITFeed    |               |
    Then Analysis log "bulk/CAEDDLoader/GitLoad%" should display below info/error/warning
      | type | logValue                                                                                                                           | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-11-05 15:28:32.585, End Time:2020-11-05 15:28:39.887, Processed Count:111, Errors:0, Warnings:0 | ANALYSIS-0072 | GITDDLoader |               |


  @TEST_MLPQA-17475 @TEST_MLPQA-17476 @MLPQA-17471 @webtest @CAE_Git
  Scenario: Verify if all directory and files are loaded when running CAEDD Loader plugin for the Git Collector generated .des files
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Git" and clicks on search
    And user performs "facet selection" in "Git" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "src [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in ". [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Git" attribute under "Technology" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
      |              |              |           |           |            |            |                | Metadata Type | File       | 10    |
      |              |              |           |           |            |            |                | Metadata Type | SourceTree | 10    |
      |              |              |           |           |            |            |                | Metadata Type | Directory  | 3     |
    And user enters the search text "src" and clicks on search
    And user performs "facet selection" in "src [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
      |              |              |           |           |            |            |                | Metadata Type | Function   | 16    |
      |              |              |           |           |            |            |                | Metadata Type | File       | 8     |
      |              |              |           |           |            |            |                | Metadata Type | SourceTree | 8     |
      |              |              |           |           |            |            |                | Metadata Type | Class      | 5     |
      |              |              |           |           |            |            |                | Metadata Type | Directory  | 2     |

#  @TEST_MLPQA-17476 @MLPQA-17471
#  Scenario: Verify if all item types like Directory,File, SourceTree, Class and Functions are loaded for CAE Git Collector data with counts  in DD facet section


  @TEST_MLPQA-17477 @MLPQA-17471 @webtest @CAE_Git
  Scenario: Verify if domain tag 'Git' and 'BEC' is generated for Git Collected data when running CAE DD Loader
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Git" and clicks on search
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                     | fileName           | userTag |
      | Default     | Directory  | Metadata Type | Git,BEC,CAE_GIT_BA      | src                |         |
      | Default     | File       | Metadata Type | Git,BEC,Java,CAE_GIT_BA | CreateServlet.java |         |
      | Default     | SourceTree | Metadata Type | Git,BEC,Java,CAE_GIT_BA | CreateServlet      |         |
      | Default     | Class      | Metadata Type | BEC,Java,CAE_GIT_BA     | CreateServlet      |         |
      | Default     | Function   | Metadata Type | BEC,Java,CAE_GIT_BA     | CreateServlet()    |         |

  @TEST_MLPQA-17478 @MLPQA-17471 @CAE_Git @webtest
  Scenario: Verify the breadcrumb order for CAE Git data in Item view page for Directory-->File-->SourceTree-->Class-->Functions
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CreateServlet()" and clicks on search
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CreateServlet()" item from search results
    Then user "verify presence" of following "hierarchy" in Item View Page
      | DEFAULT            |
      | src                |
      | g                  |
      | CreateServlet.java |
      | CreateServlet      |
      | CreateServlet      |

  @TEST_MLPQA-17479 @MLPQA-17471 @webtest @CAE_Git
  Scenario: Verify if  CAE Git Collected Directory,File,Source Tree,Class and Functions has appropriate meta data in item view page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Git" and clicks on search
    And user performs "facet selection" in "Git" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "src [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "src" item from search results
    And user performs click and verify in new window
      | Table         | value               | Action                 | RetainPrevwindow | indexSwitch |
      | Files         | File_renamed14.java | verify widget contains | No               |             |
      | has_Directory | g                   | click and switch tab   | No               |             |
    And user performs click and verify in new window
      | Table | value              | Action               | RetainPrevwindow | indexSwitch |
      | Files | CreateServlet.java | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue      | widgetName  |
      | Description       | Source Java        | Description |
      | MIME type         | text/x-java-source | Description |
    And user performs click and verify in new window
      | Table       | value              | Action                 | RetainPrevwindow | indexSwitch |
      | Data        | CreateServlet.java | verify widget contains | No               |             |
      | Source Tree | CreateServlet      | click and switch tab   | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Source Java   | Description |
    And user performs click and verify in new window
      | Table   | value         | Action               | RetainPrevwindow | indexSwitch |
      | Classes | CreateServlet | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Java          | Description |
      | startLine         | 14            | Description |
      | endLine           | 14            | Description |
    And user performs click and verify in new window
      | Table     | value           | Action               | RetainPrevwindow | indexSwitch |
      | Functions | CreateServlet() | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Java          | Description |
      | startLine         | 14            | Description |
      | endLine           | 14            | Description |

  @CAE_Git
  Scenario:PostCondition#1:Delete previously loaded Git directory data
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name | type      | query | param |
      | MultipleIDDelete | Default | src  | Directory |       |       |
      | MultipleIDDelete | Default | .    | Directory |       |       |


  @CAE_Git
  Scenario Outline:Configure and run Create Entry Point,Git Collector with single file path,Feeder and Load Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                             | bodyFile                                       | path                              | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/GitEntryPoint                            | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitEntryPoint.configurations    | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/GitEntryPoint                            |                                                |                                   | 200           | GitEntryPoint    |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/GitEntryPoint |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='GitEntryPoint')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAECreateEntryPoint/GitEntryPoint  |                                                |                                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/GitEntryPoint |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='GitEntryPoint')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/GitCAECollector/CAEGitCollector                              | payloads/ida/CAEGitCollector/pluginconfig.json | $.CAEGitSingleFile.configurations | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/GitCAECollector/CAEGitCollector                              |                                                |                                   | 200           | CAEGitCollector  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/GitCAECollector/CAEGitCollector     |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='CAEGitCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/GitCAECollector/CAEGitCollector      |                                                |                                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/GitCAECollector/CAEGitCollector     |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='CAEGitCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/GitFeed                                              | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitFeed.configurations          | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/GitFeed                                              |                                                |                                   | 200           | GitFeed          |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/GitFeed                     |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='GitFeed')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/GitFeed                      |                                                |                                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/GitFeed                     |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='GitFeed')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/GitLoad                                          | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitLoad.configurations          | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/GitLoad                                          |                                                |                                   | 200           | GitLoad          |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/GitLoad                |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='GitLoad')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/GitLoad                 |                                                |                                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/GitLoad                |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='GitLoad')].status         |


  @TEST_MLPQA-17482 @MLPQA-17471 @webtest @CAE_Git
  Scenario: Verifyif Git collector generates .des file when config line has single file ["GIT,CollectorTestData/QA_java/AbstractCollector.java,TYPE=JAVA,PROCESS=LOAD,SUBF=Y"]
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Git" and clicks on search
    And user performs "facet selection" in "Git" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "BEC" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
      |              |              |           |           |            |            |                | Metadata Type | File       | 1     |
      |              |              |           |           |            |            |                | Metadata Type | SourceTree | 1     |
      |              |              |           |           |            |            |                | Metadata Type | Directory  | 2     |


  @CAE_Git
  Scenario Outline:Configure and run Create Entry Point,Git Collector with single file path,Feeder and Load Plugins with INCREMENTAL=TRUE
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                         | bodyFile                                       | path                                 | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/GitCAECollector/CAEGitCollector                          | payloads/ida/CAEGitCollector/pluginconfig.json | $.CAEGitCollectorIncr.configurations | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/GitCAECollector/CAEGitCollector                          |                                                |                                      | 200           | CAEGitCollector  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/GitCAECollector/CAEGitCollector |                                                |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAEGitCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/GitCAECollector/CAEGitCollector  |                                                |                                      | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/GitCAECollector/CAEGitCollector |                                                |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAEGitCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/GitFeed                                          | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitFeed.configurations             | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/GitFeed                                          |                                                |                                      | 200           | GitFeed          |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/GitFeed                 |                                                |                                      | 200           | IDLE             | $.[?(@.configurationName=='GitFeed')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/GitFeed                  |                                                |                                      | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/GitFeed                 |                                                |                                      | 200           | IDLE             | $.[?(@.configurationName=='GitFeed')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/GitLoadIncrTrue                              | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitLoadIncrTrue.configurations     | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/GitLoadIncrTrue                              |                                                |                                      | 200           | GitLoad          |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/GitLoadIncrTrue    |                                                |                                      | 200           | IDLE             | $.[?(@.configurationName=='GitLoadIncrTrue')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/GitLoadIncrTrue     |                                                |                                      | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/GitLoadIncrTrue    |                                                |                                      | 200           | IDLE             | $.[?(@.configurationName=='GitLoadIncrTrue')].status |

  @TEST_MLPQA-17480 @MLPQA-17471 @webtest @CAE_Git
  Scenario: Verify incremental scenario works for Git when running CAE DD Loader with INCREMENTAL=TRUE with new file in collector config line
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Git" and clicks on search
    And user performs "facet selection" in "Git" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "BEC" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
      |              |              |           |           |            |            |                | Metadata Type | File       | 2     |
      |              |              |           |           |            |            |                | Metadata Type | SourceTree | 2     |
      |              |              |           |           |            |            |                | Metadata Type | Directory  | 2     |


  @CAE_Git
  Scenario:PostCondition#2:Delete previously loaded Git directory data
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name | type      | query | param |
      | MultipleIDDelete | Default | src  | Directory |       |       |
      | MultipleIDDelete | Default | .    | Directory |       |       |

  @CAE_Git
  Scenario Outline:Configure and run Create Entry Point,Git Collector with SUBF=N path,Feeder and Load Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                             | bodyFile                                       | path                           | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/GitEntryPoint                            | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitEntryPoint.configurations | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/GitEntryPoint                            |                                                |                                | 200           | GitEntryPoint    |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/GitEntryPoint |                                                |                                | 200           | IDLE             | $.[?(@.configurationName=='GitEntryPoint')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAECreateEntryPoint/GitEntryPoint  |                                                |                                | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/GitEntryPoint |                                                |                                | 200           | IDLE             | $.[?(@.configurationName=='GitEntryPoint')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/GitCAECollector/CAEGitCollector                              | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitSubfFalse.configurations  | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/GitCAECollector/CAEGitCollector                              |                                                |                                | 200           | CAEGitCollector  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/GitCAECollector/CAEGitCollector     |                                                |                                | 200           | IDLE             | $.[?(@.configurationName=='CAEGitCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/GitCAECollector/CAEGitCollector      |                                                |                                | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/GitCAECollector/CAEGitCollector     |                                                |                                | 200           | IDLE             | $.[?(@.configurationName=='CAEGitCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/GitFeed                                              | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitFeed.configurations       | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/GitFeed                                              |                                                |                                | 200           | GitFeed          |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/GitFeed                     |                                                |                                | 200           | IDLE             | $.[?(@.configurationName=='GitFeed')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/GitFeed                      |                                                |                                | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/GitFeed                     |                                                |                                | 200           | IDLE             | $.[?(@.configurationName=='GitFeed')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/GitLoad                                          | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitLoad.configurations       | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/GitLoad                                          |                                                |                                | 200           | GitLoad          |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/GitLoad                |                                                |                                | 200           | IDLE             | $.[?(@.configurationName=='GitLoad')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/GitLoad                 |                                                |                                | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/GitLoad                |                                                |                                | 200           | IDLE             | $.[?(@.configurationName=='GitLoad')].status         |


  @TEST_MLPQA-17481 @MLPQA-17471 @webtest @CAE_Git
  Scenario: Verify  no sub folders and its files are collected from Git in DD UI when SUBF=N in collector configuration line.["Git,CollectorTestData/*.java,TYPE=JAVA,PROCESS=LOAD,SUBF=N"]
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Git" and clicks on search
    And user performs "facet selection" in "Git" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "BEC" attribute under "Technology" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
      |              |              |           |           |            |            |                | Metadata Type | Directory  | 1     |
      |              |              |           |           |            |            |                | Metadata Type | File       | 2     |
      |              |              |           |           |            |            |                | Metadata Type | SourceTree | 2     |


  @CAE_Git
  Scenario:PostCondition#3:Delete previously loaded Git directory data
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name | type      | query | param |
      | MultipleIDDelete | Default | .    | Directory |       |       |

  @CAE_Git
  Scenario Outline:Configure and run Create Entry Point,Git Collector with PROCESS=DELETE path,Feeder and Load Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                         | bodyFile                                       | path                              | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/GitCAECollector/CAEGitCollector                          | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitProcessDelete.configurations | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/GitCAECollector/CAEGitCollector                          |                                                |                                   | 200           | CAEGitCollector  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/GitCAECollector/CAEGitCollector |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='CAEGitCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/GitCAECollector/CAEGitCollector  |                                                |                                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/GitCAECollector/CAEGitCollector |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='CAEGitCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/GitFeed                                          | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitFeed.configurations          | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/GitFeed                                          |                                                |                                   | 200           | GitFeed          |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/GitFeed                 |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='GitFeed')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/GitFeed                  |                                                |                                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/GitFeed                 |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='GitFeed')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/GitLoad                                      | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitLoad.configurations          | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/GitLoad                                      |                                                |                                   | 200           | GitLoad          |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/GitLoad            |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='GitLoad')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/GitLoad             |                                                |                                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/GitLoad            |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='GitLoad')].status         |


  @TEST_MLPQA-17483 @MLPQA-17471 @webtest @CAE_Git
  Scenario: Verifyif GIT collector generates .des file and .vso file for PROCESS=DELETE in config line [GIT, CollectorTestData/*.java,TYPE=JAVA,PROCESS=DELETE,SUBF=Y]
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Git" and clicks on search
    And user performs "facet selection" in "Git" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "BEC" attribute under "Technology" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | File       |
      | Directory  |
      | SourceTree |


  @CAE_Git
  Scenario Outline:PostCondition#Delete all Git credentials,data source and plugin configurations.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                  | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAECreateEntryPoint/GitEntryPoint |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCAECollector/CAEGitCollector   |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEFeed/GitFeed                   |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDDLoader/GitLoad               |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDDLoader/GitLoadIncrTrue       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDataSource/GitEntryPointDS     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDataSource/GitFeedLoadDS       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/GitEntryPoint                   |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/GitEntryPointServer             |          |      | 200           |                  |          |


  @CAE_Git
  Scenario Outline:PreCondition#Update data source and configuration for Entry Point,Git Collector,Feed and Loader for SQL Server
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                              | bodyFile                                      | path                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/GitEntryPointSQLServer      | payloads/ida/CAEGitCollector/credentials.json | $.CAESQLServer                          | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/GitEntryPointSQLServer      |                                               |                                         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/GitEntryPoint               | payloads/ida/CAEGitCollector/credentials.json | $.GitEntryPoint                         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/GitEntryPoint               |                                               |                                         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource/GitEntryPointDS | payloads/ida/CAEGitCollector/datasource.json  | $.GitSQLEntryPointDS.configurations.[0] | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource/GitEntryPointDS |                                               |                                         | 200           | GitEntryPointDS  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource/GitFeedLoadDS   | payloads/ida/CAEGitCollector/datasource.json  | $.GitSQLFeedLoadDS.configurations.[0]   | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource/GitFeedLoadDS   |                                               |                                         | 200           | GitFeedLoadDS    |          |


  @CAE_Git
  Scenario Outline:PreCondition#Configure and run Create Entry Point,GIT Collector,Feed,Load Plugins for SQL Server
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                             | bodyFile                                       | path                              | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/GitEntryPoint                            | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitEntryPointSQL.configurations | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/GitEntryPoint                            |                                                |                                   | 200           | GitEntryPoint    |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/GitEntryPoint |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='GitEntryPoint')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAECreateEntryPoint/GitEntryPoint  |                                                |                                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/GitEntryPoint |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='GitEntryPoint')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/GitCAECollector/CAEGitCollector                              | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitCollector.configurations     | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/GitCAECollector/CAEGitCollector                              |                                                |                                   | 200           | CAEGitCollector  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/GitCAECollector/CAEGitCollector     |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='CAEGitCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/GitCAECollector/CAEGitCollector      |                                                |                                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/GitCAECollector/CAEGitCollector     |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='CAEGitCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/GitFeed                                              | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitSQLFeed.configurations       | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/GitFeed                                              |                                                |                                   | 200           | GitFeed          |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/GitFeed                     |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='GitFeed')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/GitFeed                      |                                                |                                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/GitFeed                     |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='GitFeed')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/GitLoad                                          | payloads/ida/CAEGitCollector/pluginconfig.json | $.GitSQLLoad.configurations       | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/GitLoad                                          |                                                |                                   | 200           | GitLoad          |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/GitLoad                |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='GitLoad')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/GitLoad                 |                                                |                                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/GitLoad                |                                                |                                   | 200           | IDLE             | $.[?(@.configurationName=='GitLoad')].status         |


  @CAE_Git @webtest
  Scenario: Verify if all directory and files are loaded from SQL Server when running CAEDD Loader plugin for the Git Collector generated .de
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CAE_GIT_BA" and clicks on search
    And user performs "facet selection" in "CAE_GIT_BA" attribute under "Business Application" facets in Item Search results page
    And user performs "facet selection" in "src [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
      |              |              |           |           |            |            |                | Metadata Type | File       | 10    |
      |              |              |           |           |            |            |                | Metadata Type | SourceTree | 10    |
      |              |              |           |           |            |            |                | Metadata Type | Function   | 11    |
      |              |              |           |           |            |            |                | Metadata Type | Class      | 3     |


  @CAE_Git
  Scenario Outline:PostCondition#Delete all Git credentials,data source and plugin configured for SQL Server .
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                  | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAECreateEntryPoint/GitEntryPoint |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCAECollector/CAEGitCollector   |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEFeed/GitFeed                   |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDDLoader/GitLoad               |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDDLoader/GitLoadIncrTrue       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDataSource/GitEntryPointDS     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDataSource/GitFeedLoadDS       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/GitEntryPoint                   |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/GitEntryPointSQLServer          |          |      | 200           |                  |          |
