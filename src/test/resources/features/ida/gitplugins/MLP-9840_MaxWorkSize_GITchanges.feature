Feature: MLP-9840 Collect the file from the repository and create a chunk based on Max Work Size

  @MLP-9840 @sanity @positive @regression
  Scenario:SC#1Set the Git Credentials and DataSource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                       | body                                                   | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/credentials/GitValidCredentials  | ida/gitFilterPayloads/MLP-15357/Credentials/valid.json | 200           |                  |          |
      |                  |       |       | Get  | settings/credentials/GitValidCredentials  |                                                        | 200           |                  |          |
      |                  |       |       | Put  | settings/analyzers/GitCollectorDataSource | ida/gitFilterPayloads/MaxWorkSize_DataSoure.json       | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                                        | 200           |                  |          |


  @MLP-3244 @sanity @positive @regression
  Scenario:SC1#Verify GitCollector with maxWorkSize set to 30
    Given user "update" the json file "ida/gitFilterPayloads/MaxWorkSize.json" file for following values
      | jsonPath       | jsonValues    |
      | $..maxWorkSize | 30            |
      | $..tags[0]     | GitMaxworkSC1 |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body                                   | response code | response message | jsonPath                                          |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                           | ida/gitFilterPayloads/MaxWorkSize.json | 204           |                  |                                                   |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                           |                                        | 200           | GitCollector     |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                        | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  |                                        | 200           | IDLE             |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                        | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |

      #    #4569009#4569009#
  @webtest @MLP-9840 @sanity @positive @regression
  Scenario Outline:SC1#Collecting the repository and validating the source count in IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitMaxworkSC1" and clicks on search
    And user performs "facet selection" in "GitMaxworkSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/automationrepo_gitfilter/files?limit=100"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user connects "<database>" and run query using "<catalog>" with "<datatypevalue>" for "<column>"and store the item id results in temp text
    Then user iterate the analysis logs and click on the log from stored text
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
#    Then IDC "ANALYSIS-GIT" log "-0012" count and count from BitBucket API should match
    Examples:
      | database      | catalog | datatypevalue                           | column |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollector%DYN | name   |

  @MLP-4441 @sanity @positive
  Scenario:SC#1:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                 | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/GitCollector% | Analysis |       |       |
      | SingleItemDelete | Default | automationrepo_gitfilter             | Project  |       |       |


####################################### SC2 ##########################################

  @MLP-9840 @sanity @positive @regression
  Scenario:SC2#Catalog creation with maxWorkSize set to 500
    Given user "update" the json file "ida/gitFilterPayloads/MaxWorkSize.json" file for following values
      | jsonPath       | jsonValues    |
      | $..maxWorkSize | 500           |
      | $..tags[0]     | GitMaxworkSC2 |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body                                   | response code | response message | jsonPath                                          |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                           | ida/gitFilterPayloads/MaxWorkSize.json | 204           |                  |                                                   |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                           |                                        | 200           | GitCollector     |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                        | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  |                                        | 200           | IDLE             |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                        | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |


      #    #4569009#4569009#
  @webtest @MLP-9840 @sanity @positive @regression
  Scenario Outline:SC2#Collecting the repository and validating the source count in IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitMaxworkSC2" and clicks on search
    And user performs "facet selection" in "GitMaxworkSC2" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/automationrepo_gitfilter/files?limit=100"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user connects "<database>" and run query using "<catalog>" with "<datatypevalue>" for "<column>"and store the item id results in temp text
    Then user iterate the analysis logs and click on the log from stored text
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
#    Then IDC "ANALYSIS-GIT" log "-0012" count and count from BitBucket API should match
    Examples:
      | database      | catalog | datatypevalue                           | column |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollector%DYN | name   |

  @MLP-4441 @sanity @positive
  Scenario:SC#2:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                 | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/GitCollector% | Analysis |       |       |
      | SingleItemDelete | Default | automationrepo_gitfilter             | Project  |       |       |

####################################### SC3 ################################################

  @MLP-9840 @sanity @positive @regression
  Scenario:SC3#Catalog creation with maxWorkSize set to 10
    Given user "update" the json file "ida/gitFilterPayloads/MaxWorkSize.json" file for following values
      | jsonPath       | jsonValues    |
      | $..maxWorkSize | 10            |
      | $..tags[0]     | GitMaxworkSC3 |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body                                   | response code | response message | jsonPath                                          |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                           | ida/gitFilterPayloads/MaxWorkSize.json | 204           |                  |                                                   |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                           |                                        | 200           | GitCollector     |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                        | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  |                                        | 200           | IDLE             |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                        | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |

  #    #4569009#4569009#
  @webtest @MLP-9840 @sanity @positive @regression
  Scenario Outline:SC3#Collecting the repository and validating the source count in IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitMaxworkSC3" and clicks on search
    And user performs "facet selection" in "GitMaxworkSC3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And configure a new REST API for the service "BitBucket"
    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/automationrepo_gitfilter/files?limit=100"
    And user stores the file count from bitbucket API
    And User compares the file count from Bitbucket and search list
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user connects "<database>" and run query using "<catalog>" with "<datatypevalue>" for "<column>"and store the item id results in temp text
    Then user iterate the analysis logs and click on the log from stored text
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
#    Then IDC "ANALYSIS-GIT" log "-0012" count and count from BitBucket API should match
    Examples:
      | database      | catalog | datatypevalue                           | column |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollector%DYN | name   |

  @MLP-4441 @sanity @positive
  Scenario:SC#3:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                 | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/GitCollector% | Analysis |       |       |
      | SingleItemDelete | Default | automationrepo_gitfilter             | Project  |       |       |

############################################ SC4 ####################################################

    #6897030
  @MLP-9840 @sanity @positive @regression
  Scenario:SC4#Catalog creation with maxWorkSize set to 0
    Given user "update" the json file "ida/gitFilterPayloads/MaxWorkSize.json" file for following values
      | jsonPath       | jsonValues    |
      | $..maxWorkSize | 0             |
      | $..tags[0]     | GitMaxworkSC4 |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body                                   | response code | response message | jsonPath                                          |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                           | ida/gitFilterPayloads/MaxWorkSize.json | 204           |                  |                                                   |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                           |                                        | 200           | GitCollector     |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                        | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  |                                        | 200           | IDLE             |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                        | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |

  #    #4569009#4569009#
  @webtest @MLP-9840 @sanity @positive @regression
  Scenario Outline:SC4#Collecting the repository and validating the source count in IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GitMaxworkSC4" and clicks on search
    And user performs "facet selection" in "GitMaxworkSC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user connects "<database>" and run query using "<catalog>" with "<datatypevalue>" for "<column>"and store the item id results in temp text
    Then user iterate the analysis logs and click on the log from stored text
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | collector/GitCollector/GitCollector                  |
      | attributeName  | failure                                              |
      | actualFilePath | ida/gitFilterPayloads/actualfailure_maxworksize.json |
    And user remove the json attribute from json file using json path
      | filePath                                               | jsonpath     |
      | ida/gitFilterPayloads/actualfailure_maxworksize.json   | $..timestamp |
      | ida/gitFilterPayloads/expectedfailure_maxworksize.json | $..timestamp |
    Then file content in "ida/gitFilterPayloads/expectedfailure_maxworksize.json" should be same as the content in "ida/gitFilterPayloads/actualfailure_maxworksize.json"
    Examples:
      | database      | catalog | datatypevalue                           | column |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollector%DYN | name   |

  @MLP-4441 @sanity @positive
  Scenario:SC#4:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                 | type     | query | param |
      | SingleItemDelete | Default | collector/GitCollector/GitCollector% | Analysis |       |       |


  @MLP-9840 @sanity @positive @regression
  Scenario:SC5# Delete plugin Configurations and credentials
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                       | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector           |      | 204           |                  |          |
      |                  |       |       | Delete | settings/credentials/GitValidCredentials  |      | 200           |                  |          |
