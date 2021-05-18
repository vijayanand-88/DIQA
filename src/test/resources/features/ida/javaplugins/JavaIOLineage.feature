@MLP-13373
Feature: Validation of Java IO Lineage plugin functionality after running git, Java parser and Java IO Linker plugins



  ###################################################################PRE-CONDITION##########################################################################################################

  @git @precondition
  Scenario: SC#1 Update Git credentials with exact values
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                     | username    | password    |
      | ida/javaIOLineagePayloads/javaIOLineage_git_credentials.json | $..userName | $..password |

  @sanity @positive @regression
  Scenario Outline: SC#1 Set the credentials for GitCollector
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                         | body                                                               | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidGitCredentials    | ida/javaIOLineagePayloads/javaIOLineage_git_valid_credentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentials | idc/EdiBusPayloads/Credentials/EDIBusValidCredentials.json         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidGitCredentials    |                                                                    | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusValidCredentials |                                                                    | 200           |                  |          |

  @sanity @positive @regression
  Scenario Outline: SC#1 Create BusinessApplication tag and run the plugin configuration with the new field for Git
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/javaIOLineagePayloads/javaIOLineage_BusinessApplication.json | 200           |                  |          |


 ###################################################################PLUGIN CREATION##########################################################################################################

  @MLP-13373 @sanity @positive
  Scenario Outline: SC#2 Run the Plugin configurations for Git , Java Parser, Java IO Linker, Java IO Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                           | body                                                        | response code | response message       | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                     | ida/javaIOLineagePayloads/javaIOLineage_git_datasource.json | 204           |                        |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource                                     |                                                             | 200           | GitCollectorDataSource |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                               | ida/javaIOLineagePayloads/javaIOLineage_git.json            | 204           |                        |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector                                               |                                                             | 200           | JavaIOLineageGit       |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/JavaIOLineageGit |                                                             | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLineageGit')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/JavaIOLineageGit  | ida/empty.json                                              | 200           |                        |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/JavaIOLineageGit |                                                             | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLineageGit')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaParser                                                 | ida/javaIOLineagePayloads/javaIOLineage_parser.json         | 204           |                        |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaParser                                                 |                                                             | 200           | JavaParser             |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser            |                                                             | 200           | IDLE                   | $.[?(@.configurationName=='JavaParser')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParser             | ida/empty.json                                              | 200           |                        |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser            |                                                             | 200           | IDLE                   | $.[?(@.configurationName=='JavaParser')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaIOLinker                                               | ida/javaIOLineagePayloads/javaIOLineage_IOlinker.json       | 204           |                        |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaIOLinker                                               |                                                             | 200           | JavaIOLinker           |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaIOLinker/JavaIOLinker        |                                                             | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLinker')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/JavaIOLinker/JavaIOLinker         | ida/empty.json                                              | 200           |                        |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaIOLinker/JavaIOLinker        |                                                             | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLinker')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaIOLineage                                              | ida/javaIOLineagePayloads/javaIOLineage_IOLineage.json      | 204           |                        |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaIOLineage                                              |                                                             | 200           | JavaIOLineage          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaIOLineage/JavaIOLineage     |                                                             | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLineage')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaIOLineage/JavaIOLineage      | ida/empty.json                                              | 200           |                        |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaIOLineage/JavaIOLineage     |                                                             | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLineage')].status    |


  Scenario Outline: SC#2 User retrieves the item ids of different items and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                        | type    | targetFile                                      | jsonpath                  |
      | APPDBPOSTGRES | Default | javaspark_lineage                           | Project | response/java/javaIOLineage/actual/itemIds.json | $..Project.id             |
      | APPDBPOSTGRES | Default | test_BA_JavaIOLineage                       |         | response/java/javaIOLineage/actual/itemIds.json | $..has_BA.id              |
      | APPDBPOSTGRES | Default | collector/GitCollector/JavaIOLineageGit%DYN |         | response/java/javaIOLineage/actual/itemIds.json | $..Git_Analysis.id        |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParser%DYN            |         | response/java/javaIOLineage/actual/itemIds.json | $..JParser_Analysis.id    |
      | APPDBPOSTGRES | Default | linker/JavaIOLinker/JavaIOLinker%DYN        |         | response/java/javaIOLineage/actual/itemIds.json | $..JIOLinker_Analysis.id  |
      | APPDBPOSTGRES | Default | lineage/JavaIOLineage/JavaIOLineage%DYN     |         | response/java/javaIOLineage/actual/itemIds.json | $..JIOLineage_Analysis.id |

 ###################################################################UI VALIDATION DRYRUN SET FALSE##########################################################################################################

  @webtest @MLP-13373 @sanity @positive
  Scenario: SC#3 Verify facet counts appears properly for the items collected by GitCollector ,Java Parser and Java IO Linker
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaIOLineage" and clicks on search
    And user performs "facet selection" in "tagJavaIOLineage" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType  | count |
      | Project    | 1     |
      | Analysis   | 4     |
      | File       | 63    |
      | SourceTree | 19    |
      | Class      | 19    |
      | Function   | 20    |

  @sanity @positive @MLP-13373 @webtest
  Scenario: SC#3 Verify JavaIOLineage collects Analysis item with proper log messages
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagJavaIOLineage" and clicks on search
    And user performs "facet selection" in "tagJavaIOLineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/JavaIOLineage/JavaIOLineage/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 20            | Description |
      | Number of errors          | 0             | Description |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "lineage/JavaIOLineage/JavaIOLineage%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | logCode       | pluginName    | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0019 |               |                |
      | INFO | Plugin Name:JavaIOLineage, Plugin Type:lineage, Plugin Version:LATEST, Node Name:LocalNode, Host Name:7e66e90a26f5, Plugin Configuration name:JavaIOLineage                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | ANALYSIS-0071 | JavaIOLineage | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin JavaIOLineage Configuration: ---  2020-08-05 07:00:09.369 INFO  - ANALYSIS-0073: Plugin JavaIOLineage Configuration: name: "JavaIOLineage"  2020-08-05 07:00:09.369 INFO  - ANALYSIS-0073: Plugin JavaIOLineage Configuration: pluginVersion: "LATEST"  2020-08-05 07:00:09.369 INFO  - ANALYSIS-0073: Plugin JavaIOLineage Configuration: label:  2020-08-05 07:00:09.369 INFO  - ANALYSIS-0073: Plugin JavaIOLineage Configuration: : "JavaIOLineage"  2020-08-05 07:00:09.369 INFO  - ANALYSIS-0073: Plugin JavaIOLineage Configuration: catalogName: "Default"  2020-08-05 07:00:09.369 INFO  - ANALYSIS-0073: Plugin JavaIOLineage Configuration: eventClass: null  2020-08-05 07:00:09.369 INFO  - ANALYSIS-0073: Plugin JavaIOLineage Configuration: eventCondition: null  2020-08-05 07:00:09.369 INFO  - ANALYSIS-0073: Plugin JavaIOLineage Configuration: nodeCondition: null  2020-08-05 07:00:09.369 INFO  - ANALYSIS-0073: Plugin JavaIOLineage Configuration: maxWorkSize: 100  2020-08-05 07:00:09.369 INFO  - ANALYSIS-0073: Plugin JavaIOLineage Configuration: tags:  2020-08-05 07:00:09.369 INFO  - ANALYSIS-0073: Plugin JavaIOLineage Configuration: - "tagJavaIOLineage"  2020-08-05 07:00:09.369 INFO  - ANALYSIS-0073: Plugin JavaIOLineage Configuration: pluginType: "lineage"  2020-08-05 07:00:09.369 INFO  - ANALYSIS-0073: Plugin JavaIOLineage Configuration: dataSource: null  2020-08-05 07:00:09.369 INFO  - ANALYSIS-0073: Plugin JavaIOLineage Configuration: credential: null  2020-08-05 07:00:09.369 INFO  - ANALYSIS-0073: Plugin JavaIOLineage Configuration: businessApplicationName: "test_BA_JavaIOLineage"  2020-08-05 07:00:09.369 INFO  - ANALYSIS-0073: Plugin JavaIOLineage Configuration: dryRun: false  2020-08-05 07:00:09.369 INFO  - ANALYSIS-0073: Plugin JavaIOLineage Configuration: schedule: null  2020-08-05 07:00:09.369 INFO  - ANALYSIS-0073: Plugin JavaIOLineage Configuration: runAfter: []  2020-08-05 07:00:09.369 INFO  - ANALYSIS-0073: Plugin JavaIOLineage Configuration: filter: null | ANALYSIS-0073 | JavaIOLineage |                |
      | INFO | Plugin JavaIOLineage Start Time:2020-04-01 06:46:34.457, End Time:2020-04-01 06:46:41.124, Processed Count:20, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0072 | JavaIOLineage |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0020 |               |                |


  #6763868#
  @webtest @MLP-13373 @sanity @positive
  Scenario: SC#3 Verify the lineage established between source and target external files when data is transferred with copyFile() method of FileUtils.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagJavaIOLineage" and clicks on search
    And user performs "facet selection" in "tagJavaIOLineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FileUtilsCopyFile" item from search results
    Then user performs click and verify in new window
      | Table        | value                         | Action               | RetainPrevwindow | indexSwitch |
      | Functions    | copyFileFileUtils             | click and switch tab | No               |             |
      | Lineage Hops | Source.txt => Destination.txt | click and switch tab | No               |             |
    And user "verifies tab section values" has the following values in "Lineage Source" Tab in Item View page
      | /Source.txt |
    And user "verifies tab section values" has the following values in "Lineage Target" Tab in Item View page
      | /Destination.txt |


  #6863772# #6863777 #6863783 #6863789 #6863792 #6863795 #6863796
  @webtest @MLP-13373 @sanity @positive
  Scenario: SC#3 Verify the lineage established between source and target external files when data is transferred with Stream operations.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagJavaIOLineage" and clicks on search
    And user performs "facet selection" in "tagJavaIOLineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "StreamIntermediateOp" item from search results
    Then user performs click and verify in new window
      | Table        | value                                              | Action               | RetainPrevwindow | indexSwitch |
      | Functions    | intermediateOpStream                               | click and switch tab | No               |             |
      | Lineage Hops | StreamInterOpSource.txt => StreamInterOpOutput.txt | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | mode              | TRANSFORM     | Description |


    #6763868#
  @webtest @MLP-13373 @sanity @positive
  Scenario: SC#3 Verify the lineage established between source and target external files when data is transferred with copyFile() method of FileUtils.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagJavaIOLineage" and clicks on search
    And user performs "facet selection" in "tagJavaIOLineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FileUtilsCopyFile" item from search results
    Then user performs click and verify in new window
      | Table        | value                         | Action               | RetainPrevwindow | indexSwitch |
      | Functions    | copyFileFileUtils             | click and switch tab | No               |             |
      | Lineage Hops | Source.txt => Destination.txt | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | mode              | COPY          | Description |


  #6763868# #6763871# #6763872# #6763874# #6764212# #6764215# #6776817# #6811192# #6842789# #6863772# #6863777 #6863783 #6863789 #6863792 #6863795 #6863796
  @webtest @MLP-13373 @sanity @positive
  Scenario: SC3 Verify Lineage Hops in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "handleMultipleLineage" and clicks on search
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "handleMultipleLineage" item from search results
    Then user performs click and verify in new window
      | Table        | value                                   | Action                       | RetainPrevwindow | indexSwitch | filePath                                                       | jsonPath                  |
      | Lineage Hops | MultiSource.txt => MultiDestination.txt | click and verify lineagehops | No               |             | ida/javaIOLineagePayloads/LineageMetadata/lineageMetadata.json | $.handleMultipleLineage_1 |
    And user enters the search text "handleMultipleLineage" and clicks on search
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "handleMultipleLineage" item from search results
    Then user performs click and verify in new window
      | Table        | value                                                | Action                       | RetainPrevwindow | indexSwitch | filePath                                                       | jsonPath                  |
      | Lineage Hops | MulticopyFilesAPI_f1.txt => MulticopyFilesAPI_f2.txt | click and verify lineagehops | No               |             | ida/javaIOLineagePayloads/LineageMetadata/lineageMetadata.json | $.handleMultipleLineage_2 |


 ###################################################################LINEAGE VALIDATION##########################################################################################################

  #6863772# #6863777 #6863783 #6863789 #6863792 #6863795 #6863796 #7131914# #7131915# #7131916# #7131917# #7131918# #7131919# #7131920# #7131921# #7131922# #7131923# #7131924#
  @MLP-13373 @sanity @positive
  Scenario Outline:SC#4 user connects to database and retrieves Lineage Hops Ids in order ot find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type       | name                           | asg_scopeid | targetFile                                           | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class      | BufferedReaderWriter_Write     |             | response/Lineage/BufferedReaderWriter_Write.json     |              |
      | APPDBPOSTGRES | FunctionID | Default |            | writeBufferedWriter            |             | response/Lineage/BufferedReaderWriter_Write.json     |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/BufferedReaderWriter_Write.json     | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FilesMove                      |             | response/Lineage/FilesMove.json                      |              |
      | APPDBPOSTGRES | FunctionID | Default |            | moveFiles                      |             | response/Lineage/FilesMove.json                      |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/FilesMove.json                      | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FileStreamWrite                |             | response/Lineage/FileStreamWrite.json                |              |
      | APPDBPOSTGRES | FunctionID | Default |            | writeFileOutputStream          |             | response/Lineage/FileStreamWrite.json                |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/FileStreamWrite.json                | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FileReaderWriter_Write         |             | response/Lineage/FileReaderWriter_Write.json         |              |
      | APPDBPOSTGRES | FunctionID | Default |            | writeFileWriter                |             | response/Lineage/FileReaderWriter_Write.json         |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/FileReaderWriter_Write.json         | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FilesReadAllLines              |             | response/Lineage/FilesReadAllLines.json              |              |
      | APPDBPOSTGRES | FunctionID | Default |            | doReadAllLines                 |             | response/Lineage/FilesReadAllLines.json              |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/FilesReadAllLines.json              | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FilesLines                     |             | response/Lineage/FilesLines.json                     |              |
      | APPDBPOSTGRES | FunctionID | Default |            | readFilesLines                 |             | response/Lineage/FilesLines.json                     |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/FilesLines.json                     | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | IOMultipleLineage              |             | response/Lineage/IOMultipleLineage.json              |              |
      | APPDBPOSTGRES | FunctionID | Default |            | handleMultipleLineage          |             | response/Lineage/IOMultipleLineage.json              |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/IOMultipleLineage.json              | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FileUtilsCopyFile              |             | response/Lineage/FileUtilsCopyFile.json              |              |
      | APPDBPOSTGRES | FunctionID | Default |            | copyFileFileUtils              |             | response/Lineage/FileUtilsCopyFile.json              |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/FileUtilsCopyFile.json              | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FilesCopy                      |             | response/Lineage/FilesCopy.json                      |              |
      | APPDBPOSTGRES | FunctionID | Default |            | copyFiles                      |             | response/Lineage/FilesCopy.json                      |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/FilesCopy.json                      | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | StreamIntermediateOp           |             | response/Lineage/StreamIntermediateOp.json           |              |
      | APPDBPOSTGRES | FunctionID | Default |            | intermediateOpStream           |             | response/Lineage/StreamIntermediateOp.json           |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/StreamIntermediateOp.json           | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FileUtilsCopyURLToFile         |             | response/Lineage/FileUtilsCopyURLToFile.json         |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fileUtilsCopyURLToFile         |             | response/Lineage/FileUtilsCopyURLToFile.json         |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/FileUtilsCopyURLToFile.json         | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FileUtilsCopyInputStreamToFile |             | response/Lineage/FileUtilsCopyInputStreamToFile.json |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fileUtilsCopyInputStreamToFile |             | response/Lineage/FileUtilsCopyInputStreamToFile.json |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/FileUtilsCopyInputStreamToFile.json | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FileUtilsCopyFileToDirectory   |             | response/Lineage/FileUtilsCopyFileToDirectory.json   |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fileUtilsCopyFileToDirectory   |             | response/Lineage/FileUtilsCopyFileToDirectory.json   |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/FileUtilsCopyFileToDirectory.json   | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FileUtilsCopyToFile            |             | response/Lineage/FileUtilsCopyToFile.json            |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fileUtilsCopyToFile            |             | response/Lineage/FileUtilsCopyToFile.json            |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/FileUtilsCopyToFile.json            | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FileUtilsCopyToDirectory       |             | response/Lineage/FileUtilsCopyToDirectory.json       |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fileUtilsCopyToDirectory       |             | response/Lineage/FileUtilsCopyToDirectory.json       |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/FileUtilsCopyToDirectory.json       | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FileUtilsLineIterator          |             | response/Lineage/FileUtilsLineIterator.json          |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fileUtilsLineIterator          |             | response/Lineage/FileUtilsLineIterator.json          |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/FileUtilsLineIterator.json          | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FileUtilsReadFileToByteArray   |             | response/Lineage/FileUtilsReadFileToByteArray.json   |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fileUtilsReadFileToByteArray   |             | response/Lineage/FileUtilsReadFileToByteArray.json   |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/FileUtilsReadFileToByteArray.json   | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FileUtilsReadFileToString      |             | response/Lineage/FileUtilsReadFileToString_1.json    |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fileUtilsReadFileToString_m1   |             | response/Lineage/FileUtilsReadFileToString_1.json    |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/FileUtilsReadFileToString_1.json    | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FileUtilsReadFileToString      |             | response/Lineage/FileUtilsReadFileToString_2.json    |              |
      | APPDBPOSTGRES | FunctionID | Default |            | fileUtilsReadFileToString_m2   |             | response/Lineage/FileUtilsReadFileToString_2.json    |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/FileUtilsReadFileToString_2.json    | $.functionID |
      | APPDBPOSTGRES | ClassID    | Default | Class      | FilesNewByteChannel            |             | response/Lineage/FilesNewByteChannel.json            |              |
      | APPDBPOSTGRES | FunctionID | Default |            | filesNewByteChannel            |             | response/Lineage/FilesNewByteChannel.json            |              |
      | APPDBPOSTGRES | LineageID  | Default | LineageHop |                                |             | response/Lineage/FilesNewByteChannel.json            | $.functionID |

  #6863772# #6863777 #6863783 #6863789 #6863792 #6863795 #6863796 #7131914# #7131915# #7131916# #7131917# #7131918# #7131919# #7131920# #7131921# #7131922# #7131923# #7131924#
  @MLP-13373 @sanity @positive
  Scenario Outline: SC#4 user retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                           | inputFile                                            | outputFile                                |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | BufferedReaderWriter_Write     | response/Lineage/BufferedReaderWriter_Write.json     | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FileReaderWriter_Write         | response/Lineage/FileReaderWriter_Write.json         | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FilesCopy                      | response/Lineage/FilesCopy.json                      | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FilesLines                     | response/Lineage/FilesLines.json                     | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FilesMove                      | response/Lineage/FilesMove.json                      | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FilesReadAllLines              | response/Lineage/FilesReadAllLines.json              | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FileStreamWrite                | response/Lineage/FileStreamWrite.json                | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FileUtilsCopyFile              | response/Lineage/FileUtilsCopyFile.json              | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | IOMultipleLineage              | response/Lineage/IOMultipleLineage.json              | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | StreamIntermediateOp           | response/Lineage/StreamIntermediateOp.json           | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FileUtilsCopyURLToFile         | response/Lineage/FileUtilsCopyURLToFile.json         | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FileUtilsCopyInputStreamToFile | response/Lineage/FileUtilsCopyInputStreamToFile.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FileUtilsCopyFileToDirectory   | response/Lineage/FileUtilsCopyFileToDirectory.json   | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FileUtilsCopyToFile            | response/Lineage/FileUtilsCopyToFile.json            | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FileUtilsCopyToDirectory       | response/Lineage/FileUtilsCopyToDirectory.json       | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FileUtilsLineIterator          | response/Lineage/FileUtilsLineIterator.json          | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FileUtilsReadFileToByteArray   | response/Lineage/FileUtilsReadFileToByteArray.json   | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FileUtilsReadFileToString_1    | response/Lineage/FileUtilsReadFileToString_1.json    | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FileUtilsReadFileToString_2    | response/Lineage/FileUtilsReadFileToString_2.json    | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FilesNewByteChannel            | response/Lineage/FilesNewByteChannel.json            | response/Lineage/LineageSourceTarget.json |

  #6863772# #6863777 #6863783 #6863789 #6863792 #6863795 #6863796 #7131914# #7131915# #7131916# #7131917# #7131918# #7131919# #7131920# #7131921# #7131922# #7131923# #7131924#
  @MLP-13373 @sanity @positive
  Scenario Outline: SC#4 Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                          | actual_json                                                 | item                           |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | BufferedReaderWriter_Write     |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | FileReaderWriter_Write         |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | FilesCopy                      |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | FilesLines                     |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | FilesMove                      |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | FilesReadAllLines              |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | FileStreamWrite                |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | FileUtilsCopyFile              |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | IOMultipleLineage              |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | StreamIntermediateOp           |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | FileUtilsCopyURLToFile         |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | FileUtilsCopyInputStreamToFile |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | FileUtilsCopyFileToDirectory   |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | FileUtilsCopyToFile            |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | FileUtilsCopyToDirectory       |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | FileUtilsLineIterator          |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | FileUtilsReadFileToByteArray   |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | FileUtilsReadFileToString_1    |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | FileUtilsReadFileToString_2    |
      | ida/javaIOLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | FilesNewByteChannel            |

 ###################################################################TAG VALIDATION##########################################################################################################

  #Technology tags verification
  @webtest @MLP-13373 @sanity @positive
  Scenario: SC#5 Verify the technology tags got assigned to the Cataloged items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                             | fileName               | userTag          |
      | Default     | File       | Metadata Type | Java,test_BA_JavaIOLineage,tagJavaIOLineage,Git | FileUtilsCopyFile.java | tagJavaIOLineage |
      | Default     | Function   | Metadata Type | Java,test_BA_JavaIOLineage,tagJavaIOLineage     | writeFileOutputStream  | tagJavaIOLineage |
      | Default     | Class      | Metadata Type | Java,test_BA_JavaIOLineage,tagJavaIOLineage     | StreamIntermediateOp   | tagJavaIOLineage |
      | Default     | SourceTree | Metadata Type | Java,test_BA_JavaIOLineage,tagJavaIOLineage     | FilesLines             | tagJavaIOLineage |
      | Default     | Project    | Metadata Type | Git,test_BA_JavaIOLineage,tagJavaIOLineage,Java | javaspark_lineage      | tagJavaIOLineage |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                        | fileName               | userTag          |
      | Default     | File       | Metadata Type | Programming,Source Control | FileUtilsCopyFile.java | tagJavaIOLineage |
      | Default     | Function   | Metadata Type | Programming,Source Control | writeFileWriter        | tagJavaIOLineage |
      | Default     | Class      | Metadata Type | Programming,Source Control | FileStreamWrite        | tagJavaIOLineage |
      | Default     | SourceTree | Metadata Type | Programming,Source Control | FileReaderWriter_Write | tagJavaIOLineage |
      | Default     | Project    | Metadata Type | Programming,Source Control | javaspark_lineage      | tagJavaIOLineage |


 ###################################################################METABILITY VALIDATION##########################################################################################################

  ##6660341
  @edibus @positive @webtest @regression @sanity
  Scenario:SC#6 MLP-9043_Verify replication of Java items to EDI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagJavaIOLineage" and clicks on search
    And user performs "facet selection" in "tagJavaIOLineage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Java" attribute under "Tags" facets in Item Search results page
    And user "verify displayed" for listed "Metadata Type" facet in Search results page
      | File       |
      | Function   |
      | SourceTree |
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | JAVAIO      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
    And user update json file "idc/EdiBusPayloads/datasource/EDIBusDS_JavaIOLineage.json" file for following values using property loader
      | jsonPath        | jsonValues  |
      | $..['EDI host'] | EDIHostName |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                      | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | settings/analyzers/EDIBusDataSource                                      | idc/EdiBusPayloads/datasource/EDIBusDS_JavaIOLineage.json | 204           |                  |                                                          |
      |                  |       |       | Put          | settings/analyzers/EDIBus                                                | idc/EdiBusPayloads/JavaIOLineageConfig.json               | 204           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusJavaIOLineage |                                                           | 200           | IDLE             | $.[?(@.configurationName=='EDIBusJavaIOLineage')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusJavaIOLineage  |                                                           | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusJavaIOLineage |                                                           | 200           | IDLE             | $.[?(@.configurationName=='EDIBusJavaIOLineage')].status |
    And user enters the search text "EDIBusJavaIOLineage" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusJavaIOLineage/%"
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Number of errors  | 0             | Description |
    And user enters the search text "Default" and clicks on search
    And user performs "facet selection" in "Java" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Git" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                                             |
      | AP-DATA      | JAVAIO      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_VARIABLE OR TYPE = DWR_DAT_FILE ) |
    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
      | jsonPath                                      | jsonValues                                  |
      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Programming/Java |
      | $..selections.['type_s'][*]                   | File                                        |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                          | body                              | response code | response message | jsonPath |
      |        |       |       | Post | searches/fulltext/Default?query=JavaIOLineage&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | JAVAIO      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_VARIABLE OR TYPE = DWR_DAT_FILE ) |
    And user enters the search text "JavaIOLineage" and clicks on search
    And user performs "facet selection" in "Java" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Git" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | JAVAIO      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_METHOD ) |
    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
      | jsonPath                                      | jsonValues                                  |
      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Programming/Java |
      | $..selections.['type_s'][*]                   | Function                                    |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                          | body                              | response code | response message | jsonPath |
      |        |       |       | Post | searches/fulltext/Default?query=JavaIOLineage&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | JAVAIO      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_METHOD ) |
    And user enters the search text "JavaIOLineage" and clicks on search
    And user performs "facet selection" in "Java" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Git" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
      | AP-DATA      | JAVAIO      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_CLASS ) |
    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
      | jsonPath                                      | jsonValues                                  |
      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Programming/Java |
      | $..selections.['type_s'][*]                   | SourceTree                                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                          | body                              | response code | response message | jsonPath |
      |        |       |       | Post | searches/fulltext/Default?query=JavaIOLineage&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | JAVAIO      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_CLASS ) |
    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
      | AP-DATA      | JAVAIO      | 1.0                | (XNAME * *  ~/ @*Java≫DEFAULT≫DWR_DAT_FILE≫@* ),AND,( TYPE = DWR_IDC )     |
      | AP-DATA      | JAVAIO      | 1.0                | (XNAME * *  ~/ @*Java≫DEFAULT≫DWR_OOP_CLASS≫@* ),AND,( TYPE = DWR_IDC )    |
      | AP-DATA      | JAVAIO      | 1.0                | (XNAME * *  ~/ @*Java≫DEFAULT≫DWR_OOP_METHOD≫@* ),AND,( TYPE = DWR_IDC )   |
      | AP-DATA      | JAVAIO      | 1.0                | (XNAME * *  ~/ @*Java≫DEFAULT≫DWR_OOP_VARIABLE≫@* ),AND,( TYPE = DWR_IDC ) |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                          | body                              | response code | response message | jsonPath |
      |        |       |       | Post | searches/fulltext/Default?query=JavaIOLineage&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                        |
#      | AP-DATA      | JAVAIO      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( DWR_TFM_TRANSFORMATION_MAP) |
    And user connects Rochade Server and "verify attributeValues" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | itemName                | itemType                   | attributeName | attributeValue                     |
      | AP-DATA      | JAVAIO      | 1.0                | @*IDA.txt@*             | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | /C:/Blue Boy R/IDA.txt             |
      | AP-DATA      | JAVAIO      | 1.0                | @*IDA.txt@*             | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | /C:/Blue Boy R/FileLinesOutput.txt |
      | AP-DATA      | JAVAIO      | 1.0                | @*moveFilesAPI_f1.txt@* | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | /moveFilesAPI_f1.txt               |
      | AP-DATA      | JAVAIO      | 1.0                | @*moveFilesAPI_f1.txt@* | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | /moveFilesAPI_f2.txt               |
      | AP-DATA      | JAVAIO      | 1.0                | @*BufferedReader.txt@*  | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_FROM  | /BufferedReader.txt                |
      | AP-DATA      | JAVAIO      | 1.0                | @*BufferedReader.txt@*  | DWR_TFM_TRANSFORMATION_MAP | DWR_TFM_TO    | /BufferedWriter.txt                |


  ###################################################################DELETING TEST ITEMS##########################################################################################################

  Scenario Outline: SC#7 User deletes the collected item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                 | inputFile                                       |
      | items/Default/Default.Project:::dynamic  | 204          | $..Project.id             | response/java/javaIOLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..Git_Analysis.id        | response/java/javaIOLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..JParser_Analysis.id    | response/java/javaIOLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..JIOLinker_Analysis.id  | response/java/javaIOLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..JIOLineage_Analysis.id | response/java/javaIOLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_BA.id              | response/java/javaIOLineage/actual/itemIds.json |

  ###################################################################UI VALIDATION DRY RUN SET TRUE##########################################################################################################

  @MLP-13373 @sanity @positive
  Scenario Outline: SC#8 Run the Plugin configurations for GitCollector ,Java Parser and Java IO Linker with dryRun as true
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                           | body                                                              | response code | response message       | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                     | ida/javaIOLineagePayloads/javaIOLineage_git_datasource.json       | 204           |                        |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource                                     |                                                                   | 200           | GitCollectorDataSource |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                               | ida/javaIOLineagePayloads/javaIOLineage_git.json                  | 204           |                        |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector                                               |                                                                   | 200           | JavaIOLineageGit       |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/JavaIOLineageGit |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLineageGit')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/JavaIOLineageGit  | ida/empty.json                                                    | 200           |                        |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/JavaIOLineageGit |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLineageGit')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaParser                                                 | ida/javaIOLineagePayloads/javaIOLineage_parser.json               | 204           |                        |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaParser                                                 |                                                                   | 200           | JavaParser             |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser            |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='JavaParser')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParser             | ida/empty.json                                                    | 200           |                        |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser            |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='JavaParser')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaIOLinker                                               | ida/javaIOLineagePayloads/javaIOLineage_IOlinker.json             | 204           |                        |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaIOLinker                                               |                                                                   | 200           | JavaIOLinker           |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaIOLinker/JavaIOLinker        |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLinker')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/JavaIOLinker/JavaIOLinker         | ida/empty.json                                                    | 200           |                        |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaIOLinker/JavaIOLinker        |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLinker')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaIOLineage                                              | ida/javaIOLineagePayloads/javaIOLineage_IOLineage_dryrunTrue.json | 204           |                        |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaIOLineage                                              |                                                                   | 200           | JavaIOLineage          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaIOLineage/JavaIOLineage     |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLineage')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaIOLineage/JavaIOLineage      | ida/empty.json                                                    | 200           |                        |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaIOLineage/JavaIOLineage     |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLineage')].status    |


  @MLP-13373 @sanity @positive
  Scenario Outline: SC#8 User retrieves the item ids of different items with dryRun as true and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                        | type    | targetFile                                      | jsonpath                  |
      | APPDBPOSTGRES | Default | javaspark_lineage                           | Project | response/java/javaIOLineage/actual/itemIds.json | $..Project.id             |
      | APPDBPOSTGRES | Default | test_BA_JavaIOLineage                       |         | response/java/javaIOLineage/actual/itemIds.json | $..has_BA.id              |
      | APPDBPOSTGRES | Default | collector/GitCollector/JavaIOLineageGit%DYN |         | response/java/javaIOLineage/actual/itemIds.json | $..Git_Analysis.id        |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParser%DYN            |         | response/java/javaIOLineage/actual/itemIds.json | $..JParser_Analysis.id    |
      | APPDBPOSTGRES | Default | linker/JavaIOLinker/JavaIOLinker%DYN        |         | response/java/javaIOLineage/actual/itemIds.json | $..JIOLinker_Analysis.id  |
      | APPDBPOSTGRES | Default | lineage/JavaIOLineage/JavaIOLineage%DYN     |         | response/java/javaIOLineage/actual/itemIds.json | $..JIOLineage_Analysis.id |


  @webtest @MLP-13373 @sanity @positive
  Scenario: SC#8 Verify Java IO Lineage plugin functionality with dry run as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JavaIOLineage" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/JavaIOLineage/JavaIOLineage/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName |
      | Number of processed items | 0             |            |
      | Number of errors          | 0             |            |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "lineage/JavaIOLineage/JavaIOLineage%" should display below info/error/warning
      | type | logValue                                     | logCode       | pluginName | removableText |
      | INFO | Plugin JavaIOLineage running on dry run mode | ANALYSIS-0069 |            |               |


   ###################################################################DELETING TEST ITEMS AND CONFIGURATIONS##########################################################################################################

  @MLP-13373 @sanity @positive
  Scenario Outline: SC#9 User deletes the collected item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                 | inputFile                                       |
      | items/Default/Default.Project:::dynamic  | 204          | $..Project.id             | response/java/javaIOLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..Git_Analysis.id        | response/java/javaIOLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..JParser_Analysis.id    | response/java/javaIOLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..JIOLinker_Analysis.id  | response/java/javaIOLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..JIOLineage_Analysis.id | response/java/javaIOLineage/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_BA.id              | response/java/javaIOLineage/actual/itemIds.json |

  Scenario: SC#9: Delete the EDIBus Analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                             | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusJavaIOLineage% | Analysis |       |       |

  @cr-data @sanity
  Scenario: SC#9 Delete Plugin Configuration
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                         | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/credentials/ValidGitCredentials    |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/EDIBusValidCredentials |      | 200           |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource   |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector             |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/JavaParser               |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/JavaIOLinker             |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/JavaIOLineage            |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/EDIBusDataSource         |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/EDIBus                   |      | 204           |                  |          |
