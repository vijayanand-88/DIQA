Feature: Git - I run a simulation collection to gather the statistics of how many sources would be extracted
  Descriptiom :Run the collection, log all files that are looked at, which one would be collected, but do not do any real collection.

  Technically, only write the Analysis object with the log indicating files looked at and what files and projects would be created if the collection ran.

  Log all files details (no of projects, no of sources, deleted count, modified count, newly added source count)

  @1402 @MLP-9839 @sanity @positive @regression
  Scenario:SC#1Set the Git Credentials and DataSource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                       | body                                                                | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/credentials/GitValidCredentials  | ida/gitFilterPayloads/MLP-15357/Credentials/valid.json              | 200           |                  |          |
      |                  |       |       | Get  | settings/credentials/GitValidCredentials  |                                                                     | 200           |                  |          |
      |                  |       |       | Put  | settings/analyzers/GitCollectorDataSource | ida/gitFilterPayloads/gitFolderFilterDryRunScenario_DataSource.json | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                                                     | 200           |                  |          |


  @webtest @MLP-1402 @sanity @positive @regression
  Scenario Outline:SC1# Verification of Git Collector Log when dry run is set to true
#    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayloadDryRunScenario.json" file for following values
#      | jsonPath                         | jsonValues   | type    |
#      | $..filefilters[0].fileMode       |              |         |
#      | $..filefilters[0].expressionType |              |         |
#      | $..filefilters[0].expressions[*] |              |         |
#      | $..dryRun                        | true         | boolean |
#      | $..tags[0]                       | GitDryRunSC1 |         |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                                       | body                                                            | response code | response message           | jsonPath                                                        |
#      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayloadDryRunScenario.json | 204           |                            |                                                                 |
#      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                                 | 200           | Bitbucket AnalysisDemoData |                                                                 |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                                 | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                                 | 200           | IDLE                       |                                                                 |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                                 | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitDryRunSC1" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | File |
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user connects "<database>" and run query using "<catalog>" with "<datatypevalue>" for "<column>"and store the item id results in temp text
    And user performs "latest analysis click" in Item Results page for "collector/GitCollector/Bitbucket AnalysisDemoData%"
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Number of errors  | 0             | Description |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/git-collector/files?limit=1000000"
    And user stores the file count from bitbucket API
    Examples:
      | database      | catalog | datatypevalue                                         | column |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN | name   |

  @MLP-4441 @sanity @positive
  Scenario:SC#1:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |

################################## SC2 #######################################################

  @JGIT @webtest @MLP-1396 @sanity @positive @regression
  Scenario Outline:SC2# Verification of Incremental Git Collector Log when dry run is set to true
    Given Clone remote repository "git-collector.git" repository to "local user directory1"
    And New file has been created in local git and committed.
    And Changes pushed to "git-collector.git" repository.
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body | response code | response message | jsonPath                                                        |
      | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |      | 200           | IDLE             | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |      | 200           |                  |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |      | 200           | IDLE             | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitDryRunSC1" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user connects "<database>" and run query using "<catalog>" with "<datatypevalue>" for "<column>"and store the item id results in temp text
    And user performs "latest analysis click" in Item Results page for "collector/GitCollector/Bitbucket AnalysisDemoData%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 937           | Description |
      | Number of errors          | 0             | Description |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/git-collector/files?limit=1000000"
    And user stores the file count from bitbucket API
    Examples:
      | database      | catalog | datatypevalue                                         | column |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN | name   |

  @MLP-4441 @sanity @positive
  Scenario:SC#2:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |


######################################## SC3 #############################################################

  @JGIT @webtest @MLP-1396 @sanity @positive @regression
  Scenario Outline:SC3# Verification of Incremental Git Collector Log when dry run is set to false
    Given Clone remote repository "git-collector.git" repository to "local user directory1"
    And New file has been created in local git and committed.
    And Changes pushed to "git-collector.git" repository.
    And user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayloadDryRunScenario.json" file for following values
      | jsonPath                         | jsonValues | type    |
      | $..filefilters[0].fileMode       |            |         |
      | $..filefilters[0].expressionType |            |         |
      | $..filefilters[0].expressions[*] |            |         |
      | $..dryRun                        | false      | boolean |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                            | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayloadDryRunScenario.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                                 | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                                 | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                                 | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                                 | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitDryRunSC1" and clicks on search
    And user performs "facet selection" in "GitDryRunSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user connects "<database>" and run query using "<catalog>" with "<datatypevalue>" for "<column>"and store the item id results in temp text
    And user performs "latest analysis click" in Item Results page for "collector/GitCollector/Bitbucket AnalysisDemoData%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 938           | Description |
      | Number of errors          | 0             | Description |
    Examples:
      | database      | catalog | datatypevalue                                         | column |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN | name   |

  @MLP-4441 @sanity @positive
  Scenario:SC#3:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |
      | MultipleIDDelete | Default | GitCollector/%                                     | Project  |       |       |
      | SingleItemDelete | Default | git-collector                                      | Project  |       |       |


 ####################################################Scenario: End ##########################################

  @1402 @MLP-9839 @sanity @positive @regression
  Scenario:SC#4Update the Git DataSource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                       | body                                                  | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource | ida/gitFilterPayloads/gitFolderFilter_DataSource.json | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                                       | 200           |                  |          |


  @MLP-1402 @webtest @sanity @positive @regression
  Scenario Outline:SC4# Verification of Git Collector Log when dry run is set to true and inclusion filter is configured
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayloadDryRunScenario.json" file for following values
      | jsonPath                         | jsonValues      | type    |
      | $..filefilters[0].fileMode       | include         |         |
      | $..filefilters[0].expressionType | simple          |         |
      | $..filefilters[0].expressions[*] | **/SubFolder/** |         |
      | $..dryRun                        | true            | boolean |
      | $..tags[0]                       | GitDryRunSC2    |         |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                            | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayloadDryRunScenario.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                                 | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                                 | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                                 | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                                 | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitDryRunSC2" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user connects "<database>" and run query using "<catalog>" with "<datatypevalue>" for "<column>"and store the item id results in temp text
    And user performs "latest analysis click" in Item Results page for "collector/GitCollector/Bitbucket AnalysisDemoData%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 10            | Description |
      | Number of errors          | 0             | Description |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And configure a new REST API for the service "BitBucket"
    And User calls the below bitbucket API and accumulate count from response using json path "$.size"
      | repositoryPath                                                                    | count   |
      | projects/DIQA/repos/automationrepo_gitfilter/files/Include/SubFolder?limit=100000 | Include |
    Examples:
      | database      | catalog | datatypevalue                                         | column |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN | name   |

  @MLP-4441 @sanity @positive
  Scenario:SC#4:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |


########################### SC5 #######################################################################


  @webtest @1400 @sanity @positive @regression
  Scenario Outline:SC5# Verification of Git Collector Log when dry run is set to true and exclusion filter is configured
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayloadDryRunScenario.json" file for following values
      | jsonPath                         | jsonValues              | type    |
      | $..filefilters[0].fileMode       | exclude                 |         |
      | $..filefilters[0].expressionType | simple                  |         |
      | $..filefilters[0].expressions[*] | **/Include/SubFolder/** |         |
      | $..dryRun                        | true                    | boolean |
      | $..tags[0]                       | GitDryRunSC3            |         |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                            | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayloadDryRunScenario.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                                 | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                                 | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                                 | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                                 | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitDryRunSC3" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user connects "<database>" and run query using "<catalog>" with "<datatypevalue>" for "<column>"and store the item id results in temp text
    And user performs "latest analysis click" in Item Results page for "collector/GitCollector/Bitbucket AnalysisDemoData%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 75            | Description |
      | Number of errors          | 0             | Description |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And configure a new REST API for the service "BitBucket"
    And User calls the below bitbucket API and accumulate count from response using json path "$.size"
      | repositoryPath                                                       | count   |
      | projects/DIQA/repos/automationrepo_gitfilter/files?limit=1000000     | Include |
      | projects/DIQA/repos/automationrepo_gitfilter/files/Include/SubFolder | Exclude |
    Then IDC "ANALYSIS-GIT" log "-0012" count and count from BitBucket API should match
    Examples:
      | database      | catalog | datatypevalue                                         | column |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN | name   |

  @MLP-4441 @sanity @positive
  Scenario:SC#5:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |


  @JGIT @sanity
  Scenario:SC6# Delete the local Clone directory for dry run feature
    Given Clone remote repository "git-collector.git" repository to "local user directory1"
    Then user delete the local cloned directory


  @MLP-1986 @sanity @positive @regression
  Scenario Outline:SC7# Delete plugin Configurations and credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                       | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollector           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/GitValidCredentials  |      | 200           |                  |          |
