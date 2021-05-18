@MLP-4441
Feature:MLP-4441: cloudera_Hive

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline: SC1#-Set the Credentials and DataSource for CNavigator
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                             | body                                                               | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ClouderaValidCredentials   | ida/cloudEraNavigatorPayloads/Credentials/Valid.json               | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ClouderaInValidCredentials | ida/cloudEraNavigatorPayloads/Credentials/Invalid.json             | 200           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CNavigatorDataSource         | ida/cloudEraNavigatorPayloads/DataSource/CNavigatorDataSource.json | 204           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/CNavigatorDataSource         |                                                                    | 200           | CNavigatorDataSource |          |


  @positive @regression @cloudera @jdbc
  Scenario:SC#1_MLP-4441_Create plugin config Hive and HDFS source types.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                    | body                                                  | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/CNavigatorCataloger | ida/cloudEraNavigatorPayloads/CloudEra_4441_Hive.json | 204           |                  |          |

  @positive @regression @cloudera @jdbc
  Scenario:SC#1_MLP-4441_Run plugin config Hive and HDFS source types.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                              | body | response code | response message | jsonPath                                                         | endpointType | itemName |
      | application/json |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveTopLevelIncludeWithTags |      | 200           | IDLE             | $.[?(@.configurationName=='HiveTopLevelIncludeWithTags')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/CNavigatorCataloger/HiveTopLevelIncludeWithTags  |      | 200           |                  |                                                                  |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveTopLevelIncludeWithTags |      | 200           | IDLE             | $.[?(@.configurationName=='HiveTopLevelIncludeWithTags')].status |              |          |

##6031705##
  @webtest @MLP-4441 @positive @regression @cloudera @MLPQA-18065
  Scenario: SC#1_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype, toplevel include in Hive
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNTagSC1" and clicks on search
    And user performs "facet selection" in "CNTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                   | Feature           | jsonPath        |
      | /entities?query=(sourceType:hive)AND(type:database)AND(originalName:*testdatabase) | CloudEraNavigator | $..originalName |
    And user enters the search text "CNTagSC1" and clicks on search
    And user performs "facet selection" in "CNTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                              | Feature           | jsonPath        |
      | /entities?query=(sourceType:hive)AND(type:table)AND(parentPath:*testdatabase) | CloudEraNavigator | $..originalName |
    And user enters the search text "CNTagSC1" and clicks on search
    And user performs "facet selection" in "CNTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "testtable1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                          | Feature           | jsonPath        |
      | /entities?query=(sourceType:HIVE)AND(type:field)AND(parentPath:*testdatabase*testtable1*) | CloudEraNavigator | $..originalName |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name  | facet         | Tag                              | fileName   | userTag  |
      | Default     | Table | Metadata Type | Cloudera Navigator,CNTagSC1,Hive | testtable1 | CNTagSC1 |

  @MLP-4441 @sanity @positive
  Scenario:SC#1:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                       | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HiveTopLevelIncludeWithTags% | Analysis |       |       |
      | SingleItemDelete | Default | testdatabase                                               | Database |       |       |

############################################Scenario: 2##################################

##6031684##
  @webtest @MLP-4441 @positive @regression @cloudera @MLPQA-18065
  Scenario:SC#2_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype, toplevel include and bottom level include in Hive
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                         | body | response code | response message | jsonPath                                                                    | endpointType | itemName |
      | application/json |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveTopLevelBottomLevelIncludeWithTags |      | 200           | IDLE             | $.[?(@.configurationName=='HiveTopLevelBottomLevelIncludeWithTags')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/CNavigatorCataloger/HiveTopLevelBottomLevelIncludeWithTags  |      | 200           |                  |                                                                             |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveTopLevelBottomLevelIncludeWithTags |      | 200           | IDLE             | $.[?(@.configurationName=='HiveTopLevelBottomLevelIncludeWithTags')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNTagSC2" and clicks on search
    And user performs "facet selection" in "CNTagSC2" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                          | Feature           | jsonPath        |
      | /entities?query=(sourceType:hive)AND(type:database)AND(originalName:hive) | CloudEraNavigator | $..originalName |
    And user enters the search text "CNTagSC2" and clicks on search
    And user performs "facet selection" in "CNTagSC2" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                               | Feature           | jsonPath        |
      | /entities?query=(sourceType:hive)AND(type:table)AND(parentPath:*hive)AND(originalName:persons) | CloudEraNavigator | $..originalName |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name  | facet         | Tag                              | fileName | userTag  |
      | Default     | Table | Metadata Type | Cloudera Navigator,CNTagSC2,Hive | persons  | CNTagSC2 |

  @MLP-4441 @sanity @positive
  Scenario:SC#2:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                  | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HiveTopLevelBottomLevelIncludeWithTags% | Analysis |       |       |
      | SingleItemDelete | Default | hive                                                                  | Database |       |       |

################################### Scenario: 3 ####################################

    ##6031717##
  @webtest @MLP-4441 @positive @regression @cloudera @MLPQA-18065
  Scenario:SC#3_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype, toplevel exclude in Hive
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                              | body | response code | response message | jsonPath                                                         | endpointType | itemName |
      | application/json |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveTopLevelExcludeWithTags |      | 200           | IDLE             | $.[?(@.configurationName=='HiveTopLevelExcludeWithTags')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/CNavigatorCataloger/HiveTopLevelExcludeWithTags  |      | 200           |                  |                                                                  |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveTopLevelExcludeWithTags |      | 200           | IDLE             | $.[?(@.configurationName=='HiveTopLevelExcludeWithTags')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNTagSC3" and clicks on search
    And user performs "facet selection" in "CNTagSC3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                             | Feature           | jsonPath        |
      | /entities?query=(sourceType:hive)AND(type:database)NOT(originalName:*testdatabase*)NOT(originalName:*outdb*) | CloudEraNavigator | $..originalName |
    And user enters the search text "CNTagSC3" and clicks on search
    And user performs "facet selection" in "CNTagSC3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | testdatabase |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name     | facet         | Tag                              | fileName | userTag  |
      | Default     | Database | Metadata Type | Cloudera Navigator,CNTagSC3,Hive | hive     | CNTagSC3 |

  @MLP-4441 @sanity @positive
  Scenario:SC#3:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                       | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HiveTopLevelExcludeWithTags% | Analysis |       |       |
      | SingleItemDelete | Default | Cloudera QuickStart                                        | Cluster  |       |       |

 ########################## Scenario: 4 #########################################

##6031733##
  @webtest @MLP-4441 @positive @regression @cloudera @MLPQA-18065
  Scenario:SC#4_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype, toplevel exclude and  bottom level exclude in Hive
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                         | body | response code | response message | jsonPath                                                                    | endpointType | itemName |
      | application/json |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveTopLevelBottomLevelExcludeWithTags |      | 200           | IDLE             | $.[?(@.configurationName=='HiveTopLevelBottomLevelExcludeWithTags')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/CNavigatorCataloger/HiveTopLevelBottomLevelExcludeWithTags  |      | 200           |                  |                                                                             |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveTopLevelBottomLevelExcludeWithTags |      | 200           | IDLE             | $.[?(@.configurationName=='HiveTopLevelBottomLevelExcludeWithTags')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNTagSC4" and clicks on search
    And user performs "facet selection" in "CNTagSC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 15 items" in Item Search results page
    And user enters the search text "CNTagSC4" and clicks on search
    And user performs "facet selection" in "CNTagSC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | default |
    And user enters the search text "CNTagSC4" and clicks on search
    And user performs "facet selection" in "CNTagSC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | table1 |
      | table2 |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name     | facet         | Tag                              | fileName | userTag  |
      | Default     | Database | Metadata Type | Cloudera Navigator,CNTagSC4,Hive | media    | CNTagSC4 |
      | Default     | Table    | Metadata Type | Cloudera Navigator,CNTagSC4,Hive | t2       | CNTagSC4 |

  @MLP-4441 @sanity @positive
  Scenario:SC#4:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                  | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HiveTopLevelBottomLevelExcludeWithTags% | Analysis |       |       |
      | SingleItemDelete | Default | Cloudera QuickStart                                                   | Cluster  |       |       |


################################ Scenario: 5 ########################################################

##6031719##
  @webtest @MLP-4441 @positive @regression @cloudera @MLPQA-18065
  Scenario:SC#5_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype, toplevel include and  bottom level exclude in Hive
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                              | body | response code | response message | jsonPath                                                         | endpointType | itemName |
      | application/json |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveTopIncludeBottomExclude |      | 200           | IDLE             | $.[?(@.configurationName=='HiveTopIncludeBottomExclude')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/CNavigatorCataloger/HiveTopIncludeBottomExclude  |      | 200           |                  |                                                                  |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveTopIncludeBottomExclude |      | 200           | IDLE             | $.[?(@.configurationName=='HiveTopIncludeBottomExclude')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNTagSC5" and clicks on search
    And user performs "facet selection" in "CNTagSC5" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                                                                                                                                       | Feature           | jsonPath        |
      | /entities?query=(((sourceType:hive)AND(type:database)AND(originalName:testdatabase1)AND(deleted:false))OR((sourceType:hive)AND(type:table)AND(parentPath:*testdatabase1*)NOT(originalName:*table*)AND(deleted:false))) | CloudEraNavigator | $..originalName |
    And user enters the search text "CNTagSC5" and clicks on search
    And user performs "facet selection" in "CNTagSC5" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | table1 |
      | table2 |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name     | facet         | Tag                              | fileName      | userTag  |
      | Default     | Database | Metadata Type | Cloudera Navigator,CNTagSC5,Hive | testdatabase1 | CNTagSC5 |
      | Default     | Table    | Metadata Type | Cloudera Navigator,CNTagSC5,Hive | payroll       | CNTagSC5 |
    And user enters the search text "CNTagSC5" and clicks on search
    And user performs "facet selection" in "CNTagSC5" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "testdatabase1 [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | table1 |
      | table2 |

  @MLP-4441 @sanity @positive
  Scenario:SC#5:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                       | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HiveTopIncludeBottomExclude% | Analysis |       |       |
      | SingleItemDelete | Default | Cloudera QuickStart                                        | Cluster  |       |       |

  ################################ Scenario: 6 ######################################

##6031731##
  @webtest @MLP-4441 @positive @regression @cloudera @MLPQA-18065
  Scenario:SC#6_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype, multiple toplevel exclude in Hive
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                        | body | response code | response message | jsonPath                                                   | endpointType | itemName |
      | application/json |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveMutipleTopExclude |      | 200           | IDLE             | $.[?(@.configurationName=='HiveMutipleTopExclude')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/CNavigatorCataloger/HiveMutipleTopExclude  |      | 200           |                  |                                                            |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveMutipleTopExclude |      | 200           | IDLE             | $.[?(@.configurationName=='HiveMutipleTopExclude')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNTagSC6" and clicks on search
    And user performs "facet selection" in "CNTagSC6" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                                                             | Feature           | jsonPath        |
      | /entities?query=(sourceType:hive)AND(type:database)NOT(originalName:hive*)NOT(originalName:default*)NOT(originalName:out*)AND(deleted:false) | CloudEraNavigator | $..originalName |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name     | facet         | Tag                              | fileName      | userTag  |
      | Default     | Database | Metadata Type | Cloudera Navigator,CNTagSC6,Hive | testdatabase1 | CNTagSC6 |

  @MLP-4441 @sanity @positive
  Scenario:SC#6:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HiveMutipleTopExclude% | Analysis |       |       |
      | SingleItemDelete | Default | Cloudera QuickStart                                  | Cluster  |       |       |


 ######################### Scenario: 7 #####################################

##6031718##
  @webtest @MLP-4441 @positive @regression @cloudera @MLPQA-18065
  Scenario:SC#7_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype, bottomlevel exclude in Hive
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                 | body | response code | response message | jsonPath                                                            | endpointType | itemName |
      | application/json |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveBottomLevelExcludeWithTags |      | 200           | IDLE             | $.[?(@.configurationName=='HiveBottomLevelExcludeWithTags')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/CNavigatorCataloger/HiveBottomLevelExcludeWithTags  |      | 200           |                  |                                                                     |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveBottomLevelExcludeWithTags |      | 200           | IDLE             | $.[?(@.configurationName=='HiveBottomLevelExcludeWithTags')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNTagSC7" and clicks on search
    And user performs "facet selection" in "CNTagSC7" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "default [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
       Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                                     | Feature           | jsonPath        |
      | /entities?query=(sourceType:hive)AND(type:table)AND(parentPath:*default*)NOT(originalName:census*)AND(deleted:false) | CloudEraNavigator | $..originalName |
    And user enters the search text "census" and clicks on search
    And user performs "facet selection" in "CNTagSC7" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Table |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name  | facet         | Tag                              | fileName     | userTag  |
      | Default     | Table | Metadata Type | Cloudera Navigator,CNTagSC7,Hive | flight_count | CNTagSC7 |

  @MLP-4441 @sanity @positive
  Scenario:SC#7:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                          | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HiveBottomLevelExcludeWithTags% | Analysis |       |       |
      | SingleItemDelete | Default | Cloudera QuickStart                                           | Cluster  |       |       |


########################## Scenario: 8###########################################

##6031692##
  @webtest @MLP-4441 @positive @regression @cloudera @MLPQA-18065
  Scenario:SC#8_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype and bottom level include in Hive
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                 | body | response code | response message | jsonPath                                                            | endpointType | itemName |
      | application/json |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveBottomLevelIncludeWithTags |      | 200           | IDLE             | $.[?(@.configurationName=='HiveBottomLevelIncludeWithTags')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/CNavigatorCataloger/HiveBottomLevelIncludeWithTags  |      | 200           |                  |                                                                     |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveBottomLevelIncludeWithTags |      | 200           | IDLE             | $.[?(@.configurationName=='HiveBottomLevelIncludeWithTags')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNTagSC8" and clicks on search
    And user performs "facet selection" in "CNTagSC8" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                                                              | Feature           | jsonPath        |
      | /entities?query=((sourceType:hive)AND(type:database)AND(originalName:hive))OR((sourceType:hive)AND(type:table)AND(originalName:secondtable*)) | CloudEraNavigator | $..originalName |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name     | facet         | Tag                              | fileName    | userTag  |
      | Default     | Table    | Metadata Type | Cloudera Navigator,CNTagSC8,Hive | secondtable | CNTagSC8 |
      | Default     | Database | Metadata Type | Cloudera Navigator,CNTagSC8,Hive | hive        | CNTagSC8 |

  @MLP-4441 @sanity @positive
  Scenario:SC#8:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                          | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HiveBottomLevelIncludeWithTags% | Analysis |       |       |
      | SingleItemDelete | Default | hive                                                          | Database |       |       |


########################## Scenario: 9 #############################################

##6031734##
  @webtest @MLP-4441 @positive @regression @cloudera @MLPQA-18065
  Scenario:SC#9_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype and time intervals in Hive
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                    | body | response code | response message | jsonPath                                               | endpointType | itemName |
      | application/json |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveWithDiffDates |      | 200           | IDLE             | $.[?(@.configurationName=='HiveWithDiffDates')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/CNavigatorCataloger/HiveWithDiffDates  |      | 200           |                  |                                                        |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveWithDiffDates |      | 200           | IDLE             | $.[?(@.configurationName=='HiveWithDiffDates')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNTagSC9" and clicks on search
    And user performs "facet selection" in "CNTagSC9" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 21 items" in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name  | facet         | Tag                              | fileName | userTag  |
      | Default     | Table | Metadata Type | Cloudera Navigator,CNTagSC9,Hive | census   | CNTagSC9 |

  @MLP-4441 @sanity @positive
  Scenario:SC#9:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                             | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HiveWithDiffDates% | Analysis |       |       |
      | SingleItemDelete | Default | hive                                             | Database |       |       |
      | SingleItemDelete | Default | default                                          | Database |       |       |
      | SingleItemDelete | Default | testdatabase1                                    | Database |       |       |
      | SingleItemDelete | Default | testdatabase                                     | Database |       |       |


########################### Scenario: 10 ######################################################

    ##6044686##
  @webtest @MLP-4441 @positive @regression @cloudera
  Scenario:SC#10_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype and same time intervals in Hive
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                    | body | response code | response message | jsonPath                                               | endpointType | itemName |
      | application/json |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveWithSameDates |      | 200           | IDLE             | $.[?(@.configurationName=='HiveWithSameDates')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/CNavigatorCataloger/HiveWithSameDates  |      | 200           |                  |                                                        |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveWithSameDates |      | 200           | IDLE             | $.[?(@.configurationName=='HiveWithSameDates')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNTagSC10" and clicks on search
    And user performs "facet selection" in "CNTagSC10" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Analysis |
      | Cluster  |
      | Service  |

  @MLP-4441 @sanity @positive
  Scenario:SC#10:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                             | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HiveWithSameDates% | Analysis |       |       |
      | SingleItemDelete | Default | Cloudera QuickStart                              | Cluster  |       |       |

########################## Hive scenarios from MLP-4610 ###############

   ##5988824##
  @MLP-4610 @webtest @positive @regression @cloudera
  Scenario:SC#1_MLP_4610_Verify the metadata attributes for Hive Database entity matches with metadata attributes in cloudera navigator when a database is scanned.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                    | body | response code | response message   | jsonPath                                                |
      | application/json |       |       | Get          | settings/analyzers/CNavigatorCataloger                                                 |      | 200           | HiveConfiguration1 |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveConfiguration1 |      | 200           | IDLE               | $.[?(@.configurationName=='HiveConfiguration1')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                            | body | response code | response message | jsonPath                                                |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HiveConfiguration1  |      | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HiveConfiguration1 |      | 200           | IDLE             | $.[?(@.configurationName=='HiveConfiguration1')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4610SC1" and clicks on search
    And user performs "facet selection" in "CN4610SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                        | Feature           | jsonPath        |
      | /entities?query=(sourceType:hive)AND(type:database)AND(originalName:testscanrelations*) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  ##5989119##
  @MLP-4610 @webtest @positive @regression @cloudera
  Scenario:SC#2_MLP_4610_Verify the metadata attributes for Hive table entity matches with metadata attributes in cloudera navigator when a table is scanned.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4610SC1" and clicks on search
    And user performs "facet selection" in "CN4610SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                    | Feature           | jsonPath        |
      | /entities?query=(sourceType:hive)AND(type:table)AND(parentPath:*testscanrelations*) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  ##5989723##
  @MLP-4610 @webtest @positive @regression @cloudera
  Scenario:SC#3_MLP_4610_Verify the metadata attributes for Hive Database entity matches with metadata attributes in cloudera navigator for column entity.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4610SC1" and clicks on search
    And user performs "facet selection" in "CN4610SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "scantable1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                             | Feature           | jsonPath        |
      | /entities?query=(sourceType:HIVE)AND(type:field)AND(parentPath:*scantable1*) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:SC#1,2,3 :Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HiveConfiguration1% | Analysis  |       |       |
      | MultipleIDDelete | Default | select * from %                                   | Operation |       |       |
      | MultipleIDDelete | Default | select * from %                                   | Execution |       |       |
      | MultipleIDDelete | Default | testscanrelations%                                | Database  |       |       |
      | MultipleIDDelete | Default | insert%                                           | Operation |       |       |


##5989754##
  @MLP-4610 @webtest @positive @regression @cloudera
  Scenario:SC#4_MLP_4610_Verify the metadata attributes for Hive Database entity matches with metadata attributes in cloudera navigator for Operation entity.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                               | body | response code | response message | jsonPath                                           |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveOperation |      | 200           | IDLE             | $.[?(@.configurationName=='HiveOperation')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body | response code | response message | jsonPath                                           |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HiveOperation  |      | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HiveOperation |      | 200           | IDLE             | $.[?(@.configurationName=='HiveOperation')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4610SC4" and clicks on search
    And user performs "facet selection" in "CN4610SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies Search results present in UI List contains CloudEra API item
      | RESTAPI Endpoint                                                                       | Feature           | jsonPath        |
      | /entities?query=(sourceType:HIVE)AND(type:operation)AND(queryText:*testscanrelations*) | CloudEraNavigator | $..originalName |
    And user clicks on logout button


##5989764##
  @webtest @MLP-4610 @positive @regression
  Scenario:SC#5_MLP-4610_Verify the metadata attributes for Hive Database entity matches with metadata attributes in cloudera navigator for execution entity.
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4610SC4" and clicks on search
    And user performs "facet selection" in "CN4610SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                    | Feature           | jsonPath        |
      | /entities?query=(sourceType:hive)AND(type:operation_execution)AND(originalName:*testscanrelations*) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:SC#4,5:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HiveOperation% | Analysis  |       |       |
      | MultipleIDDelete | Default | select * from %                              | Operation |       |       |
      | MultipleIDDelete | Default | select * from %                              | Execution |       |       |
      | SingleItemDelete | Default | testscanrelations                            | Database  |       |       |


##6014464##
  @webtest @MLP-4610 @positive @regression @cloudera
  Scenario:SC#6_MLP-4610_Verify cNavigator catalog does not collect any information when not existing Hive Database is mentioned in catalog config
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                          | body | response code | response message | jsonPath                                                      |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/InvalidHiveConfiguration |      | 200           | IDLE             | $.[?(@.configurationName=='InvalidHiveConfiguration')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                  | body | response code | response message | jsonPath                                                      |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/InvalidHiveConfiguration  |      | 200           |                  |                                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/InvalidHiveConfiguration |      | 200           | IDLE             | $.[?(@.configurationName=='InvalidHiveConfiguration')].status |
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "CN4610SC6" and clicks on search
    And user performs "facet selection" in "CN4610SC6" attribute under "Tags" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | InvalidDatabase |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:SC#6:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                    | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/InvalidHiveConfiguration% | Analysis |       |       |

##6013606##
  @webtest @MLP-4610 @positive @regression @cloudera
  Scenario:SC#7_MLP-4610_Verify the metadata attributes for Hive Database entity matches with metadata attributes in cloudera navigator when a table with 100 records is scanned.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                               | body | response code | response message | jsonPath                                           |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveHugeTable |      | 200           | IDLE             | $.[?(@.configurationName=='HiveHugeTable')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body | response code | response message | jsonPath                                           |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HiveHugeTable  |      | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HiveHugeTable |      | 200           | IDLE             | $.[?(@.configurationName=='HiveHugeTable')].status |
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "CN4610SC11" and clicks on search
    And user performs "facet selection" in "CN4610SC11" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                              | Feature           | jsonPath        |
      | /entities?query=(sourceType:hive)AND(type:table)AND(parentPath:*testdatabase) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

##6013552##
  @webtest @MLP-4610 @positive @regression @cloudera
  Scenario:SC#8_MLP_4610_Verify the metadata attributes for Hive Database entity matches with metadata attributes in cloudera navigator for a lengthy columnname(50 characters) entity.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "CN4610SC11" and clicks on search
    And user performs "facet selection" in "CN4610SC11" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "lengthycolumn [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                | Feature           | jsonPath        |
      | /entities?query=(sourceType:HIVE)AND(type:field)AND(parentPath:*lengthycolumn*) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:SC#7,8_MLP-4610:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HiveHugeTable% | Analysis |       |       |
      | SingleItemDelete | Default | testdatabase                                 | Database |       |       |
      | SingleItemDelete | Default | Cloudera QuickStart                          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger%               | Analysis |       |       |

################################## MLP-4991 cases ##############################

    ##6245139##
  @MLP-4991 @webtest @positive @regression @cloudera
  Scenario:SC#1_MLP_4991_Verify the metadata attributes for Hive-Partition entity matches with metadata attributes in cloudera navigator for Partition entity.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body | response code | response message | jsonPath                                  |
      | application/json |       |       | Get          | settings/analyzers/CNavigatorCataloger                                   |      | 200           | Hive             |                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/Hive |      | 200           | IDLE             | $.[?(@.configurationName=='Hive')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body | response code | response message | jsonPath                                  |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/Hive  |      | 200           |                  |                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/Hive |      | 200           | IDLE             | $.[?(@.configurationName=='Hive')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4991SC1" and clicks on search
    And user performs "facet selection" in "CN4991SC1" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Cluster   |
      | Service   |
      | Database  |
      | Table     |
      | Column    |
      | Partition |
      | Analysis  |
    And user performs "facet selection" in "Partition" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                | Feature           | jsonPath        |
      | /entities?query=((sourceType:hive)AND(type:partition)AND(parentPath:*default*)) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

##6245140##
  @MLP-4991 @webtest @positive @regression @cloudera
  Scenario:SC#2_MLP_4991_Verify the metadata attributes for ClusterGroup entity matches with metadata attributes in cloudera navigator for ClusterGroup entity.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN4991SC1" and clicks on search
    And user performs "facet selection" in "CN4991SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                                     | Feature           | jsonPath       |
      | /entities?query=((sourceType:hive)AND(originalName:hive)AND(clusterName:*Cloudera*)NOT(identity:10)) | CloudEraNavigator | $..clusterName |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:4991_SC#3:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/Hive% | Analysis |       |       |
      | MultipleIDDelete | Default | default%                            | Database |       |       |

######################## MLP- 5919 cases #######################################

  ##6166312##
  @MLP-5919 @webtest @positive @regression @cloudera
  Scenario:SC#3_MLP_5919_Verify whether the catalog contains related entities if sourceType is "Hive Databases and Tables" and Scan relations is ON.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                            | body | response code | response message | jsonPath                                        |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveScanON |      | 200           | IDLE             | $.[?(@.configurationName=='HiveScanON')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body | response code | response message | jsonPath                                        |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HiveScanON  |      | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HiveScanON |      | 200           | IDLE             | $.[?(@.configurationName=='HiveScanON')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN5919SC3" and clicks on search
    And user performs "facet selection" in "CN5919SC3" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 211   |
      | HIVE [Service]                | 116   |
      | IMPALA [Service]              | 41    |
      | YARN [Service]                | 42    |
      | HDFS [Service]                | 11    |
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Operation |
      | Execution |
      | Directory |
      | Partition |
      | Column    |
      | Table     |
      | Service   |
      | Analysis  |
      | Cluster   |
      | Database  |
    And user enters the search text "*testlineage*" and clicks on search
    And user performs "facet selection" in "CN5919SC3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                     | Feature           | jsonPath        |
      | /entities?query=((sourceType:hive)AND(type:database)AND(originalName:*testlineage*)) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:5919_SC#3:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HiveScanON% | Analysis  |       |       |
      | MultipleIDDelete | Default | ROOT%                                     | Directory |       |       |
      | MultipleIDDelete | Default | test%                                     | Database  |       |       |
      | MultipleIDDelete | Default | select%                                   | Operation |       |       |
      | MultipleIDDelete | Default | SELECT%                                   | Operation |       |       |
      | MultipleIDDelete | Default | create%                                   | Operation |       |       |
      | MultipleIDDelete | Default | insert%                                   | Operation |       |       |
      | MultipleIDDelete | Default | INSERT%                                   | Operation |       |       |
      | MultipleIDDelete | Default | FROM%                                     | Operation |       |       |
      | MultipleIDDelete | Default | CREATE%                                   | Operation |       |       |


  ##6166315##
  @MLP-5919 @webtest @positive @regression @cloudera
  Scenario:SC#4_MLP_5919_Verify whether the catalog contains related entities if sourceType is "Hive Databases and Tables" and Scan relations is OFF.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message | jsonPath                                         |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveScanOFF |      | 200           | IDLE             | $.[?(@.configurationName=='HiveScanOFF')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body | response code | response message | jsonPath                                         |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HiveScanOFF  |      | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HiveScanOFF |      | 200           | IDLE             | $.[?(@.configurationName=='HiveScanOFF')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN5919SC4" and clicks on search
    And user performs "facet selection" in "CN5919SC4" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 65    |
      | HIVE [Service]                | 64    |
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Partition |
      | Column    |
      | Table     |
      | Service   |
      | Analysis  |
      | Cluster   |
      | Database  |
    Then user verify "verify non presence" with following values under "Hierarchy" section in item search results page
      | HDFS [Service]   |
      | IMPALA [Service] |
      | YARN [Service]   |
    And user enters the search text "*testlineage*" and clicks on search
    And user performs "facet selection" in "CN5919SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user verifies List present in CloudEra API list contains Search results present in UI
      | RESTAPI Endpoint                                                                     | Feature           | jsonPath        |
      | /entities?query=((sourceType:hive)AND(type:database)AND(originalName:*testlineage*)) | CloudEraNavigator | $..originalName |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:5919_SC#4:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                       | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HiveScanOFF% | Analysis |       |       |
      | MultipleIDDelete | Default | test%                                      | Database |       |       |

 ###########################           MLP-6466 - Cases               ###################

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline: SC1#-Set the Invalid DataSource for CNavigator
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                     | body                                                                      | response code | response message            | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CNavigatorDataSource | ida/cloudEraNavigatorPayloads/DataSource/CNavigatorInvalidDataSource.json | 204           |                             |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/CNavigatorDataSource |                                                                           | 200           | CNavigatorInvalidDataSource |          |


##6194389##
  @MLP-6466 @webtest @positive @regression @cloudera
  Scenario:SC#2_MLP-6466_Verify cloudEraCataloger plugin behaviour when misconfigurations are provided.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                     | body | response code | response message    | jsonPath                                                 |
      | application/json |       |       | Get          | settings/analyzers/CNavigatorCataloger                                                  |      | 200           | ClouderaInvalidPort |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/ClouderaInvalidPort |      | 200           | IDLE                | $.[?(@.configurationName=='ClouderaInvalidPort')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message | jsonPath                                                 |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/ClouderaInvalidPort  |      | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/ClouderaInvalidPort |      | 200           | IDLE             | $.[?(@.configurationName=='ClouderaInvalidPort')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN6466SC2" and clicks on search
    And user performs "facet selection" in "CN6466SC2" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/CNavigatorCataloger/ClouderaInvalidPort%"
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Number of errors  | 3             | Description |
    And user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/CNavigatorCataloger/ClouderaInvalidPort%" should display below info/error/warning
      | type | logValue                                                                                                                                 | logCode       | pluginName | removableText |
      | INFO | Plugin CNavigatorCataloger Start Time:2020-05-19 06:41:54.512, End Time:2020-05-19 06:41:55.152, Processed Count:0, Errors:3, Warnings:0 | ANALYSIS-0072 |            |               |
    And user clicks on logout button

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline:MLP-6466_SC3#-Set the valid DataSource for CNavigator
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                     | body                                                               | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CNavigatorDataSource | ida/cloudEraNavigatorPayloads/DataSource/CNavigatorDataSource.json | 204           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/CNavigatorDataSource |                                                                    | 200           | CNavigatorDataSource |          |

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline:MLP-6466_SC5-Delete config
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                    | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorCataloger |      | 204           |                  |          |

  @positive @regression @cloudera @jdbc
  Scenario:SC#5_MLP-4441_Create plugin config
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                    | body                                                  | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/CNavigatorCataloger | ida/cloudEraNavigatorPayloads/CloudEra_4441_Hive.json | 204           |                  |          |


##6194581##
  @MLP-6466 @webtest @positive @regression @cloudera
  Scenario:SC#3_MLP-6466_Verify cloudEraCataloger plugin behaviour when data filters(from date equal to To Date) are provided.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body | response code | response message | jsonPath                                       |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/SameDates |      | 200           | IDLE             | $.[?(@.configurationName=='SameDates')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body | response code | response message | jsonPath                                       |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CNavigatorCataloger/SameDates  |      | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/SameDates |      | 200           | IDLE             | $.[?(@.configurationName=='SameDates')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN6466SC3" and clicks on search
    And user performs "facet selection" in "CN6466SC3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/CNavigatorCataloger/SameDates%"
    And user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/CNavigatorCataloger/SameDates%" should display below info/error/warning
      | type | logValue                                                                                                                   | logCode                          | pluginName | removableText |
      | WARN | Incorrect filter settings: start time Wed Aug 08 00:00:00 GMT 2018 is not before the end time Wed Aug 08 00:00:00 GMT 2018 | ANALYSIS-CLOUDERA-PROCESSOR-0008 |            |               |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:6466_SC#3:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type     | query | param |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger/SameDates% | Analysis |       |       |

##6194620##
  @MLP-6466 @webtest @positive @regression @cloudera
  Scenario:SC#4_MLP-6466_Verify cloudEraCataloger plugin behaviour when from Date is greater than To Date is provided.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                 | body | response code | response message | jsonPath                                             |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/GreaterFromDate |      | 200           | IDLE             | $.[?(@.configurationName=='GreaterFromDate')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                 | body | response code | response message | jsonPath                                             |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CNavigatorCataloger/GreaterFromDate  |      | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/GreaterFromDate |      | 200           | IDLE             | $.[?(@.configurationName=='GreaterFromDate')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN6466SC4" and clicks on search
    And user performs "facet selection" in "CN6466SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/CNavigatorCataloger/GreaterFromDate%"
    And user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/CNavigatorCataloger/GreaterFromDate%" should display below info/error/warning
      | type | logValue                                                                                                                   | logCode                          | pluginName | removableText |
      | WARN | Incorrect filter settings: start time Mon Oct 08 00:00:00 GMT 2018 is not before the end time Wed Aug 08 00:00:00 GMT 2018 | ANALYSIS-CLOUDERA-PROCESSOR-0008 |            |               |
    And user clicks on logout button

     ##6194387##
  @MLP-6466 @webtest @positive @regression @cloudera
  Scenario:SC#5_MLP-6466_Verify cloudEraCataloger plugin Auto Start ON works properly
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                                    | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | settings/analyzers/CNavigatorCataloger |      | 200           | HiveAutoStart    |          |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body | response code | response message | jsonPath                                           |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HiveAutoStart |      | 200           | IDLE             | $.[?(@.configurationName=='HiveAutoStart')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN6466SC5" and clicks on search
    And user performs "facet selection" in "CN6466SC5" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Operation |
      | Execution |
      | Database  |
      | Table     |
      | Column    |
      | Analysis  |
      | Cluster   |
      | Service   |
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 23    |
      | HIVE [Service]                | 14    |
      | IMPALA [Service]              | 8     |
    And user clicks on logout button

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline:clouderaHive_Delete the Credentials and Data Sources
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaValidCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaInValidCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorDataSource         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorCataloger          |      | 204           |                  |          |

  @MLP-4441 @sanity @positive
  Scenario:clouderaHive_Delete cluster id & All_Analysis finally
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | Cloudera QuickStart            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger% | Analysis |       |       |