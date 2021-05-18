@MLP-1960
Feature:MLP-1960: Rework of CSV Analyzer to IDA Plugin
  Description: Hdfs bundle(previously known as IDC Prototype CatalogHdfs project ) is a set of plugins for gathering metadata, parsing directories and monitoring events in Hdfs File system


  ###################################################Delete existing Anlaysis and CLuster if any#############################

  @positve @regression @sanity  @ambari
  Scenario:Pre-Condition:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvAnalyzer/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo               | Cluster  |       |       |
      | SingleItemDelete | Default | Sandbox                    | Cluster  |       |       |
      | SingleItemDelete | Default | Cluster 1                  | Cluster  |       |       |

  ###############################################################################################################################
#7152593
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC1#Get the CSV Analyzer Configuration response
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                               | body                                    | response code | response message | filePath                                  | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | /schemes/analyzers/configurations | response/CSV_Analyzer/body/ToolTip.json | 200           |                  | response/CSV_Analyzer/actual/ToolTip.json |          |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline:SC2# Validate ToolTip for all the fields in CSV Analyzer plugin(Type,Plugin,Name,Plugin version,label,BA, Data Source, Credential,Event Condition,Dry Run, Event class,Max Work sixe,node condition,Auto Start,tags,Unique Filter)
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                              | actualValues                              | valueType     | expectedJsonPath                                    | actualJsonPath                                                  |
      | response/CSV_Analyzer/expected/ToolTip.json | response/CSV_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields..[?(@.label=='Type')].tooltip        | $..[?(@.label=='Type')].tooltip                                 |
      | response/CSV_Analyzer/expected/ToolTip.json | response/CSV_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields..[?(@.label=='Plugin')].tooltip      | $..[?(@.label=='Plugin')].tooltip                               |
      | response/CSV_Analyzer/expected/ToolTip.json | response/CSV_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.Name.tooltip                         | $.properties[0].value.prototype.properties[2].tooltip           |
      | response/CSV_Analyzer/expected/ToolTip.json | response/CSV_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.pluginVersion.tooltip                | $.properties[0].value.prototype.properties[3].tooltip           |
      | response/CSV_Analyzer/expected/ToolTip.json | response/CSV_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.label.tooltip                        | $.properties[0].value.prototype.properties[4].tooltip           |
      | response/CSV_Analyzer/expected/ToolTip.json | response/CSV_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.businessApplicationName.tooltip      | $.properties[0].value.prototype.properties[15].tooltip          |
      | response/CSV_Analyzer/expected/ToolTip.json | response/CSV_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.eventCondition.tooltip               | $.properties[0].value.prototype.properties[5].tooltip           |
      | response/CSV_Analyzer/expected/ToolTip.json | response/CSV_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.dryRun.tooltip                       | $.properties[0].value.prototype.properties[6].tooltip           |
      | response/CSV_Analyzer/expected/ToolTip.json | response/CSV_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.eventClass.tooltip                   | $.properties[0].value.prototype.properties[7].tooltip           |
      | response/CSV_Analyzer/expected/ToolTip.json | response/CSV_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.maxWorkSize.tooltip                  | $.properties[0].value.prototype.properties[8].tooltip           |
      | response/CSV_Analyzer/expected/ToolTip.json | response/CSV_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.nodeCondition.tooltip                | $.properties[0].value.prototype.properties[10].tooltip          |
      | response/CSV_Analyzer/expected/ToolTip.json | response/CSV_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.autoStart.tooltip                    | $.properties[0].value.prototype.properties[11].tooltip          |
      | response/CSV_Analyzer/expected/ToolTip.json | response/CSV_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.tags.tooltip                         | $.properties[0].value.prototype.properties[12].tooltip          |
      | response/CSV_Analyzer/expected/ToolTip.json | response/CSV_Analyzer/actual/ToolTip.json | stringCompare | $.Uniquefilter.CSVAnlayzer.sampleSize.tooltip       | $.properties[0].value.prototype.properties[16].value[0].tooltip |
      | response/CSV_Analyzer/expected/ToolTip.json | response/CSV_Analyzer/actual/ToolTip.json | stringCompare | $.Uniquefilter.CSVAnlayzer.histogramBuckets.tooltip | $.properties[0].value.prototype.properties[17].tooltip          |
      | response/CSV_Analyzer/expected/ToolTip.json | response/CSV_Analyzer/actual/ToolTip.json | stringCompare | $.Uniquefilter.CSVAnlayzer.topValues.tooltip        | $.properties[0].value.prototype.properties[18].tooltip          |


       #######################################setting the Credentials, BA ###############################################

  Scenario: SC2#-MLP_24889_Update the Host name respect to the docker
    And user update json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |

  Scenario: SC2#-MLP_24889_Update the node condition and analyzer graph fields
    And user "update" the json file "ida/CsvAnalyzer/Analyzer/SC1_new_Csv_Analyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues           | type    |
      | $.configurations..nodeCondition    | name=="Cluster Demo" |         |
      | $.configurations..name             | CsvAnalyzerQA        |         |
      | $.configurations..tags[*]          | CsvAnalyzerQA        |         |
      | $.configurations..histogramBuckets | 100                  | Integer |
      | $.configurations..sampleSize       | 10                   | Integer |
      | $.configurations..topValues        | 10                   | Integer |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC2#-MLP_24889_Set the Credentials, Datasource, Bussiness Application and Cataloger for HDFSDB Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                        | body                                                             | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hdfsDBValidCredential | ida/hdfsPayloads/Credentials/hdfsdbValidCredentials.json         | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hdfsDBValidCredential |                                                                  | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root                         | ida\CsvAnalyzer\Bussiness_Application\BussinessApplication.json  | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root                         | ida\hdfsPayloads\Bussiness_Application\BussinessApplication.json | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/license                           | ida\hbasePayloads\DataSource\license_DS.json                     | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsDataSource          | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json     | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HdfsDataSource          |                                                                  | 200           | HDFSDataSource_valid |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CsvAnalyzer             | ida/CsvAnalyzer/Analyzer/SC1_new_Csv_Analyzer_Configuration.json | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CsvAnalyzer             |                                                                  | 200           | CsvAnalyzerQA        |          |


       ######################################Analyzer mandatory field error validation#####################################
#7152594
  @MLP-24196 @webtest @regression @positive
  Scenario:SC3#MLP_24196_Verify CSV Analyzer empty field validation messaged
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem   |
      | Open Deployment | Cluster Demo |
    And user "click" on "Add Configuration" button under "Cluster Demo" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Type      | Dataanalyzer |
      | Plugin    | CsvAnalyzer  |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName      | attribute |
      | Plugin version | LATEST    |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  | CsvAnalyzerQA          |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                                        |
      | Name      | Name already exists. Please enter a different name. |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  | /////                  |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                                                               |
      | Name      | Invalid name. Leading/trailing blanks and special characters are forbidden |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Sample size           |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName   | errorMessage                          |
      | Sample size | Sample size field should not be empty |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Histogram buckets     |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                |
      | Histogram buckets | Histogram buckets field should not be empty |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Top values            |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName  | errorMessage                         |
      | Top values | Top values field should not be empty |

     #Bug-26017
    #Bug-26017
  @MLP-24196 @webtest @regression @positive
  Scenario:SC3#MLP_24196_Verify CSV Analyzer field Histogram Bucket, Top values and Sample data Count shows proper error message for higher values
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem   |
      | Open Deployment | Cluster Demo |
    And user "click" on "Add Configuration" button under "Cluster Demo" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Type      | Dataanalyzer |
      | Plugin    | CsvAnalyzer  |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName      | attribute |
      | Plugin version | LATEST    |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Sample size           | 9                      |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName   | errorMessage                                      |
      | Sample size | Value of Sample size should not be lesser than 10 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Sample size           | 1001                   |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName   | errorMessage                                         |
      | Sample size | Value of Sample size should not be greater than 1000 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Top values            | 4                      |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName  | errorMessage                                    |
      | Top values | Value of Top values should not be lesser than 5 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Top values            | 31                     |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName  | errorMessage                                      |
      | Top values | Value of Top values should not be greater than 30 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Histogram buckets     | 4                      |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                           |
      | Histogram buckets | Value of Histogram buckets should not be lesser than 5 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Histogram buckets     | 21                     |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                             |
      | Histogram buckets | Value of Histogram buckets should not be greater than 20 |


  ########################################################Data Sample and Data profiling with cluster resolve FALSE#############################################


  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC#4Creating a directory in Ambari Files View and Uploading a file into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                       | body                                             | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | CsvAnalyzerTest/CSV1/CSV2/cityFile1.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true          | ida/hdfsPayloads/TestData/cityFile1.csv          | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | CsvAnalyzerTest/CSV1/CSV2/DiffdatatypesWOH.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true   | ida/hdfsPayloads/TestData/DiffdatatypesWOH.csv   | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | CsvAnalyzerTest/CSV1/CSV2/product_sample.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/product_sample.parquet | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | CsvAnalyzerTest/CSV1/CSV2/userDiffDataTypes.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/userDiffDataTypes.avro | 201           |                  |


  Scenario: SC4#-MLP_24889_Update the plugoin name and tag name
    And user "update" the json file "ida/CsvAnalyzer/Analyzer/SC1_new_CSVHdfs_Cataloger_False_Configuration.json" file for following values
      | jsonPath                               | jsonValues                         | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"               |         |
      | $.configurations..dataSource           | HDFSDataSource_resolveclusterfalse |         |
      | $.configurations..filter..root         | /CsvAnalyzerTest                   |         |
      | $.configurations..name                 | SC1_DataSamp_Profiling             |         |
      | $.configurations..tags[*]              | SC1_DataSamp_Profiling             |         |
      | $.configurations..filter..tags[*]      | Positive                           |         |
      | $.configurations..analyzeCollectedData | false                              | boolean |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC4#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger for csv analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                            | response code | response message                   | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                          | ida\hbasePayloads\DataSource\license_DS.json                                    | 204           |                                    |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                         | ida/CsvAnalyzer/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                         |                                                                                 | 200           | HDFSDataSource_resolveclusterfalse |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                          | ida/CsvAnalyzer/Analyzer/SC1_new_CSVHdfs_Cataloger_False_Configuration.json     | 204           |                                    |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                          |                                                                                 | 200           | SC1_DataSamp_Profiling             |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_DataSamp_Profiling |                                                                                 | 200           | IDLE                               | $.[?(@.configurationName=='SC1_DataSamp_Profiling')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC1_DataSamp_Profiling  |                                                                                 | 200           |                                    |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_DataSamp_Profiling |                                                                                 | 200           | IDLE                               | $.[?(@.configurationName=='SC1_DataSamp_Profiling')].status |


  Scenario: SC4#-MLP_24889_Update the node condition and analyzer graph fields
    And user "update" the json file "ida/CsvAnalyzer/Analyzer/SC1_new_Csv_Analyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues           | type    |
      | $.configurations..nodeCondition    | name=="Cluster Demo" |         |
      | $.configurations..name             | SC1_CsvAnalyzer      |         |
      | $.configurations..tags[*]          | SC1_CsvAnalyzer      |         |
      | $.configurations..histogramBuckets | 100                  | Integer |
      | $.configurations..sampleSize       | 10                   | Integer |
      | $.configurations..topValues        | 10                   | Integer |

    #7152591
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC4#-MLP_24889_Verify CsvAnalyzer does data sampling/data profiling properly for csv files when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:False)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | body                                                             | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CsvAnalyzer                                                      | ida/CsvAnalyzer/Analyzer/SC1_new_Csv_Analyzer_Configuration.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CsvAnalyzer                                                      |                                                                  | 200           | SC1_CsvAnalyzer  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC1_CsvAnalyzer |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='SC1_CsvAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC1_CsvAnalyzer  |                                                                  | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC1_CsvAnalyzer |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='SC1_CsvAnalyzer')].status |


     ###################################################Data Profiling########################################################################
#7152591
  @webtest
  Scenario: SC#4 Verify Data profiling not happened other than csv files and displayed for Interger/Numeric/String and Boolean (Boolean, double, integer, String) datatype in CassandraDB Table.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1_CsvAnalyzer" and clicks on search
    And user performs "definite facet selection" in "SC1_CsvAnalyzer" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "CsvAnalyzerTest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CSV2" item from search results
    Then user performs click and verify in new window
      | Table  | value                | Action               | RetainPrevwindow | indexSwitch |
      | Files  | DiffdatatypesWOH.csv | click and switch tab | No               |             |
      | Fields | _c5                  | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | _c2   | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | _c9   | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section not present" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | _c7   | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section not present" on "Data Distribution" in Item view page
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | _c7                                           |
      | attributeName  | Maximum value                                 |
      | actualFilePath | ida\CsvAnalyzer\API\Actual\Maximum value.json |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | _c7                                           |
      | attributeName  | Minimum value                                 |
      | actualFilePath | ida\CsvAnalyzer\API\Actual\Minimum value.json |
    Then file content in "ida\CsvAnalyzer\API\Actual\Maximum value.json" should be same as the content in "ida\CsvAnalyzer\API\Expected\Maximum value.json"
    Then file content in "ida\CsvAnalyzer\API\Actual\Minimum value.json" should be same as the content in "ida\CsvAnalyzer\API\Expected\Minimum value.json"
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value | Action                    | RetainPrevwindow | indexSwitch | filePath                                  | jsonPath               | metadataSection |
      | Fields | _c5   | click and verify metadata | Yes              | 0           | ida/CsvAnalyzer/API/expectedMetadata.json | $.DiffdatatypesWOH._c5 | Statistics      |
      | Fields | _c2   | click and verify metadata | Yes              | 0           | ida/CsvAnalyzer/API/expectedMetadata.json | $.DiffdatatypesWOH._c2 | Statistics      |
      | Fields | _c9   | click and verify metadata | Yes              | 0           | ida/CsvAnalyzer/API/expectedMetadata.json | $.DiffdatatypesWOH._c9 | Statistics      |

    ########################################################Data Sample validation############################################################################

  Scenario Outline:SC4:user get the Dynamic ID's (Database ID) for the Directory "CSV2" and File "cityFile1.csv,DiffdatatypesWOH.csv,product_sample.parquet and userDiffDataTypes.avro"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type      | name | asg_scopeid            | targetFile                              | jsonpath                                 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | CSV2 | cityFile1.csv          | payloads/ida/CsvAnalyzer/API/items.json | $.Directories.Filename.cityFile1         |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | CSV2 | DiffdatatypesWOH.csv   | payloads/ida/CsvAnalyzer/API/items.json | $.Directories.Filename.DiffdatatypesWOH  |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | CSV2 | product_sample.parquet | payloads/ida/CsvAnalyzer/API/items.json | $.Directories.Filename.product_sample    |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | CSV2 | userDiffDataTypes.avro | payloads/ida/CsvAnalyzer/API/items.json | $.Directories.Filename.userDiffDataTypes |

  Scenario Outline: SC4:user hits the FileID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                                | inputFile                               | outPutFile                                                 | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.cityFile1         | payloads/ida/CsvAnalyzer/API/items.json | payloads\ida\CsvAnalyzer\API\Actual\cityFile1.json         |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.DiffdatatypesWOH  | payloads/ida/CsvAnalyzer/API/items.json | payloads\ida\CsvAnalyzer\API\Actual\DiffdatatypesWOH.json  |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.product_sample    | payloads/ida/CsvAnalyzer/API/items.json | payloads\ida\CsvAnalyzer\API\Actual\product_sample.json    |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.userDiffDataTypes | payloads/ida/CsvAnalyzer/API/items.json | payloads\ida\CsvAnalyzer\API\Actual\userDiffDataTypes.json |            |

#7152591
  Scenario: SC#4 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\CsvAnalyzer\API\Actual\cityFile1.json" should be same as the content in "ida\CsvAnalyzer\API\Expected\cityFile1.json"
    Then file content in "ida\CsvAnalyzer\API\Actual\DiffdatatypesWOH.json" should be same as the content in "ida\CsvAnalyzer\API\Expected\DiffdatatypesWOH.json"
    Then file content in "ida\CsvAnalyzer\API\Actual\product_sample.json" should be same as the content in "ida\CsvAnalyzer\API\Expected\product_sample.json"
    Then file content in "ida\CsvAnalyzer\API\Actual\userDiffDataTypes.json" should be same as the content in "ida\CsvAnalyzer\API\Expected\userDiffDataTypes.json"


    ##########################################################Technology ,BA and explicit tag validation######################################################

  #7152592
  @positve @regression @sanity  @PIITag
  Scenario:Commoncase#MLP_24889_Verify Technology tag , Explicit tag , Bussiness Application tag and File Filter tag
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | directoryName | TableName/Filename   | Column | Tags                                             | Query          | Action         |
      |              |             | CSV2          | DiffdatatypesWOH.csv |        | SC1_CsvAnalyzer,CSV,Hadoop Files,CSV_ANALYZER_BA | FileQuery      | TagAssigned    |
      |              |             |               | DiffdatatypesWOH.csv | _c5    | CSV,CSV_ANALYZER_BA,SC1_CsvAnalyzer              | FileFieldQuery | TagAssigned    |
      |              |             | CSV2          |                      |        | SC1_CsvAnalyzer,CSV,Hadoop Files,CSV_ANALYZER_BA | DirectoryQuery | TagAssigned |
      | Cluster Demo | HDFS        |               |                      |        | SC1_CsvAnalyzer,CSV,Hadoop Files,CSV_ANALYZER_BA | ServiceQuery   | TagAssigned |
      | Cluster Demo |             |               |                      |        | SC1_CsvAnalyzer,CSV,Hadoop Files,CSV_ANALYZER_BA | ClusterQuery   | TagAssigned |

    ############################################################Log Enhancemnt #################################################################################

   #7152592
  #Bug-ID-26015
  @sanity @positive @webtest @MLP-24889 @IDA-1.1.0
  Scenario:CommonCase:MLP_24889_Verify the Processed Items widget presence and Logging Enhancement validation
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1_CsvAnalyzer" and clicks on search
    And user performs "facet selection" in "SC1_CsvAnalyzer" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/CsvAnalyzer/SC1_CsvAnalyzer/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 2             |
      | Number of errors          | 0             |
    And user "widget presence" on "Processed Items" in Item view page
    Then Analysis log "dataanalyzer/CsvAnalyzer/SC1_CsvAnalyzer/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | logCode           | pluginName  | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | ANALYSIS-0019     |             |                |
      | INFO | ANALYSIS-0071: Plugin Name:CsvAnalyzer, Plugin Type:dataanalyzer, Plugin Version:1.1.0.SNAPSHOT, Node Name:Cluster Demo, Host Name:sandbox.hortonworks.com, Plugin Configuration name:SC1_CsvAnalyzer                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0071     | CsvAnalyzer | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin CsvAnalyzer Configuration: ---  2020-10-12 10:41:45.537 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: name: "SC1_CsvAnalyzer"  2020-10-12 10:41:45.537 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: pluginVersion: "LATEST"  2020-10-12 10:41:45.537 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: label:  2020-10-12 10:41:45.538 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: : ""  2020-10-12 10:41:45.538 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: catalogName: "Default"  2020-10-12 10:41:45.538 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: eventClass: null  2020-10-12 10:41:45.538 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: eventCondition: null  2020-10-12 10:41:45.538 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: nodeCondition: "name==\"Cluster Demo\""  2020-10-12 10:41:45.538 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: maxWorkSize: 100  2020-10-12 10:41:45.538 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: tags:  2020-10-12 10:41:45.538 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: - "SC1_CsvAnalyzer"  2020-10-12 10:41:45.538 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: pluginType: "dataanalyzer"  2020-10-12 10:41:45.539 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: dataSource: null  2020-10-12 10:41:45.539 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: credential: null  2020-10-12 10:41:45.539 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: businessApplicationName: "CSV_ANALYZER_BA"  2020-10-12 10:41:45.539 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: dryRun: false  2020-10-12 10:41:45.539 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: schedule: null  2020-10-12 10:41:45.539 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: filter: null  2020-10-12 10:41:45.539 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: histogramBuckets: 100  2020-10-12 10:41:45.539 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: sparkOptions:  2020-10-12 10:41:45.540 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: - key: "deploy.mode"  2020-10-12 10:41:45.540 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: value: "cluster"  2020-10-12 10:41:45.540 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: - key: "spark.network.timeout"  2020-10-12 10:41:45.540 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: value: "600s"  2020-10-12 10:41:45.540 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: pluginName: "CsvAnalyzer"  2020-10-12 10:41:45.540 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: runAfter: []  2020-10-12 10:41:45.540 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: dataSample:  2020-10-12 10:41:45.540 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: sampleSize: 10  2020-10-12 10:41:45.540 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: type: "Dataanalyzer"  2020-10-12 10:41:45.541 INFO  - ANALYSIS-0073: Plugin CsvAnalyzer Configuration: topValues: 10 | ANALYSIS-0073     | CsvAnalyzer |                |
      | INFO | ANALYSIS-0072: Plugin CsvAnalyzer Start Time:2020-08-09 18:12:37.887, End Time:2020-08-09 18:15:28.864, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | ANALYSIS-0072     | CsvAnalyzer |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:01:55.385)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | ANALYSIS-0020     |             |                |
      | INFO | Finish with HDFS analyzing, task 1 of 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | CSV-ANALYZER-0001 |             |                |

  Scenario:SC4:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC1_DataSamp_Profiling/% | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvAnalyzer/SC1_CsvAnalyzer/%       | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                                     | Cluster  |       |       |

    ########################################################Data Sample and Data profiling with cluster resolve TRUE#############################################

  Scenario: SC5#-MLP_24889_Update the Host name respect to the docker
    And user update json file "ida/CsvAnalyzer/DataSource/hdfsdbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |


  Scenario: SC5#-MLP_24889_Update the plugoin name and tag name
    And user "update" the json file "ida/CsvAnalyzer/Analyzer/SC1_new_CSVHdfs_Cataloger_False_Configuration.json" file for following values
      | jsonPath                               | jsonValues                        | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"              |         |
      | $.configurations..dataSource           | HDFSDataSource_valid              |         |
      | $.configurations..filter..root         | /CsvAnalyzerTest                  |         |
      | $.configurations..name                 | SC2_DataSamp_Profiling_diffvalues |         |
      | $.configurations..tags[*]              | SC2_DataSamp_Profiling_diffvalues |         |
      | $.configurations..filter..tags[*]      | Positive                          |         |
      | $.configurations..analyzeCollectedData | false                             | boolean |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC5#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger for csv analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                  | body                                                                        | response code | response message                  | jsonPath                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                                     | ida\hbasePayloads\DataSource\license_DS.json                                | 204           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                                    | ida/CsvAnalyzer/DataSource/hdfsdbValidDataSourceConfig.json                 | 204           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                                    |                                                                             | 200           | HDFSDataSource_valid              |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                                     | ida/CsvAnalyzer/Analyzer/SC1_new_CSVHdfs_Cataloger_False_Configuration.json | 204           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                                     |                                                                             | 200           | SC2_DataSamp_Profiling_diffvalues |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC2_DataSamp_Profiling_diffvalues |                                                                             | 200           | IDLE                              | $.[?(@.configurationName=='SC2_DataSamp_Profiling_diffvalues')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC2_DataSamp_Profiling_diffvalues  |                                                                             | 200           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC2_DataSamp_Profiling_diffvalues |                                                                             | 200           | IDLE                              | $.[?(@.configurationName=='SC2_DataSamp_Profiling_diffvalues')].status |


  Scenario: SC5#-MLP_24889_Update the node condition and analyzer graph fields
    And user "update" the json file "ida/CsvAnalyzer/Analyzer/SC1_new_Csv_Analyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues                 | type    |
      | $.configurations..nodeCondition    | name=="Cluster Demo"       |         |
      | $.configurations..name             | SC2_CsvAnalyzer_Diffvalues |         |
      | $.configurations..tags[*]          | SC2_CsvAnalyzer_Diffvalues |         |
      | $.configurations..histogramBuckets | 50                         | Integer |
      | $.configurations..sampleSize       | 15                         | Integer |
      | $.configurations..topValues        | 15                         | Integer |

    #7152595
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC5#-MLP_24889_Verify CsvAnalyzer does data sampling/data profiling properly for csv files when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:True)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | body                                                             | response code | response message           | jsonPath                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CsvAnalyzer                                                                 | ida/CsvAnalyzer/Analyzer/SC1_new_Csv_Analyzer_Configuration.json | 204           |                            |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CsvAnalyzer                                                                 |                                                                  | 200           | SC2_CsvAnalyzer_Diffvalues |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC2_CsvAnalyzer_Diffvalues |                                                                  | 200           | IDLE                       | $.[?(@.configurationName=='SC2_CsvAnalyzer_Diffvalues')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC2_CsvAnalyzer_Diffvalues  |                                                                  | 200           |                            |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC2_CsvAnalyzer_Diffvalues |                                                                  | 200           | IDLE                       | $.[?(@.configurationName=='SC2_CsvAnalyzer_Diffvalues')].status |


  ###################################################Data Profiling########################################################################
#7152591
  #Bug-26016
  @webtest
  Scenario: SC#5 Verify Data profiling not happened other than csv files and displayed for Interger/Numeric/String and Boolean (Boolean, double, integer, String) datatype in CassandraDB Table.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC2_CsvAnalyzer_Diffvalues" and clicks on search
    And user performs "definite facet selection" in "SC2_CsvAnalyzer_Diffvalues" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "CsvAnalyzerTest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CSV2" item from search results
    Then user performs click and verify in new window
      | Table  | value                | Action               | RetainPrevwindow | indexSwitch |
      | Files  | DiffdatatypesWOH.csv | click and switch tab | No               |             |
      | Fields | _c5                  | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | _c2   | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | _c9   | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section not present" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | _c7   | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section not present" on "Data Distribution" in Item view page
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | _c7                                           |
      | attributeName  | Maximum value                                 |
      | actualFilePath | ida\CsvAnalyzer\API\Actual\Maximum value.json |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | _c7                                           |
      | attributeName  | Minimum value                                 |
      | actualFilePath | ida\CsvAnalyzer\API\Actual\Minimum value.json |
    Then file content in "ida\CsvAnalyzer\API\Actual\Maximum value.json" should be same as the content in "ida\CsvAnalyzer\API\Expected\Maximum value.json"
    Then file content in "ida\CsvAnalyzer\API\Actual\Minimum value.json" should be same as the content in "ida\CsvAnalyzer\API\Expected\Minimum value.json"
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value | Action                    | RetainPrevwindow | indexSwitch | filePath                                  | jsonPath               | metadataSection |
      | Fields | _c5   | click and verify metadata | Yes              | 0           | ida/CsvAnalyzer/API/expectedMetadata.json | $.DiffdatatypesWOH._c5 | Statistics      |
      | Fields | _c2   | click and verify metadata | Yes              | 0           | ida/CsvAnalyzer/API/expectedMetadata.json | $.DiffdatatypesWOH._c2 | Statistics      |
      | Fields | _c9   | click and verify metadata | Yes              | 0           | ida/CsvAnalyzer/API/expectedMetadata.json | $.DiffdatatypesWOH._c9 | Statistics      |

    ########################################################Data Sample validation############################################################################

  Scenario Outline:SC5:user get the Dynamic ID's (Database ID) for the Directory "CSV2" and File "cityFile1.csv,DiffdatatypesWOH.csv,product_sample.parquet and userDiffDataTypes.avro"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type      | name | asg_scopeid            | targetFile                              | jsonpath                                 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | CSV2 | cityFile1.csv          | payloads/ida/CsvAnalyzer/API/items.json | $.Directories.Filename.cityFile1         |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | CSV2 | DiffdatatypesWOH.csv   | payloads/ida/CsvAnalyzer/API/items.json | $.Directories.Filename.DiffdatatypesWOH  |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | CSV2 | product_sample.parquet | payloads/ida/CsvAnalyzer/API/items.json | $.Directories.Filename.product_sample    |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | CSV2 | userDiffDataTypes.avro | payloads/ida/CsvAnalyzer/API/items.json | $.Directories.Filename.userDiffDataTypes |

  Scenario Outline: SC5:user hits the FileID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                                | inputFile                               | outPutFile                                                   | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.cityFile1         | payloads/ida/CsvAnalyzer/API/items.json | payloads\ida\CsvAnalyzer\API\Actual\1_cityFile1.json         |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.DiffdatatypesWOH  | payloads/ida/CsvAnalyzer/API/items.json | payloads\ida\CsvAnalyzer\API\Actual\1_DiffdatatypesWOH.json  |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.product_sample    | payloads/ida/CsvAnalyzer/API/items.json | payloads\ida\CsvAnalyzer\API\Actual\1_product_sample.json    |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.userDiffDataTypes | payloads/ida/CsvAnalyzer/API/items.json | payloads\ida\CsvAnalyzer\API\Actual\1_userDiffDataTypes.json |            |

#7152591
  Scenario: SC#5 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\CsvAnalyzer\API\Actual\1_cityFile1.json" should be same as the content in "ida\CsvAnalyzer\API\Expected\cityFile1.json"
    Then file content in "ida\CsvAnalyzer\API\Actual\1_DiffdatatypesWOH.json" should be same as the content in "ida\CsvAnalyzer\API\Expected\DiffdatatypesWOH.json"
    Then file content in "ida\CsvAnalyzer\API\Actual\1_product_sample.json" should be same as the content in "ida\CsvAnalyzer\API\Expected\product_sample.json"
    Then file content in "ida\CsvAnalyzer\API\Actual\1_userDiffDataTypes.json" should be same as the content in "ida\CsvAnalyzer\API\Expected\userDiffDataTypes.json"

  ###############################################################CSV Analyzer process only CSV files##################################################

  #7154128
  @webtest
  Scenario:SC5#MLP_21662_Verify CSVAnalyzer does not analyze non csv files(lastAnalyzedAt attribute will not be there)
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC2_DataSamp_Profiling_diffvalues" and clicks on search
    And user performs "facet selection" in "SC2_DataSamp_Profiling_diffvalues" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "product_sample.parquet" item from search results
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute         | widgetName |
      | Number of non null values | Statistics |
      | Maximum Value             | Statistics |
      | Minimum Value             | Statistics |
      | Standard deviation        | Statistics |
      | Variance                  | Statistics |
      | Last Analyzed At          | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table | value                  | Action               | RetainPrevwindow | indexSwitch |
      | Files | userDiffDataTypes.avro | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute         | widgetName |
      | Number of non null values | Statistics |
      | Maximum Value             | Statistics |
      | Minimum Value             | Statistics |
      | Standard deviation        | Statistics |
      | Variance                  | Statistics |
      | Last Analyzed At          | Lifecycle  |


  Scenario:SC5:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                        | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC2_DataSamp_Profiling_diffvalues/% | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvAnalyzer/SC2_CsvAnalyzer_Diffvalues/%       | Analysis |       |       |
      | SingleItemDelete | Default | Sandbox                                                     | Cluster  |       |       |

##########################################################Dry Run#########################################################


  Scenario: CommonCase#-MLP_24889_Update the plugoin name and tag name
    And user "update" the json file "ida/CsvAnalyzer/Analyzer/SC1_new_CSVHdfs_Cataloger_False_Configuration.json" file for following values
      | jsonPath                               | jsonValues                         | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"               |         |
      | $.configurations..dataSource           | HDFSDataSource_resolveclusterfalse |         |
      | $.configurations..filter..root         | /CsvAnalyzerTest                   |         |
      | $.configurations..name                 | SC3_forDryRun                      |         |
      | $.configurations..tags[*]              | SC3_forDryRun                      |         |
      | $.configurations..filter..tags[*]      | Positive                           |         |
      | $.configurations..analyzeCollectedData | false                              | boolean |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: CommonCase#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger for csv analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                            | response code | response message                   | jsonPath                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                 | ida\hbasePayloads\DataSource\license_DS.json                                    | 204           |                                    |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                | ida/CsvAnalyzer/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                |                                                                                 | 200           | HDFSDataSource_resolveclusterfalse |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                 | ida/CsvAnalyzer/Analyzer/SC1_new_CSVHdfs_Cataloger_False_Configuration.json     | 204           |                                    |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                 |                                                                                 | 200           | SC3_forDryRun                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC3_forDryRun |                                                                                 | 200           | IDLE                               | $.[?(@.configurationName=='SC3_forDryRun')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC3_forDryRun  |                                                                                 | 200           |                                    |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC3_forDryRun |                                                                                 | 200           | IDLE                               | $.[?(@.configurationName=='SC3_forDryRun')].status |

  #7152591
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: CommonCase#-MLP_24889_Verify CsvAnalyzer does not do data sampling/data profiling properly for csv files when Dry Run set TRUE
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                               | body                                                                         | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CsvAnalyzer                                                    | ida/CsvAnalyzer/Analyzer/SC1_new_CsvHdfs_Cataloger_DryRun_Configuration.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CsvAnalyzer                                                    |                                                                              | 200           | SC3_CSVDryRun    |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC3_CSVDryRun |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='SC3_CSVDryRun')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC3_CSVDryRun  |                                                                              | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC3_CSVDryRun |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='SC3_CSVDryRun')].status |


    #7152592
  #Bug-26015
  @sanity @positive @webtest @MLP-24889 @IDA-1.1.0
  Scenario:CommonCase:MLP_24889_Verify no Cluster , Table , Database , Host and service facets are cataloged and verify log message
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC3_CSVDryRun" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/CsvAnalyzer/SC3_CSVDryRun/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "dataanalyzer/CsvAnalyzer/SC3_CSVDryRun/%" should display below info/error/warning
      | type | logValue                                                                               | logCode       | pluginName  | removableText |
      | INFO | Plugin CsvAnalyzer running on dry run mode                                             | ANALYSIS-0069 | CsvAnalyzer |               |
      | INFO | Plugin CsvAnalyzer processed 2 items on dry run mode and not written to the repository | ANALYSIS-0070 | CsvAnalyzer |               |
      | INFO | Plugin completed                                                                       | ANALYSIS-0020 |             |               |

  Scenario:CommonCase:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC3_forDryRun/%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvAnalyzer/SC3_CSVDryRun/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                             | Cluster  |       |       |

###############################################Rename scnarios#################################################################
  Scenario: SC6#-MLP_24889_Update the Host name respect to the docker
    And user update json file "ida/CsvAnalyzer/DataSource/hdfsdbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |


  Scenario: SC6#-MLP_24889_Update the plugoin name and tag name
    And user "update" the json file "ida/CsvAnalyzer/Analyzer/SC1_new_CSVHdfs_Cataloger_False_Configuration.json" file for following values
      | jsonPath                               | jsonValues             | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"   |         |
      | $.configurations..dataSource           | HDFSDataSource_valid   |         |
      | $.configurations..filter..root         | /CsvAnalyzerTest       |         |
      | $.configurations..name                 | SC4_DataSamp_Profiling |         |
      | $.configurations..tags[*]              | SC4_DataSamp_Profiling |         |
      | $.configurations..filter..tags[*]      | Positive               |         |
      | $.configurations..analyzeCollectedData | false                  | boolean |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC6#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger for csv analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                        | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                          | ida\hbasePayloads\DataSource\license_DS.json                                | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                         | ida/CsvAnalyzer/DataSource/hdfsdbValidDataSourceConfig.json                 | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                         |                                                                             | 200           | HDFSDataSource_valid   |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                          | ida/CsvAnalyzer/Analyzer/SC1_new_CSVHdfs_Cataloger_False_Configuration.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                          |                                                                             | 200           | SC4_DataSamp_Profiling |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC4_DataSamp_Profiling |                                                                             | 200           | IDLE                   | $.[?(@.configurationName=='SC4_DataSamp_Profiling')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC4_DataSamp_Profiling  |                                                                             | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC4_DataSamp_Profiling |                                                                             | 200           | IDLE                   | $.[?(@.configurationName=='SC4_DataSamp_Profiling')].status |


  Scenario: SC6#-MLP_24889_Update the node condition and analyzer graph fields
    And user "update" the json file "ida/CsvAnalyzer/Analyzer/SC1_new_Csv_Analyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues           | type    |
      | $.configurations..nodeCondition    | name=="Cluster Demo" |         |
      | $.configurations..name             | SC4_CsvAnalyzer      |         |
      | $.configurations..tags[*]          | SC4_CsvAnalyzer      |         |
      | $.configurations..histogramBuckets | 100                  | Integer |
      | $.configurations..sampleSize       | 10                   | Integer |
      | $.configurations..topValues        | 10                   | Integer |

    #7152595
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC6#-MLP_24889_Verify CsvAnalyzer does data sampling/data profiling properly for csv files when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:True)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | body                                                             | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CsvAnalyzer                                                      | ida/CsvAnalyzer/Analyzer/SC1_new_Csv_Analyzer_Configuration.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CsvAnalyzer                                                      |                                                                  | 200           | SC4_CsvAnalyzer  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC4_CsvAnalyzer |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='SC4_CsvAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC4_CsvAnalyzer  |                                                                  | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC4_CsvAnalyzer |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='SC4_CsvAnalyzer')].status |


  ###################################################Data Profiling########################################################################

  #Bug-26016
  @webtest
  Scenario: SC#6 Verify Data profiling not happened other than csv files and displayed for Interger/Numeric/String and Boolean (Boolean, double, integer, String) datatype in CassandraDB Table.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC4_DataSamp_Profiling" and clicks on search
    And user performs "definite facet selection" in "SC4_DataSamp_Profiling" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "CsvAnalyzerTest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CSV2" item from search results
    Then user performs click and verify in new window
      | Table  | value                | Action               | RetainPrevwindow | indexSwitch |
      | Files  | DiffdatatypesWOH.csv | click and switch tab | No               |             |
      | Fields | _c5                  | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | _c2   | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | _c9   | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section not present" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | _c7   | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section not present" on "Data Distribution" in Item view page
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | _c7                                           |
      | attributeName  | Maximum value                                 |
      | actualFilePath | ida\CsvAnalyzer\API\Actual\Maximum value.json |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | _c7                                           |
      | attributeName  | Minimum value                                 |
      | actualFilePath | ida\CsvAnalyzer\API\Actual\Minimum value.json |
    Then file content in "ida\CsvAnalyzer\API\Actual\Maximum value.json" should be same as the content in "ida\CsvAnalyzer\API\Expected\Maximum value.json"
    Then file content in "ida\CsvAnalyzer\API\Actual\Minimum value.json" should be same as the content in "ida\CsvAnalyzer\API\Expected\Minimum value.json"
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value | Action                    | RetainPrevwindow | indexSwitch | filePath                                  | jsonPath               | metadataSection |
      | Fields | _c5   | click and verify metadata | Yes              | 0           | ida/CsvAnalyzer/API/expectedMetadata.json | $.DiffdatatypesWOH._c5 | Statistics      |
      | Fields | _c2   | click and verify metadata | Yes              | 0           | ida/CsvAnalyzer/API/expectedMetadata.json | $.DiffdatatypesWOH._c2 | Statistics      |
      | Fields | _c9   | click and verify metadata | Yes              | 0           | ida/CsvAnalyzer/API/expectedMetadata.json | $.DiffdatatypesWOH._c9 | Statistics      |

    ########################################################Data Sample validation############################################################################

  Scenario Outline:SC6:user get the Dynamic ID's (Database ID) for the Directory "CSV2" and File "cityFile1.csv,DiffdatatypesWOH.csv,product_sample.parquet and userDiffDataTypes.avro"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type      | name | asg_scopeid          | targetFile                              | jsonpath                                |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | CSV2 | DiffdatatypesWOH.csv | payloads/ida/CsvAnalyzer/API/items.json | $.Directories.Filename.DiffdatatypesWOH |

  Scenario Outline: SC6:user hits the FileID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                               | inputFile                               | outPutFile                                                  | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.DiffdatatypesWOH | payloads/ida/CsvAnalyzer/API/items.json | payloads\ida\CsvAnalyzer\API\Actual\2_DiffdatatypesWOH.json |            |


  Scenario: SC#6 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\CsvAnalyzer\API\Actual\2_DiffdatatypesWOH.json" should be same as the content in "ida\CsvAnalyzer\API\Expected\DiffdatatypesWOH.json"

##################################################################### Rename the file################################################################
  #7156480
  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline: SC#7Renaming the already created file in the existing directory
    Given sync the test execution for "10" seconds
    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                            | body | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | CsvAnalyzerTest/CSV1/CSV2/DiffdatatypesWOH.csv?user.name=raj_ops&op=RENAME&destination=/CsvAnalyzerTest/CSV1/CSV2/DiffdatatypesWOH_Renamed.csv |      | 200           | true             |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC7#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger for csv analyzer second run
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body | response code | response message | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC4_DataSamp_Profiling |      | 200           | IDLE             | $.[?(@.configurationName=='SC4_DataSamp_Profiling')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC4_DataSamp_Profiling  |      | 200           |                  |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC4_DataSamp_Profiling |      | 200           | IDLE             | $.[?(@.configurationName=='SC4_DataSamp_Profiling')].status |


    #7156480
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC7#-MLP_24889_Verify CsvAnalyzer does data sampling/data profiling properly for csv files when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:True) second run
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | body | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC4_CsvAnalyzer |      | 200           | IDLE             | $.[?(@.configurationName=='SC4_CsvAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC4_CsvAnalyzer  |      | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC4_CsvAnalyzer |      | 200           | IDLE             | $.[?(@.configurationName=='SC4_CsvAnalyzer')].status |


  ###################################################Data Profiling for Renamed file########################################################################
#7156480
  #Bug-26016
  @webtest
  Scenario: SC#7 Verify Data profiling not happened other than csv files and displayed for Interger/Numeric/String and Boolean (Boolean, double, integer, String) datatype in CassandraDB Table for renamed file.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC4_DataSamp_Profiling" and clicks on search
    And user performs "definite facet selection" in "SC4_DataSamp_Profiling" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "CsvAnalyzerTest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CSV2" item from search results
    Then user performs click and verify in new window
      | Table  | value                        | Action               | RetainPrevwindow | indexSwitch |
      | Files  | DiffdatatypesWOH_Renamed.csv | click and switch tab | No               |             |
      | Fields | _c5                          | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | _c2   | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | _c9   | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section not present" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | _c7   | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section not present" on "Data Distribution" in Item view page
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | _c7                                           |
      | attributeName  | Maximum value                                 |
      | actualFilePath | ida\CsvAnalyzer\API\Actual\Maximum value.json |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | _c7                                           |
      | attributeName  | Minimum value                                 |
      | actualFilePath | ida\CsvAnalyzer\API\Actual\Minimum value.json |
    Then file content in "ida\CsvAnalyzer\API\Actual\Maximum value.json" should be same as the content in "ida\CsvAnalyzer\API\Expected\Maximum value.json"
    Then file content in "ida\CsvAnalyzer\API\Actual\Minimum value.json" should be same as the content in "ida\CsvAnalyzer\API\Expected\Minimum value.json"
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value | Action                    | RetainPrevwindow | indexSwitch | filePath                                  | jsonPath               | metadataSection |
      | Fields | _c5   | click and verify metadata | Yes              | 0           | ida/CsvAnalyzer/API/expectedMetadata.json | $.DiffdatatypesWOH._c5 | Statistics      |
      | Fields | _c2   | click and verify metadata | Yes              | 0           | ida/CsvAnalyzer/API/expectedMetadata.json | $.DiffdatatypesWOH._c2 | Statistics      |
      | Fields | _c9   | click and verify metadata | Yes              | 0           | ida/CsvAnalyzer/API/expectedMetadata.json | $.DiffdatatypesWOH._c9 | Statistics      |


      ########################################################Data Sample validation for renamed file ############################################################################

  Scenario Outline:SC7:user get the Dynamic ID's (Database ID) for the Directory "CSV2" and File "cityFile1.csv,DiffdatatypesWOH.csv,product_sample.parquet and userDiffDataTypes.avro" renamed file
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type      | name | asg_scopeid                  | targetFile                              | jsonpath                                |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | CSV2 | DiffdatatypesWOH_Renamed.csv | payloads/ida/CsvAnalyzer/API/items.json | $.Directories.Filename.DiffdatatypesWOH |

  Scenario Outline: SC7:user hits the FileID's and save the DataSample Values for renamed file
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                               | inputFile                               | outPutFile                                                          | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.DiffdatatypesWOH | payloads/ida/CsvAnalyzer/API/items.json | payloads\ida\CsvAnalyzer\API\Actual\3_DiffdatatypesWOH_Renamed.json |            |

#7152591
  Scenario: SC#7 MLP_24048_Verify the DataSamples values are as expected for renamed file
    Then file content in "ida\CsvAnalyzer\API\Actual\3_DiffdatatypesWOH_Renamed.json" should be same as the content in "ida\CsvAnalyzer\API\Expected\DiffdatatypesWOH.json"


    ##########################################################3rd run for Csv Analyzer and check the Last Analyzed at field value####################################################

   #715648
  #Bug-26255
  @MLP-3422 @webtest @positve @hdfs @regression @sanity
  Scenario: SC7#-MLP_24889_Verify whether the last analyzed at value doesn't change for the second run if the collected files are not modified.
    Given User launch browser and traverse to login page
    And user enter credentials for "system Administrator1" role
    And user enters the search text "SC4_DataSamp_Profiling" and clicks on search
    And user performs "definite facet selection" in "SC4_DataSamp_Profiling" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "CsvAnalyzerTest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CSV2" item from search results
    Then user performs click and verify in new window
      | Table  | value                        | Action               | RetainPrevwindow | indexSwitch |
      | Files  | DiffdatatypesWOH_Renamed.csv | click and switch tab | No               |             |
      | Fields | _c5                          | click and switch tab | No               |             |
    And user "store" the value of item "_c5" of attribute "Last analyzed at" with temporary text
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                 | body | response code | response message | jsonPath                                             |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC4_CsvAnalyzer |      | 200           | IDLE             | $.[?(@.configurationName=='SC4_CsvAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC4_CsvAnalyzer  |      | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC4_CsvAnalyzer |      | 200           | IDLE             | $.[?(@.configurationName=='SC4_CsvAnalyzer')].status |
    And user enters the search text "SC4_DataSamp_Profiling" and clicks on search
    And user performs "definite facet selection" in "SC4_DataSamp_Profiling" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "CsvAnalyzerTest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CSV2" item from search results
    Then user performs click and verify in new window
      | Table  | value                        | Action               | RetainPrevwindow | indexSwitch |
      | Files  | DiffdatatypesWOH_Renamed.csv | click and switch tab | No               |             |
      | Fields | _c5                          | click and switch tab | No               |             |
    Then user "verify equals" the value of item "_c5" of attribute "Last analyzed at" with temporary text


  Scenario:SC7:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC4_DataSamp_Profiling/% | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvAnalyzer/SC4_CsvAnalyzer/%       | Analysis |       |       |
      | SingleItemDelete | Default | Sandbox                                          | Cluster  |       |       |


###################################################Only CSV Anlayzer Run#####################################################################

  Scenario: SC8#-MLP_24889_Update the node condition and analyzer graph fields
    And user "update" the json file "ida/CsvAnalyzer/Analyzer/SC1_new_Csv_Analyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues           | type    |
      | $.configurations..nodeCondition    | name=="Cluster Demo" |         |
      | $.configurations..name             | SC5_OnlyCsvAnalyzer  |         |
      | $.configurations..tags[*]          | SC5_OnlyCsvAnalyzer  |         |
      | $.configurations..histogramBuckets | 100                  | Integer |
      | $.configurations..sampleSize       | 10                   | Integer |
      | $.configurations..topValues        | 10                   | Integer |

    #7156482
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC8#-MLP_24889_Verify CsvAnalyzer does data sampling/data profiling properly for csv files when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:True)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                             | response code | response message    | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CsvAnalyzer                                                          | ida/CsvAnalyzer/Analyzer/SC1_new_Csv_Analyzer_Configuration.json | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CsvAnalyzer                                                          |                                                                  | 200           | SC5_OnlyCsvAnalyzer |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC5_OnlyCsvAnalyzer |                                                                  | 200           | IDLE                | $.[?(@.configurationName=='SC5_OnlyCsvAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC5_OnlyCsvAnalyzer  |                                                                  | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC5_OnlyCsvAnalyzer |                                                                  | 200           | IDLE                | $.[?(@.configurationName=='SC5_OnlyCsvAnalyzer')].status |


     #7156482
  #Bug-26015
  @sanity @positive @webtest @MLP-24889 @IDA-1.1.0
  Scenario:SC8#:MLP_24889_Verify CSVAnalyzer is ran without HDFSCataloger and the analyzer log shows proper message.
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC5_OnlyCsvAnalyzer" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/CsvAnalyzer/SC5_OnlyCsvAnalyzer/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "dataanalyzer/CsvAnalyzer/SC5_OnlyCsvAnalyzer/%" should display below info/error/warning
      | type | logValue                                                                                                                         | logCode       | pluginName  | removableText |
      | INFO | Plugin CsvAnalyzer Start Time:2020-08-05 14:50:56.710, End Time:2020-08-05 14:50:56.954, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CsvAnalyzer |               |

  Scenario:SC8:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/CsvAnalyzer/SC5_OnlyCsvAnalyzer/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                                   | Cluster  |       |       |

     ###################################################Delete existing Anlaysis and CLuster if any#############################

  @positve @regression @sanity  @ambari
  Scenario:Pre-Condition2:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvAnalyzer/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo               | Cluster  |       |       |
      | SingleItemDelete | Default | Sandbox                    | Cluster  |       |       |
      | SingleItemDelete | Default | Cluster 1                  | Cluster  |       |       |

      ############################################# Policy Patterns - PII Tagging ##########################################################
  Scenario Outline:Policy1:Create root tag and sub tag for HDFS CSV Anlayzer and Update policy tags for CsvAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                                        | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | tags/Default/structures | ida/CsvAnalyzer/API/PolicyEngine/HDFS_CSV_TagStructure.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions  | ida/CsvAnalyzer/API/PolicyEngine/HDFS_CSV_policy1.json      | 204           |                  |          |

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC#9:Creating a directory in Ambari Files View and Uploading a file into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                                                     | body                                                                                      | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | CsvPIITags/Folder1/Folder2/tagdetails_allempty_csv.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                         | ida/hdfsPayloads/TestData/CSV_PIITags/tagdetails_allempty_csv.csv                         | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | CsvPIITags/Folder1/Folder2/tagdetails_allmatch_csv.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                         | ida/hdfsPayloads/TestData/CSV_PIITags/tagdetails_allmatch_csv.csv                         | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | CsvPIITags/Folder1/Folder2/tagdetails_ratioequalto05emptyfalse_csv.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true         | ida/hdfsPayloads/TestData/CSV_PIITags/tagdetails_ratioequalto05emptyfalse_csv.csv         | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | CsvPIITags/Folder1/Folder2/tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/CSV_PIITags/tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | CsvPIITags/Folder1/Folder2/tagdetails_ratiogreaterthan05matchfulltrue_csv.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true  | ida/hdfsPayloads/TestData/CSV_PIITags/tagdetails_ratiogreaterthan05matchfulltrue_csv.csv  | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | CsvPIITags/Folder1/Folder2/tagdetails_ratiolesserthan05matchfulltrue_csv.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true   | ida/hdfsPayloads/TestData/CSV_PIITags/tagdetails_ratiolesserthan05matchfulltrue_csv.csv   | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | CsvPIITags/Folder1/Folder2/tagdetails_ratiolessthan05emptyfalse_csv.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true        | ida/hdfsPayloads/TestData/CSV_PIITags/tagdetails_ratiolessthan05emptyfalse_csv.csv        | 201           |                  |

  Scenario: SC9#-MLP_24889_Update the plugin name and tag name
    And user "update" the json file "ida/CsvAnalyzer/Analyzer/SC1_new_CSVHdfs_Cataloger_False_Configuration.json" file for following values
      | jsonPath                               | jsonValues                         | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"               |         |
      | $.configurations..dataSource           | HDFSDataSource_resolveclusterfalse |         |
      | $.configurations..filter..root         | /CsvPIITags                        |         |
      | $.configurations..name                 | SC6_HDFS_PIITags                   |         |
      | $.configurations..tags[*]              | SC6_HDFS_PIITags                   |         |
      | $.configurations..filter..tags[*]      | Positive                           |         |
      | $.configurations..analyzeCollectedData | false                              | boolean |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC9#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger for csv analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | body                                                                            | response code | response message                   | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                    | ida\hbasePayloads\DataSource\license_DS.json                                    | 204           |                                    |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                   | ida/CsvAnalyzer/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                   |                                                                                 | 200           | HDFSDataSource_resolveclusterfalse |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                    | ida/CsvAnalyzer/Analyzer/SC1_new_CSVHdfs_Cataloger_False_Configuration.json     | 204           |                                    |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                    |                                                                                 | 200           | SC6_HDFS_PIITags                   |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC6_HDFS_PIITags |                                                                                 | 200           | IDLE                               | $.[?(@.configurationName=='SC6_HDFS_PIITags')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC6_HDFS_PIITags  |                                                                                 | 200           |                                    |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC6_HDFS_PIITags |                                                                                 | 200           | IDLE                               | $.[?(@.configurationName=='SC6_HDFS_PIITags')].status |


  Scenario: SC9#-MLP_24889_Update the node condition and analyzer graph fields
    And user "update" the json file "ida/CsvAnalyzer/Analyzer/SC1_new_Csv_Analyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues           | type    |
      | $.configurations..nodeCondition    | name=="Cluster Demo" |         |
      | $.configurations..name             | SC6_CSV_PIITags      |         |
      | $.configurations..tags[*]          | SC6_CSV_PIITags      |         |
      | $.configurations..histogramBuckets | 100                  | Integer |
      | $.configurations..sampleSize       | 10                   | Integer |
      | $.configurations..topValues        | 10                   | Integer |

    #7152591
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC9#-MLP_24889_Verify CsvAnalyzer does data sampling/data profiling properly for csv files when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:False)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | body                                                             | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CsvAnalyzer                                                      | ida/CsvAnalyzer/Analyzer/SC1_new_Csv_Analyzer_Configuration.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CsvAnalyzer                                                      |                                                                  | 200           | SC6_CSV_PIITags  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC6_CSV_PIITags |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='SC6_CSV_PIITags')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC6_CSV_PIITags  |                                                                  | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC6_CSV_PIITags |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='SC6_CSV_PIITags')].status |

       ###########Set the PItags for DynamoDB tables ,typePattern can be set as:VARCHAR or .*VAR.*minimumRatio:0.5, Match Empty=false, Match Full=false##############
#7163669,7163670,7163668,7163666,7163678,7163664,7163671,7163662
  @positve @regression @sanity  @PIITag
  Scenario:SC10#MLP_24889_Verify PIItags for CSV File fields ,typePattern can be set as:VARCHAR or .*VAR.*minimumRatio:0.5, Match Empty=false, Match Full=false
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                  | Column | Tags                         | Query          | Action      |
      | tagdetails_allmatch_csv.csv                         | _c4    | Hdfs_Csv_GenderPII_SC1Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_csv.csv                         | _c5    | Hdfs_Csv_SSNPII_SC1Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_csv.csv                         | _c8    | Hdfs_Csv_IPAddressPII_SC1Tag | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_csv.csv                         | _c1    | Hdfs_Csv_FullNamePII_SC1Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_csv.csv                         | _c2    | Hdfs_Csv_EmailPII_SC1Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_csv.csv                         | _c2    | Hdfs_Csv_EmailPII_SC1Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_csv.csv                         | _c5    | Hdfs_Csv_SSNPII_SC1Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_csv.csv                         | _c8    | Hdfs_Csv_IPAddressPII_SC1Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c2    | Hdfs_Csv_EmailPII_SC1Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c4    | Hdfs_Csv_GenderPII_SC1Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c8    | Hdfs_Csv_IPAddressPII_SC1Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c4    | Hdfs_Csv_GenderPII_SC1Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c5    | Hdfs_Csv_SSNPII_SC1Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c8    | Hdfs_Csv_IPAddressPII_SC1Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c1    | Hdfs_Csv_FullNamePII_SC1Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c2    | Hdfs_Csv_EmailPII_SC1Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c4    | Hdfs_Csv_GenderPII_SC1Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c5    | Hdfs_Csv_SSNPII_SC1Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c8    | Hdfs_Csv_IPAddressPII_SC1Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c1    | Hdfs_Csv_FullNamePII_SC1Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c2    | Hdfs_Csv_EmailPII_SC1Tag     | FileFieldQuery | TagAssigned |

  ########Set the PItags for DynamoDB tables , typePattern can be set as:  NUMBER or .*VAR1.* or .*FLOAT.* or .*NUM.*  minimumRatio:0.5#########

#7163676,7163677,7163667,7163675,7163665,7163672,7163673,7163674,7163663
  @positve @regression @sanity  @PIITag
  Scenario:SC11#MLP_24889_Verify PItags not set for CSV Files tables , typePattern can be set as:  NUMBER or .*VAR1.* or .*FLOAT.* or .*NUM.*  minimumRatio:0.5
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                  | Column | Tags                         | Query          | Action         |
      | tagdetails_allmatch_csv.csv                         | _c4    | Hdfs_Csv_GenderPII_SC2Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c5    | Hdfs_Csv_SSNPII_SC2Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c8    | Hdfs_Csv_IPAddressPII_SC2Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c1    | Hdfs_Csv_FullNamePII_SC2Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c2    | Hdfs_Csv_EmailPII_SC2Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_csv.csv                         | _c2    | Hdfs_Csv_EmailPII_SC2Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_csv.csv                         | _c5    | Hdfs_Csv_SSNPII_SC2Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_csv.csv                         | _c8    | Hdfs_Csv_IPAddressPII_SC2Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c2    | Hdfs_Csv_EmailPII_SC2Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c4    | Hdfs_Csv_GenderPII_SC2Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c8    | Hdfs_Csv_IPAddressPII_SC2Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c4    | Hdfs_Csv_GenderPII_SC2Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c5    | Hdfs_Csv_SSNPII_SC2Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c8    | Hdfs_Csv_IPAddressPII_SC2Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c1    | Hdfs_Csv_FullNamePII_SC2Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c2    | Hdfs_Csv_EmailPII_SC2Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c4    | Hdfs_Csv_GenderPII_SC2Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c5    | Hdfs_Csv_SSNPII_SC2Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c8    | Hdfs_Csv_IPAddressPII_SC2Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c1    | Hdfs_Csv_FullNamePII_SC2Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c2    | Hdfs_Csv_EmailPII_SC2Tag     | FileFieldQuery | TagNotAssigned |

###############PItags for DynamoDB tables , namePattern can be set as:.*FULL.*,IPADDRESS,GENDER,.*EMAIL.*,SSN, minimumRatio:0.5################

  #7163669,7163670,7163668,7163666,7163678,7163664,7163671,7163662

  @positve @regression @sanity  @PIITag
  Scenario:SC12#MLP_24889_Verify PItags for CSV Files  , namePattern can be set as:.*FULL.*,.*IP.*,GENDER,.*EMAIL.*,SSN.*, minimumRatio:0.5
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                  | Column | Tags                         | Query          | Action      |
      | tagdetails_allmatch_csv.csv                         | _c4    | Hdfs_Csv_GenderPII_SC3Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_csv.csv                         | _c5    | Hdfs_Csv_SSNPII_SC3Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_csv.csv                         | _c8    | Hdfs_Csv_IPAddressPII_SC3Tag | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_csv.csv                         | _c1    | Hdfs_Csv_FullNamePII_SC3Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_csv.csv                         | _c2    | Hdfs_Csv_EmailPII_SC3Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_csv.csv                         | _c2    | Hdfs_Csv_EmailPII_SC3Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_csv.csv                         | _c5    | Hdfs_Csv_SSNPII_SC3Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_csv.csv                         | _c8    | Hdfs_Csv_IPAddressPII_SC3Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c2    | Hdfs_Csv_EmailPII_SC3Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c4    | Hdfs_Csv_GenderPII_SC3Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c8    | Hdfs_Csv_IPAddressPII_SC3Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c4    | Hdfs_Csv_GenderPII_SC3Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c5    | Hdfs_Csv_SSNPII_SC3Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c8    | Hdfs_Csv_IPAddressPII_SC3Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c1    | Hdfs_Csv_FullNamePII_SC3Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c2    | Hdfs_Csv_EmailPII_SC3Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c4    | Hdfs_Csv_GenderPII_SC3Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c5    | Hdfs_Csv_SSNPII_SC3Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c8    | Hdfs_Csv_IPAddressPII_SC3Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c1    | Hdfs_Csv_FullNamePII_SC3Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c2    | Hdfs_Csv_EmailPII_SC3Tag     | FileFieldQuery | TagAssigned |


###########PItags for DynamoDB tables , namePattern set as: .*F1ULL.*,IP1,1GENDER,.*EM1AIL.*,SSN11.*, minimumRatio:0.5###################

  #7163676,7163677,7163667,7163675,7163665,7163672,7163673,7163674,7163663

  @positve @regression @sanity  @PIITag
  Scenario:SC13#MLP_24889_Verify PIItags not set for CSV Files , namePattern set as: .*F1ULL.*,IP1,1GENDER,.*EM1AIL.*,SSN11.*, minimumRatio:0.5
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                  | Column | Tags                         | Query          | Action         |
      | tagdetails_allmatch_csv.csv                         | _c4    | Hdfs_Csv_GenderPII_SC4Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c5    | Hdfs_Csv_SSNPII_SC4Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c8    | Hdfs_Csv_IPAddressPII_SC4Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c1    | Hdfs_Csv_FullNamePII_SC4Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c2    | Hdfs_Csv_EmailPII_SC4Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_csv.csv                         | _c2    | Hdfs_Csv_EmailPII_SC4Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_csv.csv                         | _c5    | Hdfs_Csv_SSNPII_SC4Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_csv.csv                         | _c8    | Hdfs_Csv_IPAddressPII_SC4Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c2    | Hdfs_Csv_EmailPII_SC4Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c4    | Hdfs_Csv_GenderPII_SC4Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c8    | Hdfs_Csv_IPAddressPII_SC4Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c4    | Hdfs_Csv_GenderPII_SC4Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c5    | Hdfs_Csv_SSNPII_SC4Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c8    | Hdfs_Csv_IPAddressPII_SC4Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c1    | Hdfs_Csv_FullNamePII_SC4Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c2    | Hdfs_Csv_EmailPII_SC4Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c4    | Hdfs_Csv_GenderPII_SC4Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c5    | Hdfs_Csv_SSNPII_SC4Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c8    | Hdfs_Csv_IPAddressPII_SC4Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c1    | Hdfs_Csv_FullNamePII_SC4Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c2    | Hdfs_Csv_EmailPII_SC4Tag     | FileFieldQuery | TagNotAssigned |


    #######Set the PItags for DynamoDB tables , valid name and type pattern minimumRatio:0.2#######################

  #7163669,7163670,7163668,7163666,7163678,7163664,7163671,7163662

  Scenario:SC14#MLP_24889_Verify PItags for DynamoDB tables , valid name and type pattern minimumRatio:0.2
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                           | Column | Tags                         | Query          | Action      |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv | _c4    | Hdfs_Csv_GenderPII_SC5Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv | _c5    | Hdfs_Csv_SSNPII_SC5Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv | _c8    | Hdfs_Csv_IPAddressPII_SC5Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv | _c1    | Hdfs_Csv_FullNamePII_SC5Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv | _c2    | Hdfs_Csv_EmailPII_SC5Tag     | FileFieldQuery | TagAssigned |

    ###########Set the PIItags for DynamoDB tables , minimumRatio:0.6 matchfull false and matchempty true###############

  #7163669,7163670,7163668,7163666,7163678,7163664,7163671,7163662

  Scenario:SC15#MLP_24889_Verify PIItags for DynamoDB tables , minimumRatio:0.6 matchfull false and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                  | Column | Tags                         | Query          | Action      |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c8    | Hdfs_Csv_IPAddressPII_SC6Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c2    | Hdfs_Csv_EmailPII_SC6Tag     | FileFieldQuery | TagAssigned |

    #7163676,7163677,7163667,7163675,7163665,7163672,7163673,7163674,7163663

  Scenario:SC16#MLP_24889_Verify PIItags not set for DynamoDB tables , minimumRatio:0.6 matchfull false and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                  | Column | Tags                      | Query          | Action         |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c4    | Hdfs_Csv_GenderPII_SC6Tag | FileFieldQuery | TagNotAssigned |


      ###############Set the PIItags for DynamoDB tables , minimumRatio:1 matchfull false and matchempty false#####################

  #7163669,7163670,7163668,7163666,7163678,7163664,7163671,7163662

  Scenario:SC17#MLP_24889_Verify PIItags for DynamoDB tables , minimumRatio:1 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename          | Column | Tags                         | Query          | Action      |
      | tagdetails_allmatch_csv.csv | _c4    | Hdfs_Csv_GenderPII_SC8Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_csv.csv | _c5    | Hdfs_Csv_SSNPII_SC8Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_csv.csv | _c8    | Hdfs_Csv_IPAddressPII_SC8Tag | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_csv.csv | _c1    | Hdfs_Csv_FullNamePII_SC8Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_csv.csv | _c2    | Hdfs_Csv_EmailPII_SC8Tag     | FileFieldQuery | TagAssigned |


     ###############Set the PIItags for DynamoDB tables , minimumRatio:0.5 matchfull false and matchempty false#####################

#7163669,7163670,7163668,7163666,7163678,7163664,7163671,7163662

  Scenario:SC18#MLP_24889_Verify PIItags for DynamoDB tables , minimumRatio:0.5 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                          | Column | Tags                         | Query          | Action      |
      | tagdetails_ratioequalto05emptyfalse_csv.csv | _c4    | Hdfs_Csv_GenderPII_SC9Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv | _c5    | Hdfs_Csv_SSNPII_SC9Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv | _c8    | Hdfs_Csv_IPAddressPII_SC9Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv | _c1    | Hdfs_Csv_FullNamePII_SC9Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv | _c2    | Hdfs_Csv_EmailPII_SC9Tag     | FileFieldQuery | TagAssigned |


      ###############PIItags for DynamoDB tables , minimumRatio:0.2 matchfull false and matchempty false,namePattern can be set as:FULL.*,IPADDRESS,GENDER,.*MAIL,.*SSN.*,#####################
#7163669,7163670,7163668,7163666,7163678,7163664,7163671,7163662

  Scenario:SC19#MLP_24889_Verify PIItags for DynamoDB tables , minimumRatio:0.2 matchfull false and matchempty false,namePattern can be set as:FULL.*,IPADDRESS,GENDER,.*MAIL,.*SSN.*
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                           | Column | Tags                          | Query          | Action      |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv | _c4    | Hdfs_Csv_GenderPII_SC10Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv | _c5    | Hdfs_Csv_SSNPII_SC10Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv | _c8    | Hdfs_Csv_IPAddressPII_SC10Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv | _c1    | Hdfs_Csv_FullNamePII_SC10Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv | _c2    | Hdfs_Csv_EmailPII_SC10Tag     | FileFieldQuery | TagAssigned |

  ######################PItags for DynamoDB tables , namePattern set as: FULL1.*,IPAD1DRESS,GENDER1,.*1MAIL,.*1SSN.*, minimumRatio:0.2################################

  #7163676,7163677,7163667,7163675,7163665,7163672,7163673,7163674,7163663

  @positve @regression @sanity  @PIITag
  Scenario:SC20#MLP_24889_Verify PItags not set for DynamoDB tables , namePattern set as: FULL1.*,IPAD1DRESS,GENDER1,.*1MAIL,.*1SSN.*, minimumRatio:0.2
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                  | Column | Tags                          | Query          | Action         |
      | tagdetails_allmatch_csv.csv                         | _c4    | Hdfs_Csv_GenderPII_SC11Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c5    | Hdfs_Csv_SSNPII_SC11Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c8    | Hdfs_Csv_IPAddressPII_SC11Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c1    | Hdfs_Csv_FullNamePII_SC11Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c2    | Hdfs_Csv_EmailPII_SC11Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_csv.csv                         | _c2    | Hdfs_Csv_EmailPII_SC11Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_csv.csv                         | _c5    | Hdfs_Csv_SSNPII_SC11Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_csv.csv                         | _c8    | Hdfs_Csv_IPAddressPII_SC11Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c2    | Hdfs_Csv_EmailPII_SC11Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c4    | Hdfs_Csv_GenderPII_SC11Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c8    | Hdfs_Csv_IPAddressPII_SC11Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c4    | Hdfs_Csv_GenderPII_SC11Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c5    | Hdfs_Csv_SSNPII_SC11Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c8    | Hdfs_Csv_IPAddressPII_SC11Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c1    | Hdfs_Csv_FullNamePII_SC11Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c2    | Hdfs_Csv_EmailPII_SC11Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c4    | Hdfs_Csv_GenderPII_SC11Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c5    | Hdfs_Csv_SSNPII_SC11Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c8    | Hdfs_Csv_IPAddressPII_SC11Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c1    | Hdfs_Csv_FullNamePII_SC11Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c2    | Hdfs_Csv_EmailPII_SC11Tag     | FileFieldQuery | TagNotAssigned |



    ##############################PIItags for DynamoDB tables , name pattern (Invalid columns) minimumRatio:0.2 matchfull false and matchempty false##################

  #7163676,7163677,7163667,7163675,7163665,7163672,7163673,7163674,7163663

  Scenario:SC21#MLP_24889_Verify PItags not set for DynamoDB tables , name pattern (Invalid columns) minimumRatio:0.2 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                  | Column | Tags                          | Query          | Action         |
      | tagdetails_allmatch_csv.csv                         | _c4    | Hdfs_Csv_GenderPII_SC12Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c5    | Hdfs_Csv_SSNPII_SC12Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c8    | Hdfs_Csv_IPAddressPII_SC12Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c1    | Hdfs_Csv_FullNamePII_SC12Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c2    | Hdfs_Csv_EmailPII_SC12Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_csv.csv                         | _c2    | Hdfs_Csv_EmailPII_SC12Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_csv.csv                         | _c5    | Hdfs_Csv_SSNPII_SC12Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_csv.csv                         | _c8    | Hdfs_Csv_IPAddressPII_SC12Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c2    | Hdfs_Csv_EmailPII_SC12Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c4    | Hdfs_Csv_GenderPII_SC12Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c8    | Hdfs_Csv_IPAddressPII_SC12Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c4    | Hdfs_Csv_GenderPII_SC12Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c5    | Hdfs_Csv_SSNPII_SC12Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c8    | Hdfs_Csv_IPAddressPII_SC12Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c1    | Hdfs_Csv_FullNamePII_SC12Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c2    | Hdfs_Csv_EmailPII_SC12Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c4    | Hdfs_Csv_GenderPII_SC12Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c5    | Hdfs_Csv_SSNPII_SC12Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c8    | Hdfs_Csv_IPAddressPII_SC12Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c1    | Hdfs_Csv_FullNamePII_SC12Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c2    | Hdfs_Csv_EmailPII_SC12Tag     | FileFieldQuery | TagNotAssigned |

######################PIItags for DynamoDB tables , data pattern (Invalid regex) minimumRatio:0.2 matchfull false and matchempty false##################

#7163676,7163677,7163667,7163675,7163665,7163672,7163673,7163674,7163663

  Scenario:SC22#MLP_24889_Verify PItags not set for DynamoDB tables , data pattern (Invalid regex) minimumRatio:0.2 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                  | Column | Tags                          | Query          | Action         |
      | tagdetails_allmatch_csv.csv                         | _c4    | Hdfs_Csv_GenderPII_SC13Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c5    | Hdfs_Csv_SSNPII_SC13Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c8    | Hdfs_Csv_IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c1    | Hdfs_Csv_FullNamePII_SC13Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_csv.csv                         | _c2    | Hdfs_Csv_EmailPII_SC13Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_csv.csv                         | _c2    | Hdfs_Csv_EmailPII_SC13Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_csv.csv                         | _c5    | Hdfs_Csv_SSNPII_SC13Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_csv.csv                         | _c8    | Hdfs_Csv_IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c2    | Hdfs_Csv_EmailPII_SC13Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c4    | Hdfs_Csv_GenderPII_SC13Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_csv.csv        | _c8    | Hdfs_Csv_IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c4    | Hdfs_Csv_GenderPII_SC13Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c5    | Hdfs_Csv_SSNPII_SC13Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c8    | Hdfs_Csv_IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c1    | Hdfs_Csv_FullNamePII_SC13Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c2    | Hdfs_Csv_EmailPII_SC13Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c4    | Hdfs_Csv_GenderPII_SC13Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c5    | Hdfs_Csv_SSNPII_SC13Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c8    | Hdfs_Csv_IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c1    | Hdfs_Csv_FullNamePII_SC13Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_csv.csv         | _c2    | Hdfs_Csv_EmailPII_SC13Tag     | FileFieldQuery | TagNotAssigned |

    ####line 3228

  #################PIItags for DynamoDB tables , minimumRatio:0.5 matchfull false and matchempty true###########################

  #7163669,7163670,7163668,7163666,7163678,7163664,7163671,7163662

  Scenario:SC23#MLP_24889_Verify PIItags for DynamoDB tables , minimumRatio:0.5 matchfull false and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename          | Column | Tags                          | Query          | Action      |
      | tagdetails_allempty_csv.csv | _c2    | Hdfs_Csv_EmailPII_SC14Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_csv.csv | _c5    | Hdfs_Csv_SSNPII_SC14Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_csv.csv | _c8    | Hdfs_Csv_IPAddressPII_SC14Tag | FileFieldQuery | TagAssigned |

   #################PIItags for DynamoDB tables , minimumRatio:0.6 matchfull true and matchempty false###########################

  #7163676,7163677,7163667,7163675,7163665,7163672,7163673,7163674,7163663

  Scenario:SC24#MLP_24889_Verify PIItags for DynamoDB tables , minimumRatio:0.6 matchfull true and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                 | Column | Tags                         | Query          | Action         |
      | tagdetails_ratiogreaterthan05matchfulltrue_csv.csv | _c2    | Hdfs_Csv_FullMatchPII_SC1Tag | FileFieldQuery | TagNotAssigned |

#################PIItags for DynamoDB tables , minimumRatio:0.2 matchfull true and matchempty false###########################

  #7163676,7163677,7163667,7163675,7163665,7163672,7163673,7163674,7163663

  Scenario:SC25#MLP_24889_Verify PIItags for DynamoDB tables , minimumRatio:0.2 matchfull true and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                | Column | Tags                         | Query          | Action         |
      | tagdetails_ratiolesserthan05matchfulltrue_csv.csv | _c2    | Hdfs_Csv_FullMatchPII_SC3Tag | FileFieldQuery | TagNotAssigned |

#############################################################################################################################################################################################
 ##########################################################Re-Run Scenario PII tags#####################################################################################
 #######################################################################################################################################################


  Scenario Outline:Policy2:Create root tag and sub tag for HDFS CSV Anlayzer and Update policy tags for CsvAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | body                                                   | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions | ida/CsvAnalyzer/API/PolicyEngine/HDFS_CSV_policy2.json | 204           |                  |          |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC26#-MLP_24889_Verify CsvAnalyzer does data sampling/data profiling properly for csv files when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:False)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | body | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC6_HDFS_PIITags |      | 200           | IDLE             | $.[?(@.configurationName=='SC6_HDFS_PIITags')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC6_HDFS_PIITags  |      | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC6_HDFS_PIITags |      | 200           | IDLE             | $.[?(@.configurationName=='SC6_HDFS_PIITags')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC6_CSV_PIITags |      | 200           | IDLE             | $.[?(@.configurationName=='SC6_CSV_PIITags')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC6_CSV_PIITags  |      | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/CsvAnalyzer/SC6_CSV_PIITags |      | 200           | IDLE             | $.[?(@.configurationName=='SC6_CSV_PIITags')].status  |

#
#     #################PIItags for DynamoDB tables , minimumRatio:0.6 matchfull true and matchempty false###########################

  #7163669,7163670,7163668,7163666,7163678,7163664,7163671,7163662

  Scenario:SC27#MLP_24889_Verify PIItags for DynamoDB tables , minimumRatio:0.6 matchfull true and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                 | Column | Tags                         | Query          | Action      |
      | tagdetails_ratiogreaterthan05matchfulltrue_csv.csv | _c2    | Hdfs_Csv_FullMatchPII_SC2Tag | FileFieldQuery | TagAssigned |

#################PIItags for DynamoDB tables , minimumRatio:0.2 matchfull true and matchempty false###########################

  #7163669,7163670,7163668,7163666,7163678,7163664,7163671,7163662

  Scenario:SC28#MLP_24889_Verify PIItags for DynamoDB tables , minimumRatio:0.2 matchfull true and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                | Column | Tags                         | Query          | Action      |
      | tagdetails_ratiolesserthan05matchfulltrue_csv.csv | _c2    | Hdfs_Csv_FullMatchPII_SC4Tag | FileFieldQuery | TagAssigned |


    ###############Set the PIItags for DynamoDB tables , minimumRatio:0.6 matchfull true and matchempty true#####################

  #7163669,7163670,7163668,7163666,7163678,7163664,7163671,7163662

  Scenario:SC29#MLP_24889_Verify PIItags for DynamoDB tables , minimumRatio:0.6 matchfull true and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                  | Column | Tags                         | Query          | Action      |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c8    | Hdfs_Csv_IPAddressPII_SC7Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_csv.csv | _c2    | Hdfs_Csv_EmailPII_SC7Tag     | FileFieldQuery | TagAssigned |


  @positve @regression @sanity  @ambari
  Scenario:SC30:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                       | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC6_HDFS_PIITags/% | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CsvAnalyzer/SC6_CSV_PIITags/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                               | Cluster  |       |       |

    ###########################################Delete Amabri folder , BA , Credentials and Config

  @MLP-1960  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC31:Delete folder in Ambaris
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization               | X-Requested-By | type   | url                                       | body | response code | response message |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /CsvAnalyzerTest?op=DELETE&recursive=true |      | 200           | true             |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /CsvPIITags?op=DELETE&recursive=true      |      | 200           | true             |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline:SC31:MLP-24889:Deleting the Credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                              | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/hdfsDBValidCredential                                       |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HdfsDataSource                                                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HdfsCataloger                                                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CsvAnalyzer                                                   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | policy/tagging/analysis?dataType=STRUCTURED&pluginName=CsvAnalyzer&technologies= |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | /tags/Default/tags/HDFS_CSV_PII                                                  |      | 204           |                  |          |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario:SC31:Delete Bussiness Application
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name            | type                | query | param |
      | SingleItemDelete | Default | HDFS_BA         | BusinessApplication |       |       |
      | SingleItemDelete | Default | CSV_ANALYZER_BA | BusinessApplication |       |       |
