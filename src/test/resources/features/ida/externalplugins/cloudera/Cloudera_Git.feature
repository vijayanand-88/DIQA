@MLP-5414
Feature:MLP-5414: Cloudera_Git

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline:SC1#-Set the Credentials and DataSource for CNavigator and Git plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                              | body                                                        | response code | response message                 | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ClouderaGitValidCredentials | ida/cloudEraNavigatorPayloads/Credentials/GitValid.json     | 200           |                                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource        | ida/cloudEraNavigatorPayloads/DataSource/GitDataSource.json | 204           |                                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollectorDataSource        |                                                             | 200           | CNavigatorGitCollectorDataSource |          |


    ##6083470##6084414##
  @MLP-5414 @webtest @positive @regression @cloudera
  Scenario:SC#2_MLP_5414_Verify hierarchical directory structure in IDC UI for Git collector appears as same as Git repository directory structure
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                                 | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/GitCollector                                | ida/cloudEraNavigatorPayloads/CloudEra_5414_Git.json | 204           |                  |                                                |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                |                                                      | 200           | GitConfig        |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/GitCollector/GitConfig |                                                      | 200           | IDLE             | $.[?(@.configurationName=='GitConfig')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body | response code | response message | jsonPath                                       |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/GitCollector/GitConfig  |      | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/GitCollector/GitConfig |      | 200           | IDLE             | $.[?(@.configurationName=='GitConfig')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "WebContent" and clicks on search
    And user performs "facet selection" in "CN5414SC3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "WebContent" item from search results
    And user "widget presence" on "has_Directory" in Item view page
    And user "widget presence" on "Files" in Item view page
    Then user performs click and verify in new window
      | Table         | value               | Action                 | RetainPrevwindow | indexSwitch |
      | Files         | balance.jsp         | verify widget contains |                  |             |
      | Files         | verifyLogin211.java | verify widget contains |                  |             |
      | Files         | create.html         | verify widget contains |                  |             |
      | has_Directory | empty               | verify widget contains |                  |             |
      | has_Directory | META-INF            | verify widget contains |                  |             |
    Then user "verify presence" of following "hierarchy" in Item View Page
      | gittestrepo |
      | WebContent  |
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName |
      | Number of files           | 9             | Statistics |
      | Directory size            | 27801         | Statistics |
      | Size of files             | 27801         | Statistics |
      | Number of sub-directories | 4             | Statistics |
    And user enters the search text "CN5414SC3" and clicks on search
    And user performs "facet selection" in "CN5414SC3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/GitCollector/GitConfig%"
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Number of errors  | 0             | Description |
    And user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "collector/GitCollector/GitConfig%" should display below info/error/warning
      | type | logValue                                              | logCode           | pluginName | removableText |
      | INFO | Git collection completed for branch refs/heads/master | ANALYSIS-GIT-0008 |            |               |
    And user clicks on logout button

  ##6084411##
  @MLP-5414 @webtest @positive @regression @cloudera
  Scenario:SC#3_MLP_5414_Verify the mapping of first level directory/files to project and remaining sub folder and files should be mapped to their respective parent(for Git Collector)
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body | response code | response message | jsonPath                                          |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/GitCollector/GitDirectory |      | 200           | IDLE             | $.[?(@.configurationName=='GitDirectory')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body | response code | response message | jsonPath                                          |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/GitCollector/GitDirectory  |      | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/GitCollector/GitDirectory |      | 200           | IDLE             | $.[?(@.configurationName=='GitDirectory')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "src" and clicks on search
    And user performs "facet selection" in "CN5414SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "src" item from search results
    And user "widget presence" on "has_Directory" in Item view page
    And user "widget presence" on "Files" in Item view page
    Then user "verify presence" of following "hierarchy" in Item View Page
      | gittestrepo |
      | src         |
    And user enters the search text "CN5414SC4" and clicks on search
    And user performs "facet selection" in "CN5414SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "g [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "g" item from search results
    And user "widget presence" on "has_Directory" in Item view page
    And user "widget presence" on "Files" in Item view page
    Then user "verify presence" of following "hierarchy" in Item View Page
      | gittestrepo |
      | src         |
      | g           |
    And user enters the search text "CN5414SC4" and clicks on search
    And user performs "facet selection" in "CN5414SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/GitCollector/GitDirectory%"
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Number of errors  | 0             | Description |
    And user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "collector/GitCollector/GitDirectory%" should display below info/error/warning
      | type | logValue                                              | logCode           | pluginName | removableText |
      | INFO | Git collection completed for branch refs/heads/master | ANALYSIS-GIT-0008 |            |               |
    And user clicks on logout button

  @MLP-5414 @positive @regression @cloudera
  Scenario:SC#3:Delete Cluster and all the Analysis log for Git
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                  | type     | query | param |
      | SingleItemDelete | Default | gittestrepo                           | Project  |       |       |
      | MultipleIDDelete | Default | collector/GitCollector/GitDirectory/% | Analysis |       |       |

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline:MLP-5414_Git_SC4-Delete the Credentials and Data Sources
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                              | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaGitValidCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource        |      | 204           |                  |          |
