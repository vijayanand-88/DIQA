Feature: Feature to validate the collection of Files with Filter conditions


  #Include filter conditions
  #TestcaseId_6678967 - Verify whether the .parquet extension files are retrieved from all the levels, namely project/Directory/Sub-directory when the filter expressions are provided
  @LFC @IDA_E2E
  Scenario: SC1 - Create Local localFileCollector Plugin config OnlyParquetFiles and run it
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                    | body                                                                  | response code | response message | jsonPath                                              |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                                  | ida/localFileCollectorPayloads/Configurations/TestcaseId_6678967.json | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                  |                                                                       | 200           | OnlyParquetFiles |                                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/OnlyParquetFiles |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='OnlyParquetFiles')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/OnlyParquetFiles  |                                                                       | 200           | IDLE             |                                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/OnlyParquetFiles |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='OnlyParquetFiles')].status |

  @webtest @LFC @IDA_E2E
  Scenario: SC1 - Collecting the files with extension .parquet and validating in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "LFC" and clicks on search
    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/OnlyParquetFiles%"
    And user verifies "Processed Items" table should have following values
      | fileName                  | fileType  |
      | lfc_testfiles             | Project   |
      | file1.parquet             | File      |
      | users.parquet             | File      |
      | namesAndFavColors.parquet | File      |
      | resources                 | Directory |
      | examples                  | Directory |
      | python                    | Directory |


  @sanity @positive
  Scenario:SC#1:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | collector/LocalFileCollector/% | Analysis |       |       |
      | MultipleIDDelete | Default | lfc_testfiles                  | Project  |       |       |

  Scenario Outline: Delete Plugin configurations and catalog "OnlyParquetFiles"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/LocalFileCollector |      | 204           |                  |          |

  #TestcaseId_6678968 - Verify whether the .parquet extension files are retrieved only from the project levels, when the filter expressions are provided
  @LFC @IDA_E2E
  Scenario: SC2 - Create Local localFileCollector Plugin config RootFolderParquetFiles and run it
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                          | body                                                                  | response code | response message       | jsonPath                                                    |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                                        | ida/localFileCollectorPayloads/Configurations/TestcaseId_6678968.json | 204           |                        |                                                             |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                        |                                                                       | 200           | RootFolderParquetFiles |                                                             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/RootFolderParquetFiles |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='RootFolderParquetFiles')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/RootFolderParquetFiles  |                                                                       | 200           | IDLE                   |                                                             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/RootFolderParquetFiles |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='RootFolderParquetFiles')].status |

  @webtest @LFC
  Scenario:SC2 - Collecting the files with extension .parquet in project level and validating in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "LFC" and clicks on search
    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/RootFolderParquetFiles%"
    And user verifies "Processed Items" table should have following values
      | fileName                  | fileType |
      | namesAndFavColors.parquet | File     |
      | lfc_testfiles             | Project  |
    Then user performs click and verify in new window
      | Table           | value                     | Action               | RetainPrevwindow | indexSwitch |
      | Processed Items | namesAndFavColors.parquet | click and switch tab | No               |             |
    Then user verifies "Data" table should have following values
      | fileName                  | fileType |
      | namesAndFavColors.parquet | Content  |

  @sanity @positive
  Scenario:SC#2:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | collector/LocalFileCollector/% | Analysis |       |       |
      | MultipleIDDelete | Default | lfc_testfiles                  | Project  |       |       |


  Scenario Outline:SC2:Delete Plugin configurations and catalog "RootFolderParquetFiles"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/LocalFileCollector |      | 204           |                  |          |


#TestcaseId_6678969 - Verify whether the files are retrieved only from one sub folder only without retrieving the subfolders in the directory, namely project/subfolder when the filter expressions are provided
  @LFC
  Scenario: SC3- Create Local localFileCollector Plugin config SubdirectoryLevelParquetFiles and run it
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                 | body                                                                  | response code | response message              | jsonPath                                                           |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                                               | ida/localFileCollectorPayloads/Configurations/TestcaseId_6678969.json | 204           |                               |                                                                    |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                               |                                                                       | 200           | SubdirectoryLevelParquetFiles |                                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/SubdirectoryLevelParquetFiles |                                                                       | 200           | IDLE                          | $.[?(@.configurationName=='SubdirectoryLevelParquetFiles')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/SubdirectoryLevelParquetFiles  |                                                                       | 200           | IDLE                          |                                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/SubdirectoryLevelParquetFiles |                                                                       | 200           | IDLE                          | $.[?(@.configurationName=='SubdirectoryLevelParquetFiles')].status |

  @webtest @LFC
  Scenario: SC3 - Collecting the files from project/subfolder level and validating in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "LFC" and clicks on search
    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/SubdirectoryLevelParquetFiles%"
    And user verifies "Processed Items" table should have following values
      | fileName               | fileType  |
      | python                 | Directory |
      | lfc_testfiles          | Project   |
      | file1.parquet          | File      |
      | CascadingDataFrames.py | File      |
    Then user performs click and verify in new window
      | Table           | value  | Action               | RetainPrevwindow | indexSwitch |
      | Processed Items | python | click and switch tab | No               |             |
    Then user verifies "Files" table should have following values
      | fileName               | fileType |
      | CascadingDataFrames.py | File     |
      | file1.parquet          | File     |

  @sanity @positive
  Scenario:SC#3:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | collector/LocalFileCollector/% | Analysis |       |       |
      | MultipleIDDelete | Default | lfc_testfiles                  | Project  |       |       |

  Scenario Outline:SC3:Delete Plugin configurations and catalog "SubdirectoryLevelParquetFiles"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/LocalFileCollector |      | 204           |                  |          |


  #TestcaseId_6678970 - Verify whether the folders and files are retrieved from specified folder only , when the filter expressions are provided.
  @LFC
  Scenario: SC4 - Create Local localFileCollector Plugin config Subfolderfiles_andAll and run it
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                         | body                                                                  | response code | response message      | jsonPath                                                   |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                                       | ida/localFileCollectorPayloads/Configurations/TestcaseId_6678970.json | 204           |                       |                                                            |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                       |                                                                       | 200           | Subfolderfiles_andAll |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/Subfolderfiles_andAll |                                                                       | 200           | IDLE                  | $.[?(@.configurationName=='Subfolderfiles_andAll')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/Subfolderfiles_andAll  |                                                                       | 200           | IDLE                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/Subfolderfiles_andAll |                                                                       | 200           | IDLE                  | $.[?(@.configurationName=='Subfolderfiles_andAll')].status |

  @webtest @LFC
  Scenario: SC4 - Collecting the files and folders from specified folder and validating in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "LFC" and clicks on search
    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/Subfolderfiles_andAll%"
    And user verifies "Processed Items" table should have following values
      | fileName                       | fileType  |
      | users.parquet                  | File      |
      | SnowFlake_df_multiple_write.py | File      |
      | resources                      | Directory |
      | examples                       | Directory |
      | python                         | Directory |
      | lfc_testfiles                  | Project   |
    Then user performs click and verify in new window
      | Table           | value    | Action               | RetainPrevwindow | indexSwitch |
      | Processed Items | examples | click and switch tab | No               |             |
    Then user verifies "Files" table should have following values
      | fileName                       | fileType |
      | SnowFlake_df_multiple_write.py | File     |
    Then user verifies "has_Directory" table should have following values
      | fileName  | fileType  |
      | resources | Directory |
    Then user performs click and verify in new window
      | Table         | value     | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | resources | click and switch tab | No               |             |
    Then user verifies "Files" table should have following values
      | users.parquet | File |

  @sanity @positive
  Scenario:SC#4:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | collector/LocalFileCollector/% | Analysis |       |       |
      | MultipleIDDelete | Default | lfc_testfiles                  | Project  |       |       |


  Scenario Outline:SC4:Delete Plugin configurations and catalog "Subfolderfiles_andAll"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/LocalFileCollector |      | 204           |                  |          |


  #TestcaseId_6678971 - Verify whether the files alone are displayed that matches the filter expression : **/python/**/resources/*
  @LFC
  Scenario:SC5 - Create Local localFileCollector Plugin config ComplexExpression and run it
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                     | body                                                                  | response code | response message  | jsonPath                                               |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                                   | ida/localFileCollectorPayloads/Configurations/TestcaseId_6678971.json | 204           |                   |                                                        |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                   |                                                                       | 200           | ComplexExpression |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/ComplexExpression |                                                                       | 200           | IDLE              | $.[?(@.configurationName=='ComplexExpression')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/ComplexExpression  |                                                                       | 200           | IDLE              |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/ComplexExpression |                                                                       | 200           | IDLE              | $.[?(@.configurationName=='ComplexExpression')].status |

  @webtest @LFC
  Scenario: SC5 - Collecting the files and folders from subdirectory resources and validating in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "LFC" and clicks on search
    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/ComplexExpression%"
    And user verifies "Processed Items" table should have following values
      | fileName      | fileType  |
      | users.parquet | File      |
      | lfc_testfiles | Project   |
      | resources     | Directory |
      | examples      | Directory |
      | python        | Directory |
    Then user performs click and verify in new window
      | Table           | value  | Action               | RetainPrevwindow | indexSwitch |
      | Processed Items | python | click and switch tab | No               |             |
    Then user verifies "has_Directory" table should have following values
      | examples | Directory |
    Then user performs click and verify in new window
      | Table         | value    | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | examples | click and switch tab | No               |             |
    Then user verifies "has_Directory" table should have following values
      | resources | Directory |
    Then user performs click and verify in new window
      | Table         | value     | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | resources | click and switch tab | No               |             |
    Then user verifies "Files" table should have following values
      | users.parquet | File |

  @sanity @positive
  Scenario:SC#5:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | collector/LocalFileCollector/% | Analysis |       |       |
      | MultipleIDDelete | Default | lfc_testfiles                  | Project  |       |       |

  Scenario Outline:SC5:Delete Plugin configurationls and catalog "ComplexExpression"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/LocalFileCollector |      | 204           |                  |          |


  #TestcaseId_6678972 - Verify whether the .py extension files are retrieved only from the sub folder level , when the filter expressions are provided
  @LFC
  Scenario:SC6 - Create Local localFileCollector Plugin config OnlyPythonFiles and run it
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body                                                                  | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                                 | ida/localFileCollectorPayloads/Configurations/TestcaseId_6678972.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                 |                                                                       | 200           | OnlyPythonFiles  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/OnlyPythonFiles |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='OnlyPythonFiles')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/OnlyPythonFiles  |                                                                       | 200           | IDLE             |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/OnlyPythonFiles |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='OnlyPythonFiles')].status |


  @webtest @LFC
  Scenario:SC6 - Collecting the .py extension files from the subdirectory python and validating in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "LFC" and clicks on search
    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/OnlyPythonFiles%"
    And user verifies "Processed Items" table should have following values
      | fileName               | fileType  |
      | lfc_testfiles          | Project   |
      | python                 | Directory |
      | CascadingDataFrames.py | File      |
    Then user performs click and verify in new window
      | Table           | value  | Action               | RetainPrevwindow | indexSwitch |
      | Processed Items | python | click and switch tab | No               |             |
    Then user verifies "Files" table should have following values
      | fileName               | fileType |
      | CascadingDataFrames.py | File     |


  @sanity @positive
  Scenario:SC#6:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | collector/LocalFileCollector/% | Analysis |       |       |
      | MultipleIDDelete | Default | lfc_testfiles                  | Project  |       |       |


  Scenario Outline:SC6:Delete Plugin configurationls and catalog "OnlyPythonFiles"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/LocalFileCollector |      | 204           |                  |          |


  #Exclude filter conditions
  #TestcaseId_6678973 - Verify whether the .parquet extension files are excluded from all the levels, namely project/Directory/Sub-directory when the filter expressions are provided .
  @LFC @IDA_E2E
  Scenario: SC7 -Create Local localFileCollector Plugin config NoParquetFiles and run it
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                  | body                                                                  | response code | response message | jsonPath                                            |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                                | ida/localFileCollectorPayloads/Configurations/TestcaseId_6678973.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                |                                                                       | 200           | NoParquetFiles   |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/NoParquetFiles |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='NoParquetFiles')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/NoParquetFiles  |                                                                       | 200           | IDLE             |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/NoParquetFiles |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='NoParquetFiles')].status |

  @webtest @LFC
  Scenario: SC7 - Collecting the files by excluding .parquet extension from all levels and validating in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "LFC" and clicks on search
    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/NoParquetFiles%"
    And user verifies "Processed Items" table should have following values
      | fileName                       | fileType  |
      | SnowFlake_df_multiple_write.py | File      |
      | CascadingDataFrames.py         | File      |
      | SparkReadWrite.py              | File      |
      | lfc_testfiles                  | Project   |
      | examples                       | Directory |
      | python                         | Directory |


  @sanity @positive
  Scenario:SC#7:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | collector/LocalFileCollector/% | Analysis |       |       |
      | MultipleIDDelete | Default | lfc_testfiles                  | Project  |       |       |


  Scenario Outline:SC7:Delete Plugin configurationls and catalog "NoParquetFiles"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/LocalFileCollector |      | 204           |                  |          |


  #TestcaseId_6678974 - Verify whether .parquet extension files are excluded from only the project level and rest of the files are cataloged , when the filter expressions are provided .
  @LFC
  Scenario: SC8 - Create Local localFileCollector Plugin config NoParquetFromProjectLevel and run it
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                             | body                                                                  | response code | response message          | jsonPath                                                       |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                                           | ida/localFileCollectorPayloads/Configurations/TestcaseId_6678974.json | 204           |                           |                                                                |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                           |                                                                       | 200           | NoParquetFromProjectLevel |                                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/NoParquetFromProjectLevel |                                                                       | 200           | IDLE                      | $.[?(@.configurationName=='NoParquetFromProjectLevel')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/NoParquetFromProjectLevel  |                                                                       | 200           | IDLE                      |                                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/NoParquetFromProjectLevel |                                                                       | 200           | IDLE                      | $.[?(@.configurationName=='NoParquetFromProjectLevel')].status |

  @webtest @LFC
  Scenario: SC8 - Collecting the files by excluding .parquet extension only from project level and validating in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "LFC" and clicks on search
    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/NoParquetFromProjectLevel%"
    And user verifies "Processed Items" table should have following values
      | fileName                       | fileType  |
      | SnowFlake_df_multiple_write.py | File      |
      | CascadingDataFrames.py         | File      |
      | SparkReadWrite.py              | File      |
      | lfc_testfiles                  | Project   |
      | examples                       | Directory |
      | python                         | Directory |
      | resources                      | Directory |
      | users.parquet                  | File      |
      | file1.parquet                  | File      |


  @sanity @positive
  Scenario:SC#8:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | collector/LocalFileCollector/% | Analysis |       |       |
      | MultipleIDDelete | Default | lfc_testfiles                  | Project  |       |       |


  Scenario Outline:SC8:Delete Plugin configurationls and catalog "NoParquetFromProjectLevel"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/LocalFileCollector |      | 204           |                  |          |


  #TestcaseId_6678975 - Verify whether the files are excluded from one subfolder(python) only and rest of the files and folders are cataloged , when the filter expressions are provided .
  @LFC
  Scenario: SC9 - Create Local localFileCollector Plugin config NoFilesFromPythonDir and run it
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                        | body                                                                  | response code | response message     | jsonPath                                                  |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                                      | ida/localFileCollectorPayloads/Configurations/TestcaseId_6678975.json | 204           |                      |                                                           |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                      |                                                                       | 200           | NoFilesFromPythonDir |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/NoFilesFromPythonDir |                                                                       | 200           | IDLE                 | $.[?(@.configurationName=='NoFilesFromPythonDir')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/NoFilesFromPythonDir  |                                                                       | 200           | IDLE                 |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/NoFilesFromPythonDir |                                                                       | 200           | IDLE                 | $.[?(@.configurationName=='NoFilesFromPythonDir')].status |

  @webtest @LFC
  Scenario: SC9 - Collecting the files by excluding python directory alone and validating in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "LFC" and clicks on search
    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/NoFilesFromPythonDir%"
    And user verifies "Processed Items" table should have following values
      | fileName                       | fileType  |
      | users.parquet                  | File      |
      | namesAndFavColors.parquet      | File      |
      | SnowFlake_df_multiple_write.py | File      |
      | SparkReadWrite.py              | File      |
      | lfc_testfiles                  | Project   |
      | examples                       | Directory |
      | python                         | Directory |
      | resources                      | Directory |
    Then user performs click and verify in new window
      | Table           | value  | Action               | RetainPrevwindow | indexSwitch |
      | Processed Items | python | click and switch tab | No               |             |
    And METADATA widget should have following item values
      | metaDataItem              | metaDataItemValue |
      | Number of files           | 0                 |
      | Number of sub-directories | 1                 |


  @sanity @positive
  Scenario:SC#9:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | collector/LocalFileCollector/% | Analysis |       |       |
      | MultipleIDDelete | Default | lfc_testfiles                  | Project  |       |       |


  Scenario Outline:SC9:Delete Plugin configurationls and catalog "NoFilesFromPythonDir"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/LocalFileCollector |      | 204           |                  |          |


  #TestcaseId_6678976 - Verify whether the files and sub folders are excluded from the examples directory , namely project/subfolder when the filter expressions are provided.
  @LFC
  Scenario: SC10 - Create Local localFileCollector Plugin config NoDataFromExamplesDir and run it
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                         | body                                                                  | response code | response message      | jsonPath                                                   |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                                       | ida/localFileCollectorPayloads/Configurations/TestcaseId_6678976.json | 204           |                       |                                                            |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                       |                                                                       | 200           | NoDataFromExamplesDir |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/NoDataFromExamplesDir |                                                                       | 200           | IDLE                  | $.[?(@.configurationName=='NoDataFromExamplesDir')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/NoDataFromExamplesDir  |                                                                       | 200           | IDLE                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/NoDataFromExamplesDir |                                                                       | 200           | IDLE                  | $.[?(@.configurationName=='NoDataFromExamplesDir')].status |

  @webtest @LFC
  Scenario: SC10 - Collecting the files by excluding folders and files in examples directory alone and validating in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "LFC" and clicks on search
    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/NoDataFromExamplesDir%"
    And user verifies "Processed Items" table should have following values
      | fileName                  | fileType  |
      | python                    | Directory |
      | lfc_testfiles             | Project   |
      | file1.parquet             | File      |
      | CascadingDataFrames.py    | File      |
      | namesAndFavColors.parquet | File      |
      | SparkReadWrite.py         | File      |
    Then user performs click and verify in new window
      | Table           | value  | Action               | RetainPrevwindow | indexSwitch |
      | Processed Items | python | click and switch tab | No               |             |
    And METADATA widget should have following item values
      | metaDataItem              | metaDataItemValue |
      | Number of files           | 2                 |
      | Number of sub-directories | 0                 |


  @sanity @positive
  Scenario:SC#10:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | collector/LocalFileCollector/% | Analysis |       |       |
      | MultipleIDDelete | Default | lfc_testfiles                  | Project  |       |       |


  Scenario Outline:SC10:Delete Plugin configurationls and catalog "NoDataFromExamplesDir"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/LocalFileCollector |      | 204           |                  |          |


  #TestcaseId_6678977 - Verify whether the files alone are not displayed under the subfolder of the mentioned expression and the rest of the files are cataloged, the filter expressions are provided.
  @LFC
  Scenario: SC11 - Create Local localFileCollector Plugin config OnlyFoldersFromDir and run it
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                  | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                                    | ida/localFileCollectorPayloads/Configurations/TestcaseId_6678977.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                    |                                                                       | 200           | OnlyFoldersFromDir |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/OnlyFoldersFromDir |                                                                       | 200           | IDLE               | $.[?(@.configurationName=='OnlyFoldersFromDir')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/OnlyFoldersFromDir  |                                                                       | 200           | IDLE               |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/OnlyFoldersFromDir |                                                                       | 200           | IDLE               | $.[?(@.configurationName=='OnlyFoldersFromDir')].status |

  @webtest @LFC
  Scenario: SC11 - Collecting the folders alone by excluding files in subfolder resources directory and validating in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "LFC" and clicks on search
    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/OnlyFoldersFromDir%"
    And user verifies "Processed Items" table should have following values
      | fileName                       | fileType  |
      | examples                       | Directory |
      | python                         | Directory |
      | lfc_testfiles                  | Project   |
      | file1.parquet                  | File      |
      | SnowFlake_df_multiple_write.py | File      |
      | CascadingDataFrames.py         | File      |
      | namesAndFavColors.parquet      | File      |
      | SparkReadWrite.py              | File      |
    Then user performs click and verify in new window
      | Table           | value    | Action               | RetainPrevwindow | indexSwitch |
      | Processed Items | examples | click and switch tab | No               |             |
    And METADATA widget should have following item values
      | metaDataItem              | metaDataItemValue |
      | Number of sub-directories | 0                 |


  @sanity @positive
  Scenario:SC#11:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | collector/LocalFileCollector/% | Analysis |       |       |
      | MultipleIDDelete | Default | lfc_testfiles                  | Project  |       |       |


  Scenario Outline:SC11:Delete Plugin configurationls and catalog "OnlyFoldersFromDir"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/LocalFileCollector |      | 204           |                  |          |



  #TestcaseId_6678978 - Verify whether the .py extension files are excluded from the python subfolder only and the rest of the files/folders are excluded  when the filter expressions are provided.
  @LFC
  Scenario: SC12 - Create Local localFileCollector Plugin config NoPythonFile and run it
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                | body                                                                  | response code | response message | jsonPath                                          |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                              | ida/localFileCollectorPayloads/Configurations/TestcaseId_6678978.json | 204           |                  |                                                   |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                              |                                                                       | 200           | NoPythonFile     |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/NoPythonFile |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='NoPythonFile')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/NoPythonFile  |                                                                       | 200           | IDLE             |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/NoPythonFile |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='NoPythonFile')].status |

  @webtest @LFC
  Scenario: SC12 - Collecting the files by excluding .py extension files in subfolder python and validating in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "LFC" and clicks on search
    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/NoPythonFile%"
    And user verifies "Processed Items" table should have following values
      | fileName                       | fileType  |
      | lfc_testfiles                  | Project   |
      | resources                      | Directory |
      | examples                       | Directory |
      | python                         | Directory |
      | file1.parquet                  | File      |
      | users.parquet                  | File      |
      | SnowFlake_df_multiple_write.py | File      |
      | namesAndFavColors.parquet      | File      |
      | SparkReadWrite.py              | File      |
    Then user performs click and verify in new window
      | Table           | value  | Action               | RetainPrevwindow | indexSwitch |
      | Processed Items | python | click and switch tab | No               |             |
    And METADATA widget should have following item values
      | metaDataItem    | metaDataItemValue |
      | Number of files | 1                 |


  @sanity @positive
  Scenario:SC#12:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | collector/LocalFileCollector/% | Analysis |       |       |
      | MultipleIDDelete | Default | lfc_testfiles                  | Project  |       |       |


  Scenario Outline:SC12:Delete Plugin configurationls and catalog "NoPythonFile"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/LocalFileCollector |      | 204           |                  |          |
