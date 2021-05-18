@MLP-25373 @MLP-24877 @MLP-9905 @MLP-25370
Feature: Feature to validate the functionalities of Java Parser plugin collected by Git Collector plugin on running through LocalNode

  @git @precondition
  Scenario: SC#1-Update Git credentials with exact values
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                               | username    | password    |
      | ida/javaParserPayloads/javaParser_git_credentials.json | $..userName | $..password |

  @cr-data @sanity
  Scenario Outline: SC#3: Run the credentials configurations for GitCollector
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                        | body                                                   | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidGitCredentialsJ1 | ida/javaParserPayloads/javaParser_git_credentials.json | 200           |                  |          |


  @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#2-create Bussiness Application tag for Java Parser
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                      | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/javaParserPayloads/JavaParser_BA.json | 200           |                  |          |

  @cr-data @sanity
  Scenario Outline: SC#3: Run the Plugin configurations for GitCollector and Java Parser
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                         | body                                                  | response code | response message         | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                   | ida/javaParserPayloads/git_default_datasource.json    | 204           |                          |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJ1          | ida/javaParserPayloads/javaParser_git_datasource.json | 204           |                          |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJ1          |                                                       | 200           | GitCollectorDataSourceJ1 |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector/GitCollectorJ1                              | ida/javaParserPayloads/Git_Java_Parser.json           | 204           |                          |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector/GitCollectorJ1                              |                                                       | 200           | GitCollectorJ1           |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJ1 |                                                       | 200           | IDLE                     | $.[?(@.configurationName=='GitCollectorJ1')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorJ1  | ida/empty.json                                        | 200           |                          |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJ1 |                                                       | 200           | IDLE                     | $.[?(@.configurationName=='GitCollectorJ1')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaParser/JavaParserJ1                                  | ida/javaParserPayloads/Java_parser.json               | 204           |                          |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaParser/JavaParserJ1                                  |                                                       | 200           | JavaParserJ1             |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParserJ1        |                                                       | 200           | IDLE                     | $.[?(@.configurationName=='JavaParserJ1')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParserJ1         | ida/empty.json                                        | 200           |                          |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParserJ1        |                                                       | 200           | IDLE                     | $.[?(@.configurationName=='JavaParserJ1')].status   |

  Scenario Outline: SC#4-Dry run test Java Parser
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                  | body                                           | response code | response message | jsonPath                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaParser/JavaParserJ2                           | ida/javaParserPayloads/Java_parser_dryrun.json | 204           |                  |                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaParser/JavaParserJ2                           |                                                | 200           | JavaParserJ2     |                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParserJ2 |                                                | 200           | IDLE             | $.[?(@.configurationName=='JavaParserJ2')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParserJ2  | ida/empty.json                                 | 200           |                  |                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParserJ2 |                                                | 200           | IDLE             | $.[?(@.configurationName=='JavaParserJ2')].status |

  @webtest @sanity @positive @webtest
  Scenario: SC#4-Verify Dry run for Amazon Glue Lineage plugin
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JavaParserJ2" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on the items listed contains "JavaParserJ2"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "parser/JavaParser/JavaParserJ2%" should display below info/error/warning
      | type | logValue                                                 | logCode       | pluginName | removableText |
      | INFO | Plugin started                                           | ANALYSIS-0019 |            |               |
      | INFO | ANALYSIS-0069: Plugin JavaParser running on dry run mode | ANALYSIS-0069 |            |               |

  #6608751#
  @webtest @MLP-9905 @sanity @positive
  Scenario:SC#6: Parsing the repository and validating the errorDetails in Source Tree's metadata of invalid java file
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "InvalidJavaFile" and clicks on search
    And user performs "facet selection" in "tagJavaParser" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "InvalidJavaFile" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute               | metaDataValue | widgetName |
      | Number of imports               | 2             | Statistics |
      | Number of unresolved references | 0             | Statistics |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | InvalidJavaFile                                 |
      | widgetName     | Description                                     |
      | attributeName  | errorDetails                                    |
      | actualFilePath | ida/javaParserPayloads/actualErrorDetails1.json |
    Then file content in "ida/javaParserPayloads/expectedErrorDetails1.json" should be same as the content in "ida/javaParserPayloads/actualErrorDetails1.json"

  #6608750#
  @webtest @MLP-9905 @sanity @positive
  Scenario:SC#7: Parsing the repository and validating the Number of imports and rawImports metadata
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "FileToDirectory2" and clicks on search
    And user performs "facet selection" in "tagJavaParser" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FileToDirectory2" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute               | metaDataValue | widgetName |
      | Number of imports               | 12            | Statistics |
      | Number of unresolved references | 0             | Statistics |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | FileToDirectory2                              |
      | widgetName     | Description                                   |
      | attributeName  | rawImports                                    |
      | actualFilePath | ida/javaParserPayloads/actualRawImports1.json |
    Then file content in "ida/javaParserPayloads/expectedRawImports1.json" should be same as the content in "ida/javaParserPayloads/actualRawImports1.json"
    And user should be able logoff the IDC

  #6609209# #6609210# #6609211#
  @webtest @MLP-9905 @sanity @positive
  Scenario:SC#8: Parsing the repository and validating the static variable, constant strings and raw invokes
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "TestStatic" and clicks on search
    And user performs "facet selection" in "tagJavaParser" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TestStatic" item from search results
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Classes | TestStatic | click and switch tab | No               |             |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | TestStatic                                         |
      | widgetName     | Description                                        |
      | attributeName  | constantStrings                                    |
      | actualFilePath | ida/javaParserPayloads/actualConstantStrings5.json |
    Then file content in "ida/javaParserPayloads/expectedConstantStrings5.json" should be same as the content in "ida/javaParserPayloads/actualConstantStrings5.json"
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | TestStatic                                        |
      | widgetName     | Description                                       |
      | attributeName  | staticVariable                                    |
      | actualFilePath | ida/javaParserPayloads/actualstaticVariable5.json |
    Then file content in "ida/javaParserPayloads/expectedstaticVariable5.json" should be same as the content in "ida/javaParserPayloads/actualstaticVariable5.json"
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | TestStatic                                    |
      | widgetName     | Description                                   |
      | attributeName  | rawInvokes                                    |
      | actualFilePath | ida/javaParserPayloads/actualrawInvokes5.json |
    Then file content in "ida/javaParserPayloads/expectedrawInvokes5.json" should be same as the content in "ida/javaParserPayloads/actualrawInvokes5.json"
    And user should be able logoff the IDC


  #6609213# #6608717# #6608752# #6608907#
  @webtest @MLP-9905 @sanity @positive
  Scenario:SC#9: Parsing the repository and validating metadata - superClasses
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "SubClassWithSuperClass" and clicks on search
    And user performs "facet selection" in "tagJavaParser" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "SubClassWithSuperClass" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute               | metaDataValue | widgetName |
      | Number of imports               | 2             | Statistics |
      | Number of unresolved references | 0             | Statistics |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | SubClassWithSuperClass                        |
      | widgetName     | Description                                   |
      | attributeName  | rawImports                                    |
      | actualFilePath | ida/javaParserPayloads/actualRawImports6.json |
    Then file content in "ida/javaParserPayloads/expectedRawImports6.json" should be same as the content in "ida/javaParserPayloads/actualRawImports6.json"
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | SubClassWithSuperClass                          |
      | widgetName     | Description                                     |
      | attributeName  | errorDetails                                    |
      | actualFilePath | ida/javaParserPayloads/actualErrorDetails6.json |
    Then file content in "ida/javaParserPayloads/expectedEmptyJson.json" should be same as the content in "ida/javaParserPayloads/actualErrorDetails6.json"
    Then user performs click and verify in new window
      | Table   | value                  | Action               | RetainPrevwindow | indexSwitch |
      | Classes | SubClassWithSuperClass | click and switch tab | No               |             |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | SubClassWithSuperClass                            |
      | widgetName     | Description                                       |
      | attributeName  | staticVariable                                    |
      | actualFilePath | ida/javaParserPayloads/actualstaticVariable6.json |
    Then file content in "ida/javaParserPayloads/expectedEmptyJson.json" should be same as the content in "ida/javaParserPayloads/actualstaticVariable6.json"
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | SubClassWithSuperClass                          |
      | widgetName     | Description                                     |
      | attributeName  | superClasses                                    |
      | actualFilePath | ida/javaParserPayloads/actualsuperclasses6.json |
    Then file content in "ida/javaParserPayloads/expectedsuperClasses6.json" should be same as the content in "ida/javaParserPayloads/actualsuperclasses6.json"
    And user should be able logoff the IDC

   #6609668# #6609681# #6609611# #6609682#
  @webtest @MLP-9905 @sanity @positive
  Scenario:SC#10: Parsing the repository and validating the Functions metadata - rawInvokes and Number of Parameters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "SubClassWithSuperClass" and clicks on search
    And user performs "facet selection" in "tagJavaParser" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "SubClassWithSuperClass" item from search results
    Then user performs click and verify in new window
      | Table     | value      | Action               | RetainPrevwindow | indexSwitch |
      | Classes   | SuperClass | click and switch tab | No               |             |
      | Functions | addition   | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute    | metaDataValue | widgetName  |
      | Number of parameters | 2             | Statistics  |
      | endColumn            | 5             | Description |
      | endLine              | 8             | Description |
      | Short name           | addition      | Description |
      | startColumn          | 11            | Description |
      | startLine            | 5             | Description |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | addition                                      |
      | attributeName  | Parameters                                    |
      | actualFilePath | ida/javaParserPayloads/actualParameters7.json |
    Then file content in "ida/javaParserPayloads/expectedParameters7.json" should be same as the content in "ida/javaParserPayloads/actualParameters7.json"
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | addition                                      |
      | widgetName     | Description                                   |
      | attributeName  | rawInvokes                                    |
      | actualFilePath | ida/javaParserPayloads/actualrawInvokes7.json |
    Then file content in "ida/javaParserPayloads/expectedrawInvokes7.json" should be same as the content in "ida/javaParserPayloads/actualrawInvokes7.json"
    And user should be able logoff the IDC

  #6609212#
  @webtest @MLP-9905 @sanity @positive
  Scenario:SC#11: Parsing the repository and validating metadata - staticVariable and superClasses of Overrided Class
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "TestOverloading" and clicks on search
    And user performs "facet selection" in "tagJavaParser" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TestOverloading" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Classes | Adder | click and switch tab | No               |             |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | Adder                                             |
      | widgetName     | Description                                       |
      | attributeName  | staticVariable                                    |
      | actualFilePath | ida/javaParserPayloads/actualstaticVariable8.json |
    Then file content in "ida/javaParserPayloads/expectedEmptyJson.json" should be same as the content in "ida/javaParserPayloads/actualstaticVariable8.json"
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | Adder                                           |
      | widgetName     | Description                                     |
      | attributeName  | superClasses                                    |
      | actualFilePath | ida/javaParserPayloads/actualsuperclasses8.json |
    Then file content in "ida/javaParserPayloads/expectedEmptyJson.json" should be same as the content in "ida/javaParserPayloads/actualsuperclasses8.json"
    Then user performs click and verify in new window
      | Table     | value                       | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | add/Integer/Integer         | verify widget contains |                  |             |
      | Functions | add/Integer/Integer/Integer | verify widget contains |                  |             |
      | Functions | add/LongDouble/LongDouble   | verify widget contains |                  |             |
    And user should be able logoff the IDC

  #6609678#
  @webtest @MLP-9905 @sanity @positive
  Scenario:SC#12: Parsing the repository and validating the Functions metadata which has constantStrings attribute
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "ResolveParamLambda1" and clicks on search
    And user performs "facet selection" in "tagJavaParser" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ResolveParamLambda1" item from search results
    Then user performs click and verify in new window
      | Table     | value               | Action               | RetainPrevwindow | indexSwitch |
      | Classes   | ResolveParamLambda1 | click and switch tab | No               |             |
      | Functions | main                | click and switch tab | No               |             |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | main                                               |
      | widgetName     | Description                                        |
      | attributeName  | constantStrings                                    |
      | actualFilePath | ida/javaParserPayloads/actualConstantStrings9.json |
    Then file content in "ida/javaParserPayloads/expectedConstantStrings9.json" should be same as the content in "ida/javaParserPayloads/actualConstantStrings9.json"

  #6609681#
  @webtest @MLP-9905 @sanity @positive
  Scenario:SC#13: Parsing the repository and validating the Functions metadata which has no parameters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "ResolveFunctionReference2" and clicks on search
    And user performs "facet selection" in "tagJavaParser" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ResolveFunctionReference2" item from search results
    Then user performs click and verify in new window
      | Table     | value                     | Action               | RetainPrevwindow | indexSwitch |
      | Classes   | ResolveFunctionReference2 | click and switch tab | No               |             |
      | Functions | callSomeThing             | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute    | metaDataValue | widgetName  |
      | Number of parameters | 0             | Statistics  |
      | endColumn            | 3             | Description |
      | endLine              | 4             | Description |
      | Short name           | callSomeThing | Description |
      | startColumn          | 9             | Description |
      | startLine            | 2             | Description |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | callSomeThing                                  |
      | attributeName  | Parameters                                     |
      | actualFilePath | ida/javaParserPayloads/actualParameters10.json |
    Then file content in "ida/javaParserPayloads/expectedEmptyJson.json" should be same as the content in "ida/javaParserPayloads/actualParameters10.json"
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | callSomeThing                                  |
      | widgetName     | Description                                    |
      | attributeName  | rawInvokes                                     |
      | actualFilePath | ida/javaParserPayloads/actualrawInvokes10.json |
    Then file content in "ida/javaParserPayloads/expectedrawInvokes10.json" should be same as the content in "ida/javaParserPayloads/actualrawInvokes10.json"
    And user should be able logoff the IDC

  #6609681# #6610504# #6610505#
  @webtest @MLP-9905 @sanity @positive
  Scenario:SC#14: Parsing the repository and validating the Nested classes functionality and Method-local Inner Class functionality (Class inside a method)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "ContainsNestedClass" and clicks on search
    And user performs "facet selection" in "tagJavaParser" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ContainsNestedClass" item from search results
    Then user performs click and verify in new window
      | Table   | value               | Action               | RetainPrevwindow | indexSwitch |
      | Classes | ContainsNestedClass | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue   | widgetName  |
      | Comments          | // Nested class | Description |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | ContainsNestedClass                              |
      | widgetName     | Description                                      |
      | attributeName  | superClasses                                     |
      | actualFilePath | ida/javaParserPayloads/actualsuperClasses11.json |
    Then file content in "ida/javaParserPayloads/expectedsuperClasses11.json" should be same as the content in "ida/javaParserPayloads/actualsuperClasses11.json"
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | ContainsNestedClass                                |
      | widgetName     | Description                                        |
      | attributeName  | staticVariable                                     |
      | actualFilePath | ida/javaParserPayloads/actualstaticVariable11.json |
    Then file content in "ida/javaParserPayloads/expectedstaticVariable11.json" should be same as the content in "ida/javaParserPayloads/actualstaticVariable11.json"
    Then user performs click and verify in new window
      | Table     | value            | Action                 | RetainPrevwindow | indexSwitch |
      | Classes   | InnerClass       | verify widget contains |                  |             |
      | Functions | callingBaseFun   | verify widget contains |                  |             |
      | Functions | funContainsClass | verify widget contains |                  |             |
      | Functions | getNumber        | verify widget contains |                  |             |
      | Functions | getString        | verify widget contains |                  |             |
      | Functions | memberFunction   | verify widget contains |                  |             |
      | Functions | funContainsClass | click and switch tab   | No               |             |
      | Classes   | Foobar           | verify widget contains |                  |             |
    And user should be able logoff the IDC

  #6612036#
  @webtest @MLP-9905 @sanity @positive
  Scenario:SC#15: Parsing the repository and validating the Class which has multiple functions
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "StudentMultipleMethods" and clicks on search
    And user performs "facet selection" in "tagJavaParser" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "StudentMultipleMethods" item from search results
    Then user performs click and verify in new window
      | Table     | value                  | Action                 | RetainPrevwindow | indexSwitch |
      | Classes   | StudentMultipleMethods | click and switch tab   | No               |             |
      | Functions | getAllSubjectsTotal    | verify widget contains |                  |             |
      | Functions | getLanguagesTotal      | verify widget contains |                  |             |
      | Functions | getNonLanguagesTotal   | verify widget contains |                  |             |
      | Functions | getPCMPercentage       | verify widget contains |                  |             |
      | Functions | main                   | verify widget contains |                  |             |
      | Functions | printMarksDetails      | verify widget contains |                  |             |
      | Functions | printMarksSummary      | verify widget contains |                  |             |
    And user should be able logoff the IDC

  #6612035# #7139732#
  @webtest @MLP-9905 @sanity @positive
  Scenario:SC#16: Parsing the repository and validating the Final and Abstract classes
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "FinalClassExample" and clicks on search
    And user performs "facet selection" in "tagJavaParser" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FinalClassExample" item from search results
    Then user performs click and verify in new window
      | Table   | value             | Action               | RetainPrevwindow | indexSwitch |
      | Classes | FinalClassExample | click and switch tab | No               |             |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | FinalClassExample                                |
      | widgetName     | Description                                      |
      | attributeName  | superClasses                                     |
      | actualFilePath | ida/javaParserPayloads/actualsuperClasses13.json |
    Then file content in "ida/javaParserPayloads/expectedEmptyJson.json" should be same as the content in "ida/javaParserPayloads/actualsuperClasses13.json"
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | FinalClassExample                                  |
      | widgetName     | Description                                        |
      | attributeName  | staticVariable                                     |
      | actualFilePath | ida/javaParserPayloads/actualstaticVariable13.json |
    Then file content in "ida/javaParserPayloads/expectedEmptyJson.json" should be same as the content in "ida/javaParserPayloads/actualstaticVariable13.json"
    Then user performs click and verify in new window
      | Table     | value | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | main  | verify widget contains |                  |             |
    And user should be able logoff the IDC

  #7139733#
  @webtest @MLP-24877 @sanity @positive
  Scenario:SC#17: Verifying the Java 10 Support
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "Local3" and clicks on search
    And user performs "facet selection" in "tagJavaParser" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Local3" item from search results
    Then user performs click and verify in new window
      | Table     | value        | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | test         | verify widget contains |                  |             |
      | Functions | test1/Map    | verify widget contains |                  |             |
      | Functions | test1/String | verify widget contains |                  |             |
    And user enters the search text "tagJavaParser" and clicks on search
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Local4" item from search results
    Then user performs click and verify in new window
      | Table     | value | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | test  | verify widget contains |                  |             |
      | Functions | test1 | verify widget contains |                  |             |
      | Functions | test2 | verify widget contains |                  |             |
      | Functions | test3 | verify widget contains |                  |             |
      | Functions | test4 | verify widget contains |                  |             |
      | Functions | test5 | verify widget contains |                  |             |
      | Functions | test6 | verify widget contains |                  |             |
      | Functions | test7 | verify widget contains |                  |             |


  #7154123#
  @webtest @MLP-25370 @sanity @positive
  Scenario:SC#18: Verify Java Parser is able to parse the Java File successfully when variable with type var is used in Lambda Statements - Java 11 Support test
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "LambdaLocalVariableTypeInference" and clicks on search
    And user performs "facet selection" in "tagJavaParser" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "LambdaLocalVariableTypeInference" item from search results
    Then user performs click and verify in new window
      | Table     | value   | Action               | RetainPrevwindow | indexSwitch |
      | Functions | withVar | click and switch tab | No               |             |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | withVar                                        |
      | widgetName     | Description                                    |
      | attributeName  | rawInvokes                                     |
      | actualFilePath | ida/javaParserPayloads/actualRawInvokes18.json |
    Then file content in "ida/javaParserPayloads/expectedRawInvokes18.json" should be same as the content in "ida/javaParserPayloads/actualRawInvokes18.json"
    And user navigates to the index "0" using TopBreadCrumblist to perform actions
    Then user performs click and verify in new window
      | Table     | value      | Action               | RetainPrevwindow | indexSwitch |
      | Functions | withoutVar | click and switch tab | No               |             |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | withoutVar                                      |
      | widgetName     | Description                                     |
      | attributeName  | rawInvokes                                      |
      | actualFilePath | ida/javaParserPayloads/actualRawInvokes18A.json |
    Then file content in "ida/javaParserPayloads/expectedRawInvokes18A.json" should be same as the content in "ida/javaParserPayloads/actualRawInvokes18A.json"


  #7154124#
  @webtest @MLP-25370 @sanity @positive
  Scenario:SC#19: Verify Java Parser is able to parse the Java File successfully when Lambda Statements are used without variable type var - Java 11 Support test
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "LambdaExpwithVar" and clicks on search
    And user performs "facet selection" in "tagJavaParser" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "LambdaExpwithVar" item from search results
    Then user performs click and verify in new window
      | Table     | value       | Action               | RetainPrevwindow | indexSwitch |
      | Functions | testWithVar | click and switch tab | No               |             |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | testWithVar                                    |
      | widgetName     | Description                                    |
      | attributeName  | rawInvokes                                     |
      | actualFilePath | ida/javaParserPayloads/actualRawInvokes19.json |
    Then file content in "ida/javaParserPayloads/expectedRawInvokes19.json" should be same as the content in "ida/javaParserPayloads/actualRawInvokes19.json"
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table     | value          | Action               | RetainPrevwindow | indexSwitch |
      | Functions | testWithoutVar | click and switch tab | No               |             |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | testWithoutVar                                  |
      | widgetName     | Description                                     |
      | attributeName  | rawInvokes                                      |
      | actualFilePath | ida/javaParserPayloads/actualRawInvokes19A.json |
    Then file content in "ida/javaParserPayloads/expectedRawInvokes19A.json" should be same as the content in "ida/javaParserPayloads/actualRawInvokes19A.json"


  #7180728# #7180729# #7180730# #7180731# #7180732# #7180733#
  @webtest @MLP-25373 @sanity @positive
  Scenario:SC#20: Verify Java Parser is able to parse the Java File successfully for enbhanced SwitchCase - Java 13 & 14 Support test
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "WhoIsWho" and clicks on search
    And user performs "facet selection" in "tagJavaParser" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "WhoIsWho" item from search results
    Then user performs click and verify in new window
      | Table     | value                                | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | doSomething                          | verify widget contains | No               |             |
      | Functions | doSomethingDifferent                 | verify widget contains | No               |             |
      | Functions | doSomethingElse                      | verify widget contains | No               |             |
      | Functions | java14SwitchWithDirectReturn         | verify widget contains | No               |             |
      | Functions | java14SwitchWithNoDirectReturn       | verify widget contains | No               |             |
      | Functions | main                                 | verify widget contains | No               |             |
      | Functions | print                                | verify widget contains | No               |             |
      | Functions | testo                                | verify widget contains | No               |             |
      | Functions | yieldStInSwitch14                    | verify widget contains | No               |             |
      | Functions | yieldStInSwitch14TradionalSwitchCase | verify widget contains | No               |             |
      | Functions | yieldStInSwitch8TradionalCase        | verify widget contains | No               |             |

  #6662053#
  @webtest @MLP-9905 @sanity @positive
  Scenario:SC#21: Validate that Valid Java files are parsed without any issues even if any invalid java files are available in the repository
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "ImproperJavaFile.java" and clicks on search
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ImproperJavaFile.java" item from search results
    Then confirm "SOURCE TREE" window is not available

  #6609798#
  @webtest @MLP-9905 @sanity @positive
  Scenario: SC#22: Verify the technology tags got assigned to the Cataloged items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                       | fileName               | userTag                |
      | Default     | Class      | Metadata Type | Java,test_BA_JavaParser,tagJavaParser     | SuperClass             | tagJavaParser          |
      | Default     | File       | Metadata Type | Git,Java,test_BA_JavaParser,tagJavaParser | Caller.java            | Caller.java            |
      | Default     | Function   | Metadata Type | Java,test_BA_JavaParser,tagJavaParser     | printMarksDetails      | printMarksDetails      |
      | Default     | Project    | Metadata Type | Git,Java,test_BA_JavaParser,tagJavaParser | javaspark_lineage      | tagJavaParser          |
      | Default     | Directory  | Metadata Type | Git,test_BA_JavaParser,tagJavaParser      | javaParser             | tagJavaParser          |
      | Default     | SourceTree | Metadata Type | Java,test_BA_JavaParser,tagJavaParser     | StudentMultipleMethods | StudentMultipleMethods |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag         | fileName               | userTag                |
      | Default     | Class      | Metadata Type | Programming | SuperClass             | SuperClass             |
      | Default     | Function   | Metadata Type | Programming | printMarksDetails      | printMarksDetails      |
      | Default     | SourceTree | Metadata Type | Programming | StudentMultipleMethods | StudentMultipleMethods |
    And user should be able logoff the IDC

  @webtest @aws @regression @sanity @Bug-20149
  Scenario: SC#23-Verify logging enhancements
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagJavaParser" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on the items listed contains "JavaParserJ1"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 30            |
      | Number of errors          | 3             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "parser/JavaParser/JavaParserJ1%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | logCode       | pluginName | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0019 |            |                |
      | INFO | ANALYSIS-0071: Plugin Name:JavaParser, Plugin Type:parser, Plugin Version:1.0.0.SNAPSHOT, Node Name:LocalNode, Host Name:ab7f58d973a9, Plugin Configuration name:JavaParserJ1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ANALYSIS-0071 | JavaParser | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin JavaParser Configuration: ---  2020-08-27 08:27:26.292 INFO  - ANALYSIS-0073: Plugin JavaParser Configuration: name: "JavaParserJ1"  2020-08-27 08:27:26.292 INFO  - ANALYSIS-0073: Plugin JavaParser Configuration: pluginVersion: "LATEST"  2020-08-27 08:27:26.292 INFO  - ANALYSIS-0073: Plugin JavaParser Configuration: label:  2020-08-27 08:27:26.292 INFO  - ANALYSIS-0073: Plugin JavaParser Configuration: : "JavaParserJ1"  2020-08-27 08:27:26.292 INFO  - ANALYSIS-0073: Plugin JavaParser Configuration: catalogName: "Default"  2020-08-27 08:27:26.292 INFO  - ANALYSIS-0073: Plugin JavaParser Configuration: eventClass: null  2020-08-27 08:27:26.292 INFO  - ANALYSIS-0073: Plugin JavaParser Configuration: eventCondition: null  2020-08-27 08:27:26.292 INFO  - ANALYSIS-0073: Plugin JavaParser Configuration: nodeCondition: null  2020-08-27 08:27:26.292 INFO  - ANALYSIS-0073: Plugin JavaParser Configuration: maxWorkSize: 100  2020-08-27 08:27:26.292 INFO  - ANALYSIS-0073: Plugin JavaParser Configuration: tags:  2020-08-27 08:27:26.292 INFO  - ANALYSIS-0073: Plugin JavaParser Configuration: - "tagJavaParser"  2020-08-27 08:27:26.292 INFO  - ANALYSIS-0073: Plugin JavaParser Configuration: pluginType: "parser"  2020-08-27 08:27:26.292 INFO  - ANALYSIS-0073: Plugin JavaParser Configuration: dataSource: null  2020-08-27 08:27:26.292 INFO  - ANALYSIS-0073: Plugin JavaParser Configuration: credential: null  2020-08-27 08:27:26.292 INFO  - ANALYSIS-0073: Plugin JavaParser Configuration: businessApplicationName: "test_BA_JavaParser"  2020-08-27 08:27:26.292 INFO  - ANALYSIS-0073: Plugin JavaParser Configuration: dryRun: false  2020-08-27 08:27:26.292 INFO  - ANALYSIS-0073: Plugin JavaParser Configuration: schedule: null  2020-08-27 08:27:26.292 INFO  - ANALYSIS-0073: Plugin JavaParser Configuration: filter: null | ANALYSIS-0073 | JavaParser |                |
      | INFO | PARSING-0001: Parsing file ConstructorExample                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | PARSING-0001  |            |                |
      | INFO | PARSING-0002: File ConstructorExample parsed with no errors                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | PARSING-0002  |            |                |
      | INFO | ANALYSIS-0072: Plugin JavaParser Start Time:2020-03-25 08:39:43.481, End Time:2020-03-25 08:39:44.772, Processed Count:30, Errors:3, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0072 | JavaParser |                |
      | INFO | ANALYSIS-0075: Plugin completed with errors (elapsed time in (HH:MM:SS.ms): 00:00:01.291)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0075 |            |                |

  @regression @sanity
  Scenario Outline: PostConditions-User retrieves the item ids of different items for Git Collector and Java Parser
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                       | type | targetFile                                   | jsonpath                     |
      | APPDBPOSTGRES | Default | javaspark_lineage                          |      | response/java/JavaParser/actual/itemIds.json | $..GitData.has_Project.id    |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollectorJ1/%DYN |      | response/java/JavaParser/actual/itemIds.json | $..GitData.has_Analysis.id   |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParserJ1/%DYN        |      | response/java/JavaParser/actual/itemIds.json | $..JavaData.has_Analysis1.id |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParserJ2/%DYN        |      | response/java/JavaParser/actual/itemIds.json | $..JavaData.has_Analysis2.id |
      | APPDBPOSTGRES | Default | test_BA_JavaParser                         |      | response/java/JavaParser/actual/itemIds.json | $..BAData.has_BA.id          |

  @regression @sanity
  Scenario Outline: PostConditions-User deletes the content of different items for for Git Collector and Java Parser
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                    | inputFile                                    |
      | items/Default/Default.Project:::dynamic             | 204          | $..GitData.has_Project.id    | response/java/JavaParser/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..GitData.has_Analysis.id   | response/java/JavaParser/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JavaData.has_Analysis1.id | response/java/JavaParser/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JavaData.has_Analysis2.id | response/java/JavaParser/actual/itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BAData.has_BA.id          | response/java/JavaParser/actual/itemIds.json |

  @cr-data @sanity @positive
  Scenario Outline: PostConditions-Delete the Credentials, Data Sources and Confirgurations for Git Collector and Java Parser plugins Configurations
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidGitCredentialsJ1                         |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJ1 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollector/GitCollectorJ1                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/JavaParser/JavaParserJ1                         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/JavaParser/JavaParserJ2                         |      | 204           |                  |          |
