Feature: Feature to validate the collection of repositories through the Collector plugin and parsing of the repositories through the Parser plugin

  @cr-data @sanity
  Scenario: Create Analysis widget
    Given I create "Analysis" widget for "TestServiceUser" role

  @cr-data @sanity @positive
  Scenario: Create Dashboard with Analysis widget
    Given I create a dashboard with name "IDA" and add "Analysis" widget for "TestServiceUser" role


  @MLP-1286 @sanity @positive
  Scenario: Run Python Plugins along with git plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body                   | response code | response message | jsonPath                                          |
      | application/json | raw   | false | Put          | settings/analyzers/GitCollector                                           | ida/Git_Py_Parser.json | 204           |                  |                                                   |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                           |                        | 200           | GitCollector     |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                        | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector  |                        | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector |                        | 200           | IDLE             | $.[?(@.configurationName=='GitCollector')].status |

  @MLP-1286 @sanity @positive
  Scenario:Configure Python Plugins along with python parser plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                             | body               | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/PythonParser | ida/Py_parser.json | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/PythonParser |                    | 200           | PythonParser     |          |

  @MLP-1286 @sanity @positive
  Scenario:Run Python Plugins along with python parser plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body | response code | response message | jsonPath                                          |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser |      | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/parser/PythonParser/PythonParser  |      | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/PythonParser/PythonParser |      | 200           | IDLE             | $.[?(@.configurationName=='PythonParser')].status |

  @MLP-1286 @sanity @positive
  Scenario:Run Python Plugins along with python package linker plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body                       | response code | response message | jsonPath                                            |
      | application/json | raw   | false | Put          | settings/analyzers/PythonPackageLinker                                          | ida/Py_package_linker.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/PythonPackageLinker                                          |                            | 200           | Package_Linker   |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/Package_Linker |                            | 200           | IDLE             | $.[?(@.configurationName=='Package_Linker')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/linker/PythonPackageLinker/Package_Linker  |                            | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonPackageLinker/Package_Linker |                            | 200           | IDLE             | $.[?(@.configurationName=='Package_Linker')].status |

  @MLP-1286 @sanity @positive
  Scenario:Run Python Plugins along with python import linker plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                | body                      | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/PythonImportLinker                                              | ida/Py_Import_Linker.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/PythonImportLinker                                              |                           | 200           | PythonImportLinker |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonImportLinker/PythonImportLinker |                           | 200           | IDLE               | $.[?(@.configurationName=='PythonImportLinker')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/linker/PythonImportLinker/PythonImportLinker  |                           | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonImportLinker/PythonImportLinker |                           | 200           | IDLE               | $.[?(@.configurationName=='PythonImportLinker')].status |

  @MLP-1286 @sanity @positive
  Scenario:Run Python Plugins along with python use function linker plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                    | body                            | response code | response message  | jsonPath                                               |
      | application/json | raw   | false | Put          | settings/analyzers/PythonUseFunctionLinker                                             | ida/Py_use_function_linker.json | 204           |                   |                                                        |
      |                  |       |       | Get          | settings/analyzers/PythonUseFunctionLinker                                             |                                 | 200           | UseFunctionLinker |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonUseFunctionLinker/UseFunctionLinker |                                 | 200           | IDLE              | $.[?(@.configurationName=='UseFunctionLinker')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/linker/PythonUseFunctionLinker/UseFunctionLinker  |                                 | 200           |                   |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/PythonUseFunctionLinker/UseFunctionLinker |                                 | 200           | IDLE              | $.[?(@.configurationName=='UseFunctionLinker')].status |

  #6689699#
  @webtest @MLP-1286 @sanity @positive
  Scenario:Parsing the repository and validating the error messages in Log
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    And User clicks on IDA dashboard
    And user clicks on python parser link
    When user clicks on log link and opens the log
    Then log file text should match the expected result with index
      | index | expected text                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
      | 24    | {"lineNumber":1,"position":4,"errorMsg":"missing ':' at ' '","userInfo":"missing ","name":"error"}                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
      | 24    | {"lineNumber":5,"position":6,"errorMsg":"extraneous input '\\\\t\\\\t    ' expecting {'def', 'return', 'raise', 'from', 'import', 'global', 'nonlocal', 'assert', 'if', 'while', 'for', 'try', 'with', 'lambda', 'not', 'None', 'True', 'False', 'class', 'yield', 'del', 'pass', 'continue', 'break', 'async', 'await', NAME, STRING_LITERAL, BYTES_LITERAL, UNSIGNED_INTEGER, DECIMAL_INTEGER, OCT_INTEGER, HEX_INTEGER, BIN_INTEGER, FLOAT_NUMBER, IMAG_NUMBER, '...', '*', '(', '[', '+', '-', '~', '{', '@', DEDENT}","userInfo":"extraneous input ","name":"error"} |
      | 24    | {"lineNumber":5,"position":24,"errorMsg":"extraneous input ')' expecting {<EOF>, 'def', 'return', 'raise', 'from', 'import', 'global', 'nonlocal', 'assert', 'if', 'while', 'for', 'try', 'with', 'lambda', 'not', 'None', 'True', 'False', 'class', 'yield', 'del', 'pass', 'continue', 'break', 'async', 'await', NEWLINE, NAME, STRING_LITERAL, BYTES_LITERAL, UNSIGNED_INTEGER, DECIMAL_INTEGER, OCT_INTEGER, HEX_INTEGER, BIN_INTEGER, FLOAT_NUMBER, IMAG_NUMBER, '...', '*', '(', '[', '+', '-', '~', '{', '@'}","userInfo":"extraneous input ","name":"error"}     |
    And user should be able logoff the IDC

  #6689699#
  @webtest @MLP-1396 @sanity @positive
  Scenario:Parsing the repository and validating the Junk characters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    And User clicks on IDA dashboard
    And User clicks on widget name
    And user selects the "Analysis" from the Type
    And user clicks on git collector link
    And user clicks on "python" item from the processed items of git
    And user clicks on "sample2.py" item from the files tab list
    And user clicks on item "sample2.py" in table "DATA"
    Then the "Data" metadata of item "sample2.py" should be as expected

  #6689699#
  @webtest @MLP-1396 @sanity @positive
  Scenario: Verify the technology tags got assigned to all Cataloged items like Cluster,Service,file,class,sourceTree ,SemanticTree...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    Then user "verifies presence" of technology tags for the following parameters
      | catalogName | name            | facet | Tag                                   |
      | Analysis    | Class           | Type  | Programming,Python                    |
      | Analysis    | Namespace       | Type  | Programming,Python                    |
      | Analysis    | File            | Type  | Programming,Python,Git,Source Control |
      | Analysis    | Function        | Type  | Programming,Python                    |
      | Analysis    | ExternalPackage | Type  | Programming,Python                    |
      | Analysis    | Project         | Type  | Programming,Python,Git,Source Control |
      | Analysis    | SourceTree      | Type  | Programming,Python                    |
    Then verify the table has item
      | Table | item         |
      | DATA  | SemanticTree |
      | DATA  | ParseTree    |
    And user clicks on item "SemanticTree" in table "DATA" from parser
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | Programming,Python |
      | item | SemanticTree       |
    And user clicks on close button in the item full view page
    And user clicks on item "ParseTree" in table "DATA" from parser
    And verify "verifies presence" of technology tags in navigated items
      | Tag  | Programming,Python |
      | item | ParseTree          |

  #6689699#
  @webtest @MLP-1396 @sanity @positive
  Scenario:Parsing the repository and validating the super classes
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    And User clicks on IDA dashboard
    And user clicks on python parser link
    And user clicks on "FunCallVardeclaration" item from the processed items
    And user clicks on item "Parent" in table "CLASSES" from parser
    Then the "superClasses" metadata of item "Parent" should be as expected
    And user should be able logoff the IDC

  #6689699#
  @webtest @MLP-1396 @sanity @positive
  Scenario:Parsing the repository and validating the static variable, constant strings and raw invokes
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    And User clicks on IDA dashboard
    And user clicks on python parser link
    And user clicks on "FunCallVardeclaration" item from the processed items
    And user clicks on item "Parent" in table "CLASSES" from parser
    Then the "staticVariable" metadata of item "Parent" should be as expected
    And user clicks on item "__init__" in table "FUNCTIONS" from parser
    Then the "constantStrings" metadata of item "__init__" should be as expected
    Then the "rawInvokes" metadata of item "__init__" should be as expected
    And user should be able logoff the IDC

  #6689699#
  @webtest @MLP-1396 @sanity @positive
  Scenario:Parsing the repository and validating the single line and multiline comments
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    And User clicks on IDA dashboard
    And user clicks on python parser link
    And user clicks on "sample1" item from the processed items
    Then the "comments" metadata of item "sample1" should be as expected
    And user clicks on item "sample1" in table "CLASSES" from parser
    And user clicks on item "use2" in table "FUNCTIONS" from parser
    Then the "comments" metadata of item "use2" should be as expected
    And user should be able logoff the IDC

  #6689699#
  @webtest @MLP-1396 @sanity @positive
  Scenario:Parsing the repository and validating the functions inside classes
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    And User clicks on IDA dashboard
    And user clicks on python parser link
    And user clicks on "ClassDefinitions" item from the processed items
    Then verify the table has item
      | Table   | item   |
      | CLASSES | Child1 |
    And user clicks on item "Child1" in table "CLASSES" from parser
    Then verify the table has item
      | Table     | item        |
      | FUNCTIONS | __init__    |
      | FUNCTIONS | childMethod |
    And user should be able logoff the IDC

  #6689699#
  @webtest @MLP-1396 @sanity @positive
  Scenario:Parsing the repository and validating the classes inside functions
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    And User clicks on IDA dashboard
    And user clicks on python parser link
    And user clicks on "ClassInsideFunction" item from the processed items
    Then verify the table has item
      | Table   | item                |
      | CLASSES | EiffelBaseMetaClass |
    And user clicks on item "EiffelBaseMetaClass" in table "CLASSES" from parser
    Then verify the table has item
      | Table     | item |
      | FUNCTIONS | main |
    And user clicks on item "main" in table "FUNCTIONS" from parser
    Then verify the table has item
      | Table   | item    |
      | CLASSES | Testing |
    And user should be able logoff the IDC

  #6689699#
  @webtest @MLP-1396 @sanity @positive
  Scenario:Parsing the repository and validating the error messages in metadata
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    And User clicks on IDA dashboard
    And user clicks on python parser link
    And user clicks on "error" item from the processed items
    Then the "errorDetails" metadata of item "error" should be as expected
    And user should be able logoff the IDC

  #6689699#
  @webtest @MLP-1396 @sanity @positive
  Scenario:Parsing the repository and validating the raw imports in metadata
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    And User clicks on IDA dashboard
    And user clicks on python parser link
    And user clicks on "ImportStatement" item from the processed items
    Then the "rawImports" metadata of item "ImportStatement" should be as expected
    And the "Number of imports" metadata of item "ImportStatement" should be as expected
    And user should be able logoff the IDC


  #6689699#
  @webtest @MLP-1396 @sanity @positive
  Scenario:Parsing the repository and validating the errors in python version 2
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    And User clicks on IDA dashboard
    And user clicks on python parser link
    And user clicks on "sample1" item from the processed items
    Then the "errorDetails" metadata of item "sample1" should be as expected
    And user should be able logoff the IDC

  #6689699#
  @webtest @MLP-1396 @sanity @positive
  Scenario:Parsing the repository and validating external class import functionality in python version 2
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    And User clicks on IDA dashboard
    And user clicks on python parser link
    And user clicks on "sample1" item from the processed items
    Then verify the table has item
      | Table   | item    |
      | CLASSES | sample1 |
      | IMPORTS | sample2 |
    And user should be able logoff the IDC

  #6689699#
  @webtest @MLP-1396 @sanity @positive
  Scenario:Parsing the repository and validating external class import functionality when the implimentation is not available in python version 2
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    And User clicks on IDA dashboard
    And user clicks on python parser link
    And user clicks on "sample1" item from the processed items
    Then verify the table has item
      | Table   | item    |
      | CLASSES | sample1 |
      | IMPORTS | sample2 |
    And user clicks on item "sample2" in table "IMPORTS" from parser
    Then verify the table "IMPORTS" has item "tensorflow" if not then the "rawImports" metadata of item "tensorflow" should be as expected
    And user should be able logoff the IDC

  #6689699#
  @webtest @MLP-1396 @sanity @positive
  Scenario:run the package linker plugin and check for the processed items in python version 2
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    And User clicks on IDA dashboard
    And user clicks on python package link
    Then verify the table has item for packagelinker
      | Table           | item       |
      | PROCESSED ITEMS | sample2.py |
    And user should be able logoff the IDC


  #6689699#
  @webtest @MLP-1396 @sanity @positive
  Scenario:run the Import linker plugin and check for the processed items in python version 2
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    And User clicks on IDA dashboard
    And user clicks on python import link
    Then verify the table has item
      | Table           | item    |
      | PROCESSED ITEMS | sample2 |
    And user should be able logoff the IDC

  #6689699#
  @webtest @MLP-1396 @sanity @positive
  Scenario:run the use case linker plugin and check whether the USES table is added python version 2
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    And User clicks on IDA dashboard
    And user clicks on python parser link
    And user clicks on "sample2" item from the processed items
    Then verify the table has item
      | Table   | item    |
      | CLASSES | sample2 |
    And user clicks on item "sample2" in table "CLASSES" from parser
    Then verify the table has item
      | Table     | item   |
      | FUNCTIONS | testtf |
    And user clicks on item "testtf" in table "FUNCTIONS" from parser
    Then verify the table has item
      | Table | item                |
      | USES  | get_value_shape     |
      | USES  | convert_to_tensor/2 |
    And user should be able logoff the IDC

  #6689699#
  @webtest @MLP-1286 @sanity @positive
  Scenario:Checking the Namespace generated are valid as expected
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user select "Analysis" from Catalog list
    And user performs "facet selection" in "Namespace" attribute under "Type" facets in Item Search results page
    Then verify the results table has item
      | item             |
      | top.foo          |
      | top.sub          |
      | top.sub.sub2     |
      | top.sub.bar1     |
      | top.sub.sub2.bar |
      | top              |
    And user should be able logoff the IDC

  #6689699#
  @webtest @MLP-1286 @sanity @positive
  Scenario:Parsing the repository and validating the linkage messages in in Log
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    And User clicks on IDA dashboard
    And user clicks on python Use Function link
    When user clicks on log link and opens the log
    Then log file text should match the expected result with index
      | index | expected text                                              |
      | 24    | linktarget test1/0                                         |
      | 24    | linktarget get_value_shape/0                               |
      | 24    | linktarget external project tensorflow/convert_to_tensor/2 |
    And user should be able logoff the IDC