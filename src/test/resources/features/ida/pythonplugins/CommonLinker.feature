Feature: Feature to validate the collection of repositories through the Collector plugin and parsing of the repositories through the Parser plugin


  @MLP-13399 @sanity @positive @regression @IDA_E2E
  Scenario Outline:Precondition:Run the Plugin configurations for Git , Python Parser , Package Linker and Python Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                             | body                                              | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | items/Default/root                                                              | ida/CommonLinker/BussinessApplication_Python.json | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/SampleCredentialsgit                                       | ida/CommonLinker/GitCredentials.json              | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                       | ida/CommonLinker/gitDatasourceConfig.json         | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                                 | ida/CommonLinker/Git_Py_Parser.json               | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector                                                 |                                                   | 200           | GitCollector     |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector       |                                                   | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector        | ida/CommonLinker/Git_Py_Parser_empty.json         | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector       |                                                   | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PythonParser                                                 | ida/CommonLinker/Py_parser.json                   | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PythonParser                                                 |                                                   | 200           | PythonParser     |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser          |                                                   | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser           | ida/CommonLinker/Py_parser_empty.json             | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser          |                                                   | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PythonPackageLinker                                          | ida/CommonLinker/Py_package_linker.json           | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PythonPackageLinker                                          |                                                   | 200           | Package_Linker   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/Package_Linker |                                                   | 200           | IDLE             | $.[?(@.configurationName=='Package_Linker')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/PythonPackageLinker/Package_Linker  | ida/CommonLinker/Py_package_linker_empty.json     | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/Package_Linker |                                                   | 200           | IDLE             | $.[?(@.configurationName=='Package_Linker')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PythonLinker                                                 | ida/CommonLinker/Py_linker.json                   | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PythonLinker                                                 |                                                   | 200           | PythonLinker     |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonLinker/PythonLinker          |                                                   | 200           | IDLE             | $.[?(@.configurationName=='PythonLinker')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/PythonLinker/PythonLinker           | ida/CommonLinker/Py_linker_empty.json             | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonLinker/PythonLinker          |                                                   | 200           | IDLE             | $.[?(@.configurationName=='PythonLinker')].status   |


          #      ####################################LOGGING ENHANCEMENT VALIDATION############################################################################################
  #6689699#
  @webtest @MLP-13399 @sanity @positive
  Scenario:SC1:Parsing the repository and validating the error messages in Log
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "CommonLinker" and clicks on search
    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on python parser link from Analysis facet
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "parser/PythonParser/PythonParser%" should display below info/error/warning
      | type  | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | logCode      | pluginName   | removableText |
      | ERROR | {"lineNumber":1,"position":4,"errorMsg":"missing ':' at ' '","userInfo":"missing ","name":"error"}                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | PARSING-0003 | PythonParser |               |
      | ERROR | {"lineNumber":5,"position":6,"errorMsg":"extraneous input '\\\\t\\\\t    ' expecting {'def', 'return', 'raise', 'from', 'import', 'global', 'nonlocal', 'assert', 'if', 'while', 'for', 'try', 'with', 'lambda', 'not', 'None', 'True', 'False', 'class', 'yield', 'del', 'pass', 'continue', 'break', 'async', 'await', NAME, STRING_LITERAL, BYTES_LITERAL, UNSIGNED_INTEGER, DECIMAL_INTEGER, OCT_INTEGER, HEX_INTEGER, BIN_INTEGER, FLOAT_NUMBER, IMAG_NUMBER, '...', '*', '(', '[', '+', '-', '~', '{', '@', DEDENT}","userInfo":"extraneous input ","name":"error"} | PARSING-0003 | PythonParser |               |
      | ERROR | {"lineNumber":5,"position":24,"errorMsg":"extraneous input ')' expecting {<EOF>, 'def', 'return', 'raise', 'from', 'import', 'global', 'nonlocal', 'assert', 'if', 'while', 'for', 'try', 'with', 'lambda', 'not', 'None', 'True', 'False', 'class', 'yield', 'del', 'pass', 'continue', 'break', 'async', 'await', NEWLINE, NAME, STRING_LITERAL, BYTES_LITERAL, UNSIGNED_INTEGER, DECIMAL_INTEGER, OCT_INTEGER, HEX_INTEGER, BIN_INTEGER, FLOAT_NUMBER, IMAG_NUMBER, '...', '*', '(', '[', '+', '-', '~', '{', '@'}","userInfo":"extraneous input ","name":"error"}     | PARSING-0003 | PythonParser |               |


    #6943594
  @webtest @MLP-17108 @sanity @positive
  Scenario:SC1:Parsing the repository and validating the Git Log
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "CommonLinker" and clicks on search
    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/GitCollector/GitCollector/%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "collector/GitCollector/GitCollector%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | logCode           | pluginName   | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0019     |              |                |
      | INFO | Plugin Name:GitCollector, Plugin Type:collector, Plugin Version:10.3.0.SNAPSHOT, Node Name:LocalNode, Host Name:bc10fd8866ef, Plugin Configuration name:GitCollector                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0071     | GitCollector | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin GitCollector Configuration: ---  2020-04-03 14:46:09.093 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: name: "GitCollector"  2020-04-03 14:46:09.094 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: pluginVersion: "LATEST"  2020-04-03 14:46:09.094 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: label:  2020-04-03 14:46:09.094 INFO - ANALYSIS-0073: Plugin GitCollector Configuration:   : ""  2020-04-03 14:46:09.094 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: catalogName: "Default"  2020-04-03 14:46:09.094 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: eventClass: null  2020-04-03 14:46:09.094 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: eventCondition: null  2020-04-03 14:46:09.094 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: nodeCondition: "name==\"LocalNode\""  2020-04-03 14:46:09.094 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: maxWorkSize: 100  2020-04-03 14:46:09.094 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: tags:  2020-04-03 14:46:09.094 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: - "CommonLinker"  2020-04-03 14:46:09.095 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: pluginType: "collector"  2020-04-03 14:46:09.095 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: dataSource: "GitCollectorDataSource"  2020-04-03 14:46:09.095 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: credential: "SampleCredentialsgit"  2020-04-03 14:46:09.095 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: businessApplicationName: "BA_PY"  2020-04-03 14:46:09.095 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: dryRun: false 2020-09-08 15:57:47.901 INFO  - ANALYSIS-0073: Plugin GitCollector Configuration: schedule: null  2020-04-03 14:46:09.095 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: filter:  2020-04-03 14:46:09.095 INFO - ANALYSIS-0073: Plugin GitCollector Configuration:   filters:  2020-04-03 14:46:09.095 INFO - ANALYSIS-0073: Plugin GitCollector Configuration:   - class: "com.asg.dis.common.analysis.dom.Filter"  2020-04-03 14:46:09.095 INFO - ANALYSIS-0073: Plugin GitCollector Configuration:     label: null  2020-04-03 14:46:09.096 INFO - ANALYSIS-0073: Plugin GitCollector Configuration:     tags: null  2020-04-03 14:46:09.096 INFO - ANALYSIS-0073: Plugin GitCollector Configuration:     branch: "PythonTest"  2020-04-03 14:46:09.096 INFO - ANALYSIS-0073: Plugin GitCollector Configuration:   deltaTime: "300"  2020-04-03 14:46:09.096 INFO - ANALYSIS-0073: Plugin GitCollector Configuration:   extraFilters:  2020-04-03 14:46:09.096 INFO - ANALYSIS-0073: Plugin GitCollector Configuration:     filefilters: []  2020-04-03 14:46:09.096 INFO - ANALYSIS-0073: Plugin GitCollector Configuration:   maxHits: null  2020-04-03 14:46:09.096 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: contentAnalyzerPlugin: "UnstructuredDataAnalyzer"  2020-04-03 14:46:09.097 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: pluginName: "GitCollector" 2020-09-08 15:57:47.901 INFO  - ANALYSIS-0073: Plugin GitCollector Configuration: contentAnalyzerPluginConfiguration: null 2020-04-03 14:46:09.097 INFO - ANALYSIS-0073: Plugin GitCollector Configuration: type: "Collector" | ANALYSIS-0073     | GitCollector |                |
      | INFO | Cloning of Repository https://source-team.asg.com/scm/di/pythonanalyzerdemo.git                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-GIT-0003 |              |                |
      | INFO | Git collection initiated for branch refs/heads/PythonTest                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-GIT-0007 |              |                |
      | INFO | Branch name: refs/heads/PythonTest                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-GIT-0024 |              |                |
      | INFO | Plugin GitCollector Start Time:2020-01-31 17:20:45.373, End Time:2020-01-31 17:22:25.578, Processed Count:3, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0072     | GitCollector |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:01:40.205)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0020     |              |                |

  #6943593#
  @webtest @MLP-17108 @sanity @positive
  Scenario:SC1:Parsing the repository and validating the Python parser error messages in Log
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "CommonLinker" and clicks on search
    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "parser/PythonParser/PythonParser%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "parser/PythonParser/PythonParser%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | logCode       | pluginName   | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ANALYSIS-0019 |              |                |
      | INFO | Plugin Name:PythonParser, Plugin Type:parser, Plugin Version:10.3.0.SNAPSHOT, Node Name:LocalNode, Host Name:a0ec6a3de078, Plugin Configuration name:PythonParser                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0071 | PythonParser | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin PythonParser Configuration: ---2020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: name: "PythonParser"2020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: pluginVersion: "LATEST"2020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: label:2020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: : "PythonParser"2020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: catalogName: "Default"2020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: eventClass: null2020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: eventCondition: null2020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: nodeCondition: "name==\"LocalNode\""2020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: maxWorkSize: 1002020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: tags:2020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: - "CommonLinker"2020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: pluginType: parser2020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: dataSource: null2020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: credential: null2020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: businessApplicationName: "BA_PY"2020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: dryRun: false2020-09-08 15:58:14.519 INFO  - ANALYSIS-0073: Plugin PythonParser Configuration: schedule: null2020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: filter: null2020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: parallelWorkPollInterval: 602020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: parallelWorkBatchSize: 1002020-04-08 13:01:33.148 INFO - ANALYSIS-0073: Plugin PythonParser Configuration: parallelQueryBatchSize: 10000 | ANALYSIS-0073 | PythonParser |                |
      | INFO | Plugin PythonParser Start Time:2020-02-03 16:55:40.634, End Time:2020-02-03 16:55:41.897, Processed Count:46, Errors:4, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | ANALYSIS-0072 | PythonParser |                |
      | INFO | Found 0 sources to process in parallel in 0 batches                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0064 |              |                |
      | INFO | Plugin completed with errors (elapsed time in (HH:MM:SS.ms): 00:00:04.902)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0075 |              |                |

#6943594#
  @webtest @MLP-17108 @sanity @positive
  Scenario:SC1:Parsing the repository and validating the Package Linker messages in Log
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "CommonLinker" and clicks on search
    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "linker/PythonPackageLinker/Package_Linker/%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "linker/PythonPackageLinker/Package_Linker%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | logCode       | pluginName          | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | ANALYSIS-0019 |                     |                |
      | INFO | Plugin Name:PythonPackageLinker, Plugin Type:linker, Plugin Version:10.3.0.SNAPSHOT, Node Name:LocalNode, Host Name:bc10fd8866ef, Plugin Configuration name:Package_Linker                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0071 | PythonPackageLinker | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin PythonPackageLinker Configuration: ---2020-04-08 13:05:57.492 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: name: "Package_Linker"2020-04-08 13:05:57.492 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: pluginVersion: "LATEST"2020-04-08 13:05:57.492 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: label:2020-04-08 13:05:57.493 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: : "Package_Linker"2020-04-08 13:05:57.493 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: catalogName: "Default"2020-04-08 13:05:57.493 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: eventClass: null2020-04-08 13:05:57.493 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: eventCondition: null2020-04-08 13:05:57.493 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: nodeCondition: "name==\"LocalNode\""2020-04-08 13:05:57.493 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: maxWorkSize: 1002020-04-08 13:05:57.493 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: tags:2020-04-08 13:05:57.493 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: - "CommonLinker"2020-04-08 13:05:57.493 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: pluginType: linker2020-04-08 13:05:57.493 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: dataSource: null2020-04-08 13:05:57.493 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: credential: null2020-04-08 13:05:57.493 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: businessApplicationName: "BA_PY"2020-04-08 13:05:57.493 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: dryRun: false2020-09-08 15:58:41.196 INFO  - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: schedule: null2020-04-08 13:05:57.493 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: filter: null2020-04-08 13:05:57.493 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: parallelWorkPollInterval: 602020-04-08 13:05:57.493 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: parallelWorkBatchSize: 1002020-04-08 13:05:57.493 INFO - ANALYSIS-0073: Plugin PythonPackageLinker Configuration: parallelQueryBatchSize: 10000 | ANALYSIS-0073 | PythonPackageLinker |                |
      | INFO | Plugin PythonPackageLinker Start Time:2020-01-31 17:23:21.547, End Time:2020-01-31 17:23:27.286, Processed Count:50, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | ANALYSIS-0072 | PythonPackageLinker |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.739)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | ANALYSIS-0020 |                     |                |

   #6943594#
  @webtest @MLP-17108 @sanity @positive
  Scenario:SC1:Parsing the repository and validating the Python Linker messages in Log
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "CommonLinker" and clicks on search
    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "linker/PythonLinker/PythonLinker/%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "linker/PythonLinker/PythonLinker%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | logCode       | pluginName   | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | ANALYSIS-0019 |              |                |
      | INFO | Plugin Name:PythonLinker, Plugin Type:linker, Plugin Version:10.3.0.SNAPSHOT, Node Name:LocalNode, Host Name:bc10fd8866ef, Plugin Configuration name:PythonLinker                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0071 | PythonLinker | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin PythonLinker Configuration: ---2020-04-08 13:46:05.448 INFO - ANALYSIS-0073: Plugin PythonLinker Configuration: name: "PythonLinker"2020-04-08 13:46:05.448 INFO - ANALYSIS-0073: Plugin PythonLinker Configuration: pluginVersion: "LATEST"2020-04-08 13:46:05.448 INFO - ANALYSIS-0073: Plugin PythonLinker Configuration: label:2020-04-08 13:46:05.448 INFO - ANALYSIS-0073: Plugin PythonLinker Configuration: : ""2020-04-08 13:46:05.448 INFO - ANALYSIS-0073: Plugin PythonLinker Configuration: catalogName: "Default"2020-04-08 13:46:05.448 INFO - ANALYSIS-0073: Plugin PythonLinker Configuration: eventClass: null2020-04-08 13:46:05.448 INFO - ANALYSIS-0073: Plugin PythonLinker Configuration: eventCondition: null2020-04-08 13:46:05.448 INFO - ANALYSIS-0073: Plugin PythonLinker Configuration: nodeCondition: "name==\"LocalNode\""2020-04-08 13:46:05.448 INFO - ANALYSIS-0073: Plugin PythonLinker Configuration: maxWorkSize: 1002020-04-08 13:46:05.448 INFO - ANALYSIS-0073: Plugin PythonLinker Configuration: tags:2020-04-08 13:46:05.448 INFO - ANALYSIS-0073: Plugin PythonLinker Configuration: - "CommonLinker"2020-04-08 13:46:05.448 INFO - ANALYSIS-0073: Plugin PythonLinker Configuration: pluginType: linker2020-04-08 13:46:05.448 INFO - ANALYSIS-0073: Plugin PythonLinker Configuration: dataSource: null2020-04-08 13:46:05.448 INFO - ANALYSIS-0073: Plugin PythonLinker Configuration: credential: null2020-04-08 13:46:05.448 INFO - ANALYSIS-0073: Plugin PythonLinker Configuration: businessApplicationName: "BA_PY"2020-04-08 13:46:05.448 INFO - ANALYSIS-0073: Plugin PythonLinker Configuration: dryRun: false2020-09-08 15:59:07.763 INFO  - ANALYSIS-0073: Plugin PythonLinker Configuration: schedule: null2020-04-08 13:46:05.448 INFO - ANALYSIS-0073: Plugin PythonLinker Configuration: filter: null | ANALYSIS-0073 | PythonLinker |                |
      | INFO | Plugin PythonLinker Start Time:2020-01-31 17:23:49.412, End Time:2020-01-31 17:24:25.277, Processed Count:46, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0072 | PythonLinker |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:35.865)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | ANALYSIS-0020 |              |                |

          #      ####################################JUNK CHARECTOR VALIDATION############################################################################################

  #6689699#
  @webtest @MLP-13399 @sanity @positive
  Scenario:SC2:Parsing the repository and validating the Junk characters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "sample2" and clicks on search
    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table | value      | Action               | RetainPrevwindow | indexSwitch |
      | Data  | sample2.py | click and switch tab | No               |             |
    Then the "Data" metadata of item "sample2.py" should be as expected

          #      ####################################SUPERCLASS VALIDATION############################################################################################

# 6689699#
  @webtest @MLP-13399 @sanity @positive
  Scenario:SC3:Parsing the repository and validating the super classes2
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "CommonLinker" and clicks on search
    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "parser/PythonParser/PythonParser%"
    Then user performs click and verify in new window
      | Table           | value                                       | Action               | RetainPrevwindow | indexSwitch |
      | Processed Items | ClassDefinitionsWithSuperClassAndInitMethod | click and switch tab | No               |             |
      | Classes         | ClassDefinitionsWithSuperClassAndInitMethod | click and switch tab | No               |             |
      | Classes         | Student                                     | click and switch tab | No               |             |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | Student                                                     |
      | attributeName  | superClasses                                                |
      | actualFilePath | ida\CommonLinker\MetadataValidation\ActualSuperClasses.json |
    Then file content in "ida\CommonLinker\MetadataValidation\ActualSuperClasses.json" should be same as the content in "ida\CommonLinker\MetadataValidation\ExpectedSuperClasses.json"

              #      ####################################STATIC VARIABLE , CONSTANT AND RAW INVOKES VALIDATION############################################################################################

  #6689699#
  @webtest @MLP-13399 @sanity @positive
  Scenario:SC4:Parsing the repository and validating the static variable, constant strings and raw invokes
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "CommonLinker" and clicks on search
    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "parser/PythonParser/PythonParser%"
    Then user performs click and verify in new window
      | Table           | value                 | Action               | RetainPrevwindow | indexSwitch |
      | Processed Items | FunCallVardeclaration | click and switch tab | No               |             |
      | Classes         | FunCallVardeclaration | click and switch tab | No               |             |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | FunCallVardeclaration                                         |
      | attributeName  | staticVariable                                                |
      | actualFilePath | ida\CommonLinker\MetadataValidation\ActualstaticVariable.json |
    Then file content in "ida\CommonLinker\MetadataValidation\ActualstaticVariable.json" should be same as the content in "ida\CommonLinker\MetadataValidation\ExpectedstaticVariable.json"
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | FunCallVardeclaration                                         |
      | attributeName  | constantStrings                                               |
      | actualFilePath | ida\CommonLinker\MetadataValidation\ActualConstantString.json |
    Then file content in "ida\CommonLinker\MetadataValidation\ActualConstantString.json" should be same as the content in "ida\CommonLinker\MetadataValidation\ExpectedConstantString.json"
    Then user performs click and verify in new window
      | Table     | value     | Action               | RetainPrevwindow | indexSwitch |
      | Functions | factorial | click and switch tab | No               |             |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | factorial                                                 |
      | attributeName  | rawInvokes                                                |
      | actualFilePath | ida\CommonLinker\MetadataValidation\Actualrawinvokes.json |
    Then file content in "ida\CommonLinker\MetadataValidation\Actualrawinvokes.json" should be same as the content in "ida\CommonLinker\MetadataValidation\ExpectedRawinvokes.json"

          #      ####################################SINGLE AND MULTILINE COMMENT VALIDATION############################################################################################

#  #6689699#
  @webtest @MLP-13399 @sanity @positive
  Scenario:SC5:Parsing the repository and validating the single line and multiline comments
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "CommonLinker" and clicks on search
    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "parser/PythonParser/PythonParser%"
    Then user performs click and verify in new window
      | Table           | value              | Action               | RetainPrevwindow | indexSwitch |
      | Processed Items | FunctionDefinition | click and switch tab | No               |             |
      | Classes         | FunctionDefinition | click and switch tab | No               |             |
    Then the "Comments" metadata of item "FunctionDefinition" should be as expected
    Then user performs click and verify in new window
      | Table     | value    | Action               | RetainPrevwindow | indexSwitch |
      | Classes   | car      | click and switch tab | No               |             |
      | Functions | __init__ | click and switch tab | No               |             |
    Then the "Comments" metadata of item "__init__" should be as expected


              #      ####################################CLASS DEFINTIION VALIDATION############################################################################################

#6689699#7018624
  Scenario Outline:SC6:user get the Dynamic ID's (Class ID) for the file "ClassDefinitions"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive      | catalog | type  | name             | asg_scopeid | targetFile                                                             | jsonpath  |
      | APPDBPOSTGRES | SourceTreeID | Default | Class | ClassDefinitions |             | payloads\ida\CommonLinker\MetadataValidation\Func_inClass\itemIds.json | $.classID |
      | APPDBPOSTGRES | ClassinClass | Default | Class | Child            |             | payloads\ida\CommonLinker\MetadataValidation\Func_inClass\itemIds.json | $.child   |
      | APPDBPOSTGRES | ClassinClass | Default | Class | Parent           |             | payloads\ida\CommonLinker\MetadataValidation\Func_inClass\itemIds.json | $.parent  |

  Scenario Outline:SC6:user retrieves the class details of each datat type for a file "ClassDefinitions"
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                | responseCode | inputJson | inputFile                                                              | outPutFile                                                                   | outPutJson |
      | components/Default/item/Default.Function:::dynamic | 200          | $.classID | payloads\ida\CommonLinker\MetadataValidation\Func_inClass\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\Func_inClass\MultipleClass.json |            |
      | components/Default/item/Default.Function:::dynamic | 200          | $.child   | payloads\ida\CommonLinker\MetadataValidation\Func_inClass\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\Func_inClass\ChildClass.json    |            |
      | components/Default/item/Default.Function:::dynamic | 200          | $.parent  | payloads\ida\CommonLinker\MetadataValidation\Func_inClass\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\Func_inClass\ParentClass.json   |            |

  @MLP-13399 @sanity @positive @IDA_E2E
  Scenario Outline:SC6:Validate the functions inside classes for the file "ClassDefinitions"
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                                                            | actualValues                                                                 | valueType         | expectedJsonPath                                                  | actualJsonPath                                                                    |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Func_inClass\MultipleClass.json | stringListCompare | $..MetaData..sourceTreeName.ClassDefinitions.has_Class..ClassName | $..data.[0].data[?(@.caption=='Classes')].data.data[?(@.type=='Class')].name      |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Func_inClass\ChildClass.json    | stringListCompare | $..MetaData..sourceTreeName..Child.has_methods..Method            | $..data.[0].data[?(@.caption=='Functions')].data.data[?(@.type=='Function')].name |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Func_inClass\ParentClass.json   | stringListCompare | $..MetaData..sourceTreeName..Parent.has_methods..Method           | $..data.[0].data[?(@.caption=='Functions')].data.data[?(@.type=='Function')].name |


          #      ####################################CLASS INSIDE FUNCTION VALIDATION############################################################################################

  #6689699#7018630
  Scenario Outline:SC7:user get the Dynamic ID's (Class and Functions ID) for the file "ClassInsideFunction"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive      | catalog | type     | name                | asg_scopeid | targetFile                                                            | jsonpath     |
      | APPDBPOSTGRES | SourceTreeID | Default | Class    | ClassInsideFunction |             | payloads\ida\CommonLinker\MetadataValidation\Class_inFun\itemIds.json | $.classID1   |
      | APPDBPOSTGRES | SourceTreeID | Default | Function | func                |             | payloads\ida\CommonLinker\MetadataValidation\Class_inFun\itemIds.json | $.functionID |
      | APPDBPOSTGRES | SourceTreeID | Default | Class    | BindArgs            |             | payloads\ida\CommonLinker\MetadataValidation\Class_inFun\itemIds.json | $.classID2   |

  Scenario Outline:SC7:user retrieves the class details of each datat type for a file "ClassInsideFunction"
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                | responseCode | inputJson    | inputFile                                                             | outPutFile                                                                  | outPutJson |
      | components/Default/item/Default.Function:::dynamic | 200          | $.classID1   | payloads\ida\CommonLinker\MetadataValidation\Class_inFun\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\Class_inFun\MainClass.json     |            |
      | components/Default/item/Default.Function:::dynamic | 200          | $.functionID | payloads\ida\CommonLinker\MetadataValidation\Class_inFun\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\Class_inFun\FuncMethod.json    |            |
      | components/Default/item/Default.Function:::dynamic | 200          | $.classID2   | payloads\ida\CommonLinker\MetadataValidation\Class_inFun\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\Class_inFun\BindArgsClass.json |            |

  @MLP-13399 @sanity @positive @IDA_E2E
  Scenario Outline:SC7:Validate the classes inside functions for the file "ClassInsideFunction"
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                                                            | actualValues                                                                | valueType         | expectedJsonPath                                          | actualJsonPath                                                                    |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Class_inFun\MainClass.json     | stringListCompare | $..MetaData..ClassInsideFunction.has_methods.func.Method  | $..data.[0].data[?(@.caption=='Functions')].data.data[?(@.type=='Function')].name |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Class_inFun\FuncMethod.json    | stringListCompare | $..MetaData..sourceTreeName..BindArgs.ClassName           | $..data.[0].data[?(@.caption=='Classes')].data.data[?(@.type=='Class')].name      |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Class_inFun\BindArgsClass.json | stringListCompare | $..MetaData..sourceTreeName..BindArgs.has_methods..Method | $..data.[0].data[?(@.caption=='Functions')].data.data[?(@.type=='Function')].name |


          #      ####################################ERROR VALIDATION############################################################################################

  #6689699#
  Scenario Outline:SC8:user get the Dynamic ID's (Source ID) for the file "Error"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive      | catalog | type       | name  | asg_scopeid | targetFile                                                           | jsonpath       |
      | APPDBPOSTGRES | SourceTreeID | Default | SourceTree | error |             | payloads\ida\CommonLinker\MetadataValidation\ErrorClass\itemIds.json | $.SourceTreeID |

  Scenario Outline:SC8:user retrieves the error details of each datat type for a file "Error"
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                | responseCode | inputJson      | inputFile                                                            | outPutFile                                                              | outPutJson |
      | components/Default/item/Default.Function:::dynamic | 200          | $.SourceTreeID | payloads\ida\CommonLinker\MetadataValidation\ErrorClass\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\ErrorClass\ErrorClass.json |            |

  @MLP-13399 @sanity @positive @IDA_E2E
  Scenario Outline:SC8:Validate the repository and validating the error messages in metadata "Error"
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                                                            | actualValues                                                            | valueType     | expectedJsonPath                            | actualJsonPath                                                                |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\ErrorClass\ErrorClass.json | stringCompare | $..MetaData..sourceTreeName..Error.comments | $..data.[0].data[0].data.attributes.[?(@.caption=='errorDetails')].data.value |

          #      ####################################NUMBER OF IMPORT VALIDATION############################################################################################

  #6774130#
  Scenario Outline:SC9:user get the Dynamic ID's (Source ID) for the file "ImportStatement"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive      | catalog | type       | name            | asg_scopeid | targetFile                                                                  | jsonpath       |
      | APPDBPOSTGRES | SourceTreeID | Default | SourceTree | ImportStatement |             | payloads\ida\CommonLinker\MetadataValidation\RawImp_ImpNumbers\itemIds.json | $.SourceTreeID |

  Scenario Outline:SC9:user retrieves the raw imports of each datat type for a file "ImportStatement"
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                | responseCode | inputJson      | inputFile                                                                   | outPutFile                                                                         | outPutJson |
      | components/Default/item/Default.Function:::dynamic | 200          | $.SourceTreeID | payloads\ida\CommonLinker\MetadataValidation\RawImp_ImpNumbers\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\RawImp_ImpNumbers\rawImp_ImpNumb.json |            |


  @MLP-13399 @sanity @positive @IDA_E2E
  Scenario Outline:SC9:Validate the repository and validating the raw imports in metadata "ImportStatement"
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                                                            | actualValues                                                                       | valueType     | expectedJsonPath                                             | actualJsonPath                                                   |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\RawImp_ImpNumbers\rawImp_ImpNumb.json | stringCompare | $..MetaData..sourceTreeName..ImportStatement.RawImports      | $.data[0]..attributes.[?(@.caption=='rawImports')]..value        |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\RawImp_ImpNumbers\rawImp_ImpNumb.json | intCompare    | $..MetaData..sourceTreeName..ImportStatement.Numberofimports | $.data[0]..attributes.[?(@.caption=='Number of imports')]..value |


        #      ####################################EXTERNAL CLASS IMPORT VALIDATION############################################################################################

  ##  #6689699#7018625
  Scenario Outline:SC10:user get the Dynamic ID's (Source ID) for the file "sample1".
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive      | catalog | type       | name    | asg_scopeid | targetFile                                                        | jsonpath       |
      | APPDBPOSTGRES | SourceTreeID | Default | SourceTree | sample1 |             | payloads\ida\CommonLinker\MetadataValidation\NoError\itemIds.json | $.SourceTreeID |

  Scenario Outline:SC10:user retrieves the process items of each datat type for a file "sample1" to validate error
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                | responseCode | inputJson      | inputFile                                                         | outPutFile                                                        | outPutJson |
      | components/Default/item/Default.Function:::dynamic | 200          | $.SourceTreeID | payloads\ida\CommonLinker\MetadataValidation\NoError\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\NoError\NoError.json |            |

  @MLP-13399 @sanity @positive @IDA_E2E
  Scenario Outline:SC10:Validate the repository and validating the errors in python version 2 "sample1"
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                                                            | actualValues                                                                       | valueType     | expectedJsonPath                                  | actualJsonPath                                              |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\RawImp_ImpNumbers\rawImp_ImpNumb.json | stringCompare | $..MetaData..sourceTreeName..sample1.ErrorDetails | $.data[0]..attributes.[?(@.caption=='errorDetails')]..value |


      #      ####################################STATIC VARIABLE,CONSTANT STRINGS AND RAW INVOKES VALIDATION############################################################################################

   #6689699#
  @webtest @MLP-13399 @sanity @positive
  Scenario:SC11:Parsing the repository and validating the static variable, constant strings and raw invokes
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "CommonLinker" and clicks on search
    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "parser/PythonParser/PythonParser%"
    Then user performs click and verify in new window
      | Table           | value                 | Action               | RetainPrevwindow | indexSwitch |
      | Processed Items | FunCallVardeclaration | click and switch tab | No               |             |
      | Classes         | FunCallVardeclaration | click and switch tab | No               |             |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | FunCallVardeclaration                                         |
      | attributeName  | staticVariable                                                |
      | actualFilePath | ida\CommonLinker\MetadataValidation\ActualstaticVariable.json |
    Then file content in "ida\CommonLinker\MetadataValidation\ActualstaticVariable.json" should be same as the content in "ida\CommonLinker\MetadataValidation\ExpectedstaticVariable.json"

          #      ####################################RAW IMPORT VALIDATION############################################################################################

##  #6689699#
  Scenario Outline:SC12:user get the Dynamic ID's (Source ID) for the file "boo,boo1,boo2,boo3,boo4"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive      | catalog | type       | name        | asg_scopeid        | targetFile                                                                   | jsonpath                                     |
      | APPDBPOSTGRES | ID           | Default | SourceTree | boo         |                    | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\itemIds.json        | $.booSourceTreeID                            |
      | APPDBPOSTGRES | ID           | Default | SourceTree | boo1        |                    | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\itemIds.json        | $.boo1SourceTreeID                           |
      | APPDBPOSTGRES | ID           | Default | SourceTree | boo2        |                    | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\itemIds.json        | $.boo2SourceTreeID                           |
      | APPDBPOSTGRES | ID           | Default | SourceTree | boo3        |                    | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\itemIds.json        | $.boo3SourceTreeID                           |
      | APPDBPOSTGRES | ID           | Default | SourceTree | boo4        |                    | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\itemIds.json        | $.boo4SourceTreeID                           |
      | APPDBPOSTGRES | ID           | Default | Directory  | simple      |                    | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\itemIds.json        | $.simple.Directory                           |
      | APPDBPOSTGRES | JsonIDUpdate | Default | File       | __init__.py | $.simple.Directory | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\itemIds.json        | $.simple.boo.__init__                        |
      | APPDBPOSTGRES | JsonIDUpdate | Default | SourceTree | __init__    |                    | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\rawinvokesBoo.json  | $..resolved[*]                               |
      | APPDBPOSTGRES | JsonIDUpdate | Default | SourceTree | __init__    |                    | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\rawinvokesBoo2.json | $..resolved[*]                               |
      | APPDBPOSTGRES | ID           | Default | Directory  | simple      |                    | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\itemIds.json        | $.simple.Directory                           |
      | APPDBPOSTGRES | JsonIDUpdate | Default | File       | foo.py      | $.simple.Directory | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\itemIds.json        | $.level1.foo.id                              |
      | APPDBPOSTGRES | JsonIDUpdate | Default | SourceTree | foo         |                    | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\rawinvokesBoo1.json | $..[?(@.name=='..foo.*')].resolved[*]        |
      | APPDBPOSTGRES | JsonIDUpdate | Default | File       | soo.py      | $.simple.Directory | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\itemIds.json        | $.level1.soo.id                              |
      | APPDBPOSTGRES | JsonIDUpdate | Default | SourceTree | soo         |                    | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\rawinvokesBoo1.json | $..[?(@.name=='..soo.SooClass')].resolved[*] |
      | APPDBPOSTGRES | JsonIDUpdate | Default | SourceTree | soo         |                    | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\rawinvokesBoo1.json | $..[?(@.name=='...soo.soo')].resolved[*]     |
      | APPDBPOSTGRES | JsonIDUpdate | Default | File       | doo.py      | $.simple.Directory | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\itemIds.json        | $.level1.doo.id                              |
      | APPDBPOSTGRES | JsonIDUpdate | Default | SourceTree | doo         |                    | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\rawinvokesBoo3.json | $..resolved[*]                               |
      | APPDBPOSTGRES | JsonIDUpdate | Default | SourceTree | doo         |                    | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\rawinvokesBoo4.json | $..resolved[*]                               |

    #7018629
  @webtest   @MLP-13399 @sanity @positive
  Scenario:SC12:Compare the raw invoked of the sourceTree Boo, Boo2 , Boo3 and Boo4
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "boo" and clicks on search
    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | boo                                                                      |
      | attributeName  | rawImports                                                               |
      | actualFilePath | ida\CommonLinker\MetadataValidation\ExtClassImp\ActualrawinvokesBoo.json |
    Then file content in "ida\CommonLinker\MetadataValidation\ExtClassImp\ActualrawinvokesBoo.json" should be same as the content in "ida\CommonLinker\MetadataValidation\ExtClassImp\rawinvokesBoo.json"
    And user enters the search text "boo1" and clicks on search
    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | boo1                                                                      |
      | attributeName  | rawImports                                                                |
      | actualFilePath | ida\CommonLinker\MetadataValidation\ExtClassImp\ActualrawinvokesBoo1.json |
    Then file content in "ida\CommonLinker\MetadataValidation\ExtClassImp\ActualrawinvokesBoo1.json" should be same as the content in "ida\CommonLinker\MetadataValidation\ExtClassImp\rawinvokesBoo1.json"
    And user enters the search text "boo2" and clicks on search
    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | boo2                                                                      |
      | attributeName  | rawImports                                                                |
      | actualFilePath | ida\CommonLinker\MetadataValidation\ExtClassImp\ActualrawinvokesBoo2.json |
    Then file content in "ida\CommonLinker\MetadataValidation\ExtClassImp\ActualrawinvokesBoo2.json" should be same as the content in "ida\CommonLinker\MetadataValidation\ExtClassImp\rawinvokesBoo2.json"
    And user enters the search text "boo3" and clicks on search
    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | boo3                                                                      |
      | attributeName  | rawImports                                                                |
      | actualFilePath | ida\CommonLinker\MetadataValidation\ExtClassImp\ActualrawinvokesBoo3.json |
    Then file content in "ida\CommonLinker\MetadataValidation\ExtClassImp\ActualrawinvokesBoo3.json" should be same as the content in "ida\CommonLinker\MetadataValidation\ExtClassImp\rawinvokesBoo3.json"
    And user enters the search text "boo4" and clicks on search
    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | boo4                                                                      |
      | attributeName  | rawImports                                                                |
      | actualFilePath | ida\CommonLinker\MetadataValidation\ExtClassImp\ActualrawinvokesBoo4.json |
    Then file content in "ida\CommonLinker\MetadataValidation\ExtClassImp\ActualrawinvokesBoo4.json" should be same as the content in "ida\CommonLinker\MetadataValidation\ExtClassImp\rawinvokesBoo4.json"


  Scenario Outline:SC12:user retrieves the process items of each datat type for a file "boo,boo1,boo2,boo3,boo4"
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                | responseCode | inputJson          | inputFile                                                             | outPutFile                                                         | outPutJson |
      | components/Default/item/Default.Function:::dynamic | 200          | $.booSourceTreeID  | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\boo.json  |            |
      | components/Default/item/Default.Function:::dynamic | 200          | $.boo1SourceTreeID | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\boo1.json |            |
      | components/Default/item/Default.Function:::dynamic | 200          | $.boo2SourceTreeID | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\boo2.json |            |
      | components/Default/item/Default.Function:::dynamic | 200          | $.boo3SourceTreeID | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\boo3.json |            |
      | components/Default/item/Default.Function:::dynamic | 200          | $.boo4SourceTreeID | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\boo4.json |            |

  @MLP-13399 @sanity @positive @IDA_E2E
  Scenario Outline:SC12:Validate the repository and validating number of imports in python version 2 "boo,boo1,boo2,boo3,boo4"
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                                                            | actualValues                                                       | valueType         | expectedJsonPath                                     | actualJsonPath                                                   |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\boo.json  | stringCompare     | $..MetaData..sourceTreeName..boo.Has_Import..value   | $.data[0]..[?(@.caption=='imports')]..data.data..name            |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\boo.json  | intCompare        | $..MetaData..sourceTreeName..boo.Number_of_Imports   | $.data[0]..attributes.[?(@.caption=='Number of imports')]..value |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\boo1.json | stringListCompare | $..MetaData..sourceTreeName..boo1..Has_Import..value | $.data[0]..[?(@.caption=='imports')]..data.data..name            |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\boo1.json | intCompare        | $..MetaData..sourceTreeName..boo1.Number_of_Imports  | $.data[0]..attributes.[?(@.caption=='Number of imports')]..value |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\boo2.json | stringCompare     | $..MetaData..sourceTreeName..boo2.Has_Import..value  | $.data[0]..[?(@.caption=='imports')]..data.data..name            |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\boo2.json | intCompare        | $..MetaData..sourceTreeName..boo2.Number_of_Imports  | $.data[0]..attributes.[?(@.caption=='Number of imports')]..value |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\boo3.json | stringCompare     | $..MetaData..sourceTreeName..boo3.Has_Import..value  | $.data[0]..[?(@.caption=='imports')]..data.data..name            |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\boo3.json | intCompare        | $..MetaData..sourceTreeName..boo3.Number_of_Imports  | $.data[0]..attributes.[?(@.caption=='Number of imports')]..value |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\boo4.json | stringCompare     | $..MetaData..sourceTreeName..boo4.Has_Import..value  | $.data[0]..[?(@.caption=='imports')]..data.data..name            |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\ExtClassImp\boo4.json | intCompare        | $..MetaData..sourceTreeName..boo4.Number_of_Imports  | $.data[0]..attributes.[?(@.caption=='Number of imports')]..value |


    #      ####################################EXTERNAL CLASS IMPORT############################################################################################

##  #6689699#
  Scenario Outline:SC13:user get the Dynamic ID's (Source ID) for the file "sample1"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive      | catalog | type       | name    | asg_scopeid | targetFile                                                           | jsonpath              |
      | APPDBPOSTGRES | SourceTreeID | Default | SourceTree | sample1 |             | payloads\ida\CommonLinker\MetadataValidation\Ext_Import\itemIds.json | $.Sample1SourceTreeID |
      | APPDBPOSTGRES | SourceTreeID | Default | SourceTree | sample2 |             | payloads\ida\CommonLinker\MetadataValidation\Ext_Import\itemIds.json | $.Sample2SourceTreeID |

  Scenario Outline:SC13:user retrieves the process items of each datat type for a file "sample1"
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                | responseCode | inputJson             | inputFile                                                            | outPutFile                                                           | outPutJson |
      | components/Default/item/Default.Function:::dynamic | 200          | $.Sample1SourceTreeID | payloads\ida\CommonLinker\MetadataValidation\Ext_Import\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\Ext_Import\sample1.json |            |
      | components/Default/item/Default.Function:::dynamic | 200          | $.Sample2SourceTreeID | payloads\ida\CommonLinker\MetadataValidation\Ext_Import\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\Ext_Import\sample2.json |            |


  @MLP-13399 @sanity @positive @IDA_E2E
  Scenario Outline:SC13:Validate the repository and validating external class import functionality when the implimentation is not available "sample1"
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                                                            | actualValues                                                         | valueType     | expectedJsonPath                                       | actualJsonPath                                                               |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Ext_Import\sample1.json | stringCompare | $..MetaData..sourceTreeName..sample1.ClassName         | $..data.[0].data[?(@.caption=='Classes')].data.data[?(@.type=='Class')].name |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Ext_Import\sample1.json | stringCompare | $..MetaData..sourceTreeName..sample1.Has_Import..value | $.data[0]..[?(@.caption=='imports')]..data.data..name                        |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Ext_Import\sample2.json | stringCompare | $..MetaData..sourceTreeName..sample2.Raw_Imports       | $.data[0]..attributes.[?(@.caption=='rawImports')]..value                    |


    #      ####################################PACKAGE LIKER VALIDATION############################################################################################

  ##  #6689699#
  Scenario Outline:SC14:user get the Dynamic ID's (Analysis ID) for the file "AssertStatementwithError"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type     | name                  | asg_scopeid | targetFile                                                              | jsonpath     |
      | APPDBPOSTGRES | AnalysisID | Default | Analysis | %PythonPackageLinker% |             | payloads\ida\CommonLinker\MetadataValidation\PackageLinker\itemIds.json | $.AnalysisID |


  Scenario Outline:SC14:user retrieves the process items of each datat type for a file "AssertStatementwithError"
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                | responseCode | inputJson    | inputFile                                                               | outPutFile                                                                            | outPutJson |
      | components/Default/item/Default.Function:::dynamic | 200          | $.AnalysisID | payloads\ida\CommonLinker\MetadataValidation\PackageLinker\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\PackageLinker\PackageLinkerAnalysis.json |            |

  @MLP-13399 @sanity @positive @IDA_E2E
  Scenario Outline:SC14:Validate the package linker plugin and check for the processed items "AssertStatementwithError"
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                                                            | actualValues                                                                          | valueType     | expectedJsonPath                                     | actualJsonPath                                                                                           |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\PackageLinker\PackageLinkerAnalysis.json | stringCompare | $..Analysis..PackageLinker..ProcessedItems..value    | $.data[0].data[?(@.caption=='Processed Items')].data.data[?(@.name=='AssertStatementwithError.py')].name |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\PackageLinker\PackageLinkerAnalysis.json | stringCompare | $..Analysis..PackageLinker..Number_of_ProcessedItems | $..data[0].data[0].data.attributes.[?(@.caption=='Number of processed items')]..value                    |


  #      ####################################PYTHON LIKER VALIDATION############################################################################################

##  #6689699#
  Scenario Outline:SC15:user get the Dynamic ID's (Class and Function ID) for the file "boo2"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive    | catalog | type     | name                | asg_scopeid | targetFile                                                            | jsonpath     |
      | APPDBPOSTGRES | ClassID    | Default | Class    | boo2                |             | payloads\ida\CommonLinker\MetadataValidation\usesSection\itemIds.json | $.classID    |
      | APPDBPOSTGRES | FunctionID | Default | Function | testRelativeImports |             | payloads\ida\CommonLinker\MetadataValidation\usesSection\itemIds.json | $.functionID |

  Scenario Outline:SC15:user retrieves the metadata of each datat type for a catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                | responseCode | inputJson    | inputFile                                                             | outPutFile                                                                             | outPutJson |
      | components/Default/item/Default.Function:::dynamic | 200          | $.functionID | payloads\ida\CommonLinker\MetadataValidation\usesSection\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\usesSection\testRelativeImports_func.json |            |

  @MLP-13399 @sanity @positive @IDA_E2E
  Scenario Outline:SC15:Validate the use case linker plugin and check whether the USES table "boo2"
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                                                            | actualValues                                                                           | valueType         | expectedJsonPath                                   | actualJsonPath                                                                |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\usesSection\testRelativeImports_func.json | stringListCompare | $..MetaData..sourceTreeName..boo2..has_uses..value | $..data.[0].data[?(@.caption=='uses')].data.data[?(@.type=='Function')]..name |


  #      ####################################RawImports and Import Widget validation ############################################################################################
#Bug-ID-21936
##  #6689699#
  Scenario Outline:SC16:user get the Dynamic ID's (NameSpace) for the file "simple"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type      | name                               | asg_scopeid | targetFile                                                                     | jsonpath                                         |
      | APPDBPOSTGRES | NameSpaceID | Default | Namespace | simple                             |             | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\itemIds.json | $.nameSpaceID_simple                             |
      | APPDBPOSTGRES | NameSpaceID | Default | Namespace | simple.doo                         |             | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\itemIds.json | $.nameSpaceID_simple-doo                         |
      | APPDBPOSTGRES | NameSpaceID | Default | Namespace | simple.foo                         |             | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\itemIds.json | $.nameSpaceID_simple-foo                         |
      | APPDBPOSTGRES | NameSpaceID | Default | Namespace | simple.soo                         |             | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\itemIds.json | $.nameSpaceID_simple-soo                         |
      | APPDBPOSTGRES | NameSpaceID | Default | Namespace | simple.level1                      |             | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\itemIds.json | $.nameSpaceID_simple-level1                      |
      | APPDBPOSTGRES | NameSpaceID | Default | Namespace | simple.level2                      |             | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\itemIds.json | $.nameSpaceID_simple-level2                      |
      | APPDBPOSTGRES | NameSpaceID | Default | Namespace | simple.level1.level1_1             |             | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\itemIds.json | $.nameSpaceID_simple-level1-level1_1             |
      | APPDBPOSTGRES | NameSpaceID | Default | Namespace | simple.level1.level1_1.level1_1doo |             | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\itemIds.json | $.nameSpaceID_simple-level1-level1_1-level1_1doo |
      | APPDBPOSTGRES | NameSpaceID | Default | Namespace | simple.level2.goo                  |             | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\itemIds.json | $.nameSpaceID_simple_level2_goo                  |


  Scenario Outline:SC16:user retrieves the Namespace of the structure "simple"
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                | responseCode | inputJson                                        | inputFile                                                                      | outPutFile                                                                                       | outPutJson |
      | components/Default/item/Default.Function:::dynamic | 200          | $.nameSpaceID_simple                             | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple_namespace.json          |            |
      | components/Default/item/Default.Function:::dynamic | 200          | $.nameSpaceID_simple-doo                         | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple-doo.json                |            |
      | components/Default/item/Default.Function:::dynamic | 200          | $.nameSpaceID_simple-foo                         | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple-foo.json                |            |
      | components/Default/item/Default.Function:::dynamic | 200          | $.nameSpaceID_simple-soo                         | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple-soo.json                |            |
      | components/Default/item/Default.Function:::dynamic | 200          | $.nameSpaceID_simple-level1                      | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple-level1.json             |            |
      | components/Default/item/Default.Function:::dynamic | 200          | $.nameSpaceID_simple-level2                      | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple-level2.json             |            |
      | components/Default/item/Default.Function:::dynamic | 200          | $.nameSpaceID_simple-level1-level1_1             | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple-level1-level1_1.json    |            |
      | components/Default/item/Default.Function:::dynamic | 200          | $.nameSpaceID_simple-level1-level1_1-level1_1doo | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple-level1-level1_1doo.json |            |
      | components/Default/item/Default.Function:::dynamic | 200          | $.nameSpaceID_simple_level2_goo                  | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\itemIds.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple-level2-goo.json         |            |


#  #6689699#
  @MLP-13399 @sanity @positive @IDA_E2E
  Scenario Outline:SC16:Validate the Namespace generated are valid as expected "simple"
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                                                            | actualValues                                                                                     | valueType         | expectedJsonPath                                                                           | actualJsonPath                                                  |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple_namespace.json          | stringListCompare | $..Namespaces.has_namespaces.parent..parent_nameSpace.value                                | $..data.[0].data[?(@.caption=='has_Namespace')].data.data..name |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple_namespace.json          | stringCompare     | $..Namespaces.has_namespaces.sources..value                                                | $..data.[0].data[?(@.caption=='sources')].data.data..name       |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple-doo.json                | stringCompare     | $..Namespaces.has_namespaces..parent..sources.doo.value                                    | $..data.[0].data[?(@.caption=='sources')].data.data..name       |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple-foo.json                | stringCompare     | $..Namespaces.has_namespaces..parent..sources.foo.value                                    | $..data.[0].data[?(@.caption=='sources')].data.data..name       |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple-soo.json                | stringCompare     | $..Namespaces.has_namespaces..parent..sources.soo.value                                    | $..data.[0].data[?(@.caption=='sources')].data.data..name       |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple-level1.json             | stringListCompare | $..Namespaces.has_namespaces..parent..simple_level1.has_namespaces..child_nameSpace..value | $..data.[0].data[?(@.caption=='has_Namespace')].data.data..name |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple-level1.json             | stringCompare     | $..Namespaces.has_namespaces..parent..simple_level1.sources..value                         | $..data.[0].data[?(@.caption=='sources')].data.data..name       |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple-level1-level1_1.json    | stringCompare     | $..Namespaces.has_namespaces..parent..simple_level1_level1_1.sources..value                | $..data.[0].data[?(@.caption=='sources')].data.data..name       |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple-level1-level1_1.json    | stringCompare     | $..Namespaces.has_namespaces..parent..simple_level1_level1_1..has_namespaces.value         | $..data.[0].data[?(@.caption=='has_Namespace')].data.data..name |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple-level1-level1_1doo.json | stringCompare     | $..Namespaces.has_namespaces..parent..simple_level1_level1_1.has_namespaces.sources..value | $..data.[0].data[?(@.caption=='sources')].data.data..name       |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple-level2.json             | stringCompare     | $..Namespaces.has_namespaces..parent..simple_level2.has_namespaces..child_nameSpace..value | $..data.[0].data[?(@.caption=='has_Namespace')].data.data..name |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple-level2.json             | stringCompare     | $..Namespaces.has_namespaces..parent..simple_level2.sources..value                         | $..data.[0].data[?(@.caption=='sources')].data.data..name       |
      | payloads\ida\CommonLinker\MetadataValidation\Comments_Validation\CommonLinkerMetadataValues_Expected.json | payloads\ida\CommonLinker\MetadataValidation\Namespace_validation\simple-level2-goo.json         | stringCompare     | $..Namespaces.has_namespaces..parent..simple_level2.has_namespaces.sources..value          | $..data.[0].data[?(@.caption=='sources')].data.data..name       |

#
#  #      ####################################EDI Bus VALIDATION############################################################################################

  ##Bug ID-20962 ,MLP-21462
#  @edibus @positive @webtest @regression @sanity
#  Scenario:SC17:MLP-12574 Verify replication of Python items to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "CommonLinker" and clicks on search
#    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Python" attribute under "Tags" facets in Item Search results page
#    And user "verify displayed" for listed "Metadata Type" facet in Search results page
#      | ItemType   |
#      | File       |
#      | Function   |
#      | SourceTree |
#      | Directory  |
#      | Class      |
#      | Namespace  |
#      | Project    |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | COMMON      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "ida/CommonLinker/EDIBusPython_CommonLinker_Config.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                            | body                                                   | response code | response message | jsonPath                                                       |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                      | ida/CommonLinker/EDIBusPython_CommonLinker_Config.json | 204           |                  |                                                                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusPython_CommonLinker |                                                        | 200           | IDLE             | $.[?(@.configurationName=='EDIBusPython_CommonLinker')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusPython_CommonLinker  |                                                        | 200           |                  |                                                                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusPython_CommonLinker |                                                        | 200           | IDLE             | $.[?(@.configurationName=='EDIBusPython_CommonLinker')].status |
#    And user enters the search text "EDIBusPython_CommonLinker" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusPython_CommonLinker%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user enters the search text "CommonLinker" and clicks on search
#    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Python" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Project" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
#      | AP-DATA      | COMMON      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE_SYSTEM ) |
#    And user enters the search text "CommonLinker" and clicks on search
#    And user performs "facet selection" in "Python" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | COMMON      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) |
#    And configure a new REST API for the service "IDC"
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user update the json file "ida/CommonLinker/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                    |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Programming/Python |
#      | $..selections.['type_s'][*]                   | File                                          |
#    And supply payload with file name "ida/CommonLinker/TagFilter.json"
#    And user makes a REST Call for POST request with url "searches/fulltext/Default?query=CommonLinker&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1"
#    And Status code 200 must be returned
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | COMMON      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) |
#    And user enters the search text "CommonLinker" and clicks on search
#    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Python" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | COMMON      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_METHOD ) |
#    And configure a new REST API for the service "IDC"
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user update the json file "ida/CommonLinker/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                    |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Programming/Python |
#      | $..selections.['type_s'][*]                   | Function                                      |
#    And supply payload with file name "ida/CommonLinker/TagFilter.json"
#    And user makes a REST Call for POST request with url "searches/fulltext/Default?query=CommonLinker&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1"
#    And Status code 200 must be returned
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | COMMON      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_METHOD ) |
#    And user enters the search text "CommonLinker" and clicks on search
#    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Python" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "SourceTree" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                     |
#      | AP-DATA      | COMMON      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_PACKAGE ) |
#    And user enters the search text "CommonLinker" and clicks on search
#    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Python" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | COMMON      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_CLASS ) |
#    And configure a new REST API for the service "IDC"
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user update the json file "ida/CommonLinker/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                    |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Programming/Python |
#      | $..selections.['type_s'][*]                   | Class                                         |
#    And supply payload with file name "ida/CommonLinker/TagFilter.json"
#    And user makes a REST Call for POST request with url "searches/fulltext/Default?query=CommonLinker&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1"
#    And Status code 200 must be returned
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | COMMON      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_CLASS ) |
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
#      | AP-DATA      | COMMON      | 1.0                | (XNAME * *  ~/ @*PYTHON≫DEFAULT≫DWR_DAT_FILE≫@* ),AND,( INSTCFGCNT = 0 )    |
#      | AP-DATA      | COMMON      | 1.0                | (XNAME * *  ~/ @*PYTHON≫DEFAULT≫DWR_OOP_CLASS≫@* ),AND,( INSTCFGCNT = 0 )   |
#      | AP-DATA      | COMMON      | 1.0                | (XNAME * *  ~/ @*PYTHON≫DEFAULT≫DWR_OOP_METHOD≫@* ),AND,( INSTCFGCNT = 0 )  |
#      | AP-DATA      | COMMON      | 1.0                | (XNAME * *  ~/ @*PYTHON≫DEFAULT≫DWR_OOP_PACKAGE≫@* ),AND,( INSTCFGCNT = 0 ) |


#      ####################################TECHNOLOGY and BUSSINESS TAG VALIDATION############################################################################################

  @webtest @1400 @sanity @positive @regression
  Scenario:SC18:Verification of the Unstructured plugin along with Gitcollector plugin
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CommonLinker" and clicks on search
    And user performs "facet selection" in "CommonLinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Git,CommonLinker,BA_PY" should get displayed for the column "collector/GitCollector"
    Then the following tags "Python,CommonLinker,BA_PY" should get displayed for the column "parser/PythonParser/PythonParser"
    Then the following tags "Python,CommonLinker,BA_PY" should get displayed for the column "linker/PythonLinker/PythonLinker"
    Then the following tags "Python,CommonLinker,BA_PY" should get displayed for the column "linker/PythonPackageLinker/Package_Linker"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name            | facet         | Tag                           | fileName                      | userTag      |
      | Default     | Directory       | Metadata Type | Git,CommonLinker,BA_PY        | simple                        | CommonLinker |
      | Default     | Function        | Metadata Type | Python,CommonLinker,BA_PY     | foo                           | CommonLinker |
      | Default     | Class           | Metadata Type | Python,CommonLinker,BA_PY     | IfStatement                   | CommonLinker |
      | Default     | File            | Metadata Type | Git,Python,CommonLinker,BA_PY | goo.py                        | CommonLinker |
      | Default     | Namespace       | Metadata Type | Python,CommonLinker,BA_PY     | simple.doo                    | CommonLinker |
      | Default     | ExternalPackage | Metadata Type | Python,CommonLinker,BA_PY     | WhileStatement.WhileStatement | CommonLinker |



    #      ####################################DELETE ALL THE ITEMS############################################################################################

  @MLP-10467 @sanity @positive
  Scenario:SC19:Delete all the External Packages , BusinessApplication and anlysis with respect to commonlinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                       | type                | query | param |
      | MultipleIDDelete | Default |                                            | ExternalPackage     |       |       |
      | MultipleIDDelete | Default | collector/GitCollector/GitCollector/%      | Analysis            |       |       |
      | MultipleIDDelete | Default | parser/PythonParser/PythonParser%          | Analysis            |       |       |
      | MultipleIDDelete | Default | linker/PythonPackageLinker/Package_Linker% | Analysis            |       |       |
      | MultipleIDDelete | Default | linker/PythonLinker/PythonLinker%          | Analysis            |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBusPython_CommonLinker%     | Analysis            |       |       |
      | MultipleIDDelete | Default | pythonanalyzerdemo                         | Project             |       |       |
      | MultipleIDDelete | Default | BA_PY                                      | BusinessApplication |       |       |

  Scenario Outline:SC20:Delete Plugin configurations for Git , Python Parser , Package Linker and Python Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                       | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollector           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonParser           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonPackageLinker    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonLinker           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/SampleCredentialsgit |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource |      | 204           |                  |          |


#      ####################################DRY RUN VALIDATION############################################################################################

  @MLP-13399 @sanity @positive @regression @IDA_E2E
  Scenario Outline: Precondition:Set the Datasource and credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                       | body                                      | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/SampleCredentialsgit | ida/CommonLinker/GitCredentials.json      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource | ida/CommonLinker/gitDatasourceConfig.json | 204           |                  |          |

 #6925231
  @webtest @MLP-10467 @sanity @positive
  Scenario: DryRunSC#1:Verify Source tree is generating for Python parser plugin in IDC UI when dry run field is set as False
    Then Execute REST API with following parameters
      | Header           | Query | Param | type | url                                       | body                                         | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource | ida/CommonLinker/Dry_Run/git_DataSource.json | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                              | 200           |                  |          |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                       | body                                          | response code | response message | jsonPath                                          |
      |        |       |       | Put          | settings/analyzers/GitCollector                                           | ida/CommonLinker/Dry_Run/gitSpark_Config.json | 204           |                  |                                                   |
      |        |       |       | Get          | settings/analyzers/GitCollector                                           |                                               | 200           |                  |                                                   |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  |                                               | 200           |                  |                                                   |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                                               | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
    And user "update" the json file "ida/CommonLinker/Dry_Run/ParserDryRun_Config.json" file for following values
      | jsonPath  | jsonValues |
      | $..dryRun | true       |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                    | body                                              | response code | response message | jsonPath                                          |
      |        |       |       | Put          | settings/analyzers/PythonParser                                        | ida/CommonLinker/Dry_Run/ParserDryRun_Config.json | 204           |                  |                                                   |
      |        |       |       | Get          | settings/analyzers/PythonParser                                        |                                                   | 200           | PythonParser     |                                                   |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser |                                                   | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser  |                                                   | 200           |                  |                                                   |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser |                                                   | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "DryRun_commonlinker" and clicks on search
    And user performs "facet selection" in "DryRun_commonlinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify not displayed" for listed "Type" facet in Search results page
      | ItemType   |
      | Class      |
      | Function   |
      | SourceTree |


  @webtest @MLP-10467 @sanity @positive
  Scenario:DryRunSC#2:Verify Source tree is generating for Python package plugin in IDC UI when dry run field is set as False
    And user "update" the json file "ida/CommonLinker/Dry_Run/ParserDryRun_Config.json" file for following values
      | jsonPath  | jsonValues |
      | $..dryRun | false      |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                              | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/PythonParser                                        | ida/CommonLinker/Dry_Run/ParserDryRun_Config.json | 204           |                  |                                                   |
      |                  |       |       | Get          | settings/analyzers/PythonParser                                        |                                                   | 200           | PythonParser     |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser |                                                   | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser  | ida/CommonLinker/Dry_Run/empty.json               | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser |                                                   | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status |
    And user "update" the json file "ida/CommonLinker/Dry_Run/PackageLinkerDryRun_Config.json" file for following values
      | jsonPath  | jsonValues |
      | $..dryRun | true       |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                             | body                                                     | response code | response message | jsonPath                                            |
      |        |       |       | Put          | settings/analyzers/PythonPackageLinker                                          | ida/CommonLinker/Dry_Run/PackageLinkerDryRun_Config.json | 204           |                  |                                                     |
      |        |       |       | Get          | settings/analyzers/PythonPackageLinker                                          |                                                          | 200           | Package_Linker   |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/Package_Linker |                                                          | 200           | IDLE             | $.[?(@.configurationName=='Package_Linker')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/linker/PythonPackageLinker/Package_Linker  | ida/CommonLinker/Dry_Run/empty.json                      | 200           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/Package_Linker |                                                          | 200           | IDLE             | $.[?(@.configurationName=='Package_Linker')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "DryRun_commonlinker" and clicks on search
    And user performs "facet selection" in "DryRun_commonlinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify not displayed" for listed "Type" facet in Search results page
      | ItemType  |
      | Namespace |

  @webtest @MLP-10467 @sanity @positive
  Scenario:DryRunSC#3:Verify Source tree is generating for Python linker plugin in IDC UI when dry run field is set as False
    And user "update" the json file "ida/CommonLinker/Dry_Run/PackageLinkerDryRun_Config.json" file for following values
      | jsonPath  | jsonValues |
      | $..dryRun | false      |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body                                                     | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/PythonPackageLinker                                          | ida/CommonLinker/Dry_Run/PackageLinkerDryRun_Config.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/PythonPackageLinker                                          |                                                          | 200           | Package_Linker   |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/Package_Linker |                                                          | 200           | IDLE             | $.[?(@.configurationName=='Package_Linker')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/linker/PythonPackageLinker/Package_Linker  | ida/CommonLinker/Dry_Run/empty.json                      | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/Package_Linker |                                                          | 200           | IDLE             | $.[?(@.configurationName=='Package_Linker')].status |
    And user "update" the json file "ida/CommonLinker/Dry_Run/PythonLinkerDryRun_Config.json" file for following values
      | jsonPath  | jsonValues |
      | $..dryRun | true       |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                    | body                                                    | response code | response message | jsonPath                                          |
      |        |       |       | Put          | settings/analyzers/PythonLinker                                        | ida/CommonLinker/Dry_Run/PythonLinkerDryRun_Config.json | 204           |                  |                                                   |
      |        |       |       | Get          | settings/analyzers/PythonLinker                                        |                                                         | 200           | PythonLinker     |                                                   |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonLinker/PythonLinker |                                                         | 200           | IDLE             | $.[?(@.configurationName=='PythonLinker')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/linker/PythonLinker/PythonLinker  | ida/CommonLinker/Dry_Run/empty.json                     | 200           |                  |                                                   |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonLinker/PythonLinker |                                                         | 200           | IDLE             | $.[?(@.configurationName=='PythonLinker')].status |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "DryRun_commonlinker" and clicks on search
    And user performs "facet selection" in "DryRun_commonlinker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify not displayed" for listed "Type" facet in Search results page
      | ItemType        |
      | ExternalPackage |


  Scenario Outline:DryRunSC#4:Delete catalog and Plugin configurations for Git , Python Parser , Package Linker and Python Linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                       | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollector           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonParser           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonPackageLinker    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonLinker           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/SampleCredentialsgit |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource |      | 204           |                  |          |


  @MLP-10467 @sanity @positive
  Scenario:DryRunSC#5:Delete all the External Packages and anlysis with respect to commonlinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                       | type            | query | param |
      | MultipleIDDelete | Default |                                            | ExternalPackage |       |       |
      | SingleItemDelete | Default | collector/GitCollector/GitCollector/%      | Analysis        |       |       |
      | SingleItemDelete | Default | parser/PythonParser/PythonParser%          | Analysis        |       |       |
      | MultipleIDDelete | Default | linker/PythonPackageLinker/Package_Linker% | Analysis        |       |       |
      | MultipleIDDelete | Default | linker/PythonLinker/PythonLinker%          | Analysis        |       |       |
      | SingleItemDelete | Default | pythonanalyzerdemo                         | Project         |       |       |


