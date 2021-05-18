Feature: Feature to validate the LocalFileCollector collects the files periodically in smaller chunks


#TestcaseId_6637827 - Verify whether the Local File collector collects all the files based on the the 'MAXIMUM WORK SIZE' field value , provide the value as 100 whole number.
  @LFC @IDA_E2E
  Scenario: SC1 - Create Local localFileCollector Plugin config MaxWorkSize100 and run it
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                  | body                                                                  | response code | response message | jsonPath                                            |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                                | ida/localFileCollectorPayloads/Configurations/TestcaseId_6637827.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                |                                                                       | 200           | MaxWorkSize100   |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/MaxWorkSize100 |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='MaxWorkSize100')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/MaxWorkSize100  |                                                                       | 200           | IDLE             |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/MaxWorkSize100 |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='MaxWorkSize100')].status |

  @webtest @LFC @IDA_E2E
  Scenario: SC1 - Collecting the repository by giving maximum work size as 100 and validating the source count in IDP
    Given User launch browser and traverse to login page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "LFC" and clicks on search
    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/MaxWorkSize100%"
    And METADATA widget should have following item values
      | metaDataItem              | metaDataItemValue |
      | Number of processed items | 10                |
      | Number of errors          | 0                 |


  @sanity @positive
  Scenario:SC#1:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | collector/LocalFileCollector/% | Analysis |       |       |
      | MultipleIDDelete | Default | lfc_testfiles                  | Project  |       |       |

  Scenario Outline:SC1 Delete Plugin configurationls and catalog "MaxWorkSize100"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/LocalFileCollector |      | 204           |                  |          |


  #TestcaseId_6637829 - Verify whether the Local File collector collects all the files based on the the 'MAXIMUM WORK SIZE' field value , provide the value as 3 whole number.
  @LFC
  Scenario: SC2 - Create Local localFileCollector Plugin config MaxWorkSize3 and run it
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                | body                                                                  | response code | response message | jsonPath                                          |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                              | ida/localFileCollectorPayloads/Configurations/TestcaseId_6637829.json | 204           |                  |                                                   |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                              |                                                                       | 200           | MaxWorkSize3     |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/MaxWorkSize3 |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='MaxWorkSize3')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/MaxWorkSize3  |                                                                       | 200           | IDLE             |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/MaxWorkSize3 |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='MaxWorkSize3')].status |

  @webtest @LFC
  Scenario: SC2 - Collecting the repository by giving maximum work size as 3 and validating the source count in IDP
    Given User launch browser and traverse to login page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "LFC" and clicks on search
    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/MaxWorkSize3%"
    And METADATA widget should have following item values
      | metaDataItem              | metaDataItemValue |
      | Number of processed items | 10                |
      | Number of errors          | 0                 |


  @sanity @positive
  Scenario:SC#2:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | collector/LocalFileCollector/% | Analysis |       |       |
      | MultipleIDDelete | Default | lfc_testfiles                  | Project  |       |       |

  Scenario Outline:SC2 Delete Plugin configurationls and catalog "MaxWorkSize3"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/LocalFileCollector |      | 204           |                  |          |

  #TestcaseId_6644873 - Verify whether the Local File collector collects all the files based on the the 'MAXIMUM WORK SIZE' field value , provide the value as 500 whole number.
  @LFC @IDA_E2E
  Scenario: SC3 - Create Local localFileCollector Plugin config MaxWorkSize500 and run it
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                  | body                                                                  | response code | response message | jsonPath                                            |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                                | ida/localFileCollectorPayloads/Configurations/TestcaseId_6644873.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                |                                                                       | 200           | MaxWorkSize500   |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/MaxWorkSize500 |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='MaxWorkSize500')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/MaxWorkSize500  |                                                                       | 200           | IDLE             |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/MaxWorkSize500 |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='MaxWorkSize500')].status |

  @webtest @LFC @IDA_E2E
  Scenario: SC3 - Collecting the repository by giving maximum work size as 500 and validating the source count in IDP
    Given User launch browser and traverse to login page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "LFC" and clicks on search
    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/MaxWorkSize500%"
    And METADATA widget should have following item values
      | metaDataItem              | metaDataItemValue |
      | Number of processed items | 10                |
      | Number of errors          | 0                 |


  @sanity @positive
  Scenario:SC#3:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | collector/LocalFileCollector/% | Analysis |       |       |
      | MultipleIDDelete | Default | lfc_testfiles                  | Project  |       |       |

  Scenario Outline:SC3 Delete Plugin configurationls and catalog "MaxWorkSize500"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/LocalFileCollector |      | 204           |                  |          |


  #TestcaseId_6785628 - Verify whether the Local File collector collects no files based on the the 'MAXIMUM WORK SIZE' field value , provide the value <=0.
  @LFC
  Scenario: SC4 - Create Local localFileCollector Plugin config MaxWorkSize0 and run it
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                | body                                                                  | response code | response message | jsonPath                                          |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                              | ida/localFileCollectorPayloads/Configurations/TestcaseId_6785628.json | 204           |                  |                                                   |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                              |                                                                       | 200           | MaxWorkSize0     |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/MaxWorkSize0 |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='MaxWorkSize0')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/MaxWorkSize0  |                                                                       | 200           | IDLE             |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/MaxWorkSize0 |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='MaxWorkSize0')].status |

  @webtest @LFC
  Scenario: SC4- Collecting the repository by giving maximum work size as <=0 and validating the source count in IDP
    Given User launch browser and traverse to login page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "LFC" and clicks on search
    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/MaxWorkSize0%"
    And METADATA widget should have following item values
      | metaDataItem              | metaDataItemValue |
      | Number of processed items | 0                 |
      | Number of halt errors     | 1                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Given Analysis log "collector/LocalFileCollector/MaxWorkSize0/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                     | logCode       | pluginName         | removableText  |
      | INFO | Plugin started                                                                                                                                                               | ANALYSIS-0019 |                    |                |
      | INFO | Plugin Name:LocalFileCollector, Plugin Type:collector, Plugin Version:1.0.0.SNAPSHOT, Node Name:InternalNode, Host Name:8039d9c4cdf6, Plugin Configuration name:MaxWorkSize0 | ANALYSIS-0071 | LocalFileCollector | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin LocalFileCollector Configuration: ---  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: name: "MaxWorkSize0"  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: pluginVersion: "LATEST"  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: label:  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:   : "MaxWorkSize0"  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: catalogName: "Default"  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: eventClass: null  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: eventCondition: null  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: nodeCondition: "type=='internal'"  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: maxWorkSize: 0  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: tags:  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: - "LFC"  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: pluginType: "COLLECTOR"  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: dataSource: null  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: credential: null  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: businessApplicationName: null  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: dryRun: false  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: filter:  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:   filters: []  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:   deltaTime: null  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:   extraFilters:  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:     filefilters: []  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:   maxHits: null  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: contentAnalyzerPlugin: "UnstructuredDataAnalyzer"  2020-03-03 09:42:53.289 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: pluginName: "LocalFileCollector"  2020-03-03 09:42:53.290 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: root: "/lfc_testfiles"  2020-03-03 09:42:53.290 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: incrementalRun: true  2020-03-03 09:42:53.290 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: type: "Collector" | ANALYSIS-0073 | LocalFileCollector |                |
      | INFO | ANALYSIS-0072: Plugin LocalFileCollector Start Time:2020-03-03 09:42:53.288, End Time:2020-03-03 09:42:53.384, Processed Count:0, Errors:0, Warnings:0                       | ANALYSIS-0072 | LocalFileCollector |                |
      | INFO | Plugin completed with errors (elapsed time in (HH:MM:SS.ms): 00:00:00.096)                                                                                                   | ANALYSIS-0075 |                    |                |

  @sanity @positive
  Scenario:SC#4:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | collector/LocalFileCollector/% | Analysis |       |       |
      | MultipleIDDelete | Default | lfc_testfiles                  | Project  |       |       |

  Scenario Outline:SC4 Delete Plugin configurationls and catalog "MaxWorkSize0"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/LocalFileCollector |      | 204           |                  |          |


