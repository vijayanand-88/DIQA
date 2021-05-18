@MLP-4441
Feature:MLP-4441: cloudera_Impala

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline: SC1#-Set the Credentials and DataSource for CNavigator
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                             | body                                                               | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ClouderaValidCredentials   | ida/cloudEraNavigatorPayloads/Credentials/Valid.json               | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ClouderaInValidCredentials | ida/cloudEraNavigatorPayloads/Credentials/Invalid.json             | 200           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CNavigatorDataSource         | ida/cloudEraNavigatorPayloads/DataSource/CNavigatorDataSource.json | 204           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/CNavigatorDataSource         |                                                                    | 200           | CNavigatorDataSource |          |

  @MLP-4610 @positive @regression @cloudera
  Scenario Outline:ImpalaMLP-4441-SC1#-config the CNavigator plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                    | body                                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CNavigatorCataloger | ida/cloudEraNavigatorPayloads/CloudEra_4441_Impala.json | 204           |                  |          |


##6043931##
  @webtest @MLP-4441 @positive @regression @cloudera @MLPQA-18067
  Scenario:SC#1_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype, toplevel include in Impala
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                               | body | response code | response message              | jsonPath                                                           |
      | application/json |       |       | Get          | settings/analyzers/CNavigatorCataloger                                                            |      | 200           | ImpalaTopLevelIncludeWithTags |                                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/ImpalaTopLevelIncludeWithTags |      | 200           | IDLE                          | $.[?(@.configurationName=='ImpalaTopLevelIncludeWithTags')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body | response code | response message | jsonPath                                                           |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/ImpalaTopLevelIncludeWithTags  |      | 200           |                  |                                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/ImpalaTopLevelIncludeWithTags |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaTopLevelIncludeWithTags')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNImpSC1" and clicks on search
    And user performs "facet selection" in "CNImpSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                                     | Feature           | jsonPath        |
      | /entities?query=(sourceType:impala)AND((type:operation)OR(type:operation_execution))AND(originalName:*testdatabase*) | CloudEraNavigator | $..originalName |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                | fileName                                    | userTag  |
      | Default     | Operation | Metadata Type | Cloudera Navigator,CNImpSC1,Impala | select * from testdatabase1.finance_2216527 | CNImpSC1 |
    And user clicks on logout button


  @MLP-4441 @sanity @positive
  Scenario:SC#1:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                         | type      | query | param |
      | MultipleIDDelete | Default | select * from testdatabase1%                                 | Operation |       |       |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/ImpalaTopLevelIncludeWithTags% | Analysis  |       |       |
      | MultipleIDDelete | Default | select * from testdatabase1%                                 | Execution |       |       |

##6044680##
  @webtest @MLP-4441 @positive @regression @cloudera
  Scenario:SC#2_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype and unavailable toplevel include in Impala
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                               | body | response code | response message | jsonPath                                                           |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/ImpalaTopLevelIncludeNonexist |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaTopLevelIncludeNonexist')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body | response code | response message | jsonPath                                                           |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/ImpalaTopLevelIncludeNonexist  |      | 200           |                  |                                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/ImpalaTopLevelIncludeNonexist |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaTopLevelIncludeNonexist')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNImpSC2" and clicks on search
    And user performs "facet selection" in "CNImpSC2" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis |
      | Cluster  |
      | Service  |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:SC#2:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                         | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/ImpalaTopLevelIncludeNonexist% | Analysis |       |       |


##6044677##
  @webtest @MLP-4441 @positive @regression @cloudera
  Scenario:SC#4_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype and same time intervals in Impala
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                     | body | response code | response message | jsonPath                                                 |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/ImpalaWithSameDates |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaWithSameDates')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message | jsonPath                                                 |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/ImpalaWithSameDates  |      | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/ImpalaWithSameDates |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaWithSameDates')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNImpSC4" and clicks on search
    And user performs "facet selection" in "CNImpSC4" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis  |
      | Cluster   |
      | Service   |
      | Operation |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:SC#4:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/ImpalaWithSameDates% | Analysis  |       |       |
      | MultipleIDDelete | Default | select * from %                                    | Operation |       |       |
      | MultipleIDDelete | Default | create table%                                      | Operation |       |       |
      | MultipleIDDelete | Default | insert into %                                      | Operation |       |       |
      | MultipleIDDelete | Default | select%                                            | Operation |       |       |
      | MultipleIDDelete | Default | create%                                            | Operation |       |       |
      | MultipleIDDelete | Default | insert%                                            | Operation |       |       |
      | MultipleIDDelete | Default | SELECT%                                            | Operation |       |       |
      | MultipleIDDelete | Default | CREATE%                                            | Operation |       |       |
      | MultipleIDDelete | Default | INSERT%                                            | Operation |       |       |

    ##6044043##
  @webtest @MLP-4441 @positive @regression @cloudera @MLPQA-18067
  Scenario:SC#5_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype and toplevel multiple include in Impala
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                         | body | response code | response message | jsonPath                                                     |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/ImpalaMutipleTopInclude |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaMutipleTopInclude')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                 | body | response code | response message | jsonPath                                                     |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/ImpalaMutipleTopInclude  |      | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/ImpalaMutipleTopInclude |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaMutipleTopInclude')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNImpSC5" and clicks on search
    And user performs "facet selection" in "CNImpSC5" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                                                                     | Feature           | jsonPath        |
      | /entities?query=(sourceType:impala)AND((type:operation)OR(type:operation_execution))AND((originalName:*testdatabase*)OR(originalName:*secondtable*)) | CloudEraNavigator | $..originalName |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                | fileName                                    | userTag  |
      | Default     | Operation | Metadata Type | Cloudera Navigator,CNImpSC5,Impala | select * from testdatabase1.finance_2216527 | CNImpSC5 |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:SC#5:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                   | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/ImpalaMutipleTopInclude% | Analysis  |       |       |
      | MultipleIDDelete | Default | select%                                                | Operation |       |       |
      | MultipleIDDelete | Default | create%                                                | Operation |       |       |
      | MultipleIDDelete | Default | select%                                                | Execution |       |       |
      | MultipleIDDelete | Default | create%                                                | Execution |       |       |


##6044053##
  @MLP-4441 @webtest @positive @regression @cloudera @MLPQA-18067
  Scenario:SC#6_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype and time intervals in Impala
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body | response code | response message | jsonPath                                                  |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/ImpalaWithDiffDates1 |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaWithDiffDates1')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                              | body | response code | response message | jsonPath                                                  |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/ImpalaWithDiffDates1  |      | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/ImpalaWithDiffDates1 |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaWithDiffDates1')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNImpSC6" and clicks on search
    And user performs "facet selection" in "CNImpSC6" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                                                    | Feature           | jsonPath        |
      | /entities?query=(sourceType:impala)AND(type:operation_execution)AND(started:[2018-07-01T01:00:00.000Z TO 2018-08-08T23:00:00.000Z]) | CloudEraNavigator | $..originalName |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                | fileName                                                    | userTag  |
      | Default     | Operation | Metadata Type | Cloudera Navigator,CNImpSC6,Impala | select * from imported.sampletable where personid = ?_76310 | CNImpSC6 |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:SC#6:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/ImpalaWithDiffDates1% | Analysis  |       |       |
      | MultipleIDDelete | Default | select * from %                                     | Operation |       |       |
      | MultipleIDDelete | Default | create table%                                       | Operation |       |       |
      | MultipleIDDelete | Default | insert into %                                       | Operation |       |       |
      | MultipleIDDelete | Default | select%                                             | Operation |       |       |
      | MultipleIDDelete | Default | create%                                             | Operation |       |       |
      | MultipleIDDelete | Default | insert%                                             | Operation |       |       |
      | MultipleIDDelete | Default | SELECT%                                             | Operation |       |       |
      | MultipleIDDelete | Default | CREATE%                                             | Operation |       |       |
      | MultipleIDDelete | Default | INSERT%                                             | Operation |       |       |
      | MultipleIDDelete | Default | select%                                             | Execution |       |       |
      | MultipleIDDelete | Default | insert%                                             | Execution |       |       |
      | MultipleIDDelete | Default | create%                                             | Execution |       |       |


    ##6044049##
  @webtest @MLP-4441 @positive @regression @cloudera @MLPQA-18067
  Scenario:SC#7_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype and toplevel exclude in Impala
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                          | body | response code | response message | jsonPath                                                      |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/ImpalaTopExcludeWithTags |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaTopExcludeWithTags')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                  | body | response code | response message | jsonPath                                                      |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/ImpalaTopExcludeWithTags  |      | 200           |                  |                                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/ImpalaTopExcludeWithTags |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaTopExcludeWithTags')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNImpSC7" and clicks on search
    And user performs "facet selection" in "CNImpSC7" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "IMPALA" item from search results
    And user "contains" the "OPERATIONS" Item search result "list" value with CloudEra API
      | RESTAPI Endpoint                                                                    | Feature           | jsonPath        |
      | /entities?query=((sourceType:impala)AND(type:operation)NOT(originalName:*default*)) | CloudEraNavigator | $..originalName |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                | fileName                                                        | userTag  |
      | Default     | Operation | Metadata Type | Cloudera Navigator,CNImpSC7,Impala | insert overwrite table pageviews partition (datestam..._2559118 | CNImpSC7 |

  @MLP-4441 @sanity @positive
  Scenario:SC#7:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                    | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/ImpalaTopExcludeWithTags% | Analysis  |       |       |
      | MultipleIDDelete | Default | select * from %                                         | Operation |       |       |
      | MultipleIDDelete | Default | create table%                                           | Operation |       |       |
      | MultipleIDDelete | Default | insert into %                                           | Operation |       |       |
      | MultipleIDDelete | Default | select%                                                 | Operation |       |       |
      | MultipleIDDelete | Default | create%                                                 | Operation |       |       |
      | MultipleIDDelete | Default | insert%                                                 | Operation |       |       |
      | MultipleIDDelete | Default | SELECT%                                                 | Operation |       |       |
      | MultipleIDDelete | Default | CREATE%                                                 | Operation |       |       |
      | MultipleIDDelete | Default | INSERT%                                                 | Operation |       |       |
      | MultipleIDDelete | Default | select%                                                 | Execution |       |       |
      | MultipleIDDelete | Default | insert%                                                 | Execution |       |       |
      | MultipleIDDelete | Default | create%                                                 | Execution |       |       |
      | MultipleIDDelete | Default | SELECT%                                                 | Execution |       |       |
      | MultipleIDDelete | Default | CREATE%                                                 | Execution |       |       |
      | MultipleIDDelete | Default | INSERT%                                                 | Execution |       |       |

##6044134##
  @webtest @MLP-4441 @positive @regression @cloudera @MLPQA-18067
  Scenario:SC#8_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype ,toplevel include and top level exclude in Impala
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                               | body | response code | response message | jsonPath                                                           |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/ImpalaTopIncludeBottomExclude |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaTopIncludeBottomExclude')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body | response code | response message | jsonPath                                                           |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/ImpalaTopIncludeBottomExclude  |      | 200           |                  |                                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/ImpalaTopIncludeBottomExclude |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaTopIncludeBottomExclude')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNImpSC8" and clicks on search
    And user performs "facet selection" in "CNImpSC8" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user compare list of Search results present in Search page and List present in CloudEra API
      | RESTAPI Endpoint                                                                                                    | Feature           | jsonPath        |
      | /entities?query=((sourceType:impala)AND(type:operation)AND(originalName:*testdatabase*)NOT(originalName:*finance*)) | CloudEraNavigator | $..originalName |
    And user enters the search text "CNImpSC8" and clicks on search
    And user performs "facet selection" in "CNImpSC8" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user finds search result does not contain "finance" item name link
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                | fileName                                                        | userTag  |
      | Default     | Operation | Metadata Type | Cloudera Navigator,CNImpSC8,Impala | select * from testdatabase1.employee e join testdata..._2339180 | CNImpSC8 |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:SC#8:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                         | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/ImpalaTopIncludeBottomExclude% | Analysis  |       |       |
      | MultipleIDDelete | Default | select%                                                      | Execution |       |       |
      | MultipleIDDelete | Default | select%                                                      | Operation |       |       |


##6044050##
  @webtest @MLP-4441 @positive @regression @cloudera @MLPQA-18067
  Scenario:SC#9_MLP-4441_Verify whether the data got displayed in UI after applying filters like: sourcetype and toplevel multiple exclude in Impala
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                          | body | response code | response message | jsonPath                                                      |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/ImpalaMultipleTopExclude |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaMultipleTopExclude')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                  | body | response code | response message | jsonPath                                                      |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/ImpalaMultipleTopExclude  |      | 200           |                  |                                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/ImpalaMultipleTopExclude |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaMultipleTopExclude')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CNImpSC9" and clicks on search
    And user performs "facet selection" in "CNImpSC9" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "IMPALA" item from search results
    And user "contains" the "OPERATIONS" Item search result "list" value with CloudEra API
      | RESTAPI Endpoint                                                                                                    | Feature           | jsonPath        |
      | /entities?query=((sourceType:impala)AND(type:operation)NOT(originalName:*testdatabase*)NOT(originalName:*default*)) | CloudEraNavigator | $..originalName |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                | fileName                       | userTag  |
      | Default     | Operation | Metadata Type | Cloudera Navigator,CNImpSC9,Impala | select * from j_result_3524472 | CNImpSC9 |
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:SC#9:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                    | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/ImpalaMultipleTopExclude% | Analysis  |       |       |
      | MultipleIDDelete | Default | select * from %                                         | Operation |       |       |
      | MultipleIDDelete | Default | create table%                                           | Operation |       |       |
      | MultipleIDDelete | Default | insert into %                                           | Operation |       |       |
      | MultipleIDDelete | Default | select%                                                 | Operation |       |       |
      | MultipleIDDelete | Default | create%                                                 | Operation |       |       |
      | MultipleIDDelete | Default | insert%                                                 | Operation |       |       |
      | MultipleIDDelete | Default | SELECT%                                                 | Operation |       |       |
      | MultipleIDDelete | Default | CREATE%                                                 | Operation |       |       |
      | MultipleIDDelete | Default | INSERT%                                                 | Operation |       |       |
      | MultipleIDDelete | Default | select%                                                 | Execution |       |       |
      | MultipleIDDelete | Default | insert%                                                 | Execution |       |       |
      | MultipleIDDelete | Default | create%                                                 | Execution |       |       |
      | MultipleIDDelete | Default | SELECT%                                                 | Execution |       |       |
      | MultipleIDDelete | Default | CREATE%                                                 | Execution |       |       |
      | MultipleIDDelete | Default | INSERT%                                                 | Execution |       |       |


  @MLP-4441 @positive @regression @cloudera
  Scenario Outline: SC10-Delete the Credentials and Data Sources
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaValidCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaInValidCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorDataSource         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorCataloger          |      | 204           |                  |          |

  @MLP-4441 @sanity @positive
  Scenario:clouderaImpala_Delete cluster id & All_Analysis finally
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | Cloudera QuickStart            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger% | Analysis |       |       |

