@MLPQA-17667
Feature: CAE SVN Collector features

  MLP-30059 - Create a wrapper plugin for the CAE Subvention (SVN) collector

  @CAE_SVN
  Scenario Outline:PreCondition1#Update data source and configuration for Entry Point,SVN Collector,Feed and Loader
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                      | bodyFile                                   | path                                       | response code | response message        | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/CAEOracleServer                     | payloads/ida/SVNCollector/credentials.json | $.CAEOracleServer                          | 200           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/CAEOracleServer                     |                                            |                                            | 200           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource/SVNEntryPointDataSource | payloads/ida/SVNCollector/datasource.json  | $.SVNCreateEntryPointDS.configurations.[0] | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource/SVNEntryPointDataSource |                                            |                                            | 200           | SVNEntryPointDataSource |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/SVNCredentials                      | payloads/ida/SVNCollector/credentials.json | $.SVNCredentials                           | 200           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/SVNCredentials                      |                                            |                                            | 200           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAESVNDataSource/SVNDataSource        | payloads/ida/SVNCollector/datasource.json  | $.SVNCollectorDS.configurations.[0]        | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAESVNDataSource/SVNDataSource        |                                            |                                            | 200           | SVNDataSource           |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/SVNEntryPoint                       | payloads/ida/SVNCollector/credentials.json | $.SVNEntryPoint                            | 200           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/SVNEntryPoint                       |                                            |                                            | 200           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource/SVNFeedLoadDS           | payloads/ida/SVNCollector/datasource.json  | $.SVNFeedLoadDS.configurations.[0]         | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource/SVNFeedLoadDS           |                                            |                                            | 200           | SVNFeedLoadDS           |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/SVNInvalidCredentials               | payloads/ida/SVNCollector/credentials.json | $.SVNInvalidCredentials                    | 200           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/SVNInvalidCredentials               |                                            |                                            | 200           |                         |          |

  @CAE_SVN
  Scenario Outline: Precondition2#Create BusinessApplication tag for SVN Collector
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                 | body                                      | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | /items/Default/root | ida/SVNCollector/BusinessApplication.json | 200           |                  |          |

  @CAE_SVN
  Scenario Outline:PreCondition3#Configure and run Create Entry Point,SVN Collector,Feed,Load Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | bodyFile                                    | path                           | response code | response message    | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/SVNCreateEntryPoint                            | payloads/ida/SVNCollector/pluginconfig.json | $.SVNEntryPoint.configurations | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/SVNCreateEntryPoint                            |                                             |                                | 200           | SVNCreateEntryPoint |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/SVNCreateEntryPoint |                                             |                                | 200           | IDLE                | $.[?(@.configurationName=='SVNCreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAECreateEntryPoint/SVNCreateEntryPoint  |                                             |                                | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/SVNCreateEntryPoint |                                             |                                | 200           | IDLE                | $.[?(@.configurationName=='SVNCreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SVNCollector/SVNCollector                                          | payloads/ida/SVNCollector/pluginconfig.json | $.SVNCollector.configurations  | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SVNCollector/SVNCollector                                          |                                             |                                | 200           | SVNCollector        |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/SVNCollector/SVNCollector                 |                                             |                                | 200           | IDLE                | $.[?(@.configurationName=='SVNCollector')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/SVNCollector/SVNCollector                  |                                             |                                | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/SVNCollector/SVNCollector                 |                                             |                                | 200           | IDLE                | $.[?(@.configurationName=='SVNCollector')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/SVNFeed                                                    | payloads/ida/SVNCollector/pluginconfig.json | $.SVNFeed.configurations       | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/SVNFeed                                                    |                                             |                                | 200           | SVNFeed             |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/SVNFeed                           |                                             |                                | 200           | IDLE                | $.[?(@.configurationName=='SVNFeed')].status             |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/SVNFeed                            |                                             |                                | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/SVNFeed                           |                                             |                                | 200           | IDLE                | $.[?(@.configurationName=='SVNFeed')].status             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/SVNDDLoader                                            | payloads/ida/SVNCollector/pluginconfig.json | $.SVNDDLoader.configurations   | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/SVNDDLoader                                            |                                             |                                | 200           | SVNDDLoader         |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoader                  |                                             |                                | 200           | IDLE                | $.[?(@.configurationName=='SVNDDLoader')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoader                   |                                             |                                | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoader                  |                                             |                                | 200           | IDLE                | $.[?(@.configurationName=='SVNDDLoader')].status         |


  @CAE_SVN  @TEST_MLPQA-3375 @TEST_MLPQA-3419 @TEST_MLPQA-3420 @MLPQA-17486 @TEST_MLPQA-3422 @TEST_MLPQA-3422 @TEST_MLPQA-3421 @7248941  @7247318 @7247319
  Scenario:SC1#Verify the processed count in CAE Collector analysis log
    Given Analysis log "tools/CAECreateEntryPoint/SVNCreateEntryPoint%" should display below info/error/warning
      | type | logValue                                                                                                                                  | logCode       | pluginName          | removableText |
      | INFO | Plugin CAECreateEntryPoint Start Time:2020-11-05 15:24:02.101, End Time:2020-11-05 15:26:28.529, Processed Count:0, Errors:0, Warnings:90 | ANALYSIS-0072 | SVNCreateEntryPoint |               |
    Then Analysis log "cae/SVNCollector/SVNCollector%" should display below info/error/warning
      | type | logValue                                                                                                                          | logCode       | pluginName   | removableText |
      | INFO | Plugin SVNCollector Start Time:2020-11-05 15:27:16.836, End Time:2020-11-05 15:27:25.230, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | SVNCollector |               |
    Then Verify Analysis log "cae/SVNCollector/SVNCollector%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                             |
      | should contain | info | VHC-INF-300905 | VHC-INF-300905 : Generating DES file = |
    Then Analysis log "cae/CAEFeed/SVNFeed%" should display below info/error/warning
      | type | logValue                                                                                                                     | logCode       | pluginName | removableText |
      | INFO | Plugin CAEFeed Start Time:2020-11-05 15:27:50.581, End Time:2020-11-05 15:28:13.567, Processed Count:0, Errors:0, Warnings:1 | ANALYSIS-0072 | SVNFeed    |               |
    Then Analysis log "bulk/CAEDDLoader/SVNDDLoader%" should display below info/error/warning
      | type | logValue                                                                                                                          | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-11-05 15:28:32.585, End Time:2020-11-05 15:28:39.887, Processed Count:56, Errors:0, Warnings:0 | ANALYSIS-0072 | SVNDDLoader |               |


  @webtest @CAE_SVN @TEST_MLPQA-3418 @MLPQA-17486 @7247321
  Scenario:SC2#Verify if all the items from SVN repository is loaded in DD when running CAE DD loader
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Subversion" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "BEC" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "trunk [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
      |              |              |           |           |            |            |                | Metadata Type | Directory  | 10    |
      |              |              |           |           |            |            |                | Metadata Type | File       | 7     |
      |              |              |           |           |            |            |                | Metadata Type | SourceTree | 7     |
      |              |              |           |           |            |            |                | Metadata Type | Class      | 7     |
      |              |              |           |           |            |            |                | Metadata Type | Function   | 456   |


  @webtest @CAE_SVN @TEST_MLPQA-3416 @MLPQA-17486 @7247323
  Scenario:SC3#_Verify SVN technology tag and becubic asset tags are available for items.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Subversion" and clicks on search
    And user performs "facet selection" in "Subversion" attribute under "Technology" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                            | fileName              | userTag |
      | Default     | Directory  | Metadata Type | Subversion,BEC,CAE_SVN_BA      | trunk                 |         |
      | Default     | File       | Metadata Type | Subversion,BEC,Java,CAE_SVN_BA | CollectorFactory.java |         |
      | Default     | SourceTree | Metadata Type | Subversion,BEC,Java,CAE_SVN_BA | CollectorFactory      |         |
      | Default     | Class      | Metadata Type | BEC,Java,CAE_SVN_BA            | CollectorFactory      |         |
      | Default     | Function   | Metadata Type | BEC,Java,CAE_SVN_BA            | CollectorFactory      |         |


  @webtest @CAE_SVN @TEST_MLPQA-3417 @MLPQA-17486 @7247322
  Scenario:SC4# Verify if all item types like Directory,File, SourceTree, Class and Functions are loaded with counts  in DD facet section
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Subversion" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "BEC" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "trunk [Directory]" attribute under "Hierarchy" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Project    |
      | Directory  |
      | File       |
      | SourceTree |
      | Class      |
      | Function   |


  @webtest  @CAE_SVN @TEST_MLPQA-3415 @MLPQA-17486 @7247325
  Scenario: SC5#:#Verify breadcrumb hierarchy for items collected from CAE SVN Collector
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "helper" and clicks on search
    And user performs "facet selection" in "Subversion" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "trunk [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "helper" item from search results
    And user performs click and verify in new window
      | Table       | value                 | Action               | RetainPrevwindow | indexSwitch |
      | Files       | CollectorFactory.java | click and switch tab | No               |             |
      | Source Tree | CollectorFactory      | click and switch tab | No               |             |
      | Classes     | CollectorFactory      | click and switch tab | No               |             |
      | Functions   | CollectorFactory()    | click and switch tab | No               |             |
    Then user "verify presence" of following "hierarchy" in Item View Page
      | DEFAULT               |
      | trunk                 |
      | caeextr               |
      | dev                   |
      | com                   |
      | asg                   |
      | cae                   |
      | source                |
      | collector             |
      | caeextr               |
      | helper                |
      | CollectorFactory.java |
      | CollectorFactory      |
      | CollectorFactory      |


  @webtest  @CAE_SVN @TEST_MLPQA-3374 @TEST_MLPQA-3412 @TEST_MLPQA-3413 @TEST_MLPQA-3414 @MLPQA-17486 @7248947 @7247328 @7247327 @7247326
  Scenario: SC6#:#Verify appropriate metadata values are present for Directory,File,Source Tree,Class and Functions
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "helper" and clicks on search
    And user performs "facet selection" in "Subversion" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "trunk [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "helper" item from search results
    And user performs click and verify in new window
      | Table | value                 | Action               | RetainPrevwindow | indexSwitch |
      | Files | CollectorFactory.java | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue      | widgetName  |
      | Description       | Source Java        | Description |
      | MIME type         | text/x-java-source | Description |
    And user performs click and verify in new window
      | Table       | value                 | Action                 | RetainPrevwindow | indexSwitch |
      | Data        | CollectorFactory.java | verify widget contains | No               |             |
      | Source Tree | CollectorFactory      | click and switch tab   | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Source Java   | Description |
    And user performs click and verify in new window
      | Table   | value            | Action               | RetainPrevwindow | indexSwitch |
      | Classes | CollectorFactory | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Java          | Description |
      | startLine         | 29            | Description |
      | endLine           | 29            | Description |
    And user performs click and verify in new window
      | Table     | value              | Action               | RetainPrevwindow | indexSwitch |
      | Functions | CollectorFactory() | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Java          | Description |
      | startLine         | 29            | Description |
      | endLine           | 29            | Description |


  @webtest @TEST_MLPQA-3424 @MLPQA-17486 @7247278 @CAE_SVN
  Scenario:SC#7:Verify data source connection is successful for SVN Data source with valid and Invalid credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Data Sources" in "Add Data source Configuration"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data source Configuration"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName         | attribute        |
      | Data Source Type* | CAESVNDataSource |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName       | attribute                                            |
      | Name*           | A                                                    |
      | SCMSDir*        | http://gechemsvn1.asg.com/CAE/                       |
      | SCMSExecutable* | C:\Program Files\CollabNet\Subversion Client\svn.exe |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute      |
      | Credential | SVNCredentials |
      | Node       |                |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    Then user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute             |
      | Credential | SVNInvalidCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    Then user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"


  @CAE_SVN
  Scenario:PostCondition#1:Delete project of previously loaded data
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name  | type      | query | param |
      | MultipleIDDelete | Default | trunk | Directory |       |       |

  @CAE_SVN
  Scenario Outline:PreCondition4#Configure and run SVN Collector with PROCESS=LOAD and RINCM="FileName" along with Feed and Loader.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | bodyFile                                    | path                                    | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/SVNCreateEntryPoint                            | payloads/ida/SVNCollector/pluginconfig.json | $.SVNEntryPoint.configurations          | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/SVNCreateEntryPoint                            |                                             |                                         | 200           | SVNCreateEntryPoint    |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/SVNCreateEntryPoint |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='SVNCreateEntryPoint')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAECreateEntryPoint/SVNCreateEntryPoint  |                                             |                                         | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/SVNCreateEntryPoint |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='SVNCreateEntryPoint')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SVNCollector/SVNCollectorSingleFile                                | payloads/ida/SVNCollector/pluginconfig.json | $.SVNCollectorSingleFile.configurations | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SVNCollector/SVNCollectorSingleFile                                |                                             |                                         | 200           | SVNCollectorSingleFile |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/SVNCollector/SVNCollectorSingleFile       |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='SVNCollectorSingleFile')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/SVNCollector/SVNCollectorSingleFile        |                                             |                                         | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/SVNCollector/SVNCollectorSingleFile       |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='SVNCollectorSingleFile')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/SVNFeed                                                    | payloads/ida/SVNCollector/pluginconfig.json | $.SVNFeed.configurations                | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/SVNFeed                                                    |                                             |                                         | 200           | SVNFeed                |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/SVNFeed                           |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='SVNFeed')].status                |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/SVNFeed                            |                                             |                                         | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/SVNFeed                           |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='SVNFeed')].status                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/SVNDDLoader                                            | payloads/ida/SVNCollector/pluginconfig.json | $.SVNDDLoader.configurations            | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/SVNDDLoader                                            |                                             |                                         | 200           | SVNDDLoader            |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoader                  |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='SVNDDLoader')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoader                   |                                             |                                         | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoader                  |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='SVNDDLoader')].status            |


  @webtest  @CAE_SVN @TEST_MLPQA-3396 @MLPQA-17486 @7247850
  Scenario:SC#8:Verify if only the file provided in config line RINCM is collected and loaded in DD.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Subversion" and clicks on search
    And user performs "facet selection" in "Subversion" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "trunk [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
      |              |              |           |           |            |            |                | Metadata Type | Function   | 2     |
      |              |              |           |           |            |            |                | Metadata Type | Directory  | 10    |
      |              |              |           |           |            |            |                | Metadata Type | File       | 1     |
      |              |              |           |           |            |            |                | Metadata Type | Class      | 1     |
      |              |              |           |           |            |            |                | Metadata Type | SourceTree | 1     |

  @CAE_SVN
  Scenario Outline:PreCondition5#Configure and run SVN Collector with PROCESS=AUTO and RINCM="another FileName" along with Feed and Loader with INCREMENTAL=TRUE.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                             | bodyFile                                    | path                                     | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SVNCollector/SVNCollectorSingleFile                          | payloads/ida/SVNCollector/pluginconfig.json | $.SVNCollectorProcessAuto.configurations | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SVNCollector/SVNCollectorSingleFile                          |                                             |                                          | 200           | SVNCollectorSingleFile |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/SVNCollector/SVNCollectorSingleFile |                                             |                                          | 200           | IDLE                   | $.[?(@.configurationName=='SVNCollectorSingleFile')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/SVNCollector/SVNCollectorSingleFile  |                                             |                                          | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/SVNCollector/SVNCollectorSingleFile |                                             |                                          | 200           | IDLE                   | $.[?(@.configurationName=='SVNCollectorSingleFile')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/SVNFeed                                              | payloads/ida/SVNCollector/pluginconfig.json | $.SVNFeed.configurations                 | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/SVNFeed                                              |                                             |                                          | 200           | SVNFeed                |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/SVNFeed                     |                                             |                                          | 200           | IDLE                   | $.[?(@.configurationName=='SVNFeed')].status                |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/SVNFeed                      |                                             |                                          | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/SVNFeed                     |                                             |                                          | 200           | IDLE                   | $.[?(@.configurationName=='SVNFeed')].status                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/SVNDDLoaderIncremental                           | payloads/ida/SVNCollector/pluginconfig.json | $.SVNDDLoaderIncremental.configurations  | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/SVNDDLoaderIncremental                           |                                             |                                          | 200           | SVNDDLoaderIncremental |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoaderIncremental |                                             |                                          | 200           | IDLE                   | $.[?(@.configurationName=='SVNDDLoaderIncremental')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoaderIncremental  |                                             |                                          | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoaderIncremental |                                             |                                          | 200           | IDLE                   | $.[?(@.configurationName=='SVNDDLoaderIncremental')].status |


  @webtest  @CAE_SVN @TEST_MLPQA-3394 @MLPQA-17486 @7247858
  Scenario:SC#9:Verify if SVN collector generates .des file when regex pattern for RINCM in config line= "SVN,trunk/caeextr/dev/com/asg/cae/source/collector/caeextr/helper,TYPE=JAVA,PROCESS=AUTO,SUBF=Y,RINCM=DESFactory.java"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "trunk" and clicks on search
#    And user performs "facet selection" in "Subversion" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "trunk [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
      |              |              |           |           |            |            |                | Metadata Type | Function   | 8     |
      |              |              |           |           |            |            |                | Metadata Type | Directory  | 10    |
      |              |              |           |           |            |            |                | Metadata Type | File       | 2     |
      |              |              |           |           |            |            |                | Metadata Type | Class      | 2     |
      |              |              |           |           |            |            |                | Metadata Type | SourceTree | 2     |


  @CAE_SVN
  Scenario:PostCondition#2:Delete project of previously loaded data
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name  | type      | query | param |
      | MultipleIDDelete | Default | trunk | Directory |       |       |


  @CAE_SVN
  Scenario Outline:PreCondition6#Configure and run SVN Collector with PROCESS=LOAD,SUBF=N and RINCM="FileName" along with Feed and Loader.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | bodyFile                                    | path                                     | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/SVNCreateEntryPoint                            | payloads/ida/SVNCollector/pluginconfig.json | $.SVNEntryPoint.configurations           | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/SVNCreateEntryPoint                            |                                             |                                          | 200           | SVNCreateEntryPoint     |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/SVNCreateEntryPoint |                                             |                                          | 200           | IDLE                    | $.[?(@.configurationName=='SVNCreateEntryPoint')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAECreateEntryPoint/SVNCreateEntryPoint  |                                             |                                          | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/SVNCreateEntryPoint |                                             |                                          | 200           | IDLE                    | $.[?(@.configurationName=='SVNCreateEntryPoint')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SVNCollector/SVNCollectorSubFolderNo                               | payloads/ida/SVNCollector/pluginconfig.json | $.SVNCollectorSubFolderNo.configurations | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SVNCollector/SVNCollectorSubFolderNo                               |                                             |                                          | 200           | SVNCollectorSubFolderNo |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/SVNCollector/SVNCollectorSubFolderNo      |                                             |                                          | 200           | IDLE                    | $.[?(@.configurationName=='SVNCollectorSubFolderNo')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/SVNCollector/SVNCollectorSubFolderNo       |                                             |                                          | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/SVNCollector/SVNCollectorSubFolderNo      |                                             |                                          | 200           | IDLE                    | $.[?(@.configurationName=='SVNCollectorSubFolderNo')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/SVNFeed                                                    | payloads/ida/SVNCollector/pluginconfig.json | $.SVNFeed.configurations                 | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/SVNFeed                                                    |                                             |                                          | 200           | SVNFeed                 |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/SVNFeed                           |                                             |                                          | 200           | IDLE                    | $.[?(@.configurationName=='SVNFeed')].status                 |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/SVNFeed                            |                                             |                                          | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/SVNFeed                           |                                             |                                          | 200           | IDLE                    | $.[?(@.configurationName=='SVNFeed')].status                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/SVNDDLoader                                            | payloads/ida/SVNCollector/pluginconfig.json | $.SVNDDLoader.configurations             | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/SVNDDLoader                                            |                                             |                                          | 200           | SVNDDLoader             |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoader                  |                                             |                                          | 200           | IDLE                    | $.[?(@.configurationName=='SVNDDLoader')].status             |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoader                   |                                             |                                          | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoader                  |                                             |                                          | 200           | IDLE                    | $.[?(@.configurationName=='SVNDDLoader')].status             |


  @webtest  @CAE_SVN @TEST_MLPQA-3395 @MLPQA-17486 @7247855
  Scenario:SC#10:Verify  no sub folders and its files are collected in DD UI when SUBF=N in collector configuration line.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "trunk [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
      |              |              |           |           |            |            |                | Metadata Type | Directory  | 9     |
      |              |              |           |           |            |            |                | Metadata Type | Function   | 251   |
      |              |              |           |           |            |            |                | Metadata Type | File       | 14    |
      |              |              |           |           |            |            |                | Metadata Type | Class      | 13    |
      |              |              |           |           |            |            |                | Metadata Type | SourceTree | 14    |


  @CAE_SVN
  Scenario:PostCondition#3:Delete project of previously loaded data
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name  | type      | query | param |
      | MultipleIDDelete | Default | trunk | Directory |       |       |


  @CAE_SVN
  Scenario Outline:PreCondition7#Load single file of SVN as pre condition for PROCESS=DELETE scenario
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | bodyFile                                    | path                                    | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/SVNCreateEntryPoint                            | payloads/ida/SVNCollector/pluginconfig.json | $.SVNEntryPoint.configurations          | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/SVNCreateEntryPoint                            |                                             |                                         | 200           | SVNCreateEntryPoint    |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/SVNCreateEntryPoint |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='SVNCreateEntryPoint')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAECreateEntryPoint/SVNCreateEntryPoint  |                                             |                                         | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/SVNCreateEntryPoint |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='SVNCreateEntryPoint')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SVNCollector/SVNCollectorSingleFile                                | payloads/ida/SVNCollector/pluginconfig.json | $.SVNCollectorSingleFile.configurations | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SVNCollector/SVNCollectorSingleFile                                |                                             |                                         | 200           | SVNCollectorSingleFile |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/SVNCollector/SVNCollectorSingleFile       |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='SVNCollectorSingleFile')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/SVNCollector/SVNCollectorSingleFile        |                                             |                                         | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/SVNCollector/SVNCollectorSingleFile       |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='SVNCollectorSingleFile')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/SVNFeed                                                    | payloads/ida/SVNCollector/pluginconfig.json | $.SVNFeed.configurations                | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/SVNFeed                                                    |                                             |                                         | 200           | SVNFeed                |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/SVNFeed                           |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='SVNFeed')].status                |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/SVNFeed                            |                                             |                                         | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/SVNFeed                           |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='SVNFeed')].status                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/SVNDDLoader                                            | payloads/ida/SVNCollector/pluginconfig.json | $.SVNDDLoader.configurations            | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/SVNDDLoader                                            |                                             |                                         | 200           | SVNDDLoader            |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoader                  |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='SVNDDLoader')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoader                   |                                             |                                         | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoader                  |                                             |                                         | 200           | IDLE                   | $.[?(@.configurationName=='SVNDDLoader')].status            |


  @CAE_SVN
  Scenario Outline:PreCondition8#Configure and run SVN Collector with PROCESS=DELETE along with Feed and Loader plugins.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                | bodyFile                                    | path                                       | response code | response message          | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SVNCollector/SVNCollectorProcessDelete                          | payloads/ida/SVNCollector/pluginconfig.json | $.SVNCollectorProcessDelete.configurations | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SVNCollector/SVNCollectorProcessDelete                          |                                             |                                            | 200           | SVNCollectorProcessDelete |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/SVNCollector/SVNCollectorProcessDelete |                                             |                                            | 200           | IDLE                      | $.[?(@.configurationName=='SVNCollectorProcessDelete')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/SVNCollector/SVNCollectorProcessDelete  |                                             |                                            | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/SVNCollector/SVNCollectorProcessDelete |                                             |                                            | 200           | IDLE                      | $.[?(@.configurationName=='SVNCollectorProcessDelete')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/SVNFeed                                                 | payloads/ida/SVNCollector/pluginconfig.json | $.SVNFeed.configurations                   | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/SVNFeed                                                 |                                             |                                            | 200           | SVNFeed                   |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/SVNFeed                        |                                             |                                            | 200           | IDLE                      | $.[?(@.configurationName=='SVNFeed')].status                   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/SVNFeed                         |                                             |                                            | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/SVNFeed                        |                                             |                                            | 200           | IDLE                      | $.[?(@.configurationName=='SVNFeed')].status                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/SVNDDLoaderNegativeDelta                            | payloads/ida/SVNCollector/pluginconfig.json | $.SVNDDLoaderNegativeDelta.configurations  | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/SVNDDLoaderNegativeDelta                            |                                             |                                            | 200           | SVNDDLoaderNegativeDelta  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoaderNegativeDelta  |                                             |                                            | 200           | IDLE                      | $.[?(@.configurationName=='SVNDDLoaderNegativeDelta')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoaderNegativeDelta   |                                             |                                            | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoaderNegativeDelta  |                                             |                                            | 200           | IDLE                      | $.[?(@.configurationName=='SVNDDLoaderNegativeDelta')].status  |


  @webtest  @CAE_SVN @TEST_MLPQA-3397 @MLPQA-17486 @7247846
  Scenario:SC#10:Verify no items are loaded after running DD Loader when PROCESS=DELETE in SVN Collector config line
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CollectorFactory.java" and clicks on search
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | File |


  @CAE_SVN
  Scenario Outline:PostCondition4#Delete all SVN credentials,data source and plugin configurations.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                        | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAECreateEntryPoint/SVNCreateEntryPoint |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDeleteEntryPoint/SVNDeleteEntryPoint |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SVNCollector/SVNCollectorSingleFile     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SVNCollector/SVNCollectorSubFolderNo    |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SVNCollector/SVNCollectorProcessDelete  |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SVNCollector/SVNCollector               |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEFeed/SVNFeed                         |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDDLoader/SVNDDLoader                 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDDLoader/SVNDDLoaderIncremental      |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDDLoader/SVNDDLoaderNegativeDelta    |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDataSource/SVNEntryPointDataSource   |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDataSource/SVNFeedLoadDS             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAESVNDataSource/SVNDataSource          |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/SVNInvalidCredentials                 |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/SVNCredentials                        |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/SVNEntryPoint                         |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/CAEOracleServer                       |          |      | 200           |                  |          |


  @CAE_SVN
  Scenario:PostCondition#5:Delete project of previously loaded data
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name  | type      | query | param |
      | MultipleIDDelete | Default | trunk | Directory |       |       |


  @CAE_SVN
  Scenario Outline:PreCondition9#Update data source and configuration for Entry Point,SVN Collector,Feed and Loader
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                      | bodyFile                                   | path                                    | response code | response message        | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/CAESQLServer                        | payloads/ida/SVNCollector/credentials.json | $.CAESQLServer                          | 200           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/CAESQLServer                        |                                            |                                         | 200           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource/SVNEntryPointDataSource | payloads/ida/SVNCollector/datasource.json  | $.SVNSQLEntryPointDS.configurations.[0] | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource/SVNEntryPointDataSource |                                            |                                         | 200           | SVNEntryPointDataSource |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/SVNCredentials                      | payloads/ida/SVNCollector/credentials.json | $.SVNCredentials                        | 200           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/SVNCredentials                      |                                            |                                         | 200           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAESVNDataSource/SVNDataSource        | payloads/ida/SVNCollector/datasource.json  | $.SVNCollectorDS.configurations.[0]     | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAESVNDataSource/SVNDataSource        |                                            |                                         | 200           | SVNDataSource           |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/SVNEntryPoint                       | payloads/ida/SVNCollector/credentials.json | $.SVNEntryPoint                         | 200           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/SVNEntryPoint                       |                                            |                                         | 200           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource/SVNFeedLoadDS           | payloads/ida/SVNCollector/datasource.json  | $.SVNSQLFeedLoadDS.configurations.[0]   | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource/SVNFeedLoadDS           |                                            |                                         | 200           | SVNFeedLoadDS           |          |


  @CAE_SVN
  Scenario Outline:PreCondition10#Configure and run Create Entry Point,SVN Collector,Feed,Load Plugins for CAE SQL Server
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | bodyFile                                    | path                              | response code | response message    | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/SVNCreateEntryPoint                            | payloads/ida/SVNCollector/pluginconfig.json | $.SVNSQLEntryPoint.configurations | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/SVNCreateEntryPoint                            |                                             |                                   | 200           | SVNCreateEntryPoint |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/SVNCreateEntryPoint |                                             |                                   | 200           | IDLE                | $.[?(@.configurationName=='SVNCreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAECreateEntryPoint/SVNCreateEntryPoint  |                                             |                                   | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/SVNCreateEntryPoint |                                             |                                   | 200           | IDLE                | $.[?(@.configurationName=='SVNCreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SVNCollector/SVNCollector                                          | payloads/ida/SVNCollector/pluginconfig.json | $.SVNCollector.configurations     | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SVNCollector/SVNCollector                                          |                                             |                                   | 200           | SVNCollector        |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/SVNCollector/SVNCollector                 |                                             |                                   | 200           | IDLE                | $.[?(@.configurationName=='SVNCollector')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/SVNCollector/SVNCollector                  |                                             |                                   | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/SVNCollector/SVNCollector                 |                                             |                                   | 200           | IDLE                | $.[?(@.configurationName=='SVNCollector')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/SVNFeed                                                    | payloads/ida/SVNCollector/pluginconfig.json | $.SVNFeed.configurations          | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/SVNFeed                                                    |                                             |                                   | 200           | SVNFeed             |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/SVNFeed                           |                                             |                                   | 200           | IDLE                | $.[?(@.configurationName=='SVNFeed')].status             |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/SVNFeed                            |                                             |                                   | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/SVNFeed                           |                                             |                                   | 200           | IDLE                | $.[?(@.configurationName=='SVNFeed')].status             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/SVNDDLoader                                            | payloads/ida/SVNCollector/pluginconfig.json | $.SVNDDLoader.configurations      | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/SVNDDLoader                                            |                                             |                                   | 200           | SVNDDLoader         |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoader                  |                                             |                                   | 200           | IDLE                | $.[?(@.configurationName=='SVNDDLoader')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoader                   |                                             |                                   | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/SVNDDLoader                  |                                             |                                   | 200           | IDLE                | $.[?(@.configurationName=='SVNDDLoader')].status         |


  @webtest @CAE_SVN
  Scenario:SC11#Verify if all the items from SVN repository is loaded in DD when running CAE DD loader from SQL Server
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Subversion" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "BEC" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "trunk [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
      |              |              |           |           |            |            |                | Metadata Type | Directory  | 10    |
      |              |              |           |           |            |            |                | Metadata Type | File       | 7     |
      |              |              |           |           |            |            |                | Metadata Type | SourceTree | 7     |
      |              |              |           |           |            |            |                | Metadata Type | Class      | 7     |
      |              |              |           |           |            |            |                | Metadata Type | Function   | 456   |


  @CAE_SVN
  Scenario Outline:PostCondition6#Delete all SVN credentials,data source and plugin configurations for CAE Oracle server.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                        | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAECreateEntryPoint/SVNCreateEntryPoint |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SVNCollector/SVNCollector               |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEFeed/SVNFeed                         |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDDLoader/SVNDDLoader                 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDataSource/SVNEntryPointDataSource   |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDataSource/SVNFeedLoadDS             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAESVNDataSource/SVNDataSource          |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/SVNCredentials                        |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/SVNEntryPoint                         |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/CAESQLServer                          |          |      | 200           |                  |          |


