Feature: Validation of Java IO Linker plugin functionality after running git and Java parser plugins

  ############################################# Pre Conditions ##########################################################
  @git @precondition
  Scenario: SC#1:UpdateCredentials: Update Git credentials with exact values
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                   | username    | password    |
      | ida/javaIOLinkerPayloads/javaIOLinker_git_credentials.json | $..userName | $..password |

  @sanity @positive @regression
  Scenario Outline: SC#1:SetCredentials: Set the credentials for GitCollector
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                      | body                                                       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidGitCredentials | ida/javaIOLinkerPayloads/javaIOLinker_git_credentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidGitCredentials |                                                            | 200           |                  |          |

  @sanity @positive @regression
  Scenario Outline: SC#1:BusinessApplication: Create BusinessApplication tag and run the plugin configuration with the new field for Git
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/javaIOLinkerPayloads/javaIOLinker_BusinessApplication.json | 200           |                  |          |

  ############################################# PluginRun ##########################################################
  @MLP-9732 @sanity @positive
  Scenario Outline: SC#3:PluginRun: Run the Plugin configurations for GitCollector ,Java Parser and Java IO Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                          | body                                                      | response code | response message       | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                    | ida/javaIOLinkerPayloads/javaIOLinker_git_datasource.json | 204           |                        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource                                    |                                                           | 200           | GitCollectorDataSource |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                              | ida/javaIOLinkerPayloads/javaIOLinker_git.json            | 204           |                        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector                                              |                                                           | 200           | JavaIOLinkerGit        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/JavaIOLinkerGit |                                                           | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLinkerGit')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/JavaIOLinkerGit  | ida/empty.json                                            | 200           |                        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/JavaIOLinkerGit |                                                           | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLinkerGit')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaParser                                                | ida/JavaIOLinkerPayloads/javaIOLinker_parser.json         | 204           |                        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaParser                                                |                                                           | 200           | JavaParser             |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser           |                                                           | 200           | IDLE                   | $.[?(@.configurationName=='JavaParser')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParser            | ida/empty.json                                            | 200           |                        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser           |                                                           | 200           | IDLE                   | $.[?(@.configurationName=='JavaParser')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaIOLinker                                              | ida/JavaIOLinkerPayloads/javaIOLinker_linker.json         | 204           |                        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaIOLinker                                              |                                                           | 200           | JavaIOLinker           |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaIOLinker/JavaIOLinker       |                                                           | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLinker')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/JavaIOLinker/JavaIOLinker        | ida/empty.json                                            | 200           |                        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaIOLinker/JavaIOLinker       |                                                           | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLinker')].status    |

  Scenario Outline: SC#3:RetrieveItemIDs: User retrieves the item ids of different items and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                       | type    | targetFile                                     | jsonpath                 |
      | APPDBPOSTGRES | Default | javaspark_lineage                          | Project | response/java/javaIOLinker/actual/itemIds.json | $..Project.id            |
      | APPDBPOSTGRES | Default | test_BA_JavaIOLinker                       |         | response/java/javaIOLinker/actual/itemIds.json | $..has_BA.id             |
      | APPDBPOSTGRES | Default | collector/GitCollector/JavaIOLinkerGit%DYN |         | response/java/javaIOLinker/actual/itemIds.json | $..Git_Analysis.id       |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParser%DYN           |         | response/java/javaIOLinker/actual/itemIds.json | $..JParser_Analysis.id   |
      | APPDBPOSTGRES | Default | linker/JavaIOLinker/JavaIOLinker%DYN       |         | response/java/javaIOLinker/actual/itemIds.json | $..JIOLinker_Analysis.id |

  ############################################# Logging Enhancements ##########################################################
  @sanity @positive @MLP-9732 @webtest
  Scenario: SC#4 Verify JavaIOLinker collects Analysis item with proper log messages
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagJavaIOLinker" and clicks on search
    And user performs "facet selection" in "tagJavaIOLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "linker/JavaIOLinker/JavaIOLinker%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 8             | Description |
      | Number of errors          | 0             | Description |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "linker/JavaIOLinker/JavaIOLinker/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | logCode       | pluginName   | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | ANALYSIS-0019 |              |                |
      | INFO | Plugin Name:JavaIOLinker, Plugin Type:linker, Plugin Version:1.0.0.SNAPSHOT, Node Name:LocalNode, Host Name:e80eca0be5a2, Plugin Configuration name:JavaIOLinker                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | ANALYSIS-0071 | JavaIOLinker | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin JavaIOLinker Configuration: ---  2020-08-17 08:54:28.603 INFO  - ANALYSIS-0073: Plugin JavaIOLinker Configuration: name: "JavaIOLinker"  2020-08-17 08:54:28.603 INFO  - ANALYSIS-0073: Plugin JavaIOLinker Configuration: pluginVersion: "LATEST"  2020-08-17 08:54:28.603 INFO  - ANALYSIS-0073: Plugin JavaIOLinker Configuration: label:  2020-08-17 08:54:28.603 INFO  - ANALYSIS-0073: Plugin JavaIOLinker Configuration: : "JavaIOLinker"  2020-08-17 08:54:28.603 INFO  - ANALYSIS-0073: Plugin JavaIOLinker Configuration: catalogName: "Default"  2020-08-17 08:54:28.603 INFO  - ANALYSIS-0073: Plugin JavaIOLinker Configuration: eventClass: null  2020-08-17 08:54:28.603 INFO  - ANALYSIS-0073: Plugin JavaIOLinker Configuration: eventCondition: null  2020-08-17 08:54:28.603 INFO  - ANALYSIS-0073: Plugin JavaIOLinker Configuration: nodeCondition: "name==\"LocalNode\""  2020-08-17 08:54:28.603 INFO  - ANALYSIS-0073: Plugin JavaIOLinker Configuration: maxWorkSize: 100  2020-08-17 08:54:28.603 INFO  - ANALYSIS-0073: Plugin JavaIOLinker Configuration: tags:  2020-08-17 08:54:28.603 INFO  - ANALYSIS-0073: Plugin JavaIOLinker Configuration: - "tagJavaIOLinker"  2020-08-17 08:54:28.603 INFO  - ANALYSIS-0073: Plugin JavaIOLinker Configuration: pluginType: "linker"  2020-08-17 08:54:28.603 INFO  - ANALYSIS-0073: Plugin JavaIOLinker Configuration: dataSource: null  2020-08-17 08:54:28.603 INFO  - ANALYSIS-0073: Plugin JavaIOLinker Configuration: credential: null  2020-08-17 08:54:28.603 INFO  - ANALYSIS-0073: Plugin JavaIOLinker Configuration: businessApplicationName: "test_BA_JavaIOLinker"  2020-08-17 08:54:28.604 INFO  - ANALYSIS-0073: Plugin JavaIOLinker Configuration: dryRun: false  2020-08-17 08:54:28.604 INFO  - ANALYSIS-0073: Plugin JavaIOLinker Configuration: schedule: null  2020-08-17 08:54:28.604 INFO  - ANALYSIS-0073: Plugin JavaIOLinker Configuration: runAfter: []  2020-08-17 08:54:28.604 INFO  - ANALYSIS-0073: Plugin JavaIOLinker Configuration: filter: null | ANALYSIS-0073 | JavaIOLinker |                |
      | INFO | Plugin JavaIOLinker Start Time:2020-03-18 05:56:23.378, End Time:2020-03-18 05:56:27.972, Processed Count:8, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ANALYSIS-0072 | JavaIOLinker |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | ANALYSIS-0020 |              |                |
    And user should be able logoff the IDC

  ############################################# UI Validation ##########################################################
  @webtest @MLP-9732 @sanity @positive
  Scenario: SC#5 Verify facet counts appears properly for the items collected by GitCollector ,Java Parser and Java IO Linker
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaIOLinker" and clicks on search
    And user performs "facet selection" in "tagJavaIOLinker" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType  | count |
      | Project    | 1     |
      | Directory  | 1     |
      | Analysis   | 3     |
      | SourceTree | 8     |
      | Class      | 8     |
      | Function   | 11    |
      | File       | 40    |
    And user should be able logoff the IDC

  #6646616# #6676577# #6676578# #6676587#
  @webtest @MLP-9732 @sanity @positive
  Scenario: SC#6 Verify external files are linked with the File when File instance is created with the following, after java IO linker plugin is executed
  1.  File instance is created with String argument
  2.  File instance is created with File and String argument
  3.  File instance is created with two string arguments
  4.  File instance is created with URI argument

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaIOLinker" and clicks on search
    And user performs "facet selection" in "tagJavaIOLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "javaIOLinker" item from search results
    Then user performs click and verify in new window
      | Table | value                  | Action                    | RetainPrevwindow | indexSwitch | filePath                                       | jsonPath           | metadataSection |
      | Files | /C:\IOLinker\          | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.CIOLinker        | Description     |
      | Files | /\childFile3.file      | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.childFile3       | Description     |
      | Files | /\fileChildString1.txt | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.fileChildString1 | Description     |
      | Files | /createFile2.json      | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.createFile2      | Description     |
      | Files | /C:/IOLinker/file4.txt | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.file4            | Description     |
    And user should be able logoff the IDC

  #6676598# #6676611# #6676619# #6676620#
  @webtest @MLP-9732 @sanity @positive
  Scenario: SC#7 Verify external files are linked with the File when File Reader instance is created with the following, after java IO linker plugin is executed
  1.  File Reader instance is created with String argument
  2.  File Reader instance is created with File argument

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaIOLinker" and clicks on search
    And user performs "facet selection" in "tagJavaIOLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "fileReaderWriter" item from search results
    Then user performs click and verify in new window
      | Table | value                       | Action                    | RetainPrevwindow | indexSwitch | filePath                                       | jsonPath     | metadataSection |
      | Files | /output2.txt                | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.output2    | Description     |
      | Files | /C:\IOLinker\writetext2.txt | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.writetext2 | Description     |
    And user should be able logoff the IDC

  #6676619# #6676620# to be verified
  @webtest @MLP-9732 @sanity @positive
  Scenario: SC#8_Verify external files are linked with the File when File Writer instance is created with the following, after java IO linker plugin is executed
  1.  File Writer instance is created with String argument
  2.  File Reader instance is created with File argument
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaIOLinker" and clicks on search
    And user performs "facet selection" in "tagJavaIOLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "fileReaderWriter" item from search results
    Then user performs click and verify in new window
      | Table | value                      | Action                    | RetainPrevwindow | indexSwitch | filePath                                       | jsonPath    | metadataSection |
      | Files | /output.txt                | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.output    | Description     |
      | Files | /C:\IOLinker\writetext.txt | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.writetext | Description     |
    And user should be able logoff the IDC

  #6676625# #6676626#
  @webtest @MLP-9732 @sanity @positive
  Scenario: SC#9_Verify external files are linked with the File when File InputStream instance is created with the following, after java IO linker plugin is executed
  1.  File InputStream instance is created with String argument
  2.  File InputStream instance is created with File argument
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaIOLinker" and clicks on search
    And user performs "facet selection" in "tagJavaIOLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "fileStreamExample" item from search results
    Then user performs click and verify in new window
      | Table | value                    | Action                    | RetainPrevwindow | indexSwitch | filePath                                       | jsonPath  | metadataSection |
      | Files | /test2.txt               | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.test2   | Description     |
      | Files | /C:\IOLinker\fos2222.txt | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.fos2222 | Description     |
    And user should be able logoff the IDC


  #6676627# #6676628#
  @webtest @MLP-9732 @sanity @positive
  Scenario: SC#10_Verify external files are linked with the File when File OutputStream instance is created with the following, after java IO linker plugin is executed
  1.  File OutputStream instance is created with String argument
  2.  File OutputStream instance is created with File argument
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaIOLinker" and clicks on search
    And user performs "facet selection" in "tagJavaIOLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "fileStreamExample" item from search results
    Then user performs click and verify in new window
      | Table | value                 | Action                    | RetainPrevwindow | indexSwitch | filePath                                       | jsonPath | metadataSection |
      | Files | /test.txt             | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.test   | Description     |
      | Files | /C:\IOLinker\fos2.txt | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.fos2   | Description     |
    And user should be able logoff the IDC

  #6676717#
  @webtest @MLP-9732 @sanity @positive
  Scenario: SC#11_Verify external files gets linked with the File when RandomAccessFile instance is created with a string argument and access mode string when JavaIOLinker plugin is executed.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaIOLinker" and clicks on search
    And user performs "facet selection" in "tagJavaIOLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "readCharsFromFile" item from search results
    Then user performs click and verify in new window
      | Table | value       | Action                    | RetainPrevwindow | indexSwitch | filePath                                       | jsonPath | metadataSection |
      | Files | /source.txt | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.source | Description     |
    And user enters the search text "tagJavaIOLinker" and clicks on search
    And user performs "facet selection" in "tagJavaIOLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "appendData" item from search results
    And user "verifies tab section values" has the following values in "uses" Tab in Item View page
      | /source.txt |
    Then user performs click and verify in new window
      | Table | value       | Action                    | RetainPrevwindow | indexSwitch | filePath                                       | jsonPath | metadataSection |
      | uses  | /source.txt | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.source | Description     |
    And user enters the search text "tagJavaIOLinker" and clicks on search
    And user performs "facet selection" in "tagJavaIOLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "writeData" item from search results
    And user "verifies tab section values" has the following values in "uses" Tab in Item View page
      | /source.txt |
    Then user performs click and verify in new window
      | Table | value       | Action                    | RetainPrevwindow | indexSwitch | filePath                                       | jsonPath | metadataSection |
      | uses  | /source.txt | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.source | Description     |
    And user should be able logoff the IDC

  #6676722# #6676723#
  @webtest @MLP-9732 @sanity @positive
  Scenario: SC#12_Verify external files are linked with the File when copyFile method instance is created with String argument and when File Permission instance is created with filepath, after java IO linker plugin is executed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaIOLinker" and clicks on search
    And user performs "facet selection" in "tagJavaIOLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "permissionUtilPathExample" item from search results
    Then user performs click and verify in new window
      | Table | value                              | Action                    | RetainPrevwindow | indexSwitch | filePath                                       | jsonPath      | metadataSection |
      | Files | /createFile1.json                  | verify widget contains    |                  |             |                                                |               |                 |
      | Files | /createFile2.json                  | verify widget contains    |                  |             |                                                |               |                 |
      | Files | /createFile3.json                  | verify widget contains    |                  |             |                                                |               |                 |
      | Files | /createFile4.json                  | verify widget contains    |                  |             |                                                |               |                 |
      | Files | /C:\IOLinker\temp\CopyFile.txt     | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.CopyFile    | Description     |
      | Files | /C:\IOLinker\temp2\Destination.txt | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.Destination | Description     |
    And user should be able logoff the IDC

  #6676724#
  @webtest @MLP-9732 @sanity @positive
  Scenario: SC#13_Verify external files are linked with the File when Path and Paths instances are used, after java IO linker plugin is executed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaIOLinker" and clicks on search
    And user performs "facet selection" in "tagJavaIOLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "permissionUtilPathExample" item from search results
    Then user performs click and verify in new window
      | Table | value                                 | Action                    | RetainPrevwindow | indexSwitch | filePath                                       | jsonPath           | metadataSection |
      | Files | /C:\DummyFolder/temp2                 | verify widget contains    |                  |             |                                                |                    |                 |
      | Files | /C:\IOLinker\file4.txt                | verify widget contains    |                  |             |                                                |                    |                 |
      | Files | /C:\DummyFolder/temp2\Destination.txt | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.DummyDestination | Description     |
    And user should be able logoff the IDC

  #7029927# #7029928#
  @webtest @MLP-9732 @sanity @positive
  Scenario: SC#14_Verify external files are linked with the with testGetFile() function of the class ApacheFileUtilsGetFileExample, after java IO linker plugin is executed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaIOLinker" and clicks on search
    And user performs "facet selection" in "tagJavaIOLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testGetFile" item from search results
    Then user performs click and verify in new window
      | Table | value                      | Action                    | RetainPrevwindow | indexSwitch | filePath                                       | jsonPath     | metadataSection |
      | Files | /C:\appdata/d1/d2          | verify widget contains    |                  |             |                                                |              |                 |
      | Files | /C:\appdata/d1/d2/FileSamp | verify widget contains    |                  |             |                                                |              |                 |
      | Files | /C:\appdata/d1/d2          | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.GetFile_f1 | Description     |
      | Files | /C:\appdata/d1/d2/FileSamp | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.GetFile_f2 | Description     |
    And user should be able logoff the IDC

  #7029929#
  @webtest @MLP-9732 @sanity @positive
  Scenario: SC#15_Verify external files are linked with the with testToFile() function of the class ApacheFileUtilsToFileExample, after java IO linker plugin is executed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaIOLinker" and clicks on search
    And user performs "facet selection" in "tagJavaIOLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testToFile" item from search results
    Then user performs click and verify in new window
      | Table | value                                                                | Action                    | RetainPrevwindow | indexSwitch | filePath                                       | jsonPath    | metadataSection |
      | Files | /a/b/c/file.txt                                                      | verify widget contains    |                  |             |                                                |             |                 |
      | Files | /C:/IOLinker/file%20name.txt                                         | verify widget contains    |                  |             |                                                |             |                 |
      | Files | /file:/C:/projects/workspace/testing/file%20name%20with%20spaces.txt | verify widget contains    |                  |             |                                                |             |                 |
      | Files | /a/b/c/file.txt                                                      | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.ToFile_f1 | Description     |
      | Files | /C:/IOLinker/file%20name.txt                                         | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.ToFile_f2 | Description     |
      | Files | /file:/C:/projects/workspace/testing/file%20name%20with%20spaces.txt | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.ToFile_f3 | Description     |
    And user should be able logoff the IDC

  #7029930#
  @webtest @MLP-9732 @sanity @positive
  Scenario: SC#16_Verify external files are linked with the with testToFiles() function of the class ApacheFileUtilsToFileExample, after java IO linker plugin is executed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tagJavaIOLinker" and clicks on search
    And user performs "facet selection" in "tagJavaIOLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testToFiles" item from search results
    Then user performs click and verify in new window
      | Table | value                                                      | Action                    | RetainPrevwindow | indexSwitch | filePath                                       | jsonPath     | metadataSection |
      | Files | /file1.txt                                                 | verify widget contains    |                  |             |                                                |              |                 |
      | Files | /file:/file1_conf.txt                                      | verify widget contains    |                  |             |                                                |              |                 |
      | Files | /file:/C:/IOLinker/testing/file%20name%20with%20spaces.txt | verify widget contains    |                  |             |                                                |              |                 |
      | Files | /a/b/c/d/e/f/file.txt                                      | verify widget contains    |                  |             |                                                |              |                 |
      | Files | /file1.txt                                                 | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.ToFiles_f1 | Description     |
      | Files | /file:/file1_conf.txt                                      | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.ToFiles_f2 | Description     |
      | Files | /file:/C:/IOLinker/testing/file%20name%20with%20spaces.txt | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.ToFiles_f3 | Description     |
      | Files | /a/b/c/d/e/f/file.txt                                      | click and verify metadata | Yes              | 0           | ida/javaIOLinkerPayloads/expectedMetadata.json | $.ToFiles_f4 | Description     |
    And user should be able logoff the IDC

  ############################################# Technology tags verification #############################################
  @webtest @MLP-9732 @sanity @positive
  Scenario: SC#17:Tech_tags_Explicit_Tags verification: Verify the technology tags, explicit tags and Business Application item got assigned to the Cataloged items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                           | fileName               | userTag         |
      | Default     | File       | Metadata Type | tagJavaIOLinker,Git,test_BA_JavaIOLinker,Java | FileStreamExample.java | tagJavaIOLinker |
      | Default     | Function   | Metadata Type | tagJavaIOLinker,Java,test_BA_JavaIOLinker     | readCharsFromFile      | tagJavaIOLinker |
      | Default     | Class      | Metadata Type | tagJavaIOLinker,Java,test_BA_JavaIOLinker     | JavaIOLinker           | tagJavaIOLinker |
      | Default     | SourceTree | Metadata Type | tagJavaIOLinker,Java,test_BA_JavaIOLinker     | JavaIOLinker           | tagJavaIOLinker |
      | Default     | Project    | Metadata Type | tagJavaIOLinker,Git,test_BA_JavaIOLinker      | javaspark_lineage      | tagJavaIOLinker |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                        | fileName               | userTag         |
      | Default     | File       | Metadata Type | Programming,Source Control | FileStreamExample.java | tagJavaIOLinker |
      | Default     | Function   | Metadata Type | Programming,Source Control | readCharsFromFile      | tagJavaIOLinker |
      | Default     | Class      | Metadata Type | Programming,Source Control | JavaIOLinker           | tagJavaIOLinker |
      | Default     | SourceTree | Metadata Type | Programming,Source Control | JavaIOLinker           | tagJavaIOLinker |
      | Default     | Project    | Metadata Type | Programming,Source Control | javaspark_lineage      | tagJavaIOLinker |
    And user should be able logoff the IDC

  Scenario Outline: SC#18:ItemDeletion- User deletes the collected item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                | inputFile                                      |
      | items/Default/Default.Project:::dynamic  | 204          | $..Project.id            | response/java/javaIOLinker/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..Git_Analysis.id       | response/java/javaIOLinker/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..JParser_Analysis.id   | response/java/javaIOLinker/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..JIOLinker_Analysis.id | response/java/javaIOLinker/actual/itemIds.json |

  ############################################# PluginRun DryRun ##########################################################
  @MLP-9732 @sanity @positive
  Scenario Outline: SC#19:PluginRun: Run the Plugin configurations for GitCollector ,Java Parser and Java IO Linker with dryRun as true
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                          | body                                                         | response code | response message       | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                    | ida/javaIOLinkerPayloads/javaIOLinker_git_datasource.json    | 204           |                        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource                                    |                                                              | 200           | GitCollectorDataSource |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                              | ida/javaIOLinkerPayloads/javaIOLinker_git.json               | 204           |                        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector                                              |                                                              | 200           | JavaIOLinkerGit        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/JavaIOLinkerGit |                                                              | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLinkerGit')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/JavaIOLinkerGit  | ida/empty.json                                               | 200           |                        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/JavaIOLinkerGit |                                                              | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLinkerGit')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaParser                                                | ida/JavaIOLinkerPayloads/javaIOLinker_parser.json            | 204           |                        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaParser                                                |                                                              | 200           | JavaParser             |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser           |                                                              | 200           | IDLE                   | $.[?(@.configurationName=='JavaParser')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParser            | ida/empty.json                                               | 200           |                        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParser           |                                                              | 200           | IDLE                   | $.[?(@.configurationName=='JavaParser')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JavaIOLinker                                              | ida/JavaIOLinkerPayloads/javaIOLinker_linker_dryrunTrue.json | 204           |                        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JavaIOLinker                                              |                                                              | 200           | JavaIOLinker           |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaIOLinker/JavaIOLinker       |                                                              | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLinker')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/JavaIOLinker/JavaIOLinker        | ida/empty.json                                               | 200           |                        |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaIOLinker/JavaIOLinker       |                                                              | 200           | IDLE                   | $.[?(@.configurationName=='JavaIOLinker')].status    |

  Scenario Outline: SC#19:RetrieveItemIDs: User retrieves the item ids of different items with dryRun as true and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                       | type    | targetFile                                     | jsonpath                 |
      | APPDBPOSTGRES | Default | javaspark_lineage                          | Project | response/java/javaIOLinker/actual/itemIds.json | $..Project.id            |
      | APPDBPOSTGRES | Default | collector/GitCollector/JavaIOLinkerGit%DYN |         | response/java/javaIOLinker/actual/itemIds.json | $..Git_Analysis.id       |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParser%DYN           |         | response/java/javaIOLinker/actual/itemIds.json | $..JParser_Analysis.id   |
      | APPDBPOSTGRES | Default | linker/JavaIOLinker/JavaIOLinker%DYN       |         | response/java/javaIOLinker/actual/itemIds.json | $..JIOLinker_Analysis.id |

  @webtest @MLP-9732 @sanity @positive
  Scenario: SC#19 Verify Java IO Linker plugin functionality with dry run as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "test_BA_JavaIOLinker" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "linker/JavaIOLinker/JavaIOLinker%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "linker/JavaIOLinker/JavaIOLinker/%" should display below info/error/warning
      | type | logValue                                    | logCode       | pluginName | removableText |
      | INFO | Plugin JavaIOLinker running on dry run mode | ANALYSIS-0069 |            |               |
    And user should be able logoff the IDC

  ############################################# Post Conditions ##########################################################
  Scenario Outline: SC#20:ItemDeletion- User deletes the collected item with dry run as true from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                | inputFile                                      |
      | items/Default/Default.Project:::dynamic             | 204          | $..Project.id            | response/java/javaIOLinker/actual/itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..has_BA.id             | response/java/javaIOLinker/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Git_Analysis.id       | response/java/javaIOLinker/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JParser_Analysis.id   | response/java/javaIOLinker/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JIOLinker_Analysis.id | response/java/javaIOLinker/actual/itemIds.json |

  @cr-data @sanity
  Scenario Outline: SC#20:ConfigDeletion: Delete Plugin Configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                       | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidGitCredentials  |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaParser             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaIOLinker           |      | 204           |                  |          |
