Feature:MLP-1400 # Git - I can select folders and subfolders from the branch
  Description:  Currently the include/exclude filters only work on the short file name, and you cannot choose folders.
  I think an approach like in ant would work better, like */.java is all files with extension java in any folder, test/** is everything in the test root folder, etc.
  So maybe a collection of filter items, each filter can specify
  the expression
  include/exclude
  is the expression simple or regular
  is the expression on the file name or the full (related to the root) path
  this is very similar to what we have on HDFSCataloger, so is good for harmonization

  @1400 @MLP-9839 @sanity @positive @regression
  Scenario: SC#1Set the Git Credentials and DataSource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                       | body                                                   | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/credentials/GitValidCredentials  | ida/gitFilterPayloads/MLP-15357/Credentials/valid.json | 200           |                  |          |
      |                  |       |       | Get  | settings/credentials/GitValidCredentials  |                                                        | 200           |                  |          |
      |                  |       |       | Put  | settings/analyzers/GitCollectorDataSource | ida/gitFilterPayloads/gitFolderFilter_DataSource.json  | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                                        | 200           |                  |          |

  #5596839# #6649245
  @webtest @1400 @MLP-9839 @sanity @positive @regression
  Scenario: SC#1Verification of all the files in root folder
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayload.json" file for following values
      | jsonPath                         | jsonValues  |
      | $..filefilters[0].fileMode       | include     |
      | $..filefilters[0].objectType     | folder      |
      | $..filefilters[0].expressionType | simple      |
      | $..filefilters[0].expressions[*] | /*          |
      | $..tags[0]                       | GitFolders1 |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                              | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayload.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                   | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                   | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitFolders1" and clicks on search
    And user performs "facet selection" in "GitFolders1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the below bitbucket API and accumulate count from response using json path "$.size"
      | repositoryPath                                                       | count   |
      | projects/DIQA/repos/automationrepo_gitfilter/files?limit=100         | Include |
      | projects/DIQA/repos/automationrepo_gitfilter/files/Include?limit=100 | Exclude |
      | projects/DIQA/repos/automationrepo_gitfilter/files/Exclude?limit=100 | Exclude |
    And User compares the file count from Bitbucket and search list

  @MLP-4441 @sanity @positive
  Scenario:SC#1:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |
      | SingleItemDelete | Default | automationrepo_gitfilter                           | Project  |       |       |

  ##################################### SC2 ####################################################################

   #5596853#
  @1400 @sanity @positive @regression
  Scenario: SC#2Verification of all the files which is not having specific folder in their path using regex expression
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayload.json" file for following values
      | jsonPath                          | jsonValues          |
      | $..filefilters[0].fileMode        | exclude             |
      | $..filefilters[0]..expressionType | regex               |
      | $..filefilters[0].expressions[*]  | ^((?!SubFolder).)*$ |
      | $..tags[0]                        | GitFolders2         |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                              | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayload.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                   | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                   | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |

    #    #4569009#4569009#
  @webtest @MLP-1396 @sanity @positive @regression
  Scenario Outline:SC2#Collecting the repository and validating the source count in IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitFolders2" and clicks on search
    And user performs "facet selection" in "GitFolders2" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/automationrepo_gitfilter/files/Include/SubFolder?limit=100"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user connects "<database>" and run query using "<catalog>" with "<datatypevalue>" for "<column>"and store the item id results in temp text
    And user performs "latest analysis click" in Item Results page for "collector/GitCollector/Bitbucket AnalysisDemoData%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then IDC "ANALYSIS-GIT" log "-0012" count and count from BitBucket API should match
    Then Source count in log "0012" should have number of newly created files in repository
    Examples:
      | database      | catalog | datatypevalue                                         | column |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN | name   |

  @MLP-4441 @sanity @positive
  Scenario:SC#2:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |
      | SingleItemDelete | Default | GitCollector/Include                               | Project  |       |       |

  ########################################### SC3 ################################################################

   #5596846#6649248
  @1400 @MLP-9839 @sanity @positive @regression
  Scenario: SC#3Verification of collection of all the sub folders and files which is having a folder pattern in path
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayload.json" file for following values
      | jsonPath                         | jsonValues      |
      | $..filefilters[0].fileMode       | include         |
      | $..filefilters[0].expressionType | simple          |
      | $..filefilters[0].expressions[*] | **/SubFolder/** |
      | $..tags[0]                       | GitFolders3     |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                              | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayload.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                   | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                   | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |

      #    #4569009#4569009#
  @webtest @MLP-1400 @sanity @positive @regression
  Scenario Outline:SC3#Collecting the repository and validating the source count in IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitFolders3" and clicks on search
    And user performs "facet selection" in "GitFolders3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/automationrepo_gitfilter/files/Include/SubFolder?limit=100"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user connects "<database>" and run query using "<catalog>" with "<datatypevalue>" for "<column>"and store the item id results in temp text
    And user performs "latest analysis click" in Item Results page for "collector/GitCollector/Bitbucket AnalysisDemoData%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then IDC "ANALYSIS-GIT" log "-0012" count and count from BitBucket API should match
    Then Source count in log "0012" should have number of newly created files in repository
    Examples:
      | database      | catalog | datatypevalue                                         | column |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN | name   |

  @MLP-4441 @sanity @positive
  Scenario:SC#3:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |
      | SingleItemDelete | Default | GitCollector/Include                               | Project  |       |       |

  ######################################### SC4 ###################################################################

   #5596847#
  @1400 @sanity @positive @regression
  Scenario:SC#4Verification of the collection of all the files and sub folders under one path
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayload.json" file for following values
      | jsonPath                         | jsonValues         |
      | $..filefilters[0].fileMode       | include            |
      | $..filefilters[0].expressionType | simple             |
      | $..filefilters[0].expressions[*] | **/Include/**/g/** |
      | $..tags[0]                       | GitFolders4        |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                              | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayload.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                   | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                   | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
  #    #4569009#4569009#
  @webtest @MLP-1400 @sanity @positive @regression
  Scenario Outline:SC4#Collecting the repository and validating the source count in IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitFolders4" and clicks on search
    And user performs "facet selection" in "GitFolders4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/automationrepo_gitfilter/files/Include/SubFolder/g?limit=100"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user connects "<database>" and run query using "<catalog>" with "<datatypevalue>" for "<column>"and store the item id results in temp text
    And user performs "latest analysis click" in Item Results page for "collector/GitCollector/Bitbucket AnalysisDemoData%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then IDC "ANALYSIS-GIT" log "-0012" count and count from BitBucket API should match
    Then Source count in log "0012" should have number of newly created files in repository
    Examples:
      | database      | catalog | datatypevalue                                         | column |
      | APPDBPOSTGRES | Default | collector/GitCollector/Bitbucket AnalysisDemoData%DYN | name   |

  @MLP-4441 @sanity @positive
  Scenario:SC#4:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |
      | SingleItemDelete | Default | GitCollector/Include                               | Project  |       |       |


 ############################################# SC5 ######################################################

  #5596844#
  @1400 @sanity @positive @regression
  Scenario: SC#5Verification of the collection of all the files in one sub folder only
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayload.json" file for following values
      | jsonPath                         | jsonValues      |
      | $..filefilters[0].fileMode       | include         |
      | $..filefilters[0].expressionType | simple          |
      | $..filefilters[0].expressions[*] | **/SubFolder/** |
      | $..tags[0]                       | GitFolders5     |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                              | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayload.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                   | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                   | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |

   #    #4569009#4569009#
  @webtest @MLP-1400 @sanity @positive @regression
  Scenario:SC5#Collecting the repository and validating the source count in IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitFolders5" and clicks on search
    And user performs "facet selection" in "GitFolders5" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/automationrepo_gitfilter/files/Include/SubFolder?limit=100"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list

  @MLP-4441 @sanity @positive
  Scenario:SC#5:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |
      | SingleItemDelete | Default | GitCollector/Include                               | Project  |       |       |

############################################### SC6 ##################################################

  @1400 @sanity @positive @regression
  Scenario: SC#6 Verification of the collection of all the files in repository including the files  in sub folders
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayload.json" file for following values
      | jsonPath                         | jsonValues  |
      | $..filefilters[0].fileMode       | include     |
      | $..filefilters[0].expressionType | simple      |
      | $..filefilters[0].expressions[*] | /**         |
      | $..tags[0]                       | GitFolders6 |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                              | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayload.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                   | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                   | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
  #    #4569009#4569009#
  @webtest @MLP-1400 @sanity @positive @regression
  Scenario:SC6#Collecting the repository and validating the source count in IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitFolders6" and clicks on search
    And user performs "facet selection" in "GitFolders6" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/automationrepo_gitfilter/files?limit=100"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list

  @MLP-4441 @sanity @positive
  Scenario:SC#6:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |
      | SingleItemDelete | Default | GitCollector/Include                               | Project  |       |       |
      | SingleItemDelete | Default | GitCollector/Exclude                               | Project  |       |       |
      | SingleItemDelete | Default | automationrepo_gitfilter                           | Project  |       |       |

#################################### SC7 ##############################################

  @1400 @sanity @positive @regression
  Scenario:SC#7 Verification of the collection of all the files when two inclusion folder filters are given
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayloadMultipleFilter.json" file for following values
      | jsonPath                         | jsonValues    |
      | $..filefilters[0].fileMode       | include       |
      | $..filefilters[0].expressionType | simple        |
      | $..filefilters[0].expressions[*] | **/Include/** |
      | $..filefilters[1].fileMode       | include       |
      | $..filefilters[1].expressionType | simple        |
      | $..filefilters[1].expressions[*] | **/Exclude/** |
      | $..tags[0]                       | GitFolders7   |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                            | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayloadMultipleFilter.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                                 | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                                 | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                                 | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                                 | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |

  #    #4569009#4569009#
  @webtest @MLP-1400 @sanity @positive @regression
  Scenario:SC7#Collecting the repository and validating the source count in IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitFolders7" and clicks on search
    And user performs "facet selection" in "GitFolders7" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the below bitbucket API and accumulate count from response using json path "$.size"
      | repositoryPath                                                        | count   |
      | projects/DIQA/repos/automationrepo_gitfilter/files/Include?limit=1000 | Include |
      | projects/DIQA/repos/automationrepo_gitfilter/files/Exclude?limit=1000 | Include |
    And User compares the file count from Bitbucket and search list

  @MLP-4441 @sanity @positive
  Scenario:SC#7:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |
      | SingleItemDelete | Default | GitCollector/Include                               | Project  |       |       |
      | SingleItemDelete | Default | GitCollector/Exclude                               | Project  |       |       |
      | SingleItemDelete | Default | automationrepo_gitfilter                           | Project  |       |       |


#  ################################################# SC8 #################################################

  @webtest @3736 @sanity @positive @regression
  Scenario:SC#8Verify whether the user can delete the Unwanted Analysis details generated by Collector
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                              | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayload.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                   | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                   | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    And user makes a REST Call for Get request with url "extensions/analyzers/history/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData" and store value of json path"$.[0].name"
    And user makes a REST Call for DELETE request with url "extensions/analyzers/Analysis?analysisname=" for specific Analysis
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the Analysis job name in Search text box and click Search
    Then Analysis job "storedText" should "not be" displayed in Subject Area Search list

  @MLP-4441 @sanity @positive
  Scenario:SC#8:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |

###################################### SC9 ###################################################################

  @webtest @1400 @sanity @negative @regression
  Scenario:SC#9Verification of the collection of the files when an invalid folder filter is given
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayload.json" file for following values
      | jsonPath                         | jsonValues  |
      | $..filefilters[0].fileMode       | include     |
      | $..filefilters[0].expressionType | simple      |
      | $..filefilters[0].expressions[*] | ?           |
      | $..tags[0]                       | GitFolders9 |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                              | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayload.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                   | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                   | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    And sync the test execution for "5" seconds
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitFolders9" and clicks on search
    And user performs "facet selection" in "GitFolders9" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | File |

  @MLP-4441 @sanity @positive
  Scenario:SC#9:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |

######################################## SC10 ############################################################

  @1400 @sanity @positive @regression
  Scenario:SC#10Verification of the collection of specific files in specific folder using multiple folder filters
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayloadMultipleFilter.json" file for following values
      | jsonPath                          | jsonValues    |
      | $..filefilters[0].fileMode        | include       |
      | $..filefilters[0].expressionType  | simple        |
      | $..filefilters[0].expressions[*]  | **/Include/** |
      | $..filefilters[1].fileMode        | include       |
      | $..filefilters[1].expressionType  | simple        |
      | $..filefilters[1].expressions.[0] | **/Exclude/** |
      | $..filefilters[0].objectType      | folder        |
      | $..filefilters[1].objectType      | folder        |
      | $..tags[0]                        | GitFolders10  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                            | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayloadMultipleFilter.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                                 | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                                 | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                                 | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                                 | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |

  #    #4569009#4569009#
  @webtest @MLP-1400 @sanity @positive @regression
  Scenario:SC10#Collecting the repository and validating the source count in IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitFolders10" and clicks on search
    And user performs "facet selection" in "GitFolders10" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the below bitbucket API and accumulate count from response using json path "$.size"
      | repositoryPath                                                        | count   |
      | projects/DIQA/repos/automationrepo_gitfilter/files/Include?limit=1000 | Include |
      | projects/DIQA/repos/automationrepo_gitfilter/files/Exclude?limit=1000 | Include |
    And User compares the file count from Bitbucket and search list

  @MLP-4441 @sanity @positive
  Scenario:SC#10:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |
      | SingleItemDelete | Default | GitCollector/Include                               | Project  |       |       |
      | SingleItemDelete | Default | GitCollector/Exclude                               | Project  |       |       |

###################################### SC11 ##############################################################

  @1400 @sanity @positive @regression
  Scenario:SC#11Verification of the exclusion of all the files in root folder
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayload.json" file for following values
      | jsonPath                         | jsonValues   |
      | $..filefilters[0].fileMode       | exclude      |
      | $..filefilters[0].expressionType | simple       |
      | $..filefilters[0].expressions[*] | /*           |
      | $..tags[0]                       | GitFolders11 |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                              | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayload.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                   | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                   | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |

   #    #4569009#4569009#
  @webtest @MLP-1400 @sanity @positive @regression
  Scenario:SC11#Collecting the repository and validating the source count in IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitFolders11" and clicks on search
    And user performs "facet selection" in "GitFolders11" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the below bitbucket API and accumulate count from response using json path "$.size"
      | repositoryPath                                                        | count   |
      | projects/DIQA/repos/automationrepo_gitfilter/files/Include?limit=1000 | Include |
      | projects/DIQA/repos/automationrepo_gitfilter/files/Exclude?limit=1000 | Include |
    And User compares the file count from Bitbucket and search list

  @MLP-4441 @sanity @positive
  Scenario:SC#11:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |
      | SingleItemDelete | Default | GitCollector/Include                               | Project  |       |       |
      | SingleItemDelete | Default | GitCollector/Exclude                               | Project  |       |       |

################################################## SC12 #####################################################################

  @1400 @sanity @positive @regression
  Scenario:SC#12Verification of the exclusion of all the files in one sub folder
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayload.json" file for following values
      | jsonPath                         | jsonValues              |
      | $..filefilters[0].fileMode       | exclude                 |
      | $..filefilters[0].expressionType | simple                  |
      | $..filefilters[0].expressions[*] | **/Include/SubFolder/** |
      | $..tags[0]                       | GitFolders12            |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                              | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayload.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                   | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                   | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |

  #    #4569009#4569009#
  @webtest @MLP-1400 @sanity @positive @regression
  Scenario:SC12#Collecting the repository and validating the source count in IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitFolders12" and clicks on search
    And user performs "facet selection" in "GitFolders12" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the below bitbucket API and accumulate count from response using json path "$.size"
      | repositoryPath                                                       | count   |
      | projects/DIQA/repos/automationrepo_gitfilter/files?limit=1000        | Include |
      | projects/DIQA/repos/automationrepo_gitfilter/files/Include/SubFolder | Exclude |
    And User compares the file count from Bitbucket and search list

  @MLP-4441 @sanity @positive
  Scenario:SC#12:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |
      | SingleItemDelete | Default | GitCollector/Include                               | Project  |       |       |
      | SingleItemDelete | Default | GitCollector/Exclude                               | Project  |       |       |
      | SingleItemDelete | Default | automationrepo_gitfilter                           | Project  |       |       |

##################################### SC13 ######################################################################

  #6649247
  @1400 @MLP-9839 @sanity @positive @regression
  Scenario:SC#13Verification of the collection of files when one folder level inclusion filter and one folder level exclusion filters are  configured
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayloadMultipleFilter.json" file for following values
      | jsonPath                          | jsonValues    |
      | $..filefilters[0].fileMode        | include       |
      | $..filefilters[0].expressionType  | simple        |
      | $..filefilters[0].expressions[*]  | **/Include/** |
      | $..filefilters[1].fileMode        | exclude       |
      | $..filefilters[1].expressionType  | simple        |
      | $..filefilters[1].expressions.[0] | **/Exclude/** |
      | $..filefilters[0].objectType      | folder        |
      | $..filefilters[1].objectType      | folder        |
      | $..tags[0]                        | GitFolders13  |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                            | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayloadMultipleFilter.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                                 | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                                 | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                                 | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                                 | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |

  #    #4569009#4569009#
  @webtest @MLP-1400 @sanity @positive @regression
  Scenario:SC13#Collecting the repository and validating the source count in IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitFolders13" and clicks on search
    And user performs "facet selection" in "GitFolders13" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/automationrepo_gitfilter/files/Include?limit=100"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list

  @MLP-4441 @sanity @positive
  Scenario:SC#13:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |
      | SingleItemDelete | Default | GitCollector/Include                               | Project  |       |       |

####################################### SC14 ##################################

  @webtest @1400 @sanity @positive @regression
  Scenario:SC#14Verification of the collection of all the files which is not having specific folder in their path using regex expression
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayload.json" file for following values
      | jsonPath                         | jsonValues   |
      | $..filefilters[0].fileMode       | include      |
      | $..filefilters[0].expressionType | regex        |
      | $..filefilters[0].expressions[*] | ^((?!In).)*$ |
      | $..tags[0]                       | GitFolders14 |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                              | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayload.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                   | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                   | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitFolders14" and clicks on search
    And user performs "facet selection" in "GitFolders14" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the below bitbucket API and accumulate count from response using json path "$.size"
      | repositoryPath                                                       | count   |
      | projects/DIQA/repos/automationrepo_gitfilter/files?limit=1000        | Include |
      | projects/DIQA/repos/automationrepo_gitfilter/files/Include?limit=100 | Exclude |
    And User compares the file count from Bitbucket and search list

  @MLP-4441 @sanity @positive
  Scenario:SC#14:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |
      | SingleItemDelete | Default | GitCollector/Exclude                               | Project  |       |       |
      | SingleItemDelete | Default | automationrepo_gitfilter                           | Project  |       |       |

########################################## SC15 #########################################################

  @webtest @1400 @sanity @positive @regression
  Scenario:SC#15Verification of the collection of all the files and sub folders under one path
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayload.json" file for following values
      | jsonPath                         | jsonValues         |
      | $..filefilters[0].fileMode       | include            |
      | $..filefilters[0].expressionType | simple             |
      | $..filefilters[0].expressions[*] | **/Include/**/g/** |
      | $..tags[0]                       | GitFolders15       |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                              | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayload.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                   | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                   | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitFolders15" and clicks on search
    And user performs "facet selection" in "GitFolders15" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the below bitbucket API and accumulate count from response using json path "$.size"
      | repositoryPath                                                         | count   |
      | projects/DIQA/repos/automationrepo_gitfilter/files/Include/SubFolder/g | Include |
    And User compares the file count from Bitbucket and search list

  @MLP-4441 @sanity @positive
  Scenario:SC#15:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |
      | SingleItemDelete | Default | GitCollector/Include                               | Project  |       |       |

    ########################################## SC16  ###########################################################

  @webtest @1400 @sanity @positive @regression
  Scenario:SC#16Verification of the collection of all the files and folders in one sub folder
    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayload.json" file for following values
      | jsonPath                         | jsonValues      |
      | $..filefilters[0].fileMode       | include         |
      | $..filefilters[0].expressionType | simple          |
      | $..filefilters[0].expressions[*] | **/SubFolder/** |
      | $..tags[0]                       | GitFolders16    |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                              | response code | response message           | jsonPath                                                        |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayload.json | 204           |                            |                                                                 |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                   | 200           | Bitbucket AnalysisDemoData |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                   | 200           | IDLE                       |                                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 200           | IDLE                       | $.[?(@.configurationName=='Bitbucket AnalysisDemoData')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitFolders16" and clicks on search
    And user performs "facet selection" in "GitFolders16" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the below bitbucket API and accumulate count from response using json path "$.size"
      | repositoryPath                                                                 | count   |
      | projects/DIQA/repos/automationrepo_gitfilter/files/Include/SubFolder?limit=100 | Include |
    And User compares the file count from Bitbucket and search list

  @MLP-4441 @sanity @positive
  Scenario:SC#16:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |

#   ########################################## SC17  ###########################################################

#  @1400 @sanity @positive @regression
#  Scenario Outline:SC#17update the filter in Git and add unstructured plugin
#    Given user "update" the json file "ida/gitFilterPayloads/gitFolderFilterPayload.json" file for following values
#      | jsonPath                         | jsonValues         |
#      | $..filefilters[0].fileMode       | include            |
#      | $..filefilters[0].expressionType | simple             |
#      | $..filefilters[0].expressions[*] | **/Include/**/g/** |
#      | $..tags[0]                       | GitFolders17       |
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                              | response code | response message | jsonPath |
#      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/GitCollector                                                           | ida/gitFilterPayloads/gitFolderFilterPayload.json | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/GitCollector                                                           |                                                   | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/UnstructuredDataAnalyzer                                               | ida/gitFilterPayloads/Unstructured.json           | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/UnstructuredDataAnalyzer                                               |                                                   | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData  |                                                   | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/Bitbucket%20AnalysisDemoData |                                                   | 204           |                  |          |
#
#  @webtest @1400 @sanity @positive @regression
#  Scenario:SC#17Verification of the Unstructured plugin along with Gitcollector plugin
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "GitFolders17" and clicks on search
#    And user performs "facet selection" in "GitFolders17" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    Then the following tags "Git,GitFolders17" should get displayed for the column "collector/GitCollector"
#    Then the following tags "Git,GitFolders17" should get displayed for the column "Bye1.java"
#
#  @MLP-4441 @sanity @positive
#  Scenario:SC#17:Delete id's
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                                               | type     | query | param |
#      | SingleItemDelete | Default | collector/GitCollector/Bitbucket AnalysisDemoData% | Analysis |       |       |
#      | SingleItemDelete | Default | GitCollector/Include                               | Project  |       |       |

#########################################****************The END of Scenario's***********################################################################

  @JGIT @sanity
  Scenario:SC#18 Delete the local Clone directory for dry run feature
    Given Clone remote repository "automationrepo_gitfilter.git" repository to "local user directory1"
    Then user delete the local cloned directory

  @MLP-1986 @sanity @positive @regression
  Scenario Outline:SC#19 Delete plugin Configurations and credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                       | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/GitValidCredentials  |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollector           |      | 204           |                  |          |
