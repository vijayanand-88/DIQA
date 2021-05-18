Feature: Feature to validate the collection of repositories through the Collector plugin
  Description: To validate Git Datasource plugin and Git collector plugin to check the credentials and repo url is valid
  Git collector plugin configuration is changed due to introduction of Git DataSource plugin

  #6857968
  @positive @sanity @webtest @IDA_E2E
  Scenario:SC1# Verify proper error message is shown if mandatory fields are not filled in Git Collector DataSource plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Data Sources" in "Landing page"
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute              |
      | Type      | GitCollectorDataSource |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Name      | A         |
    And user press "BACK_SPACE" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | URL       | A         |
    And user press "BACK_SPACE" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage             |
      | URL       | URL field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

    #6857968
  @MLP-15357 @GitDataSource @positive @sanity @webtest
  Scenario:SC1# Verify proper error message is shown if mandatory fields are not filled in Git Collector plugin configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Type      | Collector    |
      | Plugin    | GitCollector |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  #6857969
  @MLP-15357 @GitDataSource @positive @sanity @webtest
  Scenario:SC1# Verify error message is displayed when providing incorrect Git repo url in url field
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Data Sources" in "Landing page"
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute              |
      | Type      | GitCollectorDataSource |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute  |
      | URL       | Pythontest |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage   |
      | URL       | UnSupported Git URL |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  #6857971
  @MLP-15357 @GitDataSource @positive @sanity @webtest
  Scenario:SC1# Verify the newly introduced fields in git collector plugin configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Type      | Collector    |
      | Plugin    | GitCollector |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Data Source |
      | Credential  |

    #6882780
  @MLP-15357 @GitDataSource @positive @sanity @webtest
  Scenario:SC1# Verify the Name and Branch name is mandatory in Git collector plugin configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Type      | Collector    |
      | Plugin    | GitCollector |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  @MLP-1986 @sanity @positive @regression
  Scenario Outline:SC1#-Set the Credentials for Git Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                        | body                                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/GitValidCredentials   | ida/gitFilterPayloads/GitCredentials.json                        | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollectorDataSource  | ida/gitFilterPayloads/git_collectory_repo_config_Datasource.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/GitCollectorDataSource  |                                                                  | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/Git_EDIBusCredentials | idc/EdiBusPayloads/Credentials/EDIBusValidCredentials.json       | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Git_EDIBusCredentials |                                                                  | 200           |                  |          |


  @MLP-1986 @sanity @positive @regression
  Scenario:SC1#Run Collector Plugin to validate the new plugin status
    Given user "update" the json file "ida/gitFilterPayloads/git_collector_repo_config.json" file for following values
      | jsonPath   | jsonValues |
      | $..tags[0] | GitSC1     |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                 | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/git_collector_repo_config.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                      | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                      | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                      | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                      | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |


  #4569009#4569009#4575245
  @webtest @MLP-1396 @sanity @positive @regression
  Scenario:SC1-2#Collecting the repository and validating the source count in IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitSC1" and clicks on search
    And user performs "facet selection" in "GitSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/git-collector/files?limit=1000000"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list

  @webtest @regression @sanity @IDA-10.0
  Scenario:SC2# Verify the technology tag is displayed properly for the items cataloged by GitCollector
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitSC1" and clicks on search
    And user performs "facet selection" in "GitSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Git,GitSC1" should get displayed for the column "collector/GitCollector"
    And user performs "facet selection" in "Project" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Git,GitSC1" should get displayed for the column "GitCollector/src"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag        | fileName | userTag |
      | Default     | Directory | Metadata Type | Git,GitSC1 | lib      | GitSC1  |

  @webtest @regression @sanity @IDA-10.0
  Scenario:SC3# Log validations for GitCollector plugin
    Given Analysis log "collector/GitCollector/Bitbucket AnalysisDemoData/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | logCode       | pluginName   | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0019 |              |                |
      | INFO | Plugin Name:GitCollector, Plugin Type:collector, Plugin Version:1.0.0.SNAPSHOT, Node Name:LocalNode, Host Name:c6cd8da304b3, Plugin Configuration name:Bitbucket AnalysisDemoData                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0071 | GitCollector | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin GitCollector Configuration: ---  2020-03-04 05:25:10.440 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: name: "Bitbucket AnalysisDemoData"  2020-03-04 05:25:10.440 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: pluginVersion: "LATEST"  2020-03-04 05:25:10.440 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: label:  2020-03-04 05:25:10.440 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: : "Git Collector"  2020-03-04 05:25:10.440 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: catalogName: "Default"  2020-03-04 05:25:10.440 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: eventClass: null  2020-03-04 05:25:10.441 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: eventCondition: null  2020-03-04 05:25:10.441 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: nodeCondition: null  2020-03-04 05:25:10.441 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: maxWorkSize: 100  2020-03-04 05:25:10.441 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: tags:  2020-03-04 05:25:10.441 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: - "GitSC1"  2020-03-04 05:25:10.441 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: pluginType: "collector"  2020-03-04 05:25:10.441 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: dataSource: "GitCollectorDataSource"  2020-03-04 05:25:10.441 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: credential: "GitValidCredentials"  2020-03-04 05:25:10.441 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: businessApplicationName: null  2020-03-04 05:25:10.441 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: dryRun: false  2020-08-24 16:52:12.150 INFO  - ANALYSIS-0073: Plugin GitCollector Configuration: schedule: null  2020-03-04 05:25:10.441 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: filter:  2020-03-04 05:25:10.441 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: filters:  2020-03-04 05:25:10.441 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: - class: "com.asg.dis.common.analysis.dom.Filter"  2020-03-04 05:25:10.441 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: label: null  2020-03-04 05:25:10.441 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: tags: null  2020-03-04 05:25:10.441 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: branch: "refs/heads/master"  2020-03-04 05:25:10.441 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: deltaTime: "300"  2020-03-04 05:25:10.441 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: extraFilters:  2020-03-04 05:25:10.441 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: filefilters: []  2020-03-04 05:25:10.442 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: maxHits: null  2020-03-04 05:25:10.442 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: contentAnalyzerPlugin: "UnstructuredDataAnalyzer"  2020-03-04 05:25:10.442 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: projectDepth: "1" | ANALYSIS-0073 | GitCollector |                |
      | INFO | Plugin GitCollector Start Time:2020-03-04 05:25:10.438, End Time:2020-03-04 05:28:24.574, Processed Count:109, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0072 | GitCollector |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.520)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0020 |              |                |

     ##############################################EDI BUS#####################################################

 ##6549303
#  @edibus @positive @webtest @regression @sanity
#  Scenario:EDIBus_SC#1MLP-9043_Verify replication of Git items to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "GitSC1" and clicks on search
#    And user performs "facet selection" in "GitSC1" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Git" attribute under "Tags" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | File      |
#      | Analysis  |
#      | Directory |
#      | Project   |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | GIT         | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/EDIBusGitConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                            | body                                            | response code | response message | jsonPath                                       |
#      | application/json | raw   | false | Put          | settings/analyzers/EDIBusDataSource                            | idc/EdiBusPayloads/DataSource/EDIBusDS_Git.json | 204           |                  |                                                |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/EDIBusGitConfig.json         | 204           |                  |                                                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusGit |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDIBusGit')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusGit  |                                                 | 200           |                  |                                                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusGit |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDIBusGit')].status |
#    And user enters the search text "EDIBusGit" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusGit%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user enters the search text "Git" and clicks on search
#    And user performs "facet selection" in "GitSC1" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Git" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Directory" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
#      | AP-DATA      | GIT         | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY ) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                    |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Source Control/Git |
#      | $..selections.['type_s'][*]                   | Directory                                     |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                   | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=GitSC1&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
#      | AP-DATA      | GIT         | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY ) |
#    And user enters the search text "Git" and clicks on search
#    And user performs "facet selection" in "GitSC1" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Git" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | GIT         | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                    |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Source Control/Git |
#      | $..selections.['type_s'][*]                   | File                                          |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                   | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=GitSC1&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | GIT         | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) |
#    And user enters the search text "Git" and clicks on search
#    And user performs "facet selection" in "GitSC1" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Git" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Project" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
#      | AP-DATA      | GIT         | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE_SYSTEM ) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                    |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Source Control/Git |
#      | $..selections.['type_s'][*]                   | Project                                       |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                   | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=GitSC1&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
#      | AP-DATA      | GIT         | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE_SYSTEM ) |
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                        |
#      | AP-DATA      | GIT         | 1.0                | (XNAME * *  ~/ @*Git≫DEFAULT≫DWR_DAT_FILE≫@* ) ,AND,( TYPE = DWR_IDC )       |
#      | AP-DATA      | GIT         | 1.0                | (XNAME * *  ~/ @*Git≫DEFAULT≫DWR_DAT_DIRECTORY≫@* ),AND,( TYPE = DWR_IDC )   |
#      | AP-DATA      | GIT         | 1.0                | (XNAME * *  ~/ @*Git≫DEFAULT≫DWR_DAT_FILE_SYSTEM≫@* ),AND,( TYPE = DWR_IDC ) |
#
#  @MLP-10467 @sanity @positive
#  Scenario:EDIBus_SC#2:Delete all the External Packages and anlysis with respect to commonlinker
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                    | type     | query | param |
#      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusGit/% | Analysis |       |       |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC3# user retrieve Dynamic ID of project and Analysis link
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type    | targetFile                                | jsonpath           |
      | APPDBPOSTGRES | Default | GitCollector/.idea                                    | Project | response/GitCollector/actual/itemIds.json | $..Project.id1     |
      | APPDBPOSTGRES | Default | GitCollector/FolderNameModified                       | Project | response/GitCollector/actual/itemIds.json | $..Project.id2     |
      | APPDBPOSTGRES | Default | GitCollector/AllFormatFilesForFilter                  | Project | response/GitCollector/actual/itemIds.json | $..Project.id3     |
      | APPDBPOSTGRES | Default | GitCollector/WebContent                               | Project | response/GitCollector/actual/itemIds.json | $..Project.id4     |
      | APPDBPOSTGRES | Default | git-collector                                         | Project | response/GitCollector/actual/itemIds.json | $..Project.id5     |
      | APPDBPOSTGRES | Default | GitCollector/src                                      | Project | response/GitCollector/actual/itemIds.json | $..Project.id6     |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN |         | response/GitCollector/actual/itemIds.json | $..has_Analysis.id |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC3# user delete the project and analysis item using dynamic id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson          | inputFile                                 |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id1     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id2     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id3     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id4     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id5     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id6     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id | response/GitCollector/actual/itemIds.json |



 ##############################################SC2#####################################################

  #4587981#
  @JGIT @MLP-1396 @sanity @positive @regression
  Scenario:SC4#Create new file and Run the GitCollector plugin
    Given Clone remote repository "git-collector.git" repository to "local user directory"
    And New file has been created in local git and committed.
    And Changes pushed to "git-collector.git" repository.
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                 | response code | response message | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/git_collector_repo_config.json | 204           |                  |                                                                 |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                      | 200           |                  |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                      | 200           | IDLE             | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |

   #4587981#
  @JGIT @webtest @MLP-1396 @sanity @positive @regression
  Scenario:SC4#validating the source count in IDP
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitSC1" and clicks on search
    And user performs "facet selection" in "GitSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/git-collector/files?limit=1000000"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC4# user retrieve Dynamic ID of project and Analysis link
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type    | targetFile                                | jsonpath           |
      | APPDBPOSTGRES | Default | GitCollector/.idea                                    | Project | response/GitCollector/actual/itemIds.json | $..Project.id1     |
      | APPDBPOSTGRES | Default | GitCollector/FolderNameModified                       | Project | response/GitCollector/actual/itemIds.json | $..Project.id2     |
      | APPDBPOSTGRES | Default | GitCollector/AllFormatFilesForFilter                  | Project | response/GitCollector/actual/itemIds.json | $..Project.id3     |
      | APPDBPOSTGRES | Default | GitCollector/WebContent                               | Project | response/GitCollector/actual/itemIds.json | $..Project.id4     |
      | APPDBPOSTGRES | Default | git-collector                                         | Project | response/GitCollector/actual/itemIds.json | $..Project.id5     |
      | APPDBPOSTGRES | Default | GitCollector/src                                      | Project | response/GitCollector/actual/itemIds.json | $..Project.id6     |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN |         | response/GitCollector/actual/itemIds.json | $..has_Analysis.id |

    #5638844
  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC4# user delete the project and analysis item using dynamic id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson          | inputFile                                 |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id1     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id2     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id3     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id4     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id5     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id6     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id | response/GitCollector/actual/itemIds.json |

  @JGIT @webtest @sanity
  Scenario:SC4#Delete the local Clone directory
    Given Clone remote repository "git-collector.git" repository to "local user directory"
    Then user delete the local cloned directory


##################################################SC3##############################################


    #4587981#4534782#6883809#6883820#4534784
  @JGIT @webtest @MLP-1396 @sanity @positive @regression
  Scenario Outline:SC5#Rename a file from bitbucket repository and Run the Git Collector
    Given Clone remote repository "git-collector.git" repository to "local user directory"
    And New file has been created in local git and committed.
    And Changes pushed to "git-collector.git" repository.
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body | response code | response message | jsonPath                                                        |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |      | 200           |                  |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |      | 200           | IDLE             | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    And A File name has been modified in bitbucket repository and committed
    And Changes pushed to "git-collector.git" repository.
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                       | body | response code | response message | jsonPath                                                        |
      |        | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |      | 200           |                  |                                                                 |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |      | 200           | IDLE             | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitSC1" and clicks on search
    And user performs "facet selection" in "GitSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/git-collector/files?limit=1000000"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user connects "<database>" and run query using "<catalog>" with "<datatypevalue>" for "<column>"and store the item id results in temp text
    And user performs "latest analysis click" in Item Results page for "collector/GitCollector/Bitbucket AnalysisDemoData%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "collector/GitCollector/Bitbucket AnalysisDemoData/%" should display below info/error/warning
      | type | logValue                                           | logCode           | pluginName | removableText |
      | INFO | Collected 1 source(s) for branch refs/heads/master | ANALYSIS-GIT-0012 |            |               |
      | INFO | Deleted 1 source(s) for branch refs/heads/master   | ANALYSIS-GIT-0016 |            |               |
    Examples:
      | database      | catalog | datatypevalue                                         | column |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN | name   |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC5# user retrieve Dynamic ID of project and Analysis link
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type    | targetFile                                | jsonpath           |
      | APPDBPOSTGRES | Default | GitCollector/.idea                                    | Project | response/GitCollector/actual/itemIds.json | $..Project.id1     |
      | APPDBPOSTGRES | Default | GitCollector/FolderNameModified                       | Project | response/GitCollector/actual/itemIds.json | $..Project.id2     |
      | APPDBPOSTGRES | Default | GitCollector/AllFormatFilesForFilter                  | Project | response/GitCollector/actual/itemIds.json | $..Project.id3     |
      | APPDBPOSTGRES | Default | GitCollector/WebContent                               | Project | response/GitCollector/actual/itemIds.json | $..Project.id4     |
      | APPDBPOSTGRES | Default | git-collector                                         | Project | response/GitCollector/actual/itemIds.json | $..Project.id5     |
      | APPDBPOSTGRES | Default | GitCollector/src                                      | Project | response/GitCollector/actual/itemIds.json | $..Project.id6     |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN |         | response/GitCollector/actual/itemIds.json | $..has_Analysis.id |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC5# user delete the project and analysis item using dynamic id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson          | inputFile                                 |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id1     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id2     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id3     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id4     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id5     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id6     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id | response/GitCollector/actual/itemIds.json |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC5# user retrieve Dynamic ID Analysis link
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type | targetFile                                | jsonpath           |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN |      | response/GitCollector/actual/itemIds.json | $..has_Analysis.id |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC5# user delete analysis item using dynamic id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson          | inputFile                                 |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id | response/GitCollector/actual/itemIds.json |

  @JGIT @webtest @sanity
  Scenario:SC5#Delete the local Clone directory
    Given Clone remote repository "git-collector.git" repository to "local user directory"
    Then user delete the local cloned directory

 ########################################################### SC5 ##################################

#    #4587981#4534785#
#  @JGIT @webtest @MLP-1396 @sanity @positive @regression
#  Scenario:SC5-1#Delete a file from bitbucket repository and Run the GitCollector plugin
#    Given Clone remote repository "git-collector.git" repository to "local user directory"
#    And New file has been created in local git and committed.
#    And Changes pushed to "git-collector.git" repository.
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                                       | body | response code | response message | jsonPath                                                        |
#      | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |      | 200           |                  |                                                                 |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |      | 200           | IDLE             | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
#    And Changes pushed to "git-collector.git" repository.
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                                       | body                                                 | response code | response message | jsonPath                                                        |
#      |        | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/git_collector_repo_config.json | 204           |                  |                                                                 |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                      | 200           |                  |                                                                 |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                      | 200           | IDLE             | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
#
#  #4587981#4534785#
#  @JGIT @webtest @MLP-1396 @sanity @positive @regression
#  Scenario Outline:SC5-2#validate in deletion count in IDA collector
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "GitCatalog" catalog and search "GitCatalog" items at top end
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user connects "<database>" and run query using "<catalog>" with "<datatypevalue>" for "<column>"and store the item id results in temp text
#And user performs "latest analysis click" in Item Results page for "collector/GitCollector/Bitbucket AnalysisDemoData%"
#    Then user performs click and verify in new window
#      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
#      | Data | log   | click and switch tab | No               |             |
#    Then user validate Analysis log "0014" in IDB UI
#    Examples:
#      | database      | catalog    | datatypevalue                                         | column |
#      | APPDBPOSTGRES | GitCatalog | collector/GitCollector/Bitbucket AnalysisDemoData%DYN | name   |

 ########################################################### SC6 ##################################

  @JGIT @webtest @MLP-1396 @sanity @positive @regression
  Scenario Outline:SC6#Create new folder and file and validate the source count in IDP
    Given Clone remote repository "git-collector.git" repository to "local user directory"
    And New "Directory" and New "File.txt" has been created
    And Changes pushed to "git-collector.git" repository.
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayload_Directory.json" file for following values
      | jsonPath                         | jsonValues      |
      | $..dryRun                        | false           |
      | $..projectDepth                  | 1               |
      | $..filefilters[0].expressions[*] | **/Directory/** |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                        | response code | response message | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayload_Directory.json | 204           |                  |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                             | 200           |                  |                                                                 |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                             | 200           |                  |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                             | 200           | IDLE             | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitSC1" and clicks on search
    And user performs "facet selection" in "GitSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Hierarchy" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/git-collector/files/src/g/Directory?limit=10000"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list
    And user performs "facet selection" in "Directory" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user connects "<database>" and run query using "<catalog>" with "<datatypevalue>" for "<column>"and store the item id results in temp text
    And user performs "latest analysis click" in Item Results page for "collector/GitCollector/Bitbucket AnalysisDemoData%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Examples:
      | database      | catalog | datatypevalue                                         | column |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN | name   |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC6# user retrieves the total items for a catalog and copy to a json file "Create Dir"
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type    | targetFile                                | jsonpath           |
      | APPDBPOSTGRES | Default | GitCollector/src                                      | Project | response/GitCollector/actual/itemIds.json | $..Project.id1     |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN |         | response/GitCollector/actual/itemIds.json | $..has_Analysis.id |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC6# user delete the  item using dynamic id "Create Dir"
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson          | inputFile                                 |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id1     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id | response/GitCollector/actual/itemIds.json |

  @JGIT @webtest @sanity
  Scenario:SC6#Delete the local Clone directory "create Dir"
    Given Clone remote repository "git-collector.git" repository to "local user directory"
    Then user delete the local cloned directory

########################################################### SC7 ##################################

    #4534787#4534783#
  @JGIT @webtest @MLP-1396 @sanity @positive @regression
  Scenario:SC7#Modify the folder Name and validate the log in IDP
    Given Clone remote repository "git-collector.git" repository to "local user directory"
    And Existing "Directory"name  has been modified to "New Directory".
    And Changes pushed to "git-collector.git" repository.
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayload_Directory.json" file for following values
      | jsonPath                         | jsonValues  |
      | $..dryRun                        | false       |
      | $..projectDepth                  | 1           |
      | $..filefilters[0].expressions[*] | **/src/g/** |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                        | response code | response message | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayload_Directory.json | 204           |                  |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                             | 200           |                  |                                                                 |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                             | 200           |                  |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                             | 200           | IDLE             | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitSC1" and clicks on search
    And user performs "facet selection" in "GitSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/git-collector/files/src/g?limit=10000"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list

  @sanity @positive
  Scenario:SC#7:Delete cluster id and Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                              | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket% | Analysis |       |       |
      | MultipleIDDelete | Default | Git%                              | Project  |       |       |
      | MultipleIDDelete | Default | git%                              | Project  |       |       |

  @JGIT @webtest @sanity
  Scenario:SC7#Delete the local Clone directory "Rename Dir"
    Given Clone remote repository "git-collector.git" repository to "local user directory"
    Then user delete the local cloned directory

########################################################### SC8 ##################################

   #4534789#4534790#
  @JGIT @webtest @MLP-1396 @sanity @positive @regression
  Scenario:SC8#Delete the folder and content and validate the log in IDP
    Given Clone remote repository "git-collector.git" repository to "local user directory"
    And  "New Directory" and its content has been deleted.
    And Changes pushed to "git-collector.git" repository.
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayload_Directory.json" file for following values
      | jsonPath                         | jsonValues |
      | $..dryRun                        | false      |
      | $..projectDepth                  | 1          |
      | $..filefilters[0].expressions[*] | **/g/**    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                        | response code | response message | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayload_Directory.json | 204           |                  |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                             | 200           |                  |                                                                 |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                             | 200           |                  |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                             | 200           | IDLE             | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitSC1" and clicks on search
    And user performs "facet selection" in "GitSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/git-collector/files/src/g?limit=10000"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list

  @sanity @positive
  Scenario:SC#8:Delete cluster id and Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                              | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket% | Analysis |       |       |
      | MultipleIDDelete | Default | Git%                              | Project  |       |       |
      | MultipleIDDelete | Default | git%                              | Project  |       |       |

  @JGIT @webtest @sanity
  Scenario:SC8#Delete the local Clone directory "Del Dir"
    Given Clone remote repository "git-collector.git" repository to "local user directory"
    Then user delete the local cloned directory

########################################################### SC9 ##################################

    #4534786#
  @JGIT @webtest @MLP-1396 @sanity @positive @regression
  Scenario:SC9#Rename Multiple files from bitbucket repository and validate whether update is collected in IDA git collector
    Given Clone remote repository "git-collector.git" repository to "local user directory"
    And user create "2" files in "MultipleFiles" directory
    And Changes pushed to "git-collector.git" repository.
    And supply payload with file name "ida/gitFilterPayloads/git_collector_repo_config.json"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                 | response code | response message | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/git_collector_repo_config.json | 204           |                  |                                                                 |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                      | 200           |                  |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                      | 200           | IDLE             | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    And user modify the file names in "MultipleFiles" directory
    And Changes pushed to "git-collector.git" repository.
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                       | body | response code | response message | jsonPath                                                        |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |      | 200           |                  |                                                                 |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |      | 200           | IDLE             | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitSC1" and clicks on search
    And user performs "facet selection" in "GitSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC9# user retrieve Dynamic ID of project and Analysis link
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type    | targetFile                                | jsonpath           |
      | APPDBPOSTGRES | Default | GitCollector/.idea                                    | Project | response/GitCollector/actual/itemIds.json | $..Project.id1     |
      | APPDBPOSTGRES | Default | GitCollector/FolderNameModified                       | Project | response/GitCollector/actual/itemIds.json | $..Project.id2     |
      | APPDBPOSTGRES | Default | GitCollector/AllFormatFilesForFilter                  | Project | response/GitCollector/actual/itemIds.json | $..Project.id3     |
      | APPDBPOSTGRES | Default | GitCollector/WebContent                               | Project | response/GitCollector/actual/itemIds.json | $..Project.id4     |
      | APPDBPOSTGRES | Default | git-collector                                         | Project | response/GitCollector/actual/itemIds.json | $..Project.id5     |
      | APPDBPOSTGRES | Default | GitCollector/src                                      | Project | response/GitCollector/actual/itemIds.json | $..Project.id6     |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN |         | response/GitCollector/actual/itemIds.json | $..has_Analysis.id |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC9# user delete the project and analysis item using dynamic id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson          | inputFile                                 |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id1     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id2     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id3     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id4     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id5     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id6     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id | response/GitCollector/actual/itemIds.json |

  @JGIT @webtest @sanity
  Scenario:SC9#Delete the local Clone directory
    Given Clone remote repository "git-collector.git" repository to "local user directory"
    Then user delete the local cloned directory

########################################################### SC10 ##################################

  @JGIT @webtest @MLP-1396 @sanity @positive @regression
  Scenario:SC10#Modify the existing content and validating whether changes are collected in IDP
    Given Clone remote repository "git-collector.git" repository to "local user directory"
    And user modify "TestFile.txt" content in "ModifyContent" directory.
    And Changes pushed to "git-collector.git" repository.
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body | response code | response message | jsonPath                                                        |
      | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |      | 200           |                  |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |      | 200           | IDLE             | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitSC1" and clicks on search
    And user performs "facet selection" in "GitSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/git-collector/files?limit=1000000"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list

  @sanity @positive
  Scenario:SC#10:Delete cluster id and Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                              | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket% | Analysis |       |       |
      | MultipleIDDelete | Default | Git%                              | Project  |       |       |
      | MultipleIDDelete | Default | git%                              | Project  |       |       |

  @JGIT @webtest @sanity
  Scenario:SC10#Delete the local Clone directory
    Given Clone remote repository "git-collector.git" repository to "local user directory"
    Then user delete the local cloned directory


############################################################### SC11 ####################################
    #4587981#
  @MLP-1986 @sanity @webtest @positive @regression
  Scenario:SC11#Run Collector Plugin to validate the new plugin status for python repository
    Given user "update" the json file "ida/gitFilterPayloads/python_parser_repo_config.json" file for following values
      | jsonPath   | jsonValues |
      | $..tags[0] | Gitpython  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                     | response code | response message | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                                 | ida/gitFilterPayloads/python_parser_repo_DataSource.json | 204           |                  |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollectorDataSource                                                 |                                                          | 200           |                  |                                                                 |
      |                  |       |       | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/python_parser_repo_config.json     | 204           |                  |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                          | 200           |                  |                                                                 |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                          | 200           |                  |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                          | 200           | IDLE             | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Gitpython" and clicks on search
    And user performs "facet selection" in "Gitpython" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/pythonparserautomationrepo/files?limit=1000000"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC11# user retrieves Analysis and projects ID
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type    | targetFile                                | jsonpath           |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN |         | response/GitCollector/actual/itemIds.json | $..has_Analysis.id |
      | APPDBPOSTGRES | Default | GitCollector/Sample files4                            | Project | response/GitCollector/actual/itemIds.json | $..Project.id1     |
      | APPDBPOSTGRES | Default | pythonparserautomationrepo                            | Project | response/GitCollector/actual/itemIds.json | $..Project.id2     |
      | APPDBPOSTGRES | Default | GitCollector/.idea                                    | Project | response/GitCollector/actual/itemIds.json | $..Project.id3     |
      | APPDBPOSTGRES | Default | GitCollector/src                                      | Project | response/GitCollector/actual/itemIds.json | $..Project.id4     |


  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC11# user delete the Analysis and projects using dynamic id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson          | inputFile                                 |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id1     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id2     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id3     | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id4     | response/GitCollector/actual/itemIds.json |


########################################################### SC12 ##################################

    #4587452#
  @MLP-1986 @sanity @webtest @positive @regression
  Scenario:SC12#Run Collector Plugin to validate the new plugin status for public repository
    Given user "update" the json file "ida/gitFilterPayloads/public_git_repository.json" file for following values
      | jsonPath   | jsonValues |
      | $..tags[0] | Gitpublic  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                        | response code | response message | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                                 | ida/gitFilterPayloads/public_git_repository_DataSource.json | 204           |                  |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollectorDataSource                                                 |                                                             | 200           |                  |                                                                 |
      |                  |       |       | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/public_git_repository.json            | 204           |                  |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                             | 200           |                  |                                                                 |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                             | 200           |                  |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                             | 200           | IDLE             | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Gitpublic" and clicks on search
    And user performs "facet selection" in "Gitpublic" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/git-collector-public-repository/files?limit=1000000"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC12# user retrieves Analysis and projects ID
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type    | targetFile                                | jsonpath           |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN |         | response/GitCollector/actual/itemIds.json | $..has_Analysis.id |
      | APPDBPOSTGRES | Default | GitCollector/git-collector-public-repository          | Project | response/GitCollector/actual/itemIds.json | $..Project.id1     |

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC12# user delete the Analysis and projects using dynamic id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson          | inputFile                                 |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id | response/GitCollector/actual/itemIds.json |
      | items/Default/Default.Project:::dynamic      | 204          | $..Project.id1     | response/GitCollector/actual/itemIds.json |

######################################################## SC13 #####################################################

  #6865494
  @MLP-15357 @sanity @webtest @positive @regression
  Scenario Outline:SC13#Verify the git collector plugin collects the data from public repository when credentials are not provided in data source plugin
    Given user "update" the json file "ida/gitFilterPayloads/public_git_repo_null_credentials.json" file for following values
      | jsonPath   | jsonValues    |
      | $..tags[0] | Gitpublicsc13 |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                                   | response code | response message | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                                 | ida/gitFilterPayloads/public_git_repo_null_credentials_DataSource.json | 204           |                  |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollectorDataSource                                                 |                                                                        | 200           |                  |                                                                 |
      |                  |       |       | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/public_git_repo_null_credentials.json            | 204           |                  |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                                        | 200           |                  |                                                                 |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                                        | 200           |                  |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Gitpublicsc13" and clicks on search
    And user performs "facet selection" in "Gitpublicsc13" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user connects "<database>" and run query using "<catalog>" with "<datatypevalue>" for "<column>"and store the item id results in temp text
    And user performs "latest analysis click" in Item Results page for "collector/GitCollector/Bitbucket AnalysisDemoData%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/git-collector-public-repository/files?limit=1000000"
    And user stores the file count from bitbucket API
    Then Source count in log "0012" should have number of newly created files in repository
    Examples:
      | database      | catalog | datatypevalue                                         | column |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN | name   |


  @MLP-3244 @sanity @positive
  Scenario: SC#13-Delete the Analysis and projects
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData/% | Analysis |       |       |
      | SingleItemDelete | Default | git-collector-public-repository                     | Project  |       |       |


############################################Halt Error Scenarios ###########################################

  @MLP-21711 @sanity @webtest @positive @IDA_E2E
  Scenario Outline:SC14#-Set the InvalidCredentials for Git Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                        | body                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/InValidGitCredentials | ida\gitFilterPayloads\InvalidGitCredentials.json | 200           |                  |          |


  @MLP-21711 @sanity @positive @IDA_E2E
  Scenario:Pre-Condition_update the git config and Git Data Source files with valid values
    Given user "update" the json file "ida/gitFilterPayloads/haltError_gitConfig.json" file for following values
      | jsonPath                  | jsonValues                |
      | $..tags[0]                | validGit                  |
      | $..credential             | GitValidCredentials       |
      | $..name                   | ValidGitconfig            |
      | $..dataSource             | ValidGitDS                |
      | $..filter.filters..branch | PythonAnalyzerDemo_Venkat |
    And user "update" the json file "ida/gitFilterPayloads/haltError_git_DataSource.json" file for following values
      | jsonPath      | jsonValues                                                |
      | $..tags[0]    | ValidGitDS                                                |
      | $..credential | GitValidCredentials                                       |
      | $..name       | ValidGitDS                                                |
      | $..url        | https://source-team.asg.com/scm/di/pythonanalyzerdemo.git |


    #7068382#
  @MLP-21711 @sanity @webtest @positive @IDA_E2E
  Scenario:SC14#Run Collector Plugin to validate whether the halt error is displayed for the invalid credentials in both GitPlugin and GitDS config
    Given user "update" the json file "ida/gitFilterPayloads/haltError_gitConfig.json" file for following values
      | jsonPath      | jsonValues            |
      | $..tags[0]    | Wrongusr_pwd          |
      | $..credential | InValidGitCredentials |
      | $..name       | InvalidGitConfig      |
      | $..dataSource | InvalidGit_DS         |
    And user "update" the json file "ida/gitFilterPayloads/haltError_git_DataSource.json" file for following values
      | jsonPath      | jsonValues            |
      | $..tags[0]    | Wrongusr_pwd          |
      | $..credential | InValidGitCredentials |
      | $..name       | InvalidGit_DS         |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body                                                | response code | response message | jsonPath                                              |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                     | ida/gitFilterPayloads/haltError_git_DataSource.json | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/analyzers/GitCollectorDataSource                                     |                                                     | 200           |                  |                                                       |
      |                  |       |       | Put          | settings/analyzers/GitCollector                                               | ida/gitFilterPayloads/haltError_gitConfig.json      | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                               |                                                     | 200           | InvalidGitConfig |                                                       |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/InvalidGitConfig  |                                                     | 200           |                  |                                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/InvalidGitConfig |                                                     | 200           | IDLE             | $.[?(@.configurationName=='InvalidGitConfig')].status |

#7068382#
  @MLP-21711 @sanity @positive @IDA_E2E
  Scenario Outline:SC14#user save the halt error output in json file
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                     | body | response code | response message | filePath                                                                     | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Get  | /extensions/analyzers/failure/LocalNode/collector/GitCollector/InvalidGitConfig/Default |      | 200           |                  | payloads\ida\gitFilterPayloads\HaltError_API\InvalidCred_DSandGitConfig.json |          |

    #7068382#
  @MLP-21711 @sanity @positive @IDA_E2E
  Scenario Outline:SC14#Validate the error message from UI to the expected message
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                                        | actualValues                                                                 | valueType     | expectedJsonPath        | actualJsonPath          |
      | payloads\ida\gitFilterPayloads\HaltError_API\Expected_InvalidCred_DSandGitConfig.json | payloads\ida\gitFilterPayloads\HaltError_API\InvalidCred_DSandGitConfig.json | stringCompare | $..errorDetails.message | $..errorDetails.message |

  @MLP-3244 @sanity @positive
  Scenario: SC#14-Delete the Analysis and projects
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/InvalidGitConfig% | Analysis |       |       |


      #7068384#
  @MLP-21711 @sanity @webtest @positive @IDA_E2E
  Scenario:SC15#Run Collector Plugin to validate whether the halt error is displayed for the invalid credentials in Git config
    Given user "update" the json file "ida/gitFilterPayloads/haltError_gitConfig.json" file for following values
      | jsonPath      | jsonValues            |
      | $..tags[0]    | Wrongpwd_gitconfig    |
      | $..credential | InValidGitCredentials |
      | $..name       | InvalidGitConfig      |
      | $..dataSource | validGit_DS           |
    And user "update" the json file "ida/gitFilterPayloads/haltError_git_DataSource.json" file for following values
      | jsonPath      | jsonValues          |
      | $..tags[0]    | Wrongpwd_gitconfig  |
      | $..credential | GitValidCredentials |
      | $..name       | validGit_DS         |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body                                                | response code | response message | jsonPath                                              |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                     | ida/gitFilterPayloads/haltError_git_DataSource.json | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/analyzers/GitCollectorDataSource                                     |                                                     | 200           |                  |                                                       |
      |                  |       |       | Put          | settings/analyzers/GitCollector                                               | ida/gitFilterPayloads/haltError_gitConfig.json      | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                               |                                                     | 200           | InvalidGitConfig |                                                       |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/InvalidGitConfig  |                                                     | 200           |                  |                                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/InvalidGitConfig |                                                     | 200           | IDLE             | $.[?(@.configurationName=='InvalidGitConfig')].status |

    #7068384#
  @MLP-21711 @sanity @positive @IDA_E2E
  Scenario Outline:SC15#user save the halt error output in json file
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                     | body | response code | response message | filePath                                                                   | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Get  | /extensions/analyzers/failure/LocalNode/collector/GitCollector/InvalidGitConfig/Default |      | 200           |                  | payloads\ida\gitFilterPayloads\HaltError_API\ValidDS_InvalidGitConfig.json |          |

    #7068384#
  @MLP-21711 @sanity @positive @IDA_E2E
  Scenario Outline:SC15#Validate the error message from UI to the expected message
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                                      | actualValues                                                               | valueType     | expectedJsonPath        | actualJsonPath          |
      | payloads\ida\gitFilterPayloads\HaltError_API\Expected_ValidDS_InvalidGitConfig.json | payloads\ida\gitFilterPayloads\HaltError_API\ValidDS_InvalidGitConfig.json | stringCompare | $..errorDetails.message | $..errorDetails.message |

  @MLP-21711 @sanity @positive @IDA_E2E
  Scenario: SC#15-Delete the Analysis and projects
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/InvalidGitConfig% | Analysis |       |       |


        #7068385#
  @MLP-21711 @sanity @webtest @positive @regression
  Scenario:SC16#Run Collector Plugin to validate whether the halt error is displayed for the invalid URL in Git config
    Given user "update" the json file "ida/gitFilterPayloads/haltError_gitConfig.json" file for following values
      | jsonPath      | jsonValues          |
      | $..tags[0]    | InvalidGitURL       |
      | $..credential | GitValidCredentials |
      | $..name       | InvalidGitURLConfig |
      | $..dataSource | InvalidvalidGit_DS  |
    And user "update" the json file "ida/gitFilterPayloads/haltError_git_DataSource.json" file for following values
      | jsonPath      | jsonValues                                                        |
      | $..tags[0]    | InvalidGitURL                                                     |
      | $..credential | GitValidCredentials                                               |
      | $..name       | InvalidvalidGit_DS                                                |
      | $..url        | https://source-team.asg.com/scm/di/pythonanalyzerdemo_invalid.git |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                              | body                                                | response code | response message    | jsonPath                                                 |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                        | ida/gitFilterPayloads/haltError_git_DataSource.json | 204           |                     |                                                          |
      |                  |       |       | Get          | settings/analyzers/GitCollectorDataSource                                        |                                                     | 200           |                     |                                                          |
      |                  |       |       | Put          | settings/analyzers/GitCollector                                                  | ida/gitFilterPayloads/haltError_gitConfig.json      | 204           |                     |                                                          |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                  |                                                     | 200           | InvalidGitURLConfig |                                                          |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/InvalidGitURLConfig  |                                                     | 200           |                     |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/InvalidGitURLConfig |                                                     | 200           | IDLE                | $.[?(@.configurationName=='InvalidGitURLConfig')].status |

    #7068385#
  @MLP-21711 @sanity @positive @IDA_E2E
  Scenario Outline:SC16#user save the halt error output in json file
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                        | body | response code | response message | filePath                                                              | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Get  | /extensions/analyzers/failure/LocalNode/collector/GitCollector/InvalidGitURLConfig/Default |      | 200           |                  | payloads\ida\gitFilterPayloads\HaltError_API\InvalidGitURLConfig.json |          |

    #7068385#
  @MLP-21711 @sanity @positive @IDA_E2E
  Scenario Outline:SC16#Validate the error message from UI to the expected message
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                                 | actualValues                                                          | valueType     | expectedJsonPath        | actualJsonPath          |
      | payloads\ida\gitFilterPayloads\HaltError_API\Expected_InvalidGitURLConfig.json | payloads\ida\gitFilterPayloads\HaltError_API\InvalidGitURLConfig.json | stringCompare | $..errorDetails.message | $..errorDetails.message |

  @MLP-21711 @sanity @positive @IDA_E2E
  Scenario: SC#16-Delete the Analysis and projects
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/InvalidGitURLConfig% | Analysis |       |       |



       #7068388#
  @MLP-21711 @sanity @webtest @positive @regression
  Scenario:SC17#Run Collector Plugin to validate whether the halt error is displayed for the invalid Branch in Git config
    Given user "update" the json file "ida/gitFilterPayloads/haltError_gitConfig.json" file for following values
      | jsonPath                  | jsonValues              |
      | $..tags[0]                | InvalidBranch           |
      | $..credential             | GitValidCredentials     |
      | $..name                   | InvalidBranch_GitConfig |
      | $..dataSource             | InvalidBranch_DS        |
      | $..filter.filters..branch | invalidBranch           |
    And user "update" the json file "ida/gitFilterPayloads/haltError_git_DataSource.json" file for following values
      | jsonPath      | jsonValues                                                |
      | $..tags[0]    | InvalidBranch                                             |
      | $..credential | GitValidCredentials                                       |
      | $..name       | InvalidBranch_DS                                          |
      | $..url        | https://source-team.asg.com/scm/di/pythonanalyzerdemo.git |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                  | body                                                | response code | response message        | jsonPath                                                     |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                            | ida/gitFilterPayloads/haltError_git_DataSource.json | 204           |                         |                                                              |
      |                  |       |       | Get          | settings/analyzers/GitCollectorDataSource                                            |                                                     | 200           |                         |                                                              |
      |                  |       |       | Put          | settings/analyzers/GitCollector                                                      | ida/gitFilterPayloads/haltError_gitConfig.json      | 204           |                         |                                                              |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                      |                                                     | 200           | InvalidBranch_GitConfig |                                                              |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/InvalidBranch_GitConfig  |                                                     | 200           |                         |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/InvalidBranch_GitConfig |                                                     | 200           | IDLE                    | $.[?(@.configurationName=='InvalidBranch_GitConfig')].status |

#7068388#
  @MLP-21711 @sanity @positive @IDA_E2E
  Scenario Outline:SC17#user save the halt error output in json file
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                            | body | response code | response message | filePath                                                                  | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Get  | /extensions/analyzers/failure/LocalNode/collector/GitCollector/InvalidBranch_GitConfig/Default |      | 200           |                  | payloads\ida\gitFilterPayloads\HaltError_API\InvalidBranch_GitConfig.json |          |

    #7068388#
  @MLP-21711 @sanity @positive @IDA_E2E
  Scenario Outline:SC17#Validate the error message from UI to the expected message
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                                     | actualValues                                                              | valueType     | expectedJsonPath        | actualJsonPath          |
      | payloads\ida\gitFilterPayloads\HaltError_API\Expected_InvalidBranch_GitConfig.json | payloads\ida\gitFilterPayloads\HaltError_API\InvalidBranch_GitConfig.json | stringCompare | $..errorDetails.message | $..errorDetails.message |

  @MLP-21711 @sanity @positive
  Scenario: SC#17-Delete the Analysis and projects
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/InvalidBranch_GitConfig% | Analysis |       |       |


    #bugID-22473
         #7068397#
  @MLP-21711 @sanity @webtest @positive @regression
  Scenario:SC18#Run Collector Plugin to validate whether the halt error is displayed for the Null Branch in Git config
    Given user "update" the json file "ida/gitFilterPayloads/haltError_gitBranchnullConfig.json" file for following values
      | jsonPath      | jsonValues           |
      | $..tags[0]    | NullBranch           |
      | $..credential | GitValidCredentials  |
      | $..name       | NullBranch_GitConfig |
      | $..dataSource | NullGit_DS           |
    And user "update" the json file "ida/gitFilterPayloads/haltError_git_DataSource.json" file for following values
      | jsonPath      | jsonValues                                                |
      | $..tags[0]    | NullBranch                                                |
      | $..credential | GitValidCredentials                                       |
      | $..name       | NullGit_DS                                                |
      | $..url        | https://source-team.asg.com/scm/di/pythonanalyzerdemo.git |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                               | body                                                     | response code | response message     | jsonPath                                                  |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                         | ida/gitFilterPayloads/haltError_git_DataSource.json      | 204           |                      |                                                           |
      |                  |       |       | Get          | settings/analyzers/GitCollectorDataSource                                         |                                                          | 200           |                      |                                                           |
      |                  |       |       | Put          | settings/analyzers/GitCollector                                                   | ida/gitFilterPayloads/haltError_gitBranchnullConfig.json | 204           |                      |                                                           |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                   |                                                          | 200           | NullBranch_GitConfig |                                                           |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/NullBranch_GitConfig  |                                                          | 200           |                      |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/NullBranch_GitConfig |                                                          | 200           | IDLE                 | $.[?(@.configurationName=='NullBranch_GitConfig')].status |

     #7068397#
  @MLP-21711 @sanity @positive @IDA_E2E
  Scenario Outline:SC18#user save the halt error output in json file
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                         | body | response code | response message | filePath                                                               | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Get  | /extensions/analyzers/failure/LocalNode/collector/GitCollector/NullBranch_GitConfig/Default |      | 200           |                  | payloads\ida\gitFilterPayloads\HaltError_API\NullBranch_GitConfig.json |          |

     #7068397#
  @MLP-21711 @sanity @positive @IDA_E2E
  Scenario Outline:SC18#Validate the error message from UI to the expected message
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                                  | actualValues                                                           | valueType     | expectedJsonPath        | actualJsonPath          |
      | payloads\ida\gitFilterPayloads\HaltError_API\Expected_NullBranch_GitConfig.json | payloads\ida\gitFilterPayloads\HaltError_API\NullBranch_GitConfig.json | stringCompare | $..errorDetails.message | $..errorDetails.message |

  @MLP-21711 @sanity @positive
  Scenario: SC#18-Delete the Analysis and projects
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/NullBranch_GitConfig% | Analysis |       |       |


    #7068400#
  @MLP-21711 @sanity @webtest @positive @regression
  Scenario:SC19#Run Collector Plugin to validate whether the halt error is displayed for the work size "0"  in Git config
    Given user "update" the json file "ida/gitFilterPayloads/haltError_gitMaxworkSizeConfig.json" file for following values
      | jsonPath                  | jsonValues                |
      | $..tags[0]                | maxworksize0              |
      | $..credential             | GitValidCredentials       |
      | $..name                   | maxworksize0_Gitconfig    |
      | $..dataSource             | maxworksize0_DS           |
      | $..filter.filters..branch | PythonAnalyzerDemo_Venkat |
    And user "update" the json file "ida/gitFilterPayloads/haltError_git_DataSource.json" file for following values
      | jsonPath      | jsonValues                                                |
      | $..tags[0]    | maxworksize0                                              |
      | $..credential | GitValidCredentials                                       |
      | $..name       | maxworksize0_DS                                           |
      | $..url        | https://source-team.asg.com/scm/di/pythonanalyzerdemo.git |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                 | body                                                      | response code | response message       | jsonPath                                                    |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                           | ida/gitFilterPayloads/haltError_git_DataSource.json       | 204           |                        |                                                             |
      |                  |       |       | Get          | settings/analyzers/GitCollectorDataSource                                           |                                                           | 200           |                        |                                                             |
      |                  |       |       | Put          | settings/analyzers/GitCollector                                                     | ida/gitFilterPayloads/haltError_gitMaxworkSizeConfig.json | 204           |                        |                                                             |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                     |                                                           | 200           | maxworksize0_Gitconfig |                                                             |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/maxworksize0_Gitconfig  |                                                           | 200           |                        |                                                             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/maxworksize0_Gitconfig |                                                           | 200           | IDLE                   | $.[?(@.configurationName=='maxworksize0_Gitconfig')].status |

    #7068400#
  @MLP-21711 @sanity @positive @IDA_E2E
  Scenario Outline:SC19#user save the halt error output in json file
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                           | body | response code | response message | filePath                                                                 | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Get  | /extensions/analyzers/failure/LocalNode/collector/GitCollector/maxworksize0_Gitconfig/Default |      | 200           |                  | payloads\ida\gitFilterPayloads\HaltError_API\maxworksize0_Gitconfig.json |          |

    #7068400#
  @MLP-21711 @sanity @positive @IDA_E2E
  Scenario Outline:SC19#Validate the error message from UI to the expected message
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                                    | actualValues                                                             | valueType     | expectedJsonPath        | actualJsonPath          |
      | payloads\ida\gitFilterPayloads\HaltError_API\Expected_maxworksize0_Gitconfig.json | payloads\ida\gitFilterPayloads\HaltError_API\maxworksize0_Gitconfig.json | stringCompare | $..errorDetails.message | $..errorDetails.message |

  @MLP-21711 @sanity @positive
  Scenario: SC#19-Delete the Analysis and projects
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/maxworksize0_Gitconfig% | Analysis |       |       |


############################################Delete Scenario's ###########################################

  @JGIT @webtest @sanity
  Scenario:SC14#Delete the local Clone directory
    Given Clone remote repository "git-collector.git" repository to "local user directory"
    Then user delete the local cloned directory


  @MLP-1986 @sanity @positive @regression
  Scenario Outline:SC15#Delete plugin Configurations ,credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                        | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/GitValidCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/InValidGitCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollector            |      | 204           |                  |          |
