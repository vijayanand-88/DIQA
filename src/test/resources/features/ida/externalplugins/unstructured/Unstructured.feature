@Unstructured
Feature:Unstructured: verification of Unstructured IDA Plugin


  @Unstructured @positve @regression @sanity @webtest
  Scenario:SC1#Verification of Unstructured Plugin getting triggered when Git Collector is run
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "ida/UnstructuredPayloads/catalogs/SC1CreateCatalog.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 204 must be returned
    And verify created schema "SC1TIKKACATALOG" exists in database
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                      | body                                                      | response code | response message | jsonPath                                          |
      |        | raw   | false | Put          | settings/analyzers/GitCollector                                                          | ida/UnstructuredPayloads/Gitconfig/SC1GitCollector.json   | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/GitCollector                                                          |                                            | 200           | Unstructured     |                                                   |
      |        |       |       | Put          | settings/analyzers/UnstructuredDataAnalyzer                                              | ida/UnstructuredPayloads/Tikkaconfig/SC1Unstructured.json | 204           |                  |                                                   |
      |        |       |       | Get          | settings/analyzers/UnstructuredDataAnalyzer                                              |                                                           | 200           | Unstructured     |                                                   |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                |                                                           | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector                 | ida/UnstructuredPayloads/Gitconfig/empty.json             | 200           |                  |                                                   |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                |                                                           | 200           | RUNNING          | $.[?(@.configurationName=='GitCollector')].status |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/Unstructured |                                                           | 200           | RUNNING          | $.[?(@.configurationName=='Unstructured')].status |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                |                                                           | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/Unstructured |                                                           | 200           | IDLE             | $.[?(@.configurationName=='Unstructured')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "SC1TIKKACATALOG" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "collector" item from search results
    And user click on Analysis log link in DATA widget section
    Then user "verify analysis log contains" presence of "UNSTRUCTUREDDATAANALYZER" in Analysis Log of IDC UI


  @Unstructured @positve @regression @sanity @webtest
  Scenario:Verification of Technology tags for Unstructured Data Analyzer
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And login must be successful for all users
    Then user "verifies presence" of technology tags for the following parameters
      | catalogName     | name     | facet | Tag                                     |
      | SC1TIKKACATALOG | Document | Type  | Unstructured,Git,Content,Source Control |
      | SC1TIKKACATALOG | File     | Type  | Unstructured,Git,Content,Source Control |
      | SC1TIKKACATALOG | Project  | Type  | Git,Source Control                      |
    And Execute REST API with following parameters
      | Header | Query | Param | type   | url                               | body | response code | response message | jsonPath |
      |        |       |       | Delete | settings/catalogs/SC1TIKKACATALOG |      | 204           |                  |          |


  @Unstructured @positve @regression @sanity @webtest
  Scenario:Verification of Password encryption for Unstructured Data Analyzer
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "SC1TIKKACATALOG" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user copy metadata value from Item View Page and write to file using below parameters
      | attributeName  | Definition                               |
      | actualFilePath | ida/UnstructuredPayloads/Definition.json |
    Then user verify whether "password encrypted" for below parameters
      | pluginName   | pluginConfigPassword | passwordFilePath                         | jsonpath             |
      | Unstructured | BITBUCKET_PASSWORD   | ida/UnstructuredPayloads/Definition.json | $.repositoryPassword |


  @Unstructured @positve @regression @sanity @webtest
  Scenario:SC2#Verification of Unstructured Analyzer functionality when Dry Run is set to true for Git Collector
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "ida/UnstructuredPayloads/catalogs/SC2CreateCatalog.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 204 must be returned
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                      | body                                                      | response code | response message | jsonPath                                          |
      |        | raw   | false | Put          | settings/analyzers/GitCollector                                                          | ida/UnstructuredPayloads/Gitconfig/SC2GitCollector.json   | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/GitCollector                                                          |                                                        | 200           | Unstructured     |                                                   |
      |        | raw   | false | Put          | settings/analyzers/UnstructuredDataAnalyzer                                              | ida/UnstructuredPayloads/Tikkaconfig/SC2Unstructured.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/UnstructuredDataAnalyzer                                              |                                                        | 200           | Unstructured     |                                                   |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                |                                                           | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector                 | ida/UnstructuredPayloads/Gitconfig/empty.json             | 200           |                  |                                                   |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                |                                                           | 200           | RUNNING          | $.[?(@.configurationName=='GitCollector')].status |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/Unstructured |                                                        | 200           | RUNNING          | $.[?(@.configurationName=='Unstructured')].status |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/Unstructured |                                                           | 200           | IDLE             | $.[?(@.configurationName=='Unstructured')].status |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                |                                                           | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "SC2TIKKACATALOG" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "collector" item from search results
    And user click on Analysis log link in DATA widget section
    Then user "verify logtext not contains" presence of "UNSTRUCTUREDDATAANALYZER" in Analysis Log of IDC UI
    And Execute REST API with following parameters
      | Header | Query | Param | type   | url                               | body | response code | response message | jsonPath |
      |        |       |       | Delete | settings/catalogs/SC2TIKKACATALOG |      | 204           |                  |          |


  @Unstructured @positve @regression @sanity @webtest
  Scenario:SC3#Verification of Git-Unstructured functionality with user defined filters in Unstructured Config for all format types of files
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "ida/UnstructuredPayloads/catalogs/SC3CreateCatalog.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 204 must be returned
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                      | body                                                      | response code | response message | jsonPath                                          |
      |        | raw   | false | Put          | settings/analyzers/GitCollector                                                          | ida/UnstructuredPayloads/Gitconfig/SC3GitCollector.json   | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/GitCollector                                                          |                                                         | 200           | Unstructured     |                                                   |
      |        | raw   | false | Put          | settings/analyzers/UnstructuredDataAnalyzer                                              | ida/UnstructuredPayloads/Tikkaconfig/SC3Unstructured.json | 204           |                  |                                                   |
#      |        |       |       | Get          | settings/analyzers/UnstructuredDataAnalyzer                                              |                                                         | 200           | Unstructured     |                                                   |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                |                                                           | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector                 | ida/UnstructuredPayloads/Gitconfig/empty.json             | 200           |                  |                                                   |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                |                                                           | 200           | RUNNING          | $.[?(@.configurationName=='GitCollector')].status |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/Unstructured |                                                           | 200           | RUNNING          | $.[?(@.configurationName=='Unstructured')].status |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                |                                                           | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/Unstructured |                                                           | 200           | IDLE             | $.[?(@.configurationName=='Unstructured')].status |

    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "SC3TIKKACATALOG" and clicks on search
    Then user verify "presence of Tag facets" with following values under "Tags" section in item search results page
      | Unstructured |
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    Then user performs "item click" on "base.py" item from search results
    And Execute REST API with following parameters
      | Header | Query | Param | type   | url                               | body | response code | response message | jsonPath |
      |        |       |       | Delete | settings/catalogs/SC3TIKKACATALOG |      | 204           |                  |          |


  @Unstructured @positve @regression @sanity @webtest
  Scenario:SC4#Git collector without Unstructured configuration
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "ida/UnstructuredPayloads/catalogs/SC4CreateCatalog.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 204 must be returned
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                       | body                                                    | response code | response message | jsonPath                                          |
      |        | raw   | false | Put          | settings/analyzers/GitCollector                                           | ida/UnstructuredPayloads/Gitconfig/SC4GitCollector.json | 204           |                  |                                                   |
      |        |       |       | Get          | settings/analyzers/GitCollector                                           |                                                         | 200           | Unstructured     |                                                   |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                                         | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  | ida/UnstructuredPayloads/Gitconfig/empty.json           | 200           |                  |                                                   |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                                         | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "SC4TIKKACATALOG" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user performs "dynamic item click" on "collector" item from search results
    And user click on Analysis log link in DATA widget section
    Then user "verify logtext not contains" presence of "UNSTRUCTUREDDATAANALYZER" in Analysis Log of IDC UI
    And Execute REST API with following parameters
      | Header | Query | Param | type   | url                               | body | response code | response message | jsonPath |
      |        |       |       | Delete | settings/catalogs/SC4TIKKACATALOG |      | 204           |                  |          |


  @Unstructured @positve @regression @sanity @webtest
  Scenario:SC5#Verification of Git-Unstructured functionality with mime type having special characters in Unstructured Config
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "ida/UnstructuredPayloads/catalogs/SC5CreateCatalog.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 204 must be returned
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                      | body                                                      | response code | response message | jsonPath                                          |
      |        | raw   | false | Put          | settings/analyzers/GitCollector                                                          | ida/UnstructuredPayloads/Gitconfig/SC5GitCollector.json   | 204           |                  |                                                   |
      |        | raw   | false | Put          | settings/analyzers/UnstructuredDataAnalyzer                                              | ida/UnstructuredPayloads/Tikkaconfig/SC5Unstructured.json | 204           |                  |                                                   |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                |                                                           | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector                 | ida/UnstructuredPayloads/Gitconfig/empty.json             | 200           |                  |                                                   |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                |                                                           | 200           | RUNNING          | $.[?(@.configurationName=='GitCollector')].status |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/Unstructured |                                                           | 200           | RUNNING          | $.[?(@.configurationName=='Unstructured')].status |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                |                                                           | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/Unstructured |                                                           | 200           | IDLE             | $.[?(@.configurationName=='Unstructured')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "SC5TIKKACATALOG" and clicks on search
    Then user verify "presence of Tag facets" with following values under "Tags" section in item search results page
      | Unstructured |
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "about2.jsp" item from search results
    Then user "verify metadata property values" with following expected parameters for item "about2.jsp"
      | MIME type |
      | ^&$&%&*^  |
    And Execute REST API with following parameters
      | Header | Query | Param | type   | url                               | body | response code | response message | jsonPath |
      |        |       |       | Delete | settings/catalogs/SC5TIKKACATALOG |      | 204           |                  |          |

  @Unstructured @positve @regression @sanity @webtest
  Scenario:SC6#Verification of Git-Unstructured functionality when a Filter with Mime type as blank is given Unstructured Config
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "ida/UnstructuredPayloads/catalogs/SC6CreateCatalog.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 204 must be returned
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                      | body                                                      | response code | response message | jsonPath                                          |
      |        | raw   | false | Put          | settings/analyzers/GitCollector                                                          | ida/UnstructuredPayloads/Gitconfig/SC6GitCollector.json   | 204           |                  |                                                   |
      |        | raw   | false | Put          | settings/analyzers/UnstructuredDataAnalyzer                                              | ida/UnstructuredPayloads/Tikkaconfig/SC6Unstructured.json | 204           |                  |                                                   |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                |                                                           | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector                 | ida/UnstructuredPayloads/Gitconfig/empty.json             | 200           |                  |                                                   |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                |                                                           | 200           | RUNNING          | $.[?(@.configurationName=='GitCollector')].status |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/Unstructured |                                                           | 200           | RUNNING          | $.[?(@.configurationName=='Unstructured')].status |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                |                                                           | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/Unstructured |                                                           | 200           | IDLE             | $.[?(@.configurationName=='Unstructured')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "SC6TIKKACATALOG" and clicks on search
    Then user verify "presence of Tag facets" with following values under "Tags" section in item search results page
      | Unstructured |
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "about2.jsp" item from search results
    Then user "verify non presence" of following "metadata list not contains" in Search Results Page
      | MIME type |
    And Execute REST API with following parameters
      | Header | Query | Param | type   | url                               | body | response code | response message | jsonPath |
      |        |       |       | Delete | settings/catalogs/SC6TIKKACATALOG |      | 204           |                  |          |


  @Unstructured @positve @regression @sanity @webtest
  Scenario:SC7#Verification of Git-Unstructured functionality with user defined filters in Unstructured Config
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "ida/UnstructuredPayloads/catalogs/SC7CreateCatalog.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 204 must be returned
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                      | body                                                      | response code | response message | jsonPath                                          |
      |        | raw   | false | Put          | settings/analyzers/GitCollector                                                          | ida/UnstructuredPayloads/Gitconfig/SC7GitCollector.json   | 204           |                  |                                                   |
      |        |       |       | Get          | settings/analyzers/GitCollector                                                          |                                                           | 200           | Unstructured     |                                                   |
      |        | raw   | false | Put          | settings/analyzers/UnstructuredDataAnalyzer                                              | ida/UnstructuredPayloads/Tikkaconfig/SC7Unstructured.json | 204           |                  |                                                   |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                |                                                           | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector                 | ida/UnstructuredPayloads/Gitconfig/empty.json             | 200           |                  |                                                   |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                |                                                           | 200           | RUNNING          | $.[?(@.configurationName=='GitCollector')].status |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/Unstructured |                                                           | 200           | RUNNING          | $.[?(@.configurationName=='Unstructured')].status |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                |                                                           | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/Unstructured |                                                           | 200           | IDLE             | $.[?(@.configurationName=='Unstructured')].status |

    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "SC7TIKKACATALOG" and clicks on search
    Then user verify "presence of Tag facets" with following values under "Tags" section in item search results page
      | Unstructured |
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "about2.jsp" item from search results
    Then user "verify metadata property values" with following expected parameters for item "about2.jsp"
      | MIME type         |
      | text/htmlModified |
    And Execute REST API with following parameters
      | Header | Query | Param | type   | url                               | body | response code | response message | jsonPath |
      |        |       |       | Delete | settings/catalogs/SC7TIKKACATALOG |      | 204           |                  |          |


  @Unstructured @positve @regression @sanity @webtest
  Scenario:SC8#User reconfigure the unstructure catalog name
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                                         | body                                                      | response code | response message | jsonPath       |
      | application/json | raw   | false | Put  | settings/analyzers/UnstructuredDataAnalyzer | ida/UnstructuredPayloads/Tikkaconfig/SC8Unstructured.json | 204           |                  |                |
      |                  |       |       | Get  | settings/analyzers/UnstructuredDataAnalyzer |                                                           | 200           | Unstructured     | $..catalogName |
