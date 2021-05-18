Feature: Validation of Java Linker plugin functionality after running git and Java parser plugins

  @git @precondition
  Scenario: SC#1 Update Git credentials with exact values
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                               | username    | password    |
      | ida/javaLinkerPayloads/javaLinker_git_credentials.json | $..userName | $..password |

  @sanity @positive @regression
  Scenario Outline: SC#2_Set the credentials for GitCollector
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                      | body                                                   | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidGitCredentials | ida/javaLinkerPayloads/javaLinker_git_credentials.json | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentials | idc/EdiBusPayloads/credentials/EDIBusValidCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidGitCredentials |                                                        | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusValidCredentials |                                                            | 200           |                  |          |

  @sanity @positive @regression
  Scenario Outline: SC#3 Create BusinessApplication tag and run the plugin configuration with the new field for Git
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/javaLinkerPayloads/javaLinker_BusinessApplication.json | 200           |                  |          |


  @MLP-10340 @sanity @positive
  Scenario Outline: SC#6_Run the Plugin configurations for GitCollector ,Java Parser and Java Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                        | body                                                  | response code | response message       | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                  | ida/javaLinkerPayloads/javaLinker_git_datasource.json | 204           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource                                  |                                                       | 200           | GitCollectorDataSource |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                            | ida/javaLinkerPayloads/javaLinker_git.json            | 204           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector                                            |                                                       | 200           | JavaLinkerGit          |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/JavaLinkerGit |                                                       | 200           | IDLE                   | $.[?(@.configurationName=='JavaLinkerGit')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/JavaLinkerGit  | ida/empty.json                                        | 200           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/JavaLinkerGit |                                                       | 200           | IDLE                   | $.[?(@.configurationName=='JavaLinkerGit')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaParser                                              | ida/JavaLinkerPayloads/javaLinker_parser.json         | 204           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaParser                                              |                                                       | 200           | JavaParser             |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser         |                                                       | 200           | IDLE                   | $.[?(@.configurationName=='JavaParser')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParser          | ida/empty.json                                        | 200           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser         |                                                       | 200           | IDLE                   | $.[?(@.configurationName=='JavaParser')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaLinker                                              | ida/JavaLinkerPayloads/javaLinker_linker.json         | 204           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaLinker                                              |                                                       | 200           | JavaLinker             |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaLinker/JavaLinker         |                                                       | 200           | IDLE                   | $.[?(@.configurationName=='JavaLinker')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/JavaLinker/JavaLinker          | ida/empty.json                                        | 200           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaLinker/JavaLinker         |                                                       | 200           | IDLE                   | $.[?(@.configurationName=='JavaLinker')].status    |

  Scenario Outline: SC#7- User retrieves the item ids of different items and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                     | type    | targetFile                                   | jsonpath               |
      | APPDBPOSTGRES | Default | automationtestjavalinker                 | Project | response/java/javaLinker/actual/itemIds.json | $..Project.id          |
      | APPDBPOSTGRES | Default | test_BA_JavaLinker                       |         | response/java/javaLinker/actual/itemIds.json | $..has_BA.id           |
      | APPDBPOSTGRES | Default | java.lang.Object                         |         | response/java/javaLinker/actual/itemIds.json | $..ExternalPackage1.id |
      | APPDBPOSTGRES | Default | com.asg.sample1.Arity                    |         | response/java/javaLinker/actual/itemIds.json | $..ExternalPackage2.id |
      | APPDBPOSTGRES | Default | System.out                               |         | response/java/javaLinker/actual/itemIds.json | $..ExternalPackage3.id |
      | APPDBPOSTGRES | Default | collector/GitCollector/JavaLinkerGit%DYN |         | response/java/javaLinker/actual/itemIds.json | $..Git_Analysis.id     |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParser%DYN         |         | response/java/javaLinker/actual/itemIds.json | $..JParser_Analysis.id |
      | APPDBPOSTGRES | Default | linker/JavaLinker/JavaLinker%DYN         |         | response/java/javaLinker/actual/itemIds.json | $..JLinker_Analysis.id |

  @webtest @MLP-10340 @sanity @positive
  Scenario: SC#8 Verify facet counts appears properly for the items collected by GitCollector ,Java Parser and Java Linker
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType       | count |
      | Project         | 1     |
      | Analysis        | 3     |
      | ExternalPackage | 3     |
      | Directory       | 7     |
      | Namespace       | 8     |
      | File            | 14    |
      | SourceTree      | 14    |
      | Class           | 17    |
      | Function        | 55    |

  @sanity @positive @MLP-10340 @webtest
  Scenario: SC#9 Verify JavaLinker collects Analysis item with proper log messages
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "linker/JavaLinker/JavaLinker%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 14            | Description |
      | Number of errors          | 0             | Description |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "linker/JavaLinker/JavaLinker/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | logCode       | pluginName | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0019 |            |                |
      | INFO | Plugin Name:JavaLinker, Plugin Type:linker, Plugin Version:1.0.0.SNAPSHOT, Node Name:LocalNode, Host Name:e80eca0be5a2, Plugin Configuration name:JavaLinker                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0071 | JavaLinker | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin JavaLinker Configuration: ---  2020-08-18 05:57:45.502 INFO  - ANALYSIS-0073: Plugin JavaLinker Configuration: name: "JavaLinker"  2020-08-18 05:57:45.502 INFO  - ANALYSIS-0073: Plugin JavaLinker Configuration: pluginVersion: "LATEST"  2020-08-18 05:57:45.502 INFO  - ANALYSIS-0073: Plugin JavaLinker Configuration: label:  2020-08-18 05:57:45.502 INFO  - ANALYSIS-0073: Plugin JavaLinker Configuration: : "JavaLinker"  2020-08-18 05:57:45.502 INFO  - ANALYSIS-0073: Plugin JavaLinker Configuration: catalogName: "Default"  2020-08-18 05:57:45.502 INFO  - ANALYSIS-0073: Plugin JavaLinker Configuration: eventClass: null  2020-08-18 05:57:45.502 INFO  - ANALYSIS-0073: Plugin JavaLinker Configuration: eventCondition: null  2020-08-18 05:57:45.502 INFO  - ANALYSIS-0073: Plugin JavaLinker Configuration: nodeCondition: null  2020-08-18 05:57:45.502 INFO  - ANALYSIS-0073: Plugin JavaLinker Configuration: maxWorkSize: 100  2020-08-18 05:57:45.502 INFO  - ANALYSIS-0073: Plugin JavaLinker Configuration: tags:  2020-08-18 05:57:45.502 INFO  - ANALYSIS-0073: Plugin JavaLinker Configuration: - "tagJavaLinker"  2020-08-18 05:57:45.502 INFO  - ANALYSIS-0073: Plugin JavaLinker Configuration: pluginType: "linker"  2020-08-18 05:57:45.502 INFO  - ANALYSIS-0073: Plugin JavaLinker Configuration: dataSource: null  2020-08-18 05:57:45.502 INFO  - ANALYSIS-0073: Plugin JavaLinker Configuration: credential: null  2020-08-18 05:57:45.502 INFO  - ANALYSIS-0073: Plugin JavaLinker Configuration: businessApplicationName: "test_BA_JavaLinker"  2020-08-18 05:57:45.502 INFO  - ANALYSIS-0073: Plugin JavaLinker Configuration: dryRun: false  2020-08-18 05:57:45.502 INFO  - ANALYSIS-0073: Plugin JavaLinker Configuration: schedule: null  2020-08-18 05:57:45.502 INFO  - ANALYSIS-0073: Plugin JavaLinker Configuration: runAfter: []  2020-08-18 05:57:45.502 INFO  - ANALYSIS-0073: Plugin JavaLinker Configuration: filter: null | ANALYSIS-0073 | JavaLinker |                |
      | INFO | Plugin JavaLinker Start Time:2020-03-19 10:03:53.666, End Time:2020-03-19 10:03:55.848, Processed Count:14, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ANALYSIS-0072 | JavaLinker |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0020 |            |                |

  #6620124#
  @webtest @MLP-10340 @sanity @positive
  Scenario: SC#10 Verify the Namespace item with included package in java file getting displayed after java linker is executed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Project" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "automationtestjavalinker" item from search results
    Then user performs click and verify in new window
      | Table         | value          | Action                 | RetainPrevwindow | indexSwitch |
      | has_Namespace | com            | verify widget contains |                  |             |
      | has_Namespace | com            | click and switch tab   | No               |             |
      | has_Namespace | com.asg        | click and switch tab   | No               |             |
      | has_Namespace | com.asg.sample | click and switch tab   | No               |             |
    And verify the table Files/Processed Items has below values
      | Table   | value               |
      | sources | BaseClassPack1.java |
      | sources | Varargs.java        |
      | sources | VarargsComplex.java |

  #  #6620182#
  @webtest @MLP-10340 @sanity @positive
  Scenario: SC#11 Verify the Namespace item without package in java file is not getting displayed after java linker is executed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Project" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "automationtestjavalinker" item from search results
    And verify the table Files/Processed Items has below values
      | Table | value                       |
      | Files | Arity.java                  |
      | Files | ConstructorExample.java     |
      | Files | InheritanceLinker.java      |
      | Files | StudentMultipleMethods.java |
      | Files | TestStatic.java             |

  #6620189#
  @webtest @MLP-10340 @sanity @positive
  Scenario: SC#12 Verify that import window in SourceTree is displayed after Java Linker is executed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "StudentDerivedClass" item from search results
    And verify the table Files/Processed Items has below values
      | Table   | value            |
      | imports | StudentBaseClass |

  #6620228#
  @webtest @MLP-10340 @sanity @positive
  Scenario: SC#13 Verify that External Package item is displayed after Java Linker plugin is executed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ExternalPackage" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "System.out" item from search results
    And verify the table Files/Processed Items has below values
      | Table     | value                  |
      | Functions | println                |
      | Functions | println/@StringLiteral |
      | Functions | println/ASTMString     |
    Then user performs click and verify in new window
      | Table     | value                  | Action               | RetainPrevwindow | indexSwitch |
      | Functions | println/@StringLiteral | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute    | metaDataValue | widgetName  |
      | Number of parameters | 1             | Statistics  |
      | Short name           | println       | Description |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | println/@StringLiteral                       |
      | attributeName  | Parameters                                   |
      | actualFilePath | ida/javaLinkerPayloads/actualParameters.json |
    Then file content in "ida/javaLinkerPayloads/expectedParameters.json" should be same as the content in "ida/javaLinkerPayloads/actualParameters.json"

  #  #6620244#to be done last linked date
  @webtest @MLP-10340 @sanity @positive
  Scenario: SC#14 Verify Last Linked date attribute in metadata of SourceTree after JavaLinker plugin is executed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "StudentDerivedClass" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute               | metaDataValue | widgetName |
      | Number of imports               | 2             | Statistics |
      | Number of unresolved references | 0             | Statistics |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | StudentDerivedClass                            |
      | widgetName     | Description                                    |
      | attributeName  | errorDetails                                   |
      | actualFilePath | ida/javaLinkerPayloads/actualErrorDetails.json |
    Then file content in "ida/javaLinkerPayloads/expectedErrorDetails.json" should be same as the content in "ida/javaLinkerPayloads/actualErrorDetails.json"
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | StudentDerivedClass                          |
      | widgetName     | Description                                  |
      | attributeName  | rawImports                                   |
      | actualFilePath | ida/javaLinkerPayloads/actualRawImports.json |
    And user "remove" the json file "ida/javaLinkerPayloads/actualRawImports.json" file for following values
      | jsonPath | jsonValues | type   |
      | resolved |            | String |
    And user "remove" the json file "ida/javaLinkerPayloads/expectedRawImports.json" file for following values
      | jsonPath | jsonValues | type   |
      | resolved |            | String |
    Then file content in "ida/javaLinkerPayloads/expectedRawImports.json" should be same as the content in "ida/javaLinkerPayloads/actualRawImports.json"
    Then user "verify meatadata attributes" section has following values
      | meataDataAttribute | widgetName |
      | Last linked date   | Lifecycle  |


  #6620249#
  @webtest @MLP-10340 @sanity @positive
  Scenario: SC#15 Verification of External Linking functionality (Uses Window under Function) after Java Linker plugin is executed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "StudentInvokerClass" item from search results
    Then user performs click and verify in new window
      | Table     | value             | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | main              | click and switch tab   | No               |             |
      | uses      | printMarksSummary | verify widget contains |                  |             |
      | uses      | printMarksDetails | verify widget contains |                  |             |
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "StudentDerivedClass" item from search results
    Then user performs click and verify in new window
      | Table     | value             | Action               | RetainPrevwindow | indexSwitch |
      | Functions | printMarksSummary | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute    | metaDataValue     | widgetName  |
      | Number of parameters | 0                 | Statistics  |
      | endColumn            | 3                 | Description |
      | endLine              | 10                | Description |
      | startLine            | 6                 | Description |
      | startColumn          | 9                 | Description |
      | Short name           | printMarksSummary | Description |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | printMarksSummary                                              |
      | widgetName     | Description                                                    |
      | attributeName  | Parameters                                                     |
      | actualFilePath | ida/javaLinkerPayloads/actualParameters_PrintMarksSummary.json |
    Then file content in "ida/javaLinkerPayloads/expectedParameters_PrintMarksSummary.json" should be same as the content in "ida/javaLinkerPayloads/actualParameters_PrintMarksSummary.json"
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | printMarksSummary                            |
      | widgetName     | Description                                  |
      | attributeName  | rawInvokes                                   |
      | actualFilePath | ida/javaLinkerPayloads/actualRawInvokes.json |
    Then file content in "ida/javaLinkerPayloads/expectedRawInvokes.json" should be same as the content in "ida/javaLinkerPayloads/actualRawInvokes.json"

  #  #6620276#
  @webtest @MLP-10340 @sanity @positive
  Scenario: SC#16 Verification of Internal Linking functionality (Uses Window under Function) after Java Linker plugin is executed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "StudentMultipleMethods" item from search results
    Then user performs click and verify in new window
      | Table     | value                | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | main                 | click and switch tab   | No               |             |
      | uses      | printMarksSummary    | verify widget contains |                  |             |
      | uses      | printMarksDetails    | verify widget contains |                  |             |
      | uses      | printMarksSummary    | click and switch tab   | No               |             |
      | uses      | getAllSubjectsTotal  | verify widget contains |                  |             |
      | uses      | getLanguagesTotal    | verify widget contains |                  |             |
      | uses      | getNonLanguagesTotal | verify widget contains |                  |             |
      | uses      | getPCMPercentage     | verify widget contains |                  |             |
      | uses      | println/ASTMString   | verify widget contains |                  |             |
      | uses      | getAllSubjectsTotal  | click and switch tab   | No               |             |
      | uses      | getLanguagesTotal    | verify widget contains |                  |             |
      | uses      | getNonLanguagesTotal | verify widget contains |                  |             |
      | uses      | getNonLanguagesTotal | click and switch tab   | No               |             |
    Then confirm "uses" window is not available

  #6621187#
  @webtest @MLP-10340 @sanity @positive
  Scenario: SC#17 Verification of Uses Window displayed under function for inherited class after Java Linker plugin is executed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "InheritanceLinker" item from search results
    Then user performs click and verify in new window
      | Table     | value             | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | main              | click and switch tab   | No               |             |
      | uses      | printClassDetails | verify widget contains |                  |             |
      | uses      | printClassDetails | click and switch tab   | No               |             |
      | uses      | printfun          | verify widget contains |                  |             |

  #6680601#
  @webtest @MLP-10610 @sanity @positive
  Scenario: SC#18 To verify whether the Uses window inside constructors(function) is getting displayed properly in IDC UI when JavaLinker plugin is executed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ConstructorExample" item from search results
    Then user performs click and verify in new window
      | Table     | value                  | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | ConstructorExample/0   | verify widget contains |                  |             |
      | Functions | ConstructorExample/1   | verify widget contains |                  |             |
      | Functions | ConstructorExample/2   | verify widget contains |                  |             |
      | Functions | main                   | verify widget contains |                  |             |
      | Functions | ConstructorExample/0   | click and switch tab   | No               |             |
      | uses      | ConstructorExample/1   | verify widget contains |                  |             |
      | uses      | println/@StringLiteral | verify widget contains |                  |             |
      | uses      | ConstructorExample/1   | click and switch tab   | No               |             |
      | uses      | ConstructorExample/2   | verify widget contains |                  |             |
      | uses      | println/ASTMString     | verify widget contains |                  |             |
      | uses      | ConstructorExample/2   | click and switch tab   | No               |             |
      | uses      | println/ASTMString     | verify widget contains |                  |             |

#  #6680602#
  @webtest @MLP-10610 @sanity @positive
  Scenario: SC#19 To verify whether the Uses window inside function for inheritance hierarchy is getting displayed properly in IDC UI when JavaLinker plugin is executed.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "InheritanceLinker" item from search results
    Then user performs click and verify in new window
      | Table     | value | Action               | RetainPrevwindow | indexSwitch |
      | Functions | main  | click and switch tab | No               |             |
    Then user verifies the class "InheritanceLinker" for the function "main"
    Then user performs click and verify in new window
      | Table | value             | Action                 | RetainPrevwindow | indexSwitch |
      | uses  | printClassDetails | verify widget contains |                  |             |
      | uses  | printClassDetails | click and switch tab   | No               |             |
    Then user verifies the class "UserClass" for the function "printClassDetails"
    Then user performs click and verify in new window
      | Table | value    | Action                 | RetainPrevwindow | indexSwitch |
      | uses  | printfun | verify widget contains |                  |             |
      | uses  | printfun | click and switch tab   | No               |             |
    Then user verifies the class "BaseClass" for the function "printfun"

  #6680603#
  @webtest @MLP-10610 @sanity @positive
  Scenario: SC#20 To verify whether the Uses window inside function have valid method invocations when the import is not declared explicitly but using full qualified name to reference it.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DerivedClassPack2" item from search results
    Then user performs click and verify in new window
      | Table     | value | Action               | RetainPrevwindow | indexSwitch |
      | Functions | main  | click and switch tab | No               |             |
    Then user verifies the class "DerivedClassPack2" for the function "main"
    Then user performs click and verify in new window
      | Table | value                  | Action                 | RetainPrevwindow | indexSwitch |
      | uses  | display                | verify widget contains |                  |             |
      | uses  | display                | click and switch tab   | No               |             |
      | uses  | println/@StringLiteral | verify widget contains |                  |             |
    Then user verifies the class "BaseClassPack1" for the function "display"

   #6679665#
  @webtest @MLP-10658 @sanity @positive
  Scenario: SC#21 To verify whether the simple function calls get resolved with variable arguments and it is getting displayed in IDC UI when JavaLinker plugin is executed.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Varargs" item from search results
    Then user performs click and verify in new window
      | Table     | value       | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | f/String    | verify widget contains |                  |             |
      | Functions | f/String... | verify widget contains |                  |             |
      | Functions | g0          | verify widget contains |                  |             |
      | Functions | g1          | verify widget contains |                  |             |
      | Functions | g2          | verify widget contains |                  |             |
      | Functions | g0          | click and switch tab   | Yes              |             |
      | uses      | f/String... | verify widget contains |                  |             |
      | uses      | f/String... | click and switch tab   | No               |             |
    Then user verifies the class "Varargs" for the function "f/String..."
    And user navigates to the index "0" using TopBreadCrumblist to perform actions
    Then user performs click and verify in new window
      | Table     | value    | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | g1       | click and switch tab   | Yes              |             |
      | uses      | f/String | verify widget contains |                  |             |
      | uses      | f/String | click and switch tab   | No               |             |
    Then user verifies the class "Varargs" for the function "f/String"
    And user navigates to the index "0" using TopBreadCrumblist to perform actions
    Then user performs click and verify in new window
      | Table     | value       | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | g2          | click and switch tab   | Yes              |             |
      | uses      | f/String... | verify widget contains |                  |             |
      | uses      | f/String... | click and switch tab   | No               |             |
    Then user verifies the class "Varargs" for the function "f/String..."


 #6679679#
  @webtest @MLP-10658 @sanity @positive
  Scenario: SC#22 To verify whether the complex function calls get resolved with variable arguments and it is getting displayed in IDC UI when JavaLinker plugin is executed.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "VarargsComplex" item from search results
    Then user performs click and verify in new window
      | Table     | value                              | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | f/VarargsComplex/Integer/String    | verify widget contains |                  |             |
      | Functions | f/VarargsComplex/Integer/String... | verify widget contains |                  |             |
      | Functions | g1                                 | verify widget contains |                  |             |
      | Functions | g2                                 | verify widget contains |                  |             |
      | Functions | g3                                 | verify widget contains |                  |             |
      | Functions | g1                                 | click and switch tab   | Yes              |             |
      | uses      | f/VarargsComplex/Integer/String... | verify widget contains |                  |             |
      | uses      | f/VarargsComplex/Integer/String... | click and switch tab   | No               |             |
    Then user verifies the class "VarargsComplex" for the function "f/VarargsComplex/Integer/String..."
    And user navigates to the index "0" using TopBreadCrumblist to perform actions
    Then user performs click and verify in new window
      | Table     | value                           | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | g2                              | click and switch tab   | Yes              |             |
      | uses      | f/VarargsComplex/Integer/String | verify widget contains |                  |             |
      | uses      | f/VarargsComplex/Integer/String | click and switch tab   | No               |             |
    Then user verifies the class "VarargsComplex" for the function "f/VarargsComplex/Integer/String"
    And user navigates to the index "0" using TopBreadCrumblist to perform actions
    Then user performs click and verify in new window
      | Table     | value                              | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | g3                                 | click and switch tab   | Yes              |             |
      | uses      | f/VarargsComplex/Integer/String... | verify widget contains |                  |             |
      | uses      | f/VarargsComplex/Integer/String... | click and switch tab   | No               |             |
    Then user verifies the class "VarargsComplex" for the function "f/VarargsComplex/Integer/String..."
    And user navigates to the index "0" using TopBreadCrumblist to perform actions

  #6679695#
  @webtest @MLP-10658 @sanity @positive
  Scenario: SC#23 To verify whether the complex function calls from Derived Class get resolved with variable arguments and it is getting displayed in IDC UI when JavaLinker plugin is executed.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "VarargsComplexExt" item from search results
    Then user performs click and verify in new window
      | Table     | value                              | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | u1                                 | verify widget contains |                  |             |
      | Functions | u2                                 | verify widget contains |                  |             |
      | Functions | u3                                 | verify widget contains |                  |             |
      | Functions | v1                                 | verify widget contains |                  |             |
      | Functions | v2                                 | verify widget contains |                  |             |
      | Functions | v3                                 | verify widget contains |                  |             |
      | Functions | w1                                 | verify widget contains |                  |             |
      | Functions | w2                                 | verify widget contains |                  |             |
      | Functions | w3                                 | verify widget contains |                  |             |
      | Functions | u1                                 | click and switch tab   | Yes              |             |
      | uses      | f/VarargsComplex/Integer/String... | verify widget contains |                  |             |
      | uses      | f/VarargsComplex/Integer/String... | click and switch tab   | No               |             |
    Then user verifies the class "VarargsComplex" for the function "f/VarargsComplex/Integer/String..."
    And user navigates to previous page
    And user navigates to the index "0" using TopBreadCrumblist to perform actions
    Then user performs click and verify in new window
      | Table     | value                              | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | u2                                 | click and switch tab   | Yes              |             |
      | uses      | f/VarargsComplex/Integer/String    | verify widget contains |                  | 0           |
      | Functions | u3                                 | click and switch tab   | Yes              |             |
      | uses      | f/VarargsComplex/Integer/String... | verify widget contains |                  | 0           |
      | Functions | v1                                 | click and switch tab   | Yes              |             |
      | uses      | f/VarargsComplex/Integer/String... | verify widget contains |                  | 0           |
      | Functions | v2                                 | click and switch tab   | Yes              |             |
      | uses      | f/VarargsComplex/Integer/String    | verify widget contains |                  | 0           |
      | Functions | v3                                 | click and switch tab   | Yes              |             |
      | uses      | f/VarargsComplex/Integer/String... | verify widget contains |                  | 0           |
      | Functions | w1                                 | click and switch tab   | Yes              |             |
      | uses      | f/VarargsComplex/Integer/String... | verify widget contains |                  | 0           |
      | Functions | w2                                 | click and switch tab   | Yes              |             |
      | uses      | f/VarargsComplex/Integer/String    | verify widget contains |                  | 0           |
      | Functions | w3                                 | click and switch tab   | No               |             |
      | uses      | f/VarargsComplex/Integer/String... | verify widget contains |                  |             |
      | uses      | f/VarargsComplex/Integer/String... | click and switch tab   | No               |             |
    Then user verifies the class "VarargsComplex" for the function "f/VarargsComplex/Integer/String..."


#  Technology tags verification
  @webtest @MLP-10340 @sanity @positive
  Scenario: SC#24 Verify the technology tags, explicit tags and Business Application item got assigned to the Cataloged items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name            | facet         | Tag                                       | fileName                 | userTag       |
      | Default     | File            | Metadata Type | tagJavaLinker,Git,test_BA_JavaLinker,Java | Varargs.java             | tagJavaLinker |
      | Default     | Function        | Metadata Type | tagJavaLinker,Java,test_BA_JavaLinker     | printMarksDetails        | tagJavaLinker |
      | Default     | Class           | Metadata Type | tagJavaLinker,Java,test_BA_JavaLinker     | Varargs                  | tagJavaLinker |
      | Default     | SourceTree      | Metadata Type | tagJavaLinker,Java,test_BA_JavaLinker     | Varargs                  | tagJavaLinker |
      | Default     | ExternalPackage | Metadata Type | tagJavaLinker,Java,test_BA_JavaLinker     | System.out               | tagJavaLinker |
      | Default     | Namespace       | Metadata Type | tagJavaLinker,Java,test_BA_JavaLinker     | com                      | tagJavaLinker |
      | Default     | Directory       | Metadata Type | tagJavaLinker,Git,test_BA_JavaLinker      | com                      | tagJavaLinker |
      | Default     | Project         | Metadata Type | tagJavaLinker,Git,test_BA_JavaLinker,Java | automationtestjavalinker | tagJavaLinker |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                        | fileName                 | userTag       |
      | Default     | Function   | Metadata Type | Programming,Source Control | printMarksDetails        | tagJavaLinker |
      | Default     | Class      | Metadata Type | Programming,Source Control | Varargs                  | tagJavaLinker |
      | Default     | SourceTree | Metadata Type | Programming,Source Control | Varargs                  | tagJavaLinker |
      | Default     | Project    | Metadata Type | Programming,Source Control | automationtestjavalinker | tagJavaLinker |

#  ############################################# EDIBusVerification #############################################
#  #7083641#
#  @sanity @positive @webtest @edibus
#  Scenario: SC#13:EDIBusVerification: Verify EDI replication for items collected using Java Linker
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "tagJavaLinker" and clicks on search
#    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Technology" attribute under "Tags" facets in Item Search results page
#    And user "verify displayed" for listed "Metadata Type" facet in Search results page
#      | Project         |
#      | Analysis        |
#      | ExternalPackage |
#      | Directory       |
#      | Namespace       |
#      | File            |
#      | SourceTree      |
#      | Class           |
#      | Function        |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | JAVALINKER  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/datasource/EDIBusDS_JavaLinker.json" file for following values using property loader
#      | jsonPath        | jsonValues  |
#      | $..['EDI host'] | EDIHostName |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                   | body                                                   | response code | response message | jsonPath                                              |
#      | application/json |       |       | Put          | settings/analyzers/EDIBusDataSource                                   | idc/EdiBusPayloads/datasource/EDIBusDS_JavaLinker.json | 204           |                  |                                                       |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                             | idc/EdiBusPayloads/JavaLinkerConfig.json               | 204           |                  |                                                       |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusJavaLinker |                                                        | 200           | IDLE             | $.[?(@.configurationName=='EDIBusJavaLinker')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusJavaLinker  |                                                        | 200           |                  |                                                       |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusJavaLinker |                                                        | 200           | IDLE             | $.[?(@.configurationName=='EDIBusJavaLinker')].status |
#    And user enters the search text "EDIBusJavaLinker" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "dynamic item click" on "EDIBusJavaLinker" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user enters the search text "tagJavaLinker" and clicks on search
#    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Java" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Project" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
#      | AP-DATA      | JAVALINKER  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE_SYSTEM ) |
#    And user enters the search text "tagJavaLinker" and clicks on search
#    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Java" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | JAVALINKER  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) |
#    And configure a new REST API for the service "IDC"
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                  |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Programming/Java |
#      | $..selections.['type_s'][*]                   | File                                        |
#    And supply payload with file name "idc/EdiBusPayloads/TagFilter.json"
#    And user makes a REST Call for POST request with url "searches/fulltext/Default?query=tagJavaLinker&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1"
#    And Status code 200 must be returned
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | JAVALINKER  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) |
#    And user enters the search text "tagJavaLinker" and clicks on search
#    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Java" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
#      | AP-DATA      | JAVALINKER  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY ) |
#    And configure a new REST API for the service "IDC"
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                  |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Programming/Java |
#      | $..selections.['type_s'][*]                   | Directory                                   |
#    And supply payload with file name "idc/EdiBusPayloads/TagFilter.json"
#    And user makes a REST Call for POST request with url "searches/fulltext/Default?query=tagJavaLinker&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1"
#    And Status code 200 must be returned
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
#      | AP-DATA      | JAVALINKER  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY ) |
#    And user enters the search text "tagJavaLinker" and clicks on search
#    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Java" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | JAVALINKER  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_METHOD ) |
#    And configure a new REST API for the service "IDC"
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                  |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Programming/Java |
#      | $..selections.['type_s'][*]                   | Function                                    |
#    And supply payload with file name "idc/EdiBusPayloads/TagFilter.json"
#    And user makes a REST Call for POST request with url "searches/fulltext/Default?query=tagJavaLinker&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1"
#    And Status code 200 must be returned
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | JAVALINKER  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_METHOD ) |
#    And user connects Rochade Server and "verifies" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   | itemCount |
#      | AP-DATA      | JAVALINKER  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_CLASS ) | 20        |
#    And user connects Rochade Server and "verifies" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                     | itemCount |
#      | AP-DATA      | JAVALINKER  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_PACKAGE ) | 17        |


  Scenario Outline: SC#25- User deletes the collected item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                             | responseCode | inputJson              | inputFile                                    |
      | items/Default/Default.Project:::dynamic         | 204          | $..Project.id          | response/java/javaLinker/actual/itemIds.json |
      | items/Default/Default.ExternalPackage:::dynamic | 204          | $..ExternalPackage1.id | response/java/javaLinker/actual/itemIds.json |
      | items/Default/Default.ExternalPackage:::dynamic | 204          | $..ExternalPackage2.id | response/java/javaLinker/actual/itemIds.json |
      | items/Default/Default.ExternalPackage:::dynamic | 204          | $..ExternalPackage3.id | response/java/javaLinker/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic        | 204          | $..Git_Analysis.id     | response/java/javaLinker/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic        | 204          | $..JParser_Analysis.id | response/java/javaLinker/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic        | 204          | $..JLinker_Analysis.id | response/java/javaLinker/actual/itemIds.json |

#######################################################################################################################################################################

  @MLP-16290 @sanity @positive
  Scenario Outline: SC#26 Run the Plugin configurations for GitCollector ,Java Parser and Java Linker for Null Literal
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                        | body                                                                | response code | response message       | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                  | ida/javaLinkerPayloads/javaLinker_git_datasourceforNullLiteral.json | 204           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource                                  |                                                                     | 200           | GitCollectorDataSource |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                            | ida/javaLinkerPayloads/javaLinker_gitforNullLiteral.json            | 204           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector                                            |                                                                     | 200           | JavaLinkerGit          |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/JavaLinkerGit |                                                                     | 200           | IDLE                   | $.[?(@.configurationName=='JavaLinkerGit')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/JavaLinkerGit  | ida/empty.json                                                      | 200           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/JavaLinkerGit |                                                                     | 200           | IDLE                   | $.[?(@.configurationName=='JavaLinkerGit')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaParser                                              | ida/JavaLinkerPayloads/javaLinker_parser.json                       | 204           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaParser                                              |                                                                     | 200           | JavaParser             |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser         |                                                                     | 200           | IDLE                   | $.[?(@.configurationName=='JavaParser')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParser          | ida/empty.json                                                      | 200           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser         |                                                                     | 200           | IDLE                   | $.[?(@.configurationName=='JavaParser')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaLinker                                              | ida/JavaLinkerPayloads/javaLinker_linker.json                       | 204           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaLinker                                              |                                                                     | 200           | JavaLinker             |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaLinker/JavaLinker         |                                                                     | 200           | IDLE                   | $.[?(@.configurationName=='JavaLinker')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/JavaLinker/JavaLinker          | ida/empty.json                                                      | 200           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaLinker/JavaLinker         |                                                                     | 200           | IDLE                   | $.[?(@.configurationName=='JavaLinker')].status    |

  Scenario Outline: SC#27- User retrieves the item ids of different items for null literal sceanrio and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                     | type    | targetFile                                   | jsonpath               |
      | APPDBPOSTGRES | Default | javaspark_lineage                        | Project | response/java/javaLinker/actual/itemIds.json | $..Project.id          |
      | APPDBPOSTGRES | Default | System.out                               |         | response/java/javaLinker/actual/itemIds.json | $..ExternalPackage1.id |
      | APPDBPOSTGRES | Default | collector/GitCollector/JavaLinkerGit%DYN |         | response/java/javaLinker/actual/itemIds.json | $..Git_Analysis.id     |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParser%DYN         |         | response/java/javaLinker/actual/itemIds.json | $..JParser_Analysis.id |
      | APPDBPOSTGRES | Default | linker/JavaLinker/JavaLinker%DYN         |         | response/java/javaLinker/actual/itemIds.json | $..JLinker_Analysis.id |

  @webtest @MLP-10340 @sanity @positive
  Scenario: SC#8 Verify facet counts appears properly for the items collected by GitCollector ,Java Parser and Java Linker for null literal sceanrio
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType       | count |
      | Project         | 1     |
      | Analysis        | 3     |
      | ExternalPackage | 1     |
      | Directory       | 1     |
      | Namespace       | 1     |
      | File            | 6     |
      | SourceTree      | 6     |
      | Class           | 6     |
      | Function        | 26    |

  @webtest @MLP-16290 @sanity @positive @Bug-26789
  Scenario: SC#28 - Verify Linking is correct when Parameters are passed as null values for functions (Null Literal check)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "MountainBikeWithNullLiteral" item from search results
    Then user performs click and verify in new window
      | Table     | value                       | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | MountainBikeWithNullLiteral | click and switch tab   | Yes              |             |
      | uses      | Bicycle1                    | verify widget contains |                  |             |
      | uses      | Bicycle1                    | click and switch tab   | No               |             |
    Then user verifies the class "Bicycle1" for the function "Bicycle1"
    And user navigates to previous page
    And user navigates to the index "0" using TopBreadCrumblist to perform actions
    Then user performs click and verify in new window
      | Table     | value               | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | createLocalInstance | click and switch tab   | Yes              |             |
      | uses      | changingGear        | verify widget contains |                  |             |
      | uses      | changingGear        | click and switch tab   | No               |             |
    Then user verifies the class "Bicycle1" for the function "changingGear"
    And user navigates to previous page
    And user navigates to the index "0" using TopBreadCrumblist to perform actions
    Then user performs click and verify in new window
      | Table     | value        | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | setGear      | click and switch tab   | Yes              |             |
      | uses      | changingGear | verify widget contains |                  |             |
      | uses      | changingGear | click and switch tab   | No               |             |
    Then user verifies the class "Bicycle1" for the function "changingGear"
    And user navigates to previous page
    And user navigates to the index "0" using TopBreadCrumblist to perform actions
    Then user performs click and verify in new window
      | Table     | value                 | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | speeddownMountainbike | click and switch tab   | Yes              |             |
      | uses      | applyBrake            | verify widget contains |                  |             |
      | uses      | applyBrake            | click and switch tab   | No               |             |
    Then user verifies the class "Bicycle1" for the function "applyBrake"
    And user navigates to previous page
    And user navigates to the index "0" using TopBreadCrumblist to perform actions
    Then user performs click and verify in new window
      | Table     | value               | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | speedupMountainbike | click and switch tab   | Yes              |             |
      | uses      | speedUp             | verify widget contains |                  |             |
      | uses      | speedUp             | click and switch tab   | No               |             |
    Then user verifies the class "Bicycle1" for the function "speedUp"
    And user navigates to previous page
    And user navigates to the index "0" using TopBreadCrumblist to perform actions
    Then user performs click and verify in new window
      | Table     | value                           | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | speedupMountainbikeUsingExtends | click and switch tab   | Yes              |             |
      | uses      | speedUp                         | verify widget contains |                  |             |
      | uses      | speedUp                         | click and switch tab   | No               |             |
    Then user verifies the class "Bicycle1" for the function "speedUp"


  @webtest @MLP-16290 @Bug-26789 @sanity @positive
  Scenario: SC#29 - Verify Linking is correct when Parameters are passed as non null values for functions
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaLinker" and clicks on search
    And user performs "facet selection" in "tagJavaLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "MountainBike" item from search results
    Then user performs click and verify in new window
      | Table     | value        | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | MountainBike | click and switch tab   | Yes              |             |
      | uses      | Bicycle      | verify widget contains |                  |             |
      | uses      | Bicycle      | click and switch tab   | No               |             |
    Then user verifies the class "Bicycle" for the function "Bicycle"
    And user navigates to previous page
    And user navigates to the index "0" using TopBreadCrumblist to perform actions
    Then user performs click and verify in new window
      | Table     | value               | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | createLocalInstance | click and switch tab   | Yes              |             |
      | uses      | changingGear        | verify widget contains |                  |             |
      | uses      | changingGear        | click and switch tab   | No               |             |
    Then user verifies the class "Bicycle" for the function "changingGear"
    And user navigates to previous page
    And user navigates to the index "0" using TopBreadCrumblist to perform actions
    Then user performs click and verify in new window
      | Table     | value        | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | setGear      | click and switch tab   | Yes              |             |
      | uses      | changingGear | verify widget contains |                  |             |
      | uses      | changingGear | click and switch tab   | No               |             |
    Then user verifies the class "Bicycle" for the function "changingGear"
    And user navigates to previous page
    And user navigates to the index "0" using TopBreadCrumblist to perform actions
    Then user performs click and verify in new window
      | Table     | value                 | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | speeddownMountainbike | click and switch tab   | Yes              |             |
      | uses      | applyBrake            | verify widget contains |                  |             |
      | uses      | applyBrake            | click and switch tab   | No               |             |
    Then user verifies the class "Bicycle" for the function "applyBrake"
    And user navigates to previous page
    And user navigates to the index "0" using TopBreadCrumblist to perform actions
    Then user performs click and verify in new window
      | Table     | value               | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | speedupMountainbike | click and switch tab   | Yes              |             |
      | uses      | speedUp             | verify widget contains |                  |             |
      | uses      | speedUp             | click and switch tab   | No               |             |
    Then user verifies the class "Bicycle" for the function "speedUp"
    And user navigates to previous page
    And user navigates to the index "0" using TopBreadCrumblist to perform actions
    Then user performs click and verify in new window
      | Table     | value                           | Action                 | RetainPrevwindow | indexSwitch |
      | Functions | speedupMountainbikeUsingExtends | click and switch tab   | Yes              |             |
      | uses      | speedUp                         | verify widget contains |                  |             |
      | uses      | speedUp                         | click and switch tab   | No               |             |
    Then user verifies the class "Bicycle" for the function "speedUp"
    And user switches to the browser window of index "0"

  Scenario Outline: SC#30- User deletes the collected item for null literal scenario from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                             | responseCode | inputJson              | inputFile                                    |
      | items/Default/Default.Project:::dynamic         | 204          | $..Project.id          | response/java/javaLinker/actual/itemIds.json |
      | items/Default/Default.ExternalPackage:::dynamic | 204          | $..ExternalPackage1.id | response/java/javaLinker/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic        | 204          | $..Git_Analysis.id     | response/java/javaLinker/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic        | 204          | $..JParser_Analysis.id | response/java/javaLinker/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic        | 204          | $..JLinker_Analysis.id | response/java/javaLinker/actual/itemIds.json |

  @MLP-10340 @sanity @positive
  Scenario Outline: SC#31_Run the Plugin configurations for GitCollector ,Java Parser and Java Linker with dryRun as true
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                        | body                                                     | response code | response message       | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                  | ida/javaLinkerPayloads/javaLinker_git_datasource.json    | 204           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource                                  |                                                          | 200           | GitCollectorDataSource |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                            | ida/javaLinkerPayloads/javaLinker_git.json               | 204           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector                                            |                                                          | 200           | JavaLinkerGit          |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/JavaLinkerGit |                                                          | 200           | IDLE                   | $.[?(@.configurationName=='JavaLinkerGit')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/JavaLinkerGit  | ida/empty.json                                           | 200           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/JavaLinkerGit |                                                          | 200           | IDLE                   | $.[?(@.configurationName=='JavaLinkerGit')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaParser                                              | ida/JavaLinkerPayloads/javaLinker_parser.json            | 204           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaParser                                              |                                                          | 200           | JavaParser             |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser         |                                                          | 200           | IDLE                   | $.[?(@.configurationName=='JavaParser')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParser          | ida/empty.json                                           | 200           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser         |                                                          | 200           | IDLE                   | $.[?(@.configurationName=='JavaParser')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaLinker                                              | ida/JavaLinkerPayloads/javaLinker_linker_dryRunTrue.json | 204           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaLinker                                              |                                                          | 200           | JavaLinker             |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaLinker/JavaLinker         |                                                          | 200           | IDLE                   | $.[?(@.configurationName=='JavaLinker')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/JavaLinker/JavaLinker          | ida/empty.json                                           | 200           |                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaLinker/JavaLinker         |                                                          | 200           | IDLE                   | $.[?(@.configurationName=='JavaLinker')].status    |

  Scenario Outline: SC#32- User retrieves the item ids of different items for dryRun scenario and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                     | type    | targetFile                                   | jsonpath               |
      | APPDBPOSTGRES | Default | automationtestjavalinker                 | Project | response/java/javaLinker/actual/itemIds.json | $..Project.id          |
      | APPDBPOSTGRES | Default | collector/GitCollector/JavaLinkerGit%DYN |         | response/java/javaLinker/actual/itemIds.json | $..Git_Analysis.id     |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParser%DYN         |         | response/java/javaLinker/actual/itemIds.json | $..JParser_Analysis.id |
      | APPDBPOSTGRES | Default | linker/JavaLinker/JavaLinker%DYN         |         | response/java/javaLinker/actual/itemIds.json | $..JLinker_Analysis.id |

  @webtest @MLP-10340 @sanity @positive
  Scenario: SC#33 Verify Java Linker plugin functionality with dry run as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "javalinker" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "linker/JavaLinker/JavaLinker%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "linker/JavaLinker/JavaLinker/%" should display below info/error/warning
      | type | logValue                                  | logCode       | pluginName | removableText |
      | INFO | Plugin JavaLinker running on dry run mode | ANALYSIS-0069 |            |               |

  Scenario Outline: SC#34- User deletes the collected item for dryRun scenario from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson              | inputFile                                    |
      | items/Default/Default.Project:::dynamic             | 204          | $..Project.id          | response/java/javaLinker/actual/itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..has_BA.id           | response/java/javaLinker/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Git_Analysis.id     | response/java/javaLinker/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JParser_Analysis.id | response/java/javaLinker/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JLinker_Analysis.id | response/java/javaLinker/actual/itemIds.json |

  @cr-data @sanity
  Scenario Outline: SC#35_Delete Plugin Configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                       | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidGitCredentials  |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/EDIBusValidCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaParser             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaLinker             |      | 204           |                  |          |
