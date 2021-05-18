@MLP-32428
@MLP-18281

Feature: MLP-29783 - Create a wrapper plugin for the CAE File System (Directory) collector

  #########################################Updating node name in Config files#######################################################################################

  @Precondition @CAE_DirectoryCollector
  Scenario: Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                                                                             | jsonPath                                                                  | node            |
      | ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_DS.json        | $..FileSystem_EntryPoint_DS.configurations..ServerName                    | HeadlessEDINode |
      | ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_DS.json        | $..FileSystem_EntryPoint_DS_SQL.configurations..ServerName                | HeadlessEDINode |
      | ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Feeder_DS.json                 | $..FileSystem_Feeder_DataSource.configurations..ServerName                | HeadlessEDINode |
      | ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Feeder_DS.json                 | $..FileSystem_Feeder_DataSource_SQL.configurations..ServerName            | HeadlessEDINode |
      | ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_Config.json    | $.FileSystem_Creator.configurations.nodeCondition                         | HeadlessEDINode |
      | ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_Config.json    | $.FileSystem_Deletor.configurations.nodeCondition                         | HeadlessEDINode |
      | ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_Config.json    | $.FileSystem_Creator_Sql.configurations.nodeCondition                     | HeadlessEDINode |
      | ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_Config.json    | $.FileSystem_Deletor_Sql.configurations.nodeCondition                     | HeadlessEDINode |
      | ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Feeder_Config.json             | $.FileSystem_Feeder.configurations.nodeCondition                          | HeadlessEDINode |
      | ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Feeder_Config.json             | $.FileSystem_Feeder_Sql.configurations.nodeCondition                      | HeadlessEDINode |
      | ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Loader.json                    | $.FileSystem_DDLoader.configurations.nodeCondition                        | HeadlessEDINode |
      | ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Loader.json                    | $.FileSystem_DDLoader_Sql.configurations.nodeCondition                    | HeadlessEDINode |
      | ida/CAE_FileSystem_Payloads/Configurations/AllFiles.json                             | $.AllFiles.configurations.nodeCondition                                   | HeadlessEDINode |
      | ida/CAE_FileSystem_Payloads/Configurations/MulConfigLines_Subfolder_Y&N.json         | $.MulConfigLines_WithSubFold_Y&N.configurations.nodeCondition             | HeadlessEDINode |
      | ida/CAE_FileSystem_Payloads/Configurations/MulConfigLines_WithFileExt_Subfold_Y.json | $.MulConfigLines_WithFileExtension_Subfold_Y.configurations.nodeCondition | HeadlessEDINode |
      | ida/CAE_FileSystem_Payloads/Configurations/RootLevelWithSubfolder_N.json             | $.RootLevelWithSubfolder_N.configurations.nodeCondition                   | HeadlessEDINode |
      | ida/CAE_FileSystem_Payloads/Configurations/WithFileName_Subfold_N.json               | $.WithFileName_SubFolder_N.configurations.nodeCondition                   | HeadlessEDINode |

  ############################################################Verify Mandatory Error Message in Collector plugin####################################################################

  @webtest @CAE_DirectoryCollector @TEST_MLPQA-3533 @MLPQA-17484 @7237903
  Scenario: Verify the mandatory fields throws an error message when the field is left blank in plugin configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem                     |
      | Open Deployment | DIQDOCKER02V.DIQ.QA.ASGINT.LOC |
    And user "click" on "Add Configuration" button under "DIQDOCKER02V.DIQ.QA.ASGINT.LOC" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute          |
      | Type      | CAE                |
      | Plugin    | DirectoryCollector |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @webtest @CAE_DirectoryCollector @TEST_MLPQA-3532 @MLPQA-17484 @7237904
  Scenario: Verify the captions and tool tips in plugin configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Add Data source Configuration"
    And user performs "click" operation in Manage Configurations panel
      | button            | actionItem                     |
      | Open Deployment   | DIQDOCKER02V.DIQ.QA.ASGINT.LOC |
      | Add Configuration |                                |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute          |
      | Type      | CAE                |
      | Plugin    | DirectoryCollector |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                |
      | Label                |
      | Business Application |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Plugin version     |
      | Event condition    |
      | Tags               |
      | DEBUG              |
      | JAVA_MEMORY_HEAP_1 |
      | JAVA_MEMORY_HEAP_2 |

    ######################################################Setting up the credentials and configuring Datasource##################################################################################

  @PreCondition @CAE_DirectoryCollector
  Scenario Outline:Set Credentials for Creator and Feeder Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                        | bodyFile                                                             | path                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/Valid_Entrypoint_Cred | payloads/ida/CAE_FileSystem_Payloads/Configurations/Credentials.json | $.Valid_Entrypoint_Cred | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Valid_Entrypoint_Cred |                                                                      |                         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/Valid_Feeder_Cred     | payloads/ida/CAE_FileSystem_Payloads/Configurations/Credentials.json | $.Valid_Feeder_Cred     | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Valid_Feeder_Cred     |                                                                      |                         | 200           |                  |          |

  @PreCondition @CAE_DirectoryCollector
  Scenario Outline:Run DataSources for Creating Entry point, Feeder and ETL plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                       | bodyFile                                                                               | path                                              | response code | response message         | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource/FileSystem_EntryPoint_DS | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_DS.json | $.FileSystem_EntryPoint_DS.configurations.[0]     | 204           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource/FileSystem_EntryPoint_DS |                                                                                        |                                                   | 200           | FileSystem_EntryPoint_DS |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource/FileSystem_Feeder_DS     | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Feeder_DS.json          | $.FileSystem_Feeder_DataSource.configurations.[0] | 204           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource/FileSystem_Feeder_DS     |                                                                                        |                                                   | 200           | FileSystem_Feeder_DS     |          |

  @PreCondition @CAE_DirectoryCollector
  Scenario Outline: create BussinessApplication tag and run the plugin configuration with the new field
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                                 | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/CAE_FileSystem_Payloads/Configurations/BussinessApplication.json | 200           |                  |          |

##################################################################################################################################################################################################################################################################################################################################

  @PreCondition @CAE_DirectoryCollector
  Scenario Outline: Run the plugins - AllFiles
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                   | path                                 | response code | response message    | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/FileSystem_Creator                            | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_Config.json | $.FileSystem_Creator.configurations  | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/FileSystem_Creator                            |                                                                                            |                                      | 200           | FileSystem_Creator  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                              |                                                                                            |                                      | 200           | UP                  | $.nodeStatus                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/FileSystem_Creator |                                                                                            |                                      | 200           | IDLE                | $.[?(@.configurationName=='FileSystem_Creator')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAECreateEntryPoint/FileSystem_Creator  |                                                                                            |                                      | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/FileSystem_Creator |                                                                                            |                                      | 200           | IDLE                | $.[?(@.configurationName=='FileSystem_Creator')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/DirectoryCollector/AllFiles                                       | payloads/ida/CAE_FileSystem_Payloads/Configurations/AllFiles.json                          | $.AllFiles.configurations            | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/DirectoryCollector/AllFiles                                       |                                                                                            |                                      | 200           | AllFiles            |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                              |                                                                                            |                                      | 200           | UP                  | $.nodeStatus                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DirectoryCollector/AllFiles              |                                                                                            |                                      | 200           | IDLE                | $.[?(@.configurationName=='AllFiles')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/DirectoryCollector/AllFiles               |                                                                                            |                                      | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DirectoryCollector/AllFiles              |                                                                                            |                                      | 200           | IDLE                | $.[?(@.configurationName=='AllFiles')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/FileSystem_Feeder                                         | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Feeder_Config.json          | $.FileSystem_Feeder.configurations   | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/FileSystem_Feeder                                         |                                                                                            |                                      | 200           | FileSystem_Feeder   |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                              |                                                                                            |                                      | 200           | UP                  | $.nodeStatus                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/FileSystem_Feeder                |                                                                                            |                                      | 200           | IDLE                | $.[?(@.configurationName=='FileSystem_Feeder')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/FileSystem_Feeder                 |                                                                                            |                                      | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/FileSystem_Feeder                |                                                                                            |                                      | 200           | IDLE                | $.[?(@.configurationName=='FileSystem_Feeder')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/FileSystem_DDLoader                                   | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Loader.json                 | $.FileSystem_DDLoader.configurations | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/FileSystem_DDLoader                                   |                                                                                            |                                      | 200           | FileSystem_DDLoader |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                              |                                                                                            |                                      | 200           | UP                  | $.nodeStatus                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/FileSystem_DDLoader         |                                                                                            |                                      | 200           | IDLE                | $.[?(@.configurationName=='FileSystem_DDLoader')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/FileSystem_DDLoader          |                                                                                            |                                      | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/FileSystem_DDLoader         |                                                                                            |                                      | 200           | IDLE                | $.[?(@.configurationName=='FileSystem_DDLoader')].status |

  @webtest @CAE_DirectoryCollector @TEST_MLPQA-3531 @MLPQA-17484 @7238673
  Scenario: Run the collector plugin to collect all files from the directory path and subfolder=Y and verify the des file is generated also verify in DD UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "FileTypes" and clicks on search
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FileTypes" item from search results
    And user verifies "Files" table should have following values
      | fileName                  | fileType |
      | LineageScenarios.docx     | File     |
      | namesAndFavColors.parquet | File     |
      | ETL-System_Training.svg   | File     |
      | EmployeeData.csv          | File     |
      | final.apk                 | File     |
      | IMAGE.jpg                 | File     |
      | Output.crc                | File     |
    And user verifies "Has_Directory" table should have following values
      | SubFolder1 | Directory |
    Then user performs click and verify in new window
      | Table         | value      | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | SubFolder1 | click and switch tab | No               |             |
    Then user verifies "Data" table should have following values
      | fileName               | fileType |
      | asg.jks                | File     |
      | Download.png           | File     |
      | RochadeImport.xml      | File     |
      | WhatsAppImage.jpeg     | File     |
      | ExternalTables.txt     | File     |
      | Spark_CsvToOracle.java | File     |
      | EDIBusSample.jmx       | File     |
    And user verifies "has_Directory" table should have following values
      | fileName   | fileType  |
      | SubFolder2 | Directory |
      | SubFolder3 | Directory |
    Then user performs click and verify in new window
      | Table         | value      | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | SubFolder2 | click and switch tab | No               |             |
    Then user verifies "Data" table should have following values
      | fileName                   | fileType |
      | PluginConfig.json          | File     |
      | SparkFolder.zip            | File     |
      | TestOrcFile.orc            | File     |
      | Spark_OracleToParquet.java | File     |
      | SparkReadWrite.py          | File     |
      | Screenshots.7z             | File     |
      | Spark_ParquetToOracle.java | File     |
    And user clicks on "SubFolder1" item in the breadcrumb items
    Then user performs click and verify in new window
      | Table         | value      | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | SubFolder3 | click and switch tab | No               |             |
    Then user verifies "Data" table should have following values
      | fileName                       | fileType |
      | PaymentReceipt.pdf             | File     |
      | WhatsAppImage.jpeg             | File     |
      | SparkReadWrite.py              | File     |
      | Spark_ParquetToOracle.java     | File     |
      | ExternalTables.txt             | File     |
      | PostProcessor_AnalysisItem.mp4 | File     |

  @CAE_DirectoryCollector @TEST_MLPQA-3506 @MLPQA-17484 @7242048
  Scenario: Verify the Logging enhancements for collector_for_directory plugin
    Given Analysis log "cae/DirectoryCollector/AllFiles%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                     | logCode       | pluginName         | removableText  |
      | INFO | Plugin started                                                                                                                                                                                               | ANALYSIS-0019 |                    |                |
      | INFO | Plugin Name:DirectoryCollector, Plugin Type:CAE, Plugin Version:1.2.0.SNAPSHOT, Node Name:DIQIDAEDINODE2V.DIQ.QA.ASGINT.LOC, Host Name:DIQIDAEDINODE2V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:AllFiles | ANALYSIS-0071 | DirectoryCollector | Plugin Version |
      | INFO | Plugin DirectoryCollector Start Time:2020-11-08 14:10:40.879, End Time:2020-11-08 14:10:49.354, Processed Count:0, Errors:0, Warnings:0                                                                      | ANALYSIS-0072 | DirectoryCollector |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                               | ANALYSIS-0020 |                    |                |

    #BUg id - MLP-30230
  @webtest @CAE_DirectoryCollector @TEST_MLPQA-3507 @MLPQA-17484 @7242047
  Scenario: Verify breadcrumb hierarchy for the collected files
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TestOrcFile.orc" and clicks on search
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TestOrcFile.orc" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
#      | DEFAULT         |
#      | Users           |
#      | becubic_build   |
#      | Documents       |
      | FileTypes       |
      | SubFolder1      |
      | SubFolder2      |
      | TestOrcFile.orc |

  #Bug id - MLP-30227
  @webtest @CAE_DirectoryCollector @TEST_MLPQA-3504 @MLPQA-17484 @7242051
  Scenario: Verify the Business application tag and technology tags for the collected items in the UI
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AllFiles" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "BEC,FileSystem" should get displayed for the column "cae/DirectoryCollector/AllFiles"
    And user enters the search text "Default" and clicks on search
    And user performs "facet selection" in "FileSystem" attribute under "Tags" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                 | fileName            | userTag             |
      | Default     | File       | Metadata Type | BEC,Java,FileSystem | final.apk           | final.apk           |
      | Default     | SourceTree | Metadata Type | BEC,Java,FileSystem | Spark_CsvToOracle   | Spark_CsvToOracle   |
      | Default     | Function   | Metadata Type | BEC,Java,FileSystem | Spark_CsvToOracle() | Spark_CsvToOracle() |
      | Default     | Class      | Metadata Type | BEC,Java,FileSystem | Spark_CsvToOracle   | Spark_CsvToOracle   |
      | Default     | Project    | Metadata Type | BEC,Java,FileSystem | FileTypes           | FileTypes           |
      | Default     | Directory  | Metadata Type | BEC,Java,FileSystem | SubFolder1          | SubFolder1          |

  @webtest @CAE_DirectoryCollector @TEST_MLPQA-3505 @MLPQA-17484 @7242049
  Scenario: Verify the Metadata Information for Project, Directory and File item types
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EmployeeData.csv" and clicks on search
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "EmployeeData.csv" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Source Java   | Description |
      | MIME type         | text/csv      | Description |
    And user enters the search text "Spark_CsvToOracle.java" and clicks on search
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Spark_CsvToOracle.java" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue      | widgetName  |
      | Description       | Source Java        | Description |
      | MIME type         | text/x-java-source | Description |

  @PostCondition @CAE_DirectoryCollector
  Scenario Outline: Run Deletor plugin - AllFiles
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                   | path                                | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDeleteEntryPoint/FileSystem_Deletor                            | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_Config.json | $.FileSystem_Deletor.configurations | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDeleteEntryPoint/FileSystem_Deletor                            |                                                                                            |                                     | 200           | FileSystem_Deletor |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                              |                                                                                            |                                     | 200           | UP                 | $.nodeStatus                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDeleteEntryPoint/FileSystem_Deletor |                                                                                            |                                     | 200           | IDLE               | $.[?(@.configurationName=='FileSystem_Deletor')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAEDeleteEntryPoint/FileSystem_Deletor  |                                                                                            |                                     | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDeleteEntryPoint/FileSystem_Deletor |                                                                                            |                                     | 200           | IDLE               | $.[?(@.configurationName=='FileSystem_Deletor')].status |

  @PostCondition @CAE_DirectoryCollector
  Scenario Outline: Delete BA tag
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                           | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | /tags/Default/tags/FileSystem |          |      | 204           |                  |          |

    ##################################################################################################################################################################################################################################################################################################################################################################################################################################

  @PreCondition @CAE_DirectoryColector
  Scenario Outline: Run the plugins - RootLevelWithSubfolder_N
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                                   | path                                      | response code | response message         | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/FileSystem_Creator                               | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_Config.json | $.FileSystem_Creator.configurations       | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/FileSystem_Creator                               |                                                                                            |                                           | 200           | FileSystem_Creator       |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                 |                                                                                            |                                           | 200           | UP                       | $.nodeStatus                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/FileSystem_Creator    |                                                                                            |                                           | 200           | IDLE                     | $.[?(@.configurationName=='FileSystem_Creator')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAECreateEntryPoint/FileSystem_Creator     |                                                                                            |                                           | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/FileSystem_Creator    |                                                                                            |                                           | 200           | IDLE                     | $.[?(@.configurationName=='FileSystem_Creator')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/DirectoryCollector/RootLevelWithSubfolder_N                          | payloads/ida/CAE_FileSystem_Payloads/Configurations/RootLevelWithSubfolder_N.json          | $.RootLevelWithSubfolder_N.configurations | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/DirectoryCollector/RootLevelWithSubfolder_N                          |                                                                                            |                                           | 200           | RootLevelWithSubfolder_N |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                 |                                                                                            |                                           | 200           | UP                       | $.nodeStatus                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DirectoryCollector/RootLevelWithSubfolder_N |                                                                                            |                                           | 200           | IDLE                     | $.[?(@.configurationName=='RootLevelWithSubfolder_N')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/DirectoryCollector/RootLevelWithSubfolder_N  |                                                                                            |                                           | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DirectoryCollector/RootLevelWithSubfolder_N |                                                                                            |                                           | 200           | IDLE                     | $.[?(@.configurationName=='RootLevelWithSubfolder_N')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/FileSystem_Feeder                                            | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Feeder_Config.json          | $.FileSystem_Feeder.configurations        | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/FileSystem_Feeder                                            |                                                                                            |                                           | 200           | FileSystem_Feeder        |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                 |                                                                                            |                                           | 200           | UP                       | $.nodeStatus                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/FileSystem_Feeder                   |                                                                                            |                                           | 200           | IDLE                     | $.[?(@.configurationName=='FileSystem_Feeder')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/FileSystem_Feeder                    |                                                                                            |                                           | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/FileSystem_Feeder                   |                                                                                            |                                           | 200           | IDLE                     | $.[?(@.configurationName=='FileSystem_Feeder')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/FileSystem_DDLoader                                      | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Loader.json                 | $.FileSystem_DDLoader.configurations      | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/FileSystem_DDLoader                                      |                                                                                            |                                           | 200           | FileSystem_DDLoader      |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                 |                                                                                            |                                           | 200           | UP                       | $.nodeStatus                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/FileSystem_DDLoader            |                                                                                            |                                           | 200           | IDLE                     | $.[?(@.configurationName=='FileSystem_DDLoader')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/FileSystem_DDLoader             |                                                                                            |                                           | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/FileSystem_DDLoader            |                                                                                            |                                           | 200           | IDLE                     | $.[?(@.configurationName=='FileSystem_DDLoader')].status      |

  @webtest @CAE_DirectoryCollector @TEST_MLPQA-3511 @MLPQA-17484 @7241952
  Scenario: Run the collector plugin by giving the directory path upto Project level with * and subfolder=N. Verify the des file is generated and items collected in DD UI via loader plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "FileTypes" and clicks on search
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FileTypes" item from search results
    And user verifies "Files" table should have following values
      | fileName                  | fileType |
      | LineageScenarios.docx     | File     |
      | namesAndFavColors.parquet | File     |
      | ETL-System_Training.svg   | File     |
      | EmployeeData.csv          | File     |
      | final.apk                 | File     |
      | IMAGE.jpg                 | File     |
      | Output.crc                | File     |

  @CAE_DirectoryCollector @PostCondition
  Scenario Outline: Run Deletor plugin - RootLevelWithSubfolder_N
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                   | path                                | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDeleteEntryPoint/FileSystem_Deletor                            | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_Config.json | $.FileSystem_Deletor.configurations | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDeleteEntryPoint/FileSystem_Deletor                            |                                                                                            |                                     | 200           | FileSystem_Deletor |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                              |                                                                                            |                                     | 200           | UP                 | $.nodeStatus                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDeleteEntryPoint/FileSystem_Deletor |                                                                                            |                                     | 200           | IDLE               | $.[?(@.configurationName=='FileSystem_Deletor')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAEDeleteEntryPoint/FileSystem_Deletor  |                                                                                            |                                     | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDeleteEntryPoint/FileSystem_Deletor |                                                                                            |                                     | 200           | IDLE               | $.[?(@.configurationName=='FileSystem_Deletor')].status |

  #########################################################################################################################################################################################################################################################################################################

  @PreCondition @CAE_DirectoryCollector
  Scenario Outline: Run the plugins - MulConfigLines_WithSubFold_Y
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                           | bodyFile                                                                                   | path                                            | response code | response message               | jsonPath                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/FileSystem_Creator                                     | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_Config.json | $.FileSystem_Creator.configurations             | 204           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/FileSystem_Creator                                     |                                                                                            |                                                 | 200           | FileSystem_Creator             |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                       |                                                                                            |                                                 | 200           | UP                             | $.nodeStatus                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/FileSystem_Creator          |                                                                                            |                                                 | 200           | IDLE                           | $.[?(@.configurationName=='FileSystem_Creator')].status             |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAECreateEntryPoint/FileSystem_Creator           |                                                                                            |                                                 | 200           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/FileSystem_Creator          |                                                                                            |                                                 | 200           | IDLE                           | $.[?(@.configurationName=='FileSystem_Creator')].status             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/DirectoryCollector/MulConfigLines_WithSubFold_Y&N                          | payloads/ida/CAE_FileSystem_Payloads/Configurations/MulConfigLines_SubFolder_Y&N.json      | $.MulConfigLines_WithSubFold_Y&N.configurations | 204           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/DirectoryCollector/MulConfigLines_WithSubFold_Y&N                          |                                                                                            |                                                 | 200           | MulConfigLines_WithSubFold_Y&N |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                       |                                                                                            |                                                 | 200           | UP                             | $.nodeStatus                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DirectoryCollector/MulConfigLines_WithSubFold_Y&N |                                                                                            |                                                 | 200           | IDLE                           | $.[?(@.configurationName=='MulConfigLines_WithSubFold_Y&N')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/DirectoryCollector/MulConfigLines_WithSubFold_Y&N  |                                                                                            |                                                 | 200           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DirectoryCollector/MulConfigLines_WithSubFold_Y&N |                                                                                            |                                                 | 200           | IDLE                           | $.[?(@.configurationName=='MulConfigLines_WithSubFold_Y&N')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/FileSystem_Feeder                                                  | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Feeder_Config.json          | $.FileSystem_Feeder.configurations              | 204           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/FileSystem_Feeder                                                  |                                                                                            |                                                 | 200           | FileSystem_Feeder              |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                       |                                                                                            |                                                 | 200           | UP                             | $.nodeStatus                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/FileSystem_Feeder                         |                                                                                            |                                                 | 200           | IDLE                           | $.[?(@.configurationName=='FileSystem_Feeder')].status              |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/FileSystem_Feeder                          |                                                                                            |                                                 | 200           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/FileSystem_Feeder                         |                                                                                            |                                                 | 200           | IDLE                           | $.[?(@.configurationName=='FileSystem_Feeder')].status              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/FileSystem_DDLoader                                            | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Loader.json                 | $.FileSystem_DDLoader.configurations            | 204           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/FileSystem_DDLoader                                            |                                                                                            |                                                 | 200           | FileSystem_DDLoader            |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                       |                                                                                            |                                                 | 200           | UP                             | $.nodeStatus                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/FileSystem_DDLoader                  |                                                                                            |                                                 | 200           | IDLE                           | $.[?(@.configurationName=='FileSystem_DDLoader')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/FileSystem_DDLoader                   |                                                                                            |                                                 | 200           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/FileSystem_DDLoader                  |                                                                                            |                                                 | 200           | IDLE                           | $.[?(@.configurationName=='FileSystem_DDLoader')].status            |

  @webtest @CAE_DirectoryCollector @TEST_MLPQA-3510 @MLPQA-17484 @7242009
  Scenario: Run collector plugin with multiple config lines upto the subfolder level with * and subfolder=Y . Verify the des file is generated and items are collected in DD UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "FileTypes" and clicks on search
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FileTypes" item from search results
    And user verifies "Has_Directory" table should have following values
      | SubFolder1 | Directory |
    Then user performs click and verify in new window
      | Table         | value      | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | SubFolder1 | click and switch tab | No               |             |
    Then user verifies "Data" table should have following values
      | fileName               | fileType |
      | asg.jks                | File     |
      | Download.png           | File     |
      | RochadeImport.xml      | File     |
      | WhatsAppImage.jpeg     | File     |
      | ExternalTables.txt     | File     |
      | Spark_CsvToOracle.java | File     |
      | EDIBusSample.jmx       | File     |
    And user verifies "has_Directory" table should have following values
      | fileName   | fileType  |
      | SubFolder3 | Directory |
    Then user performs click and verify in new window
      | Table         | value      | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | SubFolder3 | click and switch tab | No               |             |
    Then user verifies "Data" table should have following values
      | fileName                       | fileType |
      | PaymentReceipt.pdf             | File     |
      | WhatsAppImage.jpeg             | File     |
      | SparkReadWrite.py              | File     |
      | Spark_ParquetToOracle.java     | File     |
      | ExternalTables.txt             | File     |
      | PostProcessor_AnalysisItem.mp4 | File     |

  @CAE_DirectoryCollector @PostCondition
  Scenario Outline: Run Deletor plugin - MulConfigLines_WithSubFold_Y
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                   | path                                | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDeleteEntryPoint/FileSystem_Deletor                            | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_Config.json | $.FileSystem_Deletor.configurations | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDeleteEntryPoint/FileSystem_Deletor                            |                                                                                            |                                     | 200           | FileSystem_Deletor |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                              |                                                                                            |                                     | 200           | UP                 | $.nodeStatus                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDeleteEntryPoint/FileSystem_Deletor |                                                                                            |                                     | 200           | IDLE               | $.[?(@.configurationName=='FileSystem_Deletor')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAEDeleteEntryPoint/FileSystem_Deletor  |                                                                                            |                                     | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDeleteEntryPoint/FileSystem_Deletor |                                                                                            |                                     | 200           | IDLE               | $.[?(@.configurationName=='FileSystem_Deletor')].status |

#########################################################################################################################################################################################################################################################################################################

  @PreCondition @CAE_DirectoryCollector
  Scenario Outline:Run the plugins - MulConfigLines_WithFileExtension_Subfold_Y
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                       | bodyFile                                                                                      | path                                                        | response code | response message                           | jsonPath                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/FileSystem_Creator                                                 | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_Config.json    | $.FileSystem_Creator.configurations                         | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/FileSystem_Creator                                                 |                                                                                               |                                                             | 200           | FileSystem_Creator                         |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                                   |                                                                                               |                                                             | 200           | UP                                         | $.nodeStatus                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/FileSystem_Creator                      |                                                                                               |                                                             | 200           | IDLE                                       | $.[?(@.configurationName=='FileSystem_Creator')].status                         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAECreateEntryPoint/FileSystem_Creator                       |                                                                                               |                                                             | 200           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/FileSystem_Creator                      |                                                                                               |                                                             | 200           | IDLE                                       | $.[?(@.configurationName=='FileSystem_Creator')].status                         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/DirectoryCollector/MulConfigLines_WithFileExtension_Subfold_Y                          | payloads/ida/CAE_FileSystem_Payloads/Configurations/MulConfigLines_WithFileExt_Subfold_Y.json | $.MulConfigLines_WithFileExtension_Subfold_Y.configurations | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/DirectoryCollector/MulConfigLines_WithFileExtension_Subfold_Y                          |                                                                                               |                                                             | 200           | MulConfigLines_WithFileExtension_Subfold_Y |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                                   |                                                                                               |                                                             | 200           | UP                                         | $.nodeStatus                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DirectoryCollector/MulConfigLines_WithFileExtension_Subfold_Y |                                                                                               |                                                             | 200           | IDLE                                       | $.[?(@.configurationName=='MulConfigLines_WithFileExtension_Subfold_Y')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/DirectoryCollector/MulConfigLines_WithFileExtension_Subfold_Y  |                                                                                               |                                                             | 200           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DirectoryCollector/MulConfigLines_WithFileExtension_Subfold_Y |                                                                                               |                                                             | 200           | IDLE                                       | $.[?(@.configurationName=='MulConfigLines_WithFileExtension_Subfold_Y')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/FileSystem_Feeder                                                              | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Feeder_Config.json             | $.FileSystem_Feeder.configurations                          | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/FileSystem_Feeder                                                              |                                                                                               |                                                             | 200           | FileSystem_Feeder                          |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                                   |                                                                                               |                                                             | 200           | UP                                         | $.nodeStatus                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/FileSystem_Feeder                                     |                                                                                               |                                                             | 200           | IDLE                                       | $.[?(@.configurationName=='FileSystem_Feeder')].status                          |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/FileSystem_Feeder                                      |                                                                                               |                                                             | 200           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/FileSystem_Feeder                                     |                                                                                               |                                                             | 200           | IDLE                                       | $.[?(@.configurationName=='FileSystem_Feeder')].status                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/FileSystem_DDLoader                                                        | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Loader.json                    | $.FileSystem_DDLoader.configurations                        | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/FileSystem_DDLoader                                                        |                                                                                               |                                                             | 200           | FileSystem_DDLoader                        |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                                   |                                                                                               |                                                             | 200           | UP                                         | $.nodeStatus                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/FileSystem_DDLoader                              |                                                                                               |                                                             | 200           | IDLE                                       | $.[?(@.configurationName=='FileSystem_DDLoader')].status                        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/FileSystem_DDLoader                               |                                                                                               |                                                             | 200           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/FileSystem_DDLoader                              |                                                                                               |                                                             | 200           | IDLE                                       | $.[?(@.configurationName=='FileSystem_DDLoader')].status                        |

  @webtest @CAE_DirectoryCollector @TEST_MLPQA-3509 @MLPQA-17484 @7242013
  Scenario: Run collector plugin with multiple config lines with file extension as filter and subfolder=Y . Verify the des file is generated and items are collected in DD UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "FileTypes" and clicks on search
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FileTypes" item from search results
    And user verifies "Files" table should have following values
      | fileName              | fileType |
      | LineageScenarios.docx | File     |
    And user verifies "Has_Directory" table should have following values
      | SubFolder1 | Directory |
    Then user performs click and verify in new window
      | Table         | value      | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | SubFolder1 | click and switch tab | No               |             |
    And user verifies "has_Directory" table should have following values
      | fileName   | fileType  |
      | SubFolder2 | Directory |
      | SubFolder3 | Directory |
    Then user performs click and verify in new window
      | Table         | value      | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | SubFolder2 | click and switch tab | No               |             |
    Then user verifies "Data" table should have following values
      | fileName                   | fileType |
      | Spark_OracleToParquet.java | File     |
      | Spark_ParquetToOracle.java | File     |
    And user clicks on "SubFolder1" item in the breadcrumb items
    Then user performs click and verify in new window
      | Table         | value      | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | SubFolder3 | click and switch tab | No               |             |
    Then user verifies "Data" table should have following values
      | fileName           | fileType |
      | PaymentReceipt.pdf | File     |

  @CAE_DirectoryCollector @PostCondition
  Scenario Outline:Run Deletor plugin - MulConfigLines_WithFileExtension_Subfold_Y
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                   | path                                | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDeleteEntryPoint/FileSystem_Deletor                            | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_Config.json | $.FileSystem_Deletor.configurations | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDeleteEntryPoint/FileSystem_Deletor                            |                                                                                            |                                     | 200           | FileSystem_Deletor |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                              |                                                                                            |                                     | 200           | UP                 | $.nodeStatus                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDeleteEntryPoint/FileSystem_Deletor |                                                                                            |                                     | 200           | IDLE               | $.[?(@.configurationName=='FileSystem_Deletor')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAEDeleteEntryPoint/FileSystem_Deletor  |                                                                                            |                                     | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDeleteEntryPoint/FileSystem_Deletor |                                                                                            |                                     | 200           | IDLE               | $.[?(@.configurationName=='FileSystem_Deletor')].status |

    #########################################################################################################################################################################################################################################################################################################

  Scenario Outline: Run the plugins - WithFileName_SubFolder_N
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                                   | path                                      | response code | response message         | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/FileSystem_Creator                               | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_Config.json | $.FileSystem_Creator.configurations       | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/FileSystem_Creator                               |                                                                                            |                                           | 200           | FileSystem_Creator       |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                 |                                                                                            |                                           | 200           | UP                       | $.nodeStatus                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/FileSystem_Creator    |                                                                                            |                                           | 200           | IDLE                     | $.[?(@.configurationName=='FileSystem_Creator')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAECreateEntryPoint/FileSystem_Creator     |                                                                                            |                                           | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/FileSystem_Creator    |                                                                                            |                                           | 200           | IDLE                     | $.[?(@.configurationName=='FileSystem_Creator')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/DirectoryCollector/WithFileName_SubFolder_N                          | payloads/ida/CAE_FileSystem_Payloads/Configurations/WithFileName_Subfold_N.json            | $.WithFileName_SubFolder_N.configurations | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/DirectoryCollector/WithFileName_SubFolder_N                          |                                                                                            |                                           | 200           | WithFileName_SubFolder_N |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                 |                                                                                            |                                           | 200           | UP                       | $.nodeStatus                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DirectoryCollector/WithFileName_SubFolder_N |                                                                                            |                                           | 200           | IDLE                     | $.[?(@.configurationName=='WithFileName_SubFolder_N')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/DirectoryCollector/WithFileName_SubFolder_N  |                                                                                            |                                           | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DirectoryCollector/WithFileName_SubFolder_N |                                                                                            |                                           | 200           | IDLE                     | $.[?(@.configurationName=='WithFileName_SubFolder_N')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/FileSystem_Feeder                                            | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Feeder_Config.json          | $.FileSystem_Feeder.configurations        | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/FileSystem_Feeder                                            |                                                                                            |                                           | 200           | FileSystem_Feeder        |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                 |                                                                                            |                                           | 200           | UP                       | $.nodeStatus                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/FileSystem_Feeder                   |                                                                                            |                                           | 200           | IDLE                     | $.[?(@.configurationName=='FileSystem_Feeder')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/FileSystem_Feeder                    |                                                                                            |                                           | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/FileSystem_Feeder                   |                                                                                            |                                           | 200           | IDLE                     | $.[?(@.configurationName=='FileSystem_Feeder')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/FileSystem_DDLoader                                      | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Loader.json                 | $.FileSystem_DDLoader.configurations      | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/FileSystem_DDLoader                                      |                                                                                            |                                           | 200           | FileSystem_DDLoader      |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                 |                                                                                            |                                           | 200           | UP                       | $.nodeStatus                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/FileSystem_DDLoader            |                                                                                            |                                           | 200           | IDLE                     | $.[?(@.configurationName=='FileSystem_DDLoader')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/FileSystem_DDLoader             |                                                                                            |                                           | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/FileSystem_DDLoader            |                                                                                            |                                           | 200           | IDLE                     | $.[?(@.configurationName=='FileSystem_DDLoader')].status      |

  @webtest @CAE_Directorycollector @TEST_MLPQA-3508 @MLPQA-17484 @7242015
  Scenario: Run collector plugin with file name as filter and subfolder=N . Verify the des file is generated and items are collected in DD UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "FileTypes" and clicks on search
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FileTypes" item from search results
    And user verifies "Has_Directory" table should have following values
      | SubFolder1 | Directory |
    Then user performs click and verify in new window
      | Table         | value      | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | SubFolder1 | click and switch tab | No               |             |
    Then user verifies "Data" table should have following values
      | fileName          | fileType |
      | RochadeImport.xml | File     |

  @PostCondition @CAE_DirectoryCollector
  Scenario Outline: Run Deletor plugin - WithFileName_SubFolder_N
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                   | path                                | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDeleteEntryPoint/FileSystem_Deletor                            | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_Config.json | $.FileSystem_Deletor.configurations | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDeleteEntryPoint/FileSystem_Deletor                            |                                                                                            |                                     | 200           | FileSystem_Deletor |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                              |                                                                                            |                                     | 200           | UP                 | $.nodeStatus                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDeleteEntryPoint/FileSystem_Deletor |                                                                                            |                                     | 200           | IDLE               | $.[?(@.configurationName=='FileSystem_Deletor')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAEDeleteEntryPoint/FileSystem_Deletor  |                                                                                            |                                     | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDeleteEntryPoint/FileSystem_Deletor |                                                                                            |                                     | 200           | IDLE               | $.[?(@.configurationName=='FileSystem_Deletor')].status |

  ######################################################Setting up the credentials and configuring Datasource to test on SQLServer CAE DB##################################################################################

  @PreCondition @CAE_DirectoryCollector
  Scenario Outline:Set Credentials for Creator and Feeder Plugins for SQL Server DB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                  | bodyFile                                                             | path                              | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/Valid_Entrypoint_Cred_SQLServer | payloads/ida/CAE_FileSystem_Payloads/Configurations/Credentials.json | $.Valid_Entrypoint_Cred_SQLServer | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Valid_Entrypoint_Cred_SQLServer |                                                                      |                                   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/Valid_Feeder_Cred_SQLServer     | payloads/ida/CAE_FileSystem_Payloads/Configurations/Credentials.json | $.Valid_Feeder_Cred_SQLServer     | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Valid_Feeder_Cred_SQLServer     |                                                                      |                                   | 200           |                  |          |

  @PreCondition @CAE_DirectoryCollector
  Scenario Outline:Run DataSources for Creating Entry point, Feeder and ETL plugins for SQl Server DB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                           | bodyFile                                                                               | path                                                  | response code | response message             | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource/FileSystem_EntryPoint_DS_SQL | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_DS.json | $.FileSystem_EntryPoint_DS_SQL.configurations.[0]     | 204           |                              |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource/FileSystem_EntryPoint_DS_SQL |                                                                                        |                                                       | 200           | FileSystem_EntryPoint_DS_SQL |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource/FileSystem_Feeder_DS_SQL     | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Feeder_DS.json          | $.FileSystem_Feeder_DataSource_SQL.configurations.[0] | 204           |                              |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource/FileSystem_Feeder_DS_SQL     |                                                                                        |                                                       | 200           | FileSystem_Feeder_DS_SQL     |          |

  @PreCondition @CAE_DirectoryCollector
  Scenario Outline: Run the plugins - AllFiles_SQLServer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                                                                   | path                                     | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/FileSystem_Creator_Sql                            | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_Config.json | $.FileSystem_Creator_Sql.configurations  | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/FileSystem_Creator_Sql                            |                                                                                            |                                          | 200           | FileSystem_Creator_Sql  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                  |                                                                                            |                                          | 200           | UP                      | $.nodeStatus                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/FileSystem_Creator_Sql |                                                                                            |                                          | 200           | IDLE                    | $.[?(@.configurationName=='FileSystem_Creator_Sql')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAECreateEntryPoint/FileSystem_Creator_Sql  |                                                                                            |                                          | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/FileSystem_Creator_Sql |                                                                                            |                                          | 200           | IDLE                    | $.[?(@.configurationName=='FileSystem_Creator_Sql')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/DirectoryCollector/AllFiles                                           | payloads/ida/CAE_FileSystem_Payloads/Configurations/AllFiles.json                          | $.AllFiles.configurations                | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/DirectoryCollector/AllFiles                                           |                                                                                            |                                          | 200           | AllFiles                |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                  |                                                                                            |                                          | 200           | UP                      | $.nodeStatus                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DirectoryCollector/AllFiles                  |                                                                                            |                                          | 200           | IDLE                    | $.[?(@.configurationName=='AllFiles')].status                |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/DirectoryCollector/AllFiles                   |                                                                                            |                                          | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DirectoryCollector/AllFiles                  |                                                                                            |                                          | 200           | IDLE                    | $.[?(@.configurationName=='AllFiles')].status                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/FileSystem_Feeder_Sql                                         | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Feeder_Config.json          | $.FileSystem_Feeder_Sql.configurations   | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/FileSystem_Feeder_Sql                                         |                                                                                            |                                          | 200           | FileSystem_Feeder_Sql   |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                  |                                                                                            |                                          | 200           | UP                      | $.nodeStatus                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/FileSystem_Feeder_Sql                |                                                                                            |                                          | 200           | IDLE                    | $.[?(@.configurationName=='FileSystem_Feeder_Sql')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/FileSystem_Feeder_Sql                 |                                                                                            |                                          | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/FileSystem_Feeder_Sql                |                                                                                            |                                          | 200           | IDLE                    | $.[?(@.configurationName=='FileSystem_Feeder_Sql')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/FileSystem_DDLoader_Sql                                   | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Loader.json                 | $.FileSystem_DDLoader_Sql.configurations | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/FileSystem_DDLoader_Sql                                   |                                                                                            |                                          | 200           | FileSystem_DDLoader_Sql |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                  |                                                                                            |                                          | 200           | UP                      | $.nodeStatus                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/FileSystem_DDLoader_Sql         |                                                                                            |                                          | 200           | IDLE                    | $.[?(@.configurationName=='FileSystem_DDLoader_Sql')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/FileSystem_DDLoader_Sql          |                                                                                            |                                          | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/FileSystem_DDLoader_Sql         |                                                                                            |                                          | 200           | IDLE                    | $.[?(@.configurationName=='FileSystem_DDLoader_Sql')].status |

  @webtest @CAE_DirectoryCollector @TEST_MLPQA-18256 @MLPQA-18084
  Scenario: Validate  CAE Directory collector collected data items are feeded in SQL Server and loaded in DD
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "FileTypes" and clicks on search
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FileTypes" item from search results
    And user verifies "Files" table should have following values
      | fileName                  | fileType |
      | LineageScenarios.docx     | File     |
      | namesAndFavColors.parquet | File     |
      | ETL-System_Training.svg   | File     |
      | EmployeeData.csv          | File     |
      | final.apk                 | File     |
      | IMAGE.jpg                 | File     |
      | Output.crc                | File     |
    And user verifies "Has_Directory" table should have following values
      | SubFolder1 | Directory |
    Then user performs click and verify in new window
      | Table         | value      | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | SubFolder1 | click and switch tab | No               |             |
    Then user verifies "Data" table should have following values
      | fileName               | fileType |
      | asg.jks                | File     |
      | Download.png           | File     |
      | RochadeImport.xml      | File     |
      | WhatsAppImage.jpeg     | File     |
      | ExternalTables.txt     | File     |
      | Spark_CsvToOracle.java | File     |
      | EDIBusSample.jmx       | File     |
    And user verifies "has_Directory" table should have following values
      | fileName   | fileType  |
      | SubFolder2 | Directory |
      | SubFolder3 | Directory |
    Then user performs click and verify in new window
      | Table         | value      | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | SubFolder2 | click and switch tab | No               |             |
    Then user verifies "Data" table should have following values
      | fileName                   | fileType |
      | PluginConfig.json          | File     |
      | SparkFolder.zip            | File     |
      | TestOrcFile.orc            | File     |
      | Spark_OracleToParquet.java | File     |
      | SparkReadWrite.py          | File     |
      | Screenshots.7z             | File     |
      | Spark_ParquetToOracle.java | File     |
    And user clicks on "SubFolder1" item in the breadcrumb items
    Then user performs click and verify in new window
      | Table         | value      | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | SubFolder3 | click and switch tab | No               |             |
    Then user verifies "Data" table should have following values
      | fileName                       | fileType |
      | PaymentReceipt.pdf             | File     |
      | WhatsAppImage.jpeg             | File     |
      | SparkReadWrite.py              | File     |
      | Spark_ParquetToOracle.java     | File     |
      | ExternalTables.txt             | File     |
      | PostProcessor_AnalysisItem.mp4 | File     |

  @PostCondition @CAE_DirectoryCollector
  Scenario Outline: Run Deletor plugin - AllFiles_SQLServer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                                                                   | path                                    | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDeleteEntryPoint/FileSystem_Deletor_Sql                            | payloads/ida/CAE_FileSystem_Payloads/Configurations/FileSystem_Creator_Deletor_Config.json | $.FileSystem_Deletor_Sql.configurations | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDeleteEntryPoint/FileSystem_Deletor_Sql                            |                                                                                            |                                         | 200           | FileSystem_Deletor_Sql |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/HeadlessEDI                                                  |                                                                                            |                                         | 200           | UP                     | $.nodeStatus                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDeleteEntryPoint/FileSystem_Deletor_Sql |                                                                                            |                                         | 200           | IDLE                   | $.[?(@.configurationName=='FileSystem_Deletor_Sql')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAEDeleteEntryPoint/FileSystem_Deletor_Sql  |                                                                                            |                                         | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDeleteEntryPoint/FileSystem_Deletor_Sql |                                                                                            |                                         | 200           | IDLE                   | $.[?(@.configurationName=='FileSystem_Deletor_Sql')].status |
