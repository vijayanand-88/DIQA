Feature: Feature to validate the functionalities of Java Parser plugin collected by Git Collector plugin on running through InternalNode

  @git @precondition
  Scenario: SC#1: Update Git credentials with exact values
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                               | username    | password    |
      | ida/javaParserPayloads/javaParser_git_credentials.json | $..userName | $..password |

  @cr-data @sanity
  Scenario Outline: SC#2: Run the Plugin configurations for GitCollector and Java Parser
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                         | body                                                   | response code | response message         | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/ValidGitCredentialsJ1                                  | ida/javaParserPayloads/javaParser_git_credentials.json | 200           |                          |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                   | ida/javaParserPayloads/git_default_datasource.json     | 204           |                          |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJ1          | ida/javaParserPayloads/javaParser_git_datasource.json  | 204           |                          |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJ1          |                                                        | 200           | GitCollectorDataSourceJ1 |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector/GitCollectorJ1                              | ida/javaParserPayloads/Git_Java_Parser.json            | 204           |                          |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector/GitCollectorJ1                              |                                                        | 200           | GitCollectorJ1           |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJ1 |                                                        | 200           | IDLE                     | $.[?(@.configurationName=='GitCollectorJ1')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorJ1  | ida/empty.json                                         | 200           |                          |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJ1 |                                                        | 200           | IDLE                     | $.[?(@.configurationName=='GitCollectorJ1')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaParser/JavaParserJ1                                  | ida/javaParserPayloads/Java_parser_internal.json       | 204           |                          |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaParser/JavaParserJ1                                  |                                                        | 200           | JavaParserJ1             |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/parser/JavaParser/JavaParserJ1     |                                                        | 200           | IDLE                     | $.[?(@.configurationName=='JavaParserJ1')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/parser/JavaParser/JavaParserJ1      | ida/empty.json                                         | 200           |                          |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/parser/JavaParser/JavaParserJ1     |                                                        | 200           | IDLE                     | $.[?(@.configurationName=='JavaParserJ1')].status   |

  #6609797#
  @webtest @MLP-9905 @sanity @positive
  Scenario: SC#3: Verify plugin java parser ran as expected with internal node
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaParser" and clicks on search
    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "SubClassWithSuperClass.java" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                          | widgetName  |
      | Created by        | KarthikDeepan.Gujulu                   | Description |
      | Location          | javaParser/SubClassWithSuperClass.java | Description |
      | MIME type         | text/x-java-source                     | Description |
      | Modified by       | KarthikDeepan.Gujulu                   | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Created           | Lifecycle  |
      | Modified          | Lifecycle  |
      | Last collected at | Lifecycle  |
      | Last parsed at    | Lifecycle  |
    Then user performs click and verify in new window
      | Table       | value                       | Action                    | RetainPrevwindow | indexSwitch | filePath                                     | jsonPath                 | metadataSection |
      | Source Tree | SubClassWithSuperClass      | verify widget contains    |                  |             |                                              |                          |                 |
      | Data        | SubClassWithSuperClass.java | click and verify metadata | Yes              | 0           | ida/javaParserPayloads/expectedMetadata.json | $.SubClassWithSuperClass | Data            |
    And user should be able logoff the IDC

  @cr-data @sanity
  Scenario Outline: SC#4: Run the Plugin configurations for GitCollector and Java Parser
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                  | body                                        | response code | response message | jsonPath                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaParser/JavaParserJ4                           | ida/javaParserPayloads/Java_parser_SC4.json | 204           |                  |                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaParser/JavaParserJ4                           |                                             | 200           | JavaParserJ4     |                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParserJ4 |                                             | 200           | IDLE             | $.[?(@.configurationName=='JavaParserJ4')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParserJ4  | ida/empty.json                              | 200           |                  |                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParserJ4 |                                             | 200           | IDLE             | $.[?(@.configurationName=='JavaParserJ4')].status |

  #6609797#
  @webtest @MLP-9905 @sanity @positive
  Scenario: SC#4: Verify plugin java parser log has no items processed log
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "JavaParserJ4" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
    And user "click" on "AnalysisItem" containing "Java"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Name of plugin            | JavaParser    |
      | Number of errors          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "parser/JavaParser/JavaParserJ4%" should display below info/error/warning
      | type | logValue                                                                                                                                       | logCode       | pluginName | removableText |
      | INFO | ANALYSIS-0072: Plugin JavaParser Start Time:2020-04-07 11:27:02.516, End Time:2020-04-07 11:27:02.765, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | JavaParser |               |

  @regression @sanity
  Scenario Outline: PostConditions-User retrieves the item ids of different items for Git Collector and Java Parser
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                       | type | targetFile                                   | jsonpath                     |
      | APPDBPOSTGRES | Default | javaspark_lineage                          |      | response/java/JavaParser/actual/itemIds.json | $..GitData.has_Project.id    |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollectorJ1/%DYN |      | response/java/JavaParser/actual/itemIds.json | $..GitData.has_Analysis.id   |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParserJ1/%DYN        |      | response/java/JavaParser/actual/itemIds.json | $..JavaData.has_Analysis1.id |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParserJ4/%DYN        |      | response/java/JavaParser/actual/itemIds.json | $..JavaData.has_Analysis2.id |

  @regression @sanity
  Scenario Outline: PostConditions-User deletes the content of different items for for Git Collector and Java Parser
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                    | inputFile                                    |
      | items/Default/Default.Project:::dynamic  | 204          | $..GitData.has_Project.id    | response/java/JavaParser/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..GitData.has_Analysis.id   | response/java/JavaParser/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..JavaData.has_Analysis1.id | response/java/JavaParser/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..JavaData.has_Analysis2.id | response/java/JavaParser/actual/itemIds.json |

  @cr-data @sanity @positive
  Scenario Outline: PostConditions-Delete the Credentials, Data Sources and Confirgurations for Git Collector and Java Parser plugins Configurations
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidGitCredentialsJ1                         |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJ1 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollector/GitCollectorJ1                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/JavaParser/JavaParserJ1                         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/JavaParser/JavaParserJ4                         |      | 204           |                  |          |

