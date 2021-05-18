Feature: Add missing git collector attributes to IDC UI


  @MLP-3244 @sanity @positive @regression
  Scenario:SC#1Set the Git Credentials and DataSource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                       | body                                                   | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/credentials/GitValidCredentials  | ida/gitFilterPayloads/MLP-15357/Credentials/valid.json | 200           |                  |          |
      |                  |       |       | Get  | settings/credentials/GitValidCredentials  |                                                        | 200           |                  |          |
      |                  |       |       | Put  | settings/analyzers/GitCollectorDataSource | ida/gitFilterPayloads/gitFolderFilter_DataSource.json  | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                                        | 200           |                  |          |


  @webtest @MLP-3244 @sanity @positive @regression
  Scenario:SC1# Verification of git collector functionality for Invalid project depth
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayloadProjectDepth.json" file for following values
      | jsonPath        | jsonValues      | type    |
      | $..dryRun       | false           | boolean |
      | $..projectDepth | RT              |         |
      | $..tags[0]      | GitProjectDepth |         |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                          | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayloadProjectDepth.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                               | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                               | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                               | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                               | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitProjectDepth" and clicks on search
    And user performs "facet selection" in "GitProjectDepth" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/GitCollector/Bitbucket AnalysisDemoData%"
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | collector/GitCollector/Bitbucket AnalysisDemoData |
      | attributeName  | failure                                           |
      | actualFilePath | ida/gitFilterPayloads/actualfailure.json          |
    And user remove the json attribute from json file using json path
      | filePath                                   | jsonpath     |
      | ida/gitFilterPayloads/actualfailure.json   | $..timestamp |
      | ida/gitFilterPayloads/expectedfailure.json | $..timestamp |
    Then file content in "ida/gitFilterPayloads/expectedfailure.json" should be same as the content in "ida/gitFilterPayloads/actualfailure.json"

  @MLP-4441 @sanity @positive
  Scenario:SC#1:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |
      | SingleItemDelete | Default | automationrepo_gitfilter                           | Project  |       |       |


######################################## SC2 #####################################################

  #4569009#
  @webtest @MLP-3244 @sanity @positive @regression
  Scenario:SC2# Verification of git collector functionality for valid project depth
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayloadProjectDepth.json" file for following values
      | jsonPath        | jsonValues         | type    |
      | $..dryRun       | false              | boolean |
      | $..projectDepth | 1                  |         |
      | $..tags[0]      | GitProjectDepthSC2 |         |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                          | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayloadProjectDepth.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                               | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                               | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                               | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                               | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitProjectDepthSC2" and clicks on search
    And user performs "facet selection" in "GitProjectDepthSC2" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Project" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | automationrepo_gitfilter |
      | GitCollector/Exclude     |
      | GitCollector/Include     |

  #    #4569009#4569009#
  @webtest @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC2#Collecting the repository and validating the source count in IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitProjectDepthSC2" and clicks on search
    And user performs "facet selection" in "GitProjectDepthSC2" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/automationrepo_gitfilter/files?limit=100"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user connects "<database>" and run query using "<catalog>" with "<datatypevalue>" for "<column>"and store the item id results in temp text
    And user performs "latest analysis click" in Item Results page for "collector/GitCollector/Bitbucket AnalysisDemoData%"
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Number of errors  | 0             | Description |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then IDC "ANALYSIS-GIT" log "-0012" count and count from BitBucket API should match
    Examples:
      | database      | catalog | datatypevalue                                         | column |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN | name   |

  @MLP-4441 @sanity @positive
  Scenario:SC#2:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |
      | SingleItemDelete | Default | automationrepo_gitfilter                           | Project  |       |       |
      | SingleItemDelete | Default | GitCollector/Exclude                               | Project  |       |       |
      | SingleItemDelete | Default | GitCollector/Include                               | Project  |       |       |

######################################## SC3 ##################################################

    #4587981#
  @webtest @MLP-3244 @sanity @positive @regression
  Scenario:SC3# Verification of git collector functionality for zero project depth
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayloadProjectDepth.json" file for following values
      | jsonPath        | jsonValues         | type    |
      | $..dryRun       | false              | boolean |
      | $..projectDepth | 0                  |         |
      | $..tags[0]      | GitProjectDepthSC3 |         |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                          | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayloadProjectDepth.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                               | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                               | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                               | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                               | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitProjectDepthSC3" and clicks on search
    And user performs "facet selection" in "GitProjectDepthSC3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Project" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | automationrepo_gitfilter |

  #4569009#4569009#
  @webtest @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC3#Collecting the repository and validating the source count in IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitProjectDepthSC3" and clicks on search
    And user performs "facet selection" in "GitProjectDepthSC3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/automationrepo_gitfilter/files?limit=100"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user connects "<database>" and run query using "<catalog>" with "<datatypevalue>" for "<column>"and store the item id results in temp text
    And user performs "latest analysis click" in Item Results page for "collector/GitCollector/Bitbucket AnalysisDemoData%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then IDC "ANALYSIS-GIT" log "-0012" count and count from BitBucket API should match
    Examples:
      | database      | catalog | datatypevalue                                         | column |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN | name   |

  @MLP-4441 @sanity @positive
  Scenario:SC#3:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |
      | SingleItemDelete | Default | automationrepo_gitfilter                           | Project  |       |       |

################################## SC4 ###########################################

    #6882946
  @webtest @MLP-3244 @sanity @positive @regression
  Scenario:SC4# Verification of git collector functionality for project depth 2
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayloadProjectDepth.json" file for following values
      | jsonPath        | jsonValues         | type    |
      | $..dryRun       | false              | boolean |
      | $..projectDepth | 2                  |         |
      | $..tags[0]      | GitProjectDepthSC4 |         |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                          | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayloadProjectDepth.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                               | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                               | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                               | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                               | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitProjectDepthSC4" and clicks on search
    And user performs "facet selection" in "GitProjectDepthSC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Project" attribute under "Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | automationrepo_gitfilter       |
      | GitCollector/Include/SubFolder |

  #    #4569009#4569009#
  @webtest @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC4#Collecting the repository and validating the source count in IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitProjectDepthSC4" and clicks on search
    And user performs "facet selection" in "GitProjectDepthSC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/automationrepo_gitfilter/files?limit=100"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user connects "<database>" and run query using "<catalog>" with "<datatypevalue>" for "<column>"and store the item id results in temp text
    And user performs "latest analysis click" in Item Results page for "collector/GitCollector/Bitbucket AnalysisDemoData%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then IDC "ANALYSIS-GIT" log "-0012" count and count from BitBucket API should match
    Examples:
      | database      | catalog | datatypevalue                                         | column |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN | name   |

  @MLP-4441 @sanity @positive
  Scenario:SC#4:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |
      | SingleItemDelete | Default | automationrepo_gitfilter                           | Project  |       |       |
      | SingleItemDelete | Default | GitCollector/Include/SubFolder                     | Project  |       |       |

#################################### SC5 - Bussiness Tag verification ##############################

  @sanity @positive @regression @IDA_E2E
  Scenario Outline:SC5#create BussinessApplication tag and run the plugin configuration with the new field
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                            | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/gitFilterPayloads/BussinessApplication.json | 200           |                  |          |

  #4569009#
  @webtest @MLP-3244 @sanity @positive @regression
  Scenario:SC5# Verification of git collector functionality for Bussiness Tag
    Given user "update" the json file "ida/gitFilterPayloads/gitBussinessTag.json" file for following values
      | jsonPath        | jsonValues | type    |
      | $..dryRun       | false      | boolean |
      | $..projectDepth | 1          |         |
      | $..tags[0]      | GitBusTag  |         |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                       | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitBussinessTag.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                            | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                            | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                            | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                            | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitBusTag" and clicks on search
    And user performs "facet selection" in "GitBusTag" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Git,GitBusTag,GitCollector_BA" should get displayed for the column "collector/GitCollector"
    And user performs "facet selection" in "Project" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Git,GitBusTag,GitCollector_BA" should get displayed for the column "GitCollector/Include"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                           | fileName  | userTag   |
      | Default     | Directory | Metadata Type | Git,GitBusTag,GitCollector_BA | SubFolder | GitBusTag |

  @MLP-4441 @sanity @positive
  Scenario:SC#5:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type                | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis            |       |       |
      | SingleItemDelete | Default | GitCollector/Include                               | Project             |       |       |



  @MLP-1986 @sanity @positive @regression
  Scenario Outline:SC6# Delete plugin Configurations and credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                       | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollector           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/GitValidCredentials  |      | 200           |                  |          |

  @MLP-4441 @sanity @positive
  Scenario:SC#7:Delete BA
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name            | type                | query | param |
      | SingleItemDelete | Default | GitCollector_BA | BusinessApplication |       |       |

