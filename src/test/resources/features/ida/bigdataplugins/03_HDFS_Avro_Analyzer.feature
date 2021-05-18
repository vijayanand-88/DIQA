@MLP-7674  @MLP-24889 @MLP-26087
Feature:This is to support analyze Avrofiles for Hadoop environment.
  Description : As part of this we have to identify avro files and has to analyze the information that can be retrieved as part of these files.



  ###################################################Delete existing Anlaysis and CLuster if any#############################

  @positve @regression @sanity  @ambari
  Scenario:Pre-Condition:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AvroAnalyzer/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                | Cluster  |       |       |
      | SingleItemDelete | Default | Sandbox                     | Cluster  |       |       |
      | SingleItemDelete | Default | Cluster 1                   | Cluster  |       |       |

  ###############################################################################################################################
 #7156833
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC1#Get the Avro Analyzer Configuration response
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                               | body                                     | response code | response message | filePath                                   | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | /schemes/analyzers/configurations | response/Avro_Analyzer/body/ToolTip.json | 200           |                  | response/Avro_Analyzer/actual/ToolTip.json |          |

  #7156833
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline:SC2# Validate ToolTip for all the fields in Avro Analyzer plugin(Type,Plugin,Name,Plugin version,label,BA, Data Source, Credential,Event Condition,Dry Run, Event class,Max Work sixe,node condition,Auto Start,tags,Unique Filter)
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                               | actualValues                               | valueType     | expectedJsonPath                                     | actualJsonPath                                                  |
      | response/Avro_Analyzer/expected/ToolTip.json | response/Avro_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields..[?(@.label=='Type')].tooltip         | $..[?(@.label=='Type')].tooltip                                 |
      | response/Avro_Analyzer/expected/ToolTip.json | response/Avro_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields..[?(@.label=='Plugin')].tooltip       | $..[?(@.label=='Plugin')].tooltip                               |
      | response/Avro_Analyzer/expected/ToolTip.json | response/Avro_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.Name.tooltip                          | $.properties[0].value.prototype.properties[2].tooltip           |
      | response/Avro_Analyzer/expected/ToolTip.json | response/Avro_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.pluginVersion.tooltip                 | $.properties[0].value.prototype.properties[3].tooltip           |
      | response/Avro_Analyzer/expected/ToolTip.json | response/Avro_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.label.tooltip                         | $.properties[0].value.prototype.properties[4].tooltip           |
      | response/Avro_Analyzer/expected/ToolTip.json | response/Avro_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.businessApplicationName.tooltip       | $.properties[0].value.prototype.properties[15].tooltip          |
      | response/Avro_Analyzer/expected/ToolTip.json | response/Avro_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.eventCondition.tooltip                | $.properties[0].value.prototype.properties[5].tooltip           |
      | response/Avro_Analyzer/expected/ToolTip.json | response/Avro_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.dryRun.tooltip                        | $.properties[0].value.prototype.properties[6].tooltip           |
      | response/Avro_Analyzer/expected/ToolTip.json | response/Avro_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.eventClass.tooltip                    | $.properties[0].value.prototype.properties[7].tooltip           |
      | response/Avro_Analyzer/expected/ToolTip.json | response/Avro_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.maxWorkSize.tooltip                   | $.properties[0].value.prototype.properties[8].tooltip           |
      | response/Avro_Analyzer/expected/ToolTip.json | response/Avro_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.nodeCondition.tooltip                 | $.properties[0].value.prototype.properties[10].tooltip          |
      | response/Avro_Analyzer/expected/ToolTip.json | response/Avro_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.autoStart.tooltip                     | $.properties[0].value.prototype.properties[11].tooltip          |
      | response/Avro_Analyzer/expected/ToolTip.json | response/Avro_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.tags.tooltip                          | $.properties[0].value.prototype.properties[12].tooltip          |
      | response/Avro_Analyzer/expected/ToolTip.json | response/Avro_Analyzer/actual/ToolTip.json | stringCompare | $.Uniquefilter.AVROAnlayzer.sampleSize.tooltip       | $.properties[0].value.prototype.properties[16].value[0].tooltip |
      | response/Avro_Analyzer/expected/ToolTip.json | response/Avro_Analyzer/actual/ToolTip.json | stringCompare | $.Uniquefilter.AVROAnlayzer.histogramBuckets.tooltip | $.properties[0].value.prototype.properties[17].tooltip          |
      | response/Avro_Analyzer/expected/ToolTip.json | response/Avro_Analyzer/actual/ToolTip.json | stringCompare | $.Uniquefilter.AVROAnlayzer.topValues.tooltip        | $.properties[0].value.prototype.properties[18].tooltip          |



       #######################################setting the Credentials, BA ###############################################

  Scenario: SC2#-MLP_24889_Update the Host name respect to the docker
    And user update json file "ida/avroPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |

  Scenario: SC2#-MLP_24889_Update the node condition and analyzer graph fields
    And user "update" the json file "ida/avroPayloads/Analyzer/SC1_new_Avro_Analyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues           | type    |
      | $.configurations..nodeCondition    | name=="Cluster Demo" |         |
      | $.configurations..name             | AvroAnalyzerQA       |         |
      | $.configurations..tags[*]          | AvroAnalyzerQA       |         |
      | $.configurations..histogramBuckets | 100                  | Integer |
      | $.configurations..sampleSize       | 10                   | Integer |
      | $.configurations..topValues        | 10                   | Integer |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC2#-MLP_24889_Set the Credentials, Datasource, Bussiness Application and Cataloger for HDFSDB Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                        | body                                                               | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hdfsDBValidCredential | ida/avroPayloads/Credentials/hdfsdbValidCredentials.json           | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hdfsDBValidCredential |                                                                    | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root                         | ida\avroPayloads\Bussiness_Application\BussinessApplication.json   | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root                         | ida\hdfsPayloads\Bussiness_Application\BussinessApplication.json   | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/license                           | ida\hbasePayloads\DataSource\license_DS.json                       | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsDataSource          | ida/avroPayloads/DataSource/hdfsdbValidDataSourceConfig.json       | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HdfsDataSource          |                                                                    | 200           | HDFSDataSource_valid |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/AvroAnalyzer            | ida/avroPayloads/Analyzer/SC1_new_Avro_Analyzer_Configuration.json | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/AvroAnalyzer            |                                                                    | 200           | AvroAnalyzerQA       |          |



       ######################################Analyzer mandatory field error validation#####################################

  #7156839
  #Bug-26017
  @MLP-24196 @webtest @regression @positive
  Scenario:SC3#MLP_24196_Verify Avro Analyzer empty field validation messaged
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
      | Plugin    | AvroAnalyzer |
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
      | Name                  | AvroAnalyzerQA         |
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
  #7156839,7163965
  @MLP-24196 @webtest @regression @positive
  Scenario:SC3#MLP_24196_Verify Avro Analyzer field Histogram Bucket, Top values and Sample data Count shows proper error message for higher values
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
      | Plugin    | AvroAnalyzer |
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
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                          | body                                             | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | AvroAnalyzerTest/Avro1/Avro2/userDiffDataTypes.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/userDiffDataTypes.avro | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | AvroAnalyzerTest/Avro1/Avro2/userdata2.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true         | ida/hdfsPayloads/TestData/userdata2.avro         | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | AvroAnalyzerTest/Avro1/Avro2/userInfo.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true          | ida/hdfsPayloads/TestData/userInfo.avro          | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | AvroAnalyzerTest/Avro1/Avro2/product_sample.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/product_sample.parquet | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | AvroAnalyzerTest/Avro1/Avro2/DiffdatatypesWOH.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true   | ida/hdfsPayloads/TestData/DiffdatatypesWOH.csv   | 201           |                  |

  Scenario: SC4#-MLP_24889_Update the plugoin name and tag name
    And user "update" the json file "ida/avroPayloads/Analyzer/SC1_new_AvroHdfs_Cataloger_False_Configuration.json" file for following values
      | jsonPath                               | jsonValues                         | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"               |         |
      | $.configurations..dataSource           | HDFSDataSource_resolveclusterfalse |         |
      | $.configurations..filter..root         | /AvroAnalyzerTest                  |         |
      | $.configurations..name                 | SC1_Avro_DataSamp_Profiling        |         |
      | $.configurations..tags[*]              | SC1_Avro_DataSamp_Profiling        |         |
      | $.configurations..filter..tags[*]      | Positive                           |         |
      | $.configurations..analyzeCollectedData | false                              | boolean |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC4#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger for Avro  analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | body                                                                             | response code | response message                   | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                               | ida\hbasePayloads\DataSource\license_DS.json                                     | 204           |                                    |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                              | ida/avroPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                              |                                                                                  | 200           | HDFSDataSource_resolveclusterfalse |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                               | ida/avroPayloads/Analyzer/SC1_new_AvroHdfs_Cataloger_False_Configuration.json    | 204           |                                    |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                               |                                                                                  | 200           | SC1_Avro_DataSamp_Profiling        |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_Avro_DataSamp_Profiling |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC1_Avro_DataSamp_Profiling')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC1_Avro_DataSamp_Profiling  |                                                                                  | 200           |                                    |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_Avro_DataSamp_Profiling |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC1_Avro_DataSamp_Profiling')].status |


  Scenario: SC4#-MLP_24889_Update the node condition and analyzer graph fields
    And user "update" the json file "ida/avroPayloads/Analyzer/SC1_new_Avro_Analyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues           | type    |
      | $.configurations..nodeCondition    | name=="Cluster Demo" |         |
      | $.configurations..name             | SC1_AvroAnalyzer     |         |
      | $.configurations..tags[*]          | SC1_AvroAnalyzer     |         |
      | $.configurations..histogramBuckets | 100                  | Integer |
      | $.configurations..sampleSize       | 10                   | Integer |
      | $.configurations..topValues        | 10                   | Integer |

    #7156834
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC4#-MLP_24889_Verify AvroAnalyzer does data sampling/data profiling properly for Avro  files when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:False)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | body                                                               | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AvroAnalyzer                                                       | ida/avroPayloads/Analyzer/SC1_new_Avro_Analyzer_Configuration.json | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AvroAnalyzer                                                       |                                                                    | 200           | SC1_AvroAnalyzer |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC1_AvroAnalyzer |                                                                    | 200           | IDLE             | $.[?(@.configurationName=='SC1_AvroAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC1_AvroAnalyzer  |                                                                    | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC1_AvroAnalyzer |                                                                    | 200           | IDLE             | $.[?(@.configurationName=='SC1_AvroAnalyzer')].status |



     ###################################################Data Profiling########################################################################

 #7156834
  @webtest
  Scenario: SC#4 Verify Data profiling not happened other than avro files and displayed for Interger/Numeric/String and Boolean (Boolean, double, integer, String) datatype in Avro File.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1_AvroAnalyzer" and clicks on search
    And user performs "definite facet selection" in "SC1_AvroAnalyzer" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "AvroAnalyzerTest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Avro2" item from search results
    Then user performs click and verify in new window
      | Table  | value                  | Action               | RetainPrevwindow | indexSwitch |
      | Files  | userDiffDataTypes.avro | click and switch tab | No               |             |
      | Fields | username               | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | string        | Description |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section not present" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | age   | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | integer       | Description |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section present" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Fields | longType | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | long          | Description |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section present" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch |
      | Fields | floatType | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | float         | Description |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section present" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value      | Action               | RetainPrevwindow | indexSwitch |
      | Fields | doubleType | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | double        | Description |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section present" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value  | Action               | RetainPrevwindow | indexSwitch |
      | Fields | InCity | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | boolean       | Description |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section not present" on "Data Distribution" in Item view page
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | InCity                                         |
      | attributeName  | Maximum value                                  |
      | actualFilePath | ida\avroPayloads\API\Actual\Maximum value.json |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | InCity                                         |
      | attributeName  | Minimum value                                  |
      | actualFilePath | ida\avroPayloads\API\Actual\Minimum value.json |
    Then file content in "ida\avroPayloads\API\Actual\Maximum value.json" should be same as the content in "ida\avroPayloads\API\Expected\Maximum value.json"
    Then file content in "ida\avroPayloads\API\Actual\Minimum value.json" should be same as the content in "ida\avroPayloads\API\Expected\Minimum value.json"
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value      | Action                    | RetainPrevwindow | indexSwitch | filePath                                   | jsonPath                      | metadataSection |
      | Fields | username   | click and verify metadata | Yes              | 0           | ida/avroPayloads/API/expectedMetadata.json | $.DiffdatatypesWOH.username   | Statistics      |
      | Fields | age        | click and verify metadata | Yes              | 0           | ida/avroPayloads/API/expectedMetadata.json | $.DiffdatatypesWOH.age        | Statistics      |
      | Fields | longType   | click and verify metadata | Yes              | 0           | ida/avroPayloads/API/expectedMetadata.json | $.DiffdatatypesWOH.longtype   | Statistics      |
      | Fields | floatType  | click and verify metadata | Yes              | 0           | ida/avroPayloads/API/expectedMetadata.json | $.DiffdatatypesWOH.floatType  | Statistics      |
      | Fields | doubleType | click and verify metadata | Yes              | 0           | ida/avroPayloads/API/expectedMetadata.json | $.DiffdatatypesWOH.doubleType | Statistics      |

    ########################################################Data Sample validation############################################################################


  Scenario Outline:SC4:user get the Dynamic ID's (Database ID) for the Directory "Avro2" and File "DiffdatatypesWOH.csv,product_sample.parquet,userInfo.avro and userDiffDataTypes.avro,userdata2.avro"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type      | name  | asg_scopeid            | targetFile                               | jsonpath                                 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | Avro2 | DiffdatatypesWOH.csv   | payloads/ida/avroPayloads/API/items.json | $.Directories.Filename.DiffdatatypesWOH  |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | Avro2 | product_sample.parquet | payloads/ida/avroPayloads/API/items.json | $.Directories.Filename.product_sample    |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | Avro2 | userInfo.avro          | payloads/ida/avroPayloads/API/items.json | $.Directories.Filename.userInfo          |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | Avro2 | userDiffDataTypes.avro | payloads/ida/avroPayloads/API/items.json | $.Directories.Filename.userDiffDataTypes |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | Avro2 | userdata2.avro         | payloads/ida/avroPayloads/API/items.json | $.Directories.Filename.userdata2         |

  Scenario Outline: SC4:user hits the FileID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                                | inputFile                                | outPutFile                                                  | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.DiffdatatypesWOH  | payloads/ida/avroPayloads/API/items.json | payloads\ida\avroPayloads\API\Actual\DiffdatatypesWOH.json  |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.product_sample    | payloads/ida/avroPayloads/API/items.json | payloads\ida\avroPayloads\API\Actual\product_sample.json    |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.userInfo          | payloads/ida/avroPayloads/API/items.json | payloads\ida\avroPayloads\API\Actual\userInfo.json          |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.userDiffDataTypes | payloads/ida/avroPayloads/API/items.json | payloads\ida\avroPayloads\API\Actual\userDiffDataTypes.json |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.userdata2         | payloads/ida/avroPayloads/API/items.json | payloads\ida\avroPayloads\API\Actual\userdata2.json         |            |
#
#7156834
  Scenario: SC#4 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\avroPayloads\API\Actual\DiffdatatypesWOH.json" should be same as the content in "ida\avroPayloads\API\Expected\DiffdatatypesWOH.json"
    Then file content in "ida\avroPayloads\API\Actual\product_sample.json" should be same as the content in "ida\avroPayloads\API\Expected\product_sample.json"
    Then file content in "ida\avroPayloads\API\Actual\userInfo.json" should be same as the content in "ida\avroPayloads\API\Expected\userInfo.json"
    Then file content in "ida\avroPayloads\API\Actual\userDiffDataTypes.json" should be same as the content in "ida\avroPayloads\API\Expected\userDiffDataTypes.json"
    Then file content in "ida\avroPayloads\API\Actual\userdata2.json" should be same as the content in "ida\avroPayloads\API\Expected\userdata2.json"


    ##########################################################Technology ,BA and explicit tag validation######################################################
   #Bug-26107
  #7156829
  @positve @regression @sanity  @PIITag
  Scenario:Commoncase#MLP_24889_Verify Technology tag , Explicit tag , Bussiness Application tag and File Filter tag
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | directoryName | TableName/Filename | Column            | Tags                                                | Query          | Action      |
      |              |             | Avro2         | userdata2.avro     |                   | SC1_AvroAnalyzer,Avro,Hadoop Files,AVRO_ANALYZER_BA | FileQuery      | TagAssigned |
      |              |             |               | userdata2.avro     | registration_dttm | Avro,AVRO_ANALYZER_BA,SC1_AvroAnalyzer              | FileFieldQuery | TagAssigned |
      |              |             | Avro2         |                    |                   | SC1_AvroAnalyzer                                    | DirectoryQuery | TagAssigned |
      | Cluster Demo | HDFS        |               |                    |                   | SC1_AvroAnalyzer                                    | ServiceQuery   | TagAssigned |
      | Cluster Demo |             |               |                    |                   | SC1_AvroAnalyzer                                    | ClusterQuery   | TagAssigned |

  ############################################################Log Enhancemnt #################################################################################

  #7156829
  @sanity @positive @webtest @MLP-24889 @IDA-1.1.0
  Scenario:CommonCase:MLP_24889_Verify the Processed Items widget presence validation
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1_AvroAnalyzer" and clicks on search
    And user performs "facet selection" in "SC1_AvroAnalyzer" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/AvroAnalyzer/SC1_AvroAnalyzer/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 2             |
      | Number of errors          | 0             |
    And user "widget presence" on "Processed Items" in Item view page

#7156829
  Scenario:CommonCase:MLP_24889_Verify Logging Enhancement validation
    Then Analysis log "dataanalyzer/AvroAnalyzer/SC1_AvroAnalyzer/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | logCode            | pluginName   | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0019      |              |                |
      | INFO | Plugin Name:AvroAnalyzer, Plugin Type:dataanalyzer, Plugin Version:1.1.0.SNAPSHOT, Node Name:Cluster Demo, Host Name:sandbox.hortonworks.com, Plugin Configuration name:SC1_AvroAnalyzer                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ANALYSIS-0071      | AvroAnalyzer | Plugin Version |
      | INFO | INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: ---  2020-10-01 06:26:16.413 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: name: "SC1_AvroAnalyzer"  2020-10-01 06:26:16.413 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: pluginVersion: "LATEST"  2020-10-01 06:26:16.413 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: label:  2020-10-01 06:26:16.413 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: : ""  2020-10-01 06:26:16.414 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: catalogName: "Default"  2020-10-01 06:26:16.414 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: eventClass: null  2020-10-01 06:26:16.414 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: eventCondition: null  2020-10-01 06:26:16.414 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: nodeCondition: "name==\"Cluster Demo\""  2020-10-01 06:26:16.414 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: maxWorkSize: 100  2020-10-01 06:26:16.414 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: tags:  2020-10-01 06:26:16.414 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: - "SC1_AvroAnalyzer"  2020-10-01 06:26:16.414 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: pluginType: "dataanalyzer"  2020-10-01 06:26:16.414 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: dataSource: null  2020-10-01 06:26:16.414 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: credential: null  2020-10-01 06:26:16.414 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: businessApplicationName: "AVRO_ANALYZER_BA"  2020-10-01 06:26:16.414 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: dryRun: false  2020-10-01 06:26:16.414 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: schedule: null  2020-10-01 06:26:16.415 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: filter: null  2020-10-01 06:26:16.415 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: histogramBuckets: 100  2020-10-01 06:26:16.415 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: sparkOptions:  2020-10-01 06:26:16.415 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: - key: "deploy.mode"  2020-10-01 06:26:16.415 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: value: "cluster"  2020-10-01 06:26:16.415 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: - key: "spark.network.timeout"  2020-10-01 06:26:16.415 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: value: "600s"  2020-10-01 06:26:16.415 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: pluginName: "AvroAnalyzer"  2020-10-01 06:26:16.415 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: runAfter: []  2020-10-01 06:26:16.415 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: dataSample:  2020-10-01 06:26:16.415 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: sampleSize: 10  2020-10-01 06:26:16.415 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: type: "Dataanalyzer"  2020-10-01 06:26:16.416 INFO  - ANALYSIS-0073: Plugin AvroAnalyzer Configuration: topValues: 10 | ANALYSIS-0073      | AvroAnalyzer |                |
      | INFO | Plugin AvroAnalyzer Start Time:2020-10-01 06:26:16.412, End Time:2020-10-01 06:28:44.098, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0072      | AvroAnalyzer |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:01:55.385)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0020      |              |                |
      | INFO | Finish with HDFS analyzing, task 1 of 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | AVRO-ANALYZER-0001 |              |                |

    ##########################################################2nd run for Avro Analyzer and check the Last Analyzed at field value####################################################

   #7156838,7163965
  #Bug-26255
  @MLP-3422 @webtest @positve @hdfs @regression @sanity
  Scenario: SC4#-MLP_24889_Verify whether the last analyzed at value doesn't change for the second run if the collected files are not modified.
    Given User launch browser and traverse to login page
    And user enter credentials for "system Administrator1" role
    And user enters the search text "SC1_AvroAnalyzer" and clicks on search
    And user performs "definite facet selection" in "SC1_AvroAnalyzer" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "AvroAnalyzerTest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Avro2" item from search results
    Then user performs click and verify in new window
      | Table  | value             | Action               | RetainPrevwindow | indexSwitch |
      | Files  | userdata2.avro    | click and switch tab | No               |             |
      | Fields | registration_dttm | click and switch tab | No               |             |
    And user "store" the value of item "registration_dttm" of attribute "Last analyzed at" with temporary text
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body | response code | response message | jsonPath                                              |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC1_AvroAnalyzer |      | 200           | IDLE             | $.[?(@.configurationName=='SC1_AvroAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC1_AvroAnalyzer  |      | 200           |                  |                                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC1_AvroAnalyzer |      | 200           | IDLE             | $.[?(@.configurationName=='SC1_AvroAnalyzer')].status |
    And user enters the search text "SC1_AvroAnalyzer" and clicks on search
    And user performs "definite facet selection" in "SC1_AvroAnalyzer" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "AvroAnalyzerTest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Avro2" item from search results
    Then user performs click and verify in new window
      | Table  | value             | Action               | RetainPrevwindow | indexSwitch |
      | Files  | userdata2.avro    | click and switch tab | No               |             |
      | Fields | registration_dttm | click and switch tab | No               |             |
    Then user "verify equals" the value of item "registration_dttm" of attribute "Last analyzed at" with temporary text


  Scenario:SC4:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC1_Avro_DataSamp_Profiling/% | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AvroAnalyzer/SC1_AvroAnalyzer/%          | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                                          | Cluster  |       |       |

    ########################################################Data Sample and Data profiling with cluster resolve TRUE#############################################

  Scenario: SC5#-MLP_24889_Update the Host name respect to the docker
    And user update json file "ida/avroPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |


  Scenario: SC5#-MLP_24889_Update the plugoin name and tag name
    And user "update" the json file "ida/avroPayloads/Analyzer/SC1_new_AvroHdfs_Cataloger_False_Configuration.json" file for following values
      | jsonPath                               | jsonValues                        | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"              |         |
      | $.configurations..dataSource           | HDFSDataSource_valid              |         |
      | $.configurations..filter..root         | /AvroAnalyzerTest                 |         |
      | $.configurations..name                 | SC2_DataSamp_Profiling_diffvalues |         |
      | $.configurations..tags[*]              | SC2_DataSamp_Profiling_diffvalues |         |
      | $.configurations..filter..tags[*]      | Positive                          |         |
      | $.configurations..analyzeCollectedData | false                             | boolean |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC5#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger for Avro  analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                  | body                                                                          | response code | response message                  | jsonPath                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                                     | ida\hbasePayloads\DataSource\license_DS.json                                  | 204           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                                    | ida/avroPayloads/DataSource/hdfsdbValidDataSourceConfig.json                  | 204           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                                    |                                                                               | 200           | HDFSDataSource_valid              |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                                     | ida/avroPayloads/Analyzer/SC1_new_AvroHdfs_Cataloger_False_Configuration.json | 204           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                                     |                                                                               | 200           | SC2_DataSamp_Profiling_diffvalues |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC2_DataSamp_Profiling_diffvalues |                                                                               | 200           | IDLE                              | $.[?(@.configurationName=='SC2_DataSamp_Profiling_diffvalues')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC2_DataSamp_Profiling_diffvalues  |                                                                               | 200           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC2_DataSamp_Profiling_diffvalues |                                                                               | 200           | IDLE                              | $.[?(@.configurationName=='SC2_DataSamp_Profiling_diffvalues')].status |


  Scenario: SC5#-MLP_24889_Update the node condition and analyzer graph fields
    And user "update" the json file "ida/avroPayloads/Analyzer/SC1_new_Avro_Analyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues                  | type    |
      | $.configurations..nodeCondition    | name=="Cluster Demo"        |         |
      | $.configurations..name             | SC2_AvroAnalyzer_Diffvalues |         |
      | $.configurations..tags[*]          | SC2_AvroAnalyzer_Diffvalues |         |
      | $.configurations..histogramBuckets | 50                          | Integer |
      | $.configurations..sampleSize       | 15                          | Integer |
      | $.configurations..topValues        | 15                          | Integer |

    #7156835
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC5#-MLP_24889_Verify AvroAnalyzer does data sampling/data profiling properly for Avro  files when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:True)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | body                                                               | response code | response message            | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AvroAnalyzer                                                                  | ida/avroPayloads/Analyzer/SC1_new_Avro_Analyzer_Configuration.json | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AvroAnalyzer                                                                  |                                                                    | 200           | SC2_AvroAnalyzer_Diffvalues |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC2_AvroAnalyzer_Diffvalues |                                                                    | 200           | IDLE                        | $.[?(@.configurationName=='SC2_AvroAnalyzer_Diffvalues')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC2_AvroAnalyzer_Diffvalues  |                                                                    | 200           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC2_AvroAnalyzer_Diffvalues |                                                                    | 200           | IDLE                        | $.[?(@.configurationName=='SC2_AvroAnalyzer_Diffvalues')].status |



 #7156835
  @webtest
  Scenario: SC#5 Verify Data profiling not happened other than avro files and displayed for Interger/Numeric/String and Boolean (Boolean, double, integer, String) datatype in Avro File.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC2_AvroAnalyzer_Diffvalues" and clicks on search
    And user performs "definite facet selection" in "SC2_AvroAnalyzer_Diffvalues" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "AvroAnalyzerTest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Avro2" item from search results
    Then user performs click and verify in new window
      | Table  | value                  | Action               | RetainPrevwindow | indexSwitch |
      | Files  | userDiffDataTypes.avro | click and switch tab | No               |             |
      | Fields | username               | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | string        | Description |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section not present" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | age   | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | integer       | Description |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section present" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Fields | longType | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | long          | Description |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section present" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch |
      | Fields | floatType | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | float         | Description |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section present" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value      | Action               | RetainPrevwindow | indexSwitch |
      | Fields | doubleType | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | double        | Description |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section present" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value  | Action               | RetainPrevwindow | indexSwitch |
      | Fields | InCity | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | boolean       | Description |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section not present" on "Data Distribution" in Item view page
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | InCity                                         |
      | attributeName  | Maximum value                                  |
      | actualFilePath | ida\avroPayloads\API\Actual\Maximum value.json |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | InCity                                         |
      | attributeName  | Minimum value                                  |
      | actualFilePath | ida\avroPayloads\API\Actual\Minimum value.json |
    Then file content in "ida\avroPayloads\API\Actual\Maximum value.json" should be same as the content in "ida\avroPayloads\API\Expected\Maximum value.json"
    Then file content in "ida\avroPayloads\API\Actual\Minimum value.json" should be same as the content in "ida\avroPayloads\API\Expected\Minimum value.json"
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value      | Action                    | RetainPrevwindow | indexSwitch | filePath                                   | jsonPath                      | metadataSection |
      | Fields | username   | click and verify metadata | Yes              | 0           | ida/avroPayloads/API/expectedMetadata.json | $.DiffdatatypesWOH.username   | Statistics      |
      | Fields | age        | click and verify metadata | Yes              | 0           | ida/avroPayloads/API/expectedMetadata.json | $.DiffdatatypesWOH.age        | Statistics      |
      | Fields | longType   | click and verify metadata | Yes              | 0           | ida/avroPayloads/API/expectedMetadata.json | $.DiffdatatypesWOH.longtype   | Statistics      |
      | Fields | floatType  | click and verify metadata | Yes              | 0           | ida/avroPayloads/API/expectedMetadata.json | $.DiffdatatypesWOH.floatType  | Statistics      |
      | Fields | doubleType | click and verify metadata | Yes              | 0           | ida/avroPayloads/API/expectedMetadata.json | $.DiffdatatypesWOH.doubleType | Statistics      |

    ########################################################Data Sample validation############################################################################


  Scenario Outline:SC5:user get the Dynamic ID's (Database ID) for the Directory "Avro2" and File "DiffdatatypesWOH.csv,product_sample.parquet,userInfo.avro and userDiffDataTypes.avro,userdata2.avro"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type      | name  | asg_scopeid            | targetFile                               | jsonpath                                 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | Avro2 | DiffdatatypesWOH.csv   | payloads/ida/avroPayloads/API/items.json | $.Directories.Filename.DiffdatatypesWOH  |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | Avro2 | product_sample.parquet | payloads/ida/avroPayloads/API/items.json | $.Directories.Filename.product_sample    |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | Avro2 | userInfo.avro          | payloads/ida/avroPayloads/API/items.json | $.Directories.Filename.userInfo          |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | Avro2 | userDiffDataTypes.avro | payloads/ida/avroPayloads/API/items.json | $.Directories.Filename.userDiffDataTypes |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | Avro2 | userdata2.avro         | payloads/ida/avroPayloads/API/items.json | $.Directories.Filename.userdata2         |

  Scenario Outline: SC5:user hits the FileID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                                | inputFile                                | outPutFile                                                  | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.DiffdatatypesWOH  | payloads/ida/avroPayloads/API/items.json | payloads\ida\avroPayloads\API\Actual\DiffdatatypesWOH.json  |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.product_sample    | payloads/ida/avroPayloads/API/items.json | payloads\ida\avroPayloads\API\Actual\product_sample.json    |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.userInfo          | payloads/ida/avroPayloads/API/items.json | payloads\ida\avroPayloads\API\Actual\userInfo.json          |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.userDiffDataTypes | payloads/ida/avroPayloads/API/items.json | payloads\ida\avroPayloads\API\Actual\userDiffDataTypes.json |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.userdata2         | payloads/ida/avroPayloads/API/items.json | payloads\ida\avroPayloads\API\Actual\userdata2.json         |            |
#
#7156835
  Scenario: SC#5 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\avroPayloads\API\Actual\DiffdatatypesWOH.json" should be same as the content in "ida\avroPayloads\API\Expected\DiffdatatypesWOH.json"
    Then file content in "ida\avroPayloads\API\Actual\product_sample.json" should be same as the content in "ida\avroPayloads\API\Expected\product_sample.json"
    Then file content in "ida\avroPayloads\API\Actual\userInfo.json" should be same as the content in "ida\avroPayloads\API\Expected\userInfo.json"
    Then file content in "ida\avroPayloads\API\Actual\userDiffDataTypes.json" should be same as the content in "ida\avroPayloads\API\Expected\userDiffDataTypes.json"
    Then file content in "ida\avroPayloads\API\Actual\userdata2.json" should be same as the content in "ida\avroPayloads\API\Expected\userdata2_15.json"

  ###############################################################Avro Analyzer process only Avro files##################################################

   #7156835
  @webtest
  Scenario:SC6#MLP_21662_Verify AvroAnalyzer does not analyze non Avro files(lastAnalyzedAt attribute will not be there)
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC2_DataSamp_Profiling_diffvalues" and clicks on search
    And user performs "facet selection" in "SC2_DataSamp_Profiling_diffvalues" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DiffdatatypesWOH.csv" item from search results
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last Analyzed At  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table | value                  | Action               | RetainPrevwindow | indexSwitch |
      | Files | product_sample.parquet | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last Analyzed At  | Lifecycle  |


    ##################################################################### Rename the file scenario################################################################
  #7156842
  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline: SC#7Renaming the already created file in the existing directory
    Given sync the test execution for "10" seconds
    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                     | body | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | AvroAnalyzerTest/Avro1/Avro2/userDiffDataTypes.avro?user.name=raj_ops&op=RENAME&destination=/AvroAnalyzerTest/Avro1/Avro2/userDiffDataTypes_Rename.avro |      | 200           | true             |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC7#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger for Avro  analyzer second run
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                  | body | response code | response message | jsonPath                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC2_DataSamp_Profiling_diffvalues |      | 200           | IDLE             | $.[?(@.configurationName=='SC2_DataSamp_Profiling_diffvalues')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC2_DataSamp_Profiling_diffvalues  |      | 200           |                  |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC2_DataSamp_Profiling_diffvalues |      | 200           | IDLE             | $.[?(@.configurationName=='SC2_DataSamp_Profiling_diffvalues')].status |


    #7156842
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC7#-MLP_24889_Verify AvroAnalyzer does data sampling/data profiling properly for Avro  files when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:True) second run
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | body | response code | response message | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC2_AvroAnalyzer_Diffvalues |      | 200           | IDLE             | $.[?(@.configurationName=='SC2_AvroAnalyzer_Diffvalues')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC2_AvroAnalyzer_Diffvalues  |      | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC2_AvroAnalyzer_Diffvalues |      | 200           | IDLE             | $.[?(@.configurationName=='SC2_AvroAnalyzer_Diffvalues')].status |


  ###################################################Data Profiling for Renamed file########################################################################

 #7156842
  #Bug-26016
  @webtest
  Scenario: SC#7 Verify Data profiling not happened other than avro files and displayed for Interger/Numeric/String and Boolean (Boolean, double, integer, String) datatype in Avro File.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC2_AvroAnalyzer_Diffvalues" and clicks on search
    And user performs "definite facet selection" in "SC2_AvroAnalyzer_Diffvalues" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "AvroAnalyzerTest [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Avro2" item from search results
    Then user performs click and verify in new window
      | Table  | value                         | Action               | RetainPrevwindow | indexSwitch |
      | Files  | userDiffDataTypes_Rename.avro | click and switch tab | No               |             |
      | Fields | username                      | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | string        | Description |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section not present" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value | Action               | RetainPrevwindow | indexSwitch |
      | Fields | age   | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | integer       | Description |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section present" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Fields | longType | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | long          | Description |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section present" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch |
      | Fields | floatType | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | float         | Description |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section present" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value      | Action               | RetainPrevwindow | indexSwitch |
      | Fields | doubleType | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | double        | Description |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section present" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value  | Action               | RetainPrevwindow | indexSwitch |
      | Fields | InCity | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | boolean       | Description |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section not present" on "Data Distribution" in Item view page
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | InCity                                         |
      | attributeName  | Maximum value                                  |
      | actualFilePath | ida\avroPayloads\API\Actual\Maximum value.json |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | InCity                                         |
      | attributeName  | Minimum value                                  |
      | actualFilePath | ida\avroPayloads\API\Actual\Minimum value.json |
    Then file content in "ida\avroPayloads\API\Actual\Maximum value.json" should be same as the content in "ida\avroPayloads\API\Expected\Maximum value.json"
    Then file content in "ida\avroPayloads\API\Actual\Minimum value.json" should be same as the content in "ida\avroPayloads\API\Expected\Minimum value.json"
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value      | Action                    | RetainPrevwindow | indexSwitch | filePath                                   | jsonPath                      | metadataSection |
      | Fields | username   | click and verify metadata | Yes              | 0           | ida/avroPayloads/API/expectedMetadata.json | $.DiffdatatypesWOH.username   | Statistics      |
      | Fields | age        | click and verify metadata | Yes              | 0           | ida/avroPayloads/API/expectedMetadata.json | $.DiffdatatypesWOH.age        | Statistics      |
      | Fields | longType   | click and verify metadata | Yes              | 0           | ida/avroPayloads/API/expectedMetadata.json | $.DiffdatatypesWOH.longType   | Statistics      |
      | Fields | floatType  | click and verify metadata | Yes              | 0           | ida/avroPayloads/API/expectedMetadata.json | $.DiffdatatypesWOH.floatType  | Statistics      |
      | Fields | doubleType | click and verify metadata | Yes              | 0           | ida/avroPayloads/API/expectedMetadata.json | $.DiffdatatypesWOH.doubleType | Statistics      |


      ########################################################Data Sample validation for renamed file ############################################################################

  Scenario Outline:SC7:user get the Dynamic ID's (Database ID) for the Directory "Avro2" and File "DiffdatatypesWOH.csv,product_sample.parquet,userInfo.avro and userDiffDataTypes_Renamed.avro,userdata2.avro"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type      | name  | asg_scopeid                   | targetFile                               | jsonpath                                 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Directory | Avro2 | userDiffDataTypes_Rename.avro | payloads/ida/avroPayloads/API/items.json | $.Directories.Filename.userDiffDataTypes |

  Scenario Outline: SC7:user hits the FileID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                                | inputFile                                | outPutFile                                                         | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Directories.Filename.userDiffDataTypes | payloads/ida/avroPayloads/API/items.json | payloads\ida\avroPayloads\API\Actual\userDiffDataTypes_rename.json |            |
   #
#7156842
  Scenario: SC#7 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\avroPayloads\API\Actual\userDiffDataTypes_rename.json" should be same as the content in "ida\avroPayloads\API\Expected\userDiffDataTypes.json"


  Scenario:SC7:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                        | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC2_DataSamp_Profiling_diffvalues/% | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AvroAnalyzer/SC2_AvroAnalyzer_Diffvalues/%     | Analysis |       |       |
      | SingleItemDelete | Default | Sandbox                                                     | Cluster  |       |       |

   ########################################################Avro Analyzer doesn't analyze data when invliddir in Hdfs cataloger config############################################################################


  Scenario: SC8#-MLP_24889_Update the plugoin name and tag name
    And user "update" the json file "ida/avroPayloads/Analyzer/SC1_new_AvroHdfs_Cataloger_False_Configuration.json" file for following values
      | jsonPath                               | jsonValues                         | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"               |         |
      | $.configurations..dataSource           | HDFSDataSource_resolveclusterfalse |         |
      | $.configurations..filter..root         | /Invalid_dir                       |         |
      | $.configurations..name                 | SC3_Avro_InvalidDir                |         |
      | $.configurations..tags[*]              | SC3_Avro_InvalidDir                |         |
      | $.configurations..filter..tags[*]      | NoDir                              |         |
      | $.configurations..analyzeCollectedData | false                              | boolean |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC8#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger for Avro  analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                             | response code | response message                   | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                       | ida\hbasePayloads\DataSource\license_DS.json                                     | 204           |                                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                      | ida/avroPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                      |                                                                                  | 200           | HDFSDataSource_resolveclusterfalse |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                       | ida/avroPayloads/Analyzer/SC1_new_AvroHdfs_Cataloger_False_Configuration.json    | 204           |                                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                       |                                                                                  | 200           | SC3_Avro_InvalidDir                |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC3_Avro_InvalidDir |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC3_Avro_InvalidDir')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC3_Avro_InvalidDir  |                                                                                  | 200           |                                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC3_Avro_InvalidDir |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC3_Avro_InvalidDir')].status |


  Scenario: SC8#-MLP_24889_Update the node condition and analyzer graph fields
    And user "update" the json file "ida/avroPayloads/Analyzer/SC1_new_Avro_Analyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues           | type    |
      | $.configurations..nodeCondition    | name=="Cluster Demo" |         |
      | $.configurations..name             | SC3_AvroAnalyzer     |         |
      | $.configurations..tags[*]          | SC3_AvroAnalyzer     |         |
      | $.configurations..histogramBuckets | 100                  | Integer |
      | $.configurations..sampleSize       | 10                   | Integer |
      | $.configurations..topValues        | 10                   | Integer |

    #7163787
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC8#-MLP_24889_Verify AvroAnalyzer does data sampling/data profiling properly for Avro  files when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:False)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | body                                                               | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AvroAnalyzer                                                       | ida/avroPayloads/Analyzer/SC1_new_Avro_Analyzer_Configuration.json | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AvroAnalyzer                                                       |                                                                    | 200           | SC3_AvroAnalyzer |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC3_AvroAnalyzer |                                                                    | 200           | IDLE             | $.[?(@.configurationName=='SC3_AvroAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC3_AvroAnalyzer  |                                                                    | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC3_AvroAnalyzer |                                                                    | 200           | IDLE             | $.[?(@.configurationName=='SC3_AvroAnalyzer')].status |

#7163787
  @sanity @positive @webtest @avro
  Scenario:SC8#MLP_24889_Verify the cataloger doesn't collects the data when invalid directory is provided
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC3_AvroAnalyzer" and clicks on search
    And user performs "facet selection" in "SC3_AvroAnalyzer" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Directory |
      | File      |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/AvroAnalyzer/SC3_AvroAnalyzer%"
    And METADATA widget should have following item values
      | metaDataItem              | metaDataItemValue |
      | Number of errors          | 0                 |
      | Number of processed items | 0                 |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "dataanalyzer/AvroAnalyzer/SC3_AvroAnalyzer/%" should display below info/error/warning
      | type | logValue                                                                                                                                         | logCode       | pluginName    | removableText |
      | INFO | ANALYSIS-0072: Plugin AvroAnalyzer Start Time:2020-07-30 17:11:18.233, End Time:2020-07-30 17:11:19.831, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | HdfsCataloger |               |

  Scenario:SC8:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC3_Avro_InvalidDir/% | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AvroAnalyzer/SC3_AvroAnalyzer/%  | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                                  | Cluster  |       |       |

 ###################################################Only Avro Anlayzer Run without HDFS Cataloger#####################################################################

  Scenario: SC9#-MLP_24889_Update the node condition and analyzer graph fields
    And user "update" the json file "ida/avroPayloads/Analyzer/SC1_new_Avro_Analyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues           | type    |
      | $.configurations..nodeCondition    | name=="Cluster Demo" |         |
      | $.configurations..name             | SC4_OnlyAvroAnalyzer |         |
      | $.configurations..tags[*]          | SC4_OnlyAvroAnalyzer |         |
      | $.configurations..histogramBuckets | 100                  | Integer |
      | $.configurations..sampleSize       | 10                   | Integer |
      | $.configurations..topValues        | 10                   | Integer |

    #7156836
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC9#-MLP_24889_Verify AvroAnalyzer does data sampling/data profiling properly for Avro  files when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:False)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                               | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AvroAnalyzer                                                           | ida/avroPayloads/Analyzer/SC1_new_Avro_Analyzer_Configuration.json | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AvroAnalyzer                                                           |                                                                    | 200           | SC4_OnlyAvroAnalyzer |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC4_OnlyAvroAnalyzer |                                                                    | 200           | IDLE                 | $.[?(@.configurationName=='SC4_OnlyAvroAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC4_OnlyAvroAnalyzer  |                                                                    | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC4_OnlyAvroAnalyzer |                                                                    | 200           | IDLE                 | $.[?(@.configurationName=='SC4_OnlyAvroAnalyzer')].status |


     #7156836
  #Bug-26015
  @sanity @positive @webtest @MLP-24889 @IDA-1.1.0
  Scenario:SC9#:MLP_24889_Verify AvroAnalyzer is ran without HDFSCataloger and the analyzer log shows proper message.
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC4_OnlyAvroAnalyzer" and clicks on search
    And user performs "facet selection" in "SC4_OnlyAvroAnalyzer" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Directory |
      | File      |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/AvroAnalyzer/SC4_OnlyAvroAnalyzer%"
    And METADATA widget should have following item values
      | metaDataItem              | metaDataItemValue |
      | Number of errors          | 0                 |
      | Number of processed items | 0                 |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "dataanalyzer/AvroAnalyzer/SC4_OnlyAvroAnalyzer/%" should display below info/error/warning
      | type | logValue                                                                                                                          | logCode       | pluginName   | removableText |
      | INFO | Plugin AvroAnalyzer Start Time:2020-08-05 14:50:56.710, End Time:2020-08-05 14:50:56.954, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | AvroAnalyzer |               |

  Scenario:SC9:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                             | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/AvroAnalyzer/SC4_OnlyAvroAnalyzer/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                                     | Cluster  |       |       |


##########################################################Dry Run#########################################################

  Scenario: CommonCase#-MLP_24889_Update the plugoin name and tag name
    And user "update" the json file "ida/avroPayloads/Analyzer/SC1_new_AvroHdfs_Cataloger_False_Configuration.json" file for following values
      | jsonPath                               | jsonValues                         | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"               |         |
      | $.configurations..dataSource           | HDFSDataSource_resolveclusterfalse |         |
      | $.configurations..filter..root         | /AvroAnalyzerTest                  |         |
      | $.configurations..name                 | SC5_Avro_Hdfs_DryRun               |         |
      | $.configurations..tags[*]              | SC5_Avro_Hdfs_DryRun               |         |
      | $.configurations..filter..tags[*]      | Positive                           |         |
      | $.configurations..analyzeCollectedData | false                              | boolean |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: CommonCase#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger for Avro  analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                             | response code | response message                   | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                        | ida\hbasePayloads\DataSource\license_DS.json                                     | 204           |                                    |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                       | ida/avroPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                       |                                                                                  | 200           | HDFSDataSource_resolveclusterfalse |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                        | ida/avroPayloads/Analyzer/SC1_new_AvroHdfs_Cataloger_False_Configuration.json    | 204           |                                    |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                        |                                                                                  | 200           | SC5_Avro_Hdfs_DryRun               |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC5_Avro_Hdfs_DryRun |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC5_Avro_Hdfs_DryRun')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC5_Avro_Hdfs_DryRun  |                                                                                  | 200           |                                    |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC5_Avro_Hdfs_DryRun |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC5_Avro_Hdfs_DryRun')].status |


    #7156829
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: CommonCase#-MLP_24889_Verify AvroAnalyzer does not do data sampling/data profiling properly for avro files when Dry Run set TRUE
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | body                                                                           | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AvroAnalyzer                                                      | ida/avroPayloads/Analyzer/SC1_new_AvroHdfs_Cataloger_DryRun_Configuration.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AvroAnalyzer                                                      |                                                                                | 200           | SC5_Avro_DryRun  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC5_Avro_DryRun |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='SC5_Avro_DryRun')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC5_Avro_DryRun  |                                                                                | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC5_Avro_DryRun |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='SC5_Avro_DryRun')].status |

   #7156829
  #Bug-26015
  @sanity @positive @webtest @MLP-24889 @IDA-1.1.0
  Scenario:CommonCase:MLP_24889_Verify no Cluster , Table , Database , Host and service facets are cataloged and verify log message
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC5_Avro_DryRun" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/AvroAnalyzer/SC5_Avro_DryRun/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "dataanalyzer/AvroAnalyzer/SC5_Avro_DryRun/%" should display below info/error/warning
      | type | logValue                                                                                | logCode       | pluginName   | removableText |
      | INFO | Plugin AvroAnalyzer running on dry run mode                                             | ANALYSIS-0069 | AvroAnalyzer |               |
      | INFO | Plugin AvroAnalyzer processed 2 items on dry run mode and not written to the repository | ANALYSIS-0070 | AvroAnalyzer |               |
      | INFO | Plugin completed                                                                        | ANALYSIS-0020 |              |               |

  Scenario:CommonCase:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC5_Avro_Hdfs_DryRun/% | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AvroAnalyzer/SC5_Avro_DryRun/%    | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                                   | Cluster  |       |       |

         ###################################################Delete existing Anlaysis and CLuster if any#############################

  @positve @regression @sanity  @ambari
  Scenario:Pre-Condition:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AvroAnalyzer/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                | Cluster  |       |       |
      | SingleItemDelete | Default | Sandbox                     | Cluster  |       |       |
      | SingleItemDelete | Default | Cluster 1                   | Cluster  |       |       |

      ############################################# Policy Patterns - PII Tagging ##########################################################


  @MLP-26087 @positve @hdfs @regression @sanity
  Scenario Outline:SC#10:Creating a directory in Ambari Files View and Uploading a file into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                                                        | body                                                                                         | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | AVROPIITags/Folder1/Folder2/tagdetails_allempty_avro.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                         | ida/hdfsPayloads/TestData/Avro_PIITags/tagdetails_allempty_avro.avro                         | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | AVROPIITags/Folder1/Folder2/tagdetails_allmatch_avro.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                         | ida/hdfsPayloads/TestData/Avro_PIITags/tagdetails_allmatch_avro.avro                         | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | AVROPIITags/Folder1/Folder2/tagdetails_ratioequalto05emptyfalse_avro.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true         | ida/hdfsPayloads/TestData/Avro_PIITags/tagdetails_ratioequalto05emptyfalse_avro.avro         | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | AVROPIITags/Folder1/Folder2/tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/Avro_PIITags/tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | AVROPIITags/Folder1/Folder2/tagdetails_ratiogreaterthan05matchfulltrue_avro.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true  | ida/hdfsPayloads/TestData/Avro_PIITags/tagdetails_ratiogreaterthan05matchfulltrue_avro.avro  | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | AVROPIITags/Folder1/Folder2/tagdetails_ratiolesserthan05matchfulltrue_avro.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true   | ida/hdfsPayloads/TestData/Avro_PIITags/tagdetails_ratiolesserthan05matchfulltrue_avro.avro   | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | AVROPIITags/Folder1/Folder2/tagdetails_ratiolessthan05emptyfalse_avro.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true        | ida/hdfsPayloads/TestData/Avro_PIITags/tagdetails_ratiolessthan05emptyfalse_avro.avro        | 201           |                  |


  Scenario Outline:Policy1:Create root tag and sub tag for HDFS AVRO Anlayzer and Update policy tags for AvroAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                                          | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | tags/Default/structures | ida/avroPayloads/API/PolicyEngine/HDFS_AVRO_TagStructure.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions  | ida/avroPayloads/API/PolicyEngine/HDFS_AVRO_policy1.json      | 204           |                  |          |

  Scenario: SC10#-MLP_24889_Update the plugoin name and tag name
    And user "update" the json file "ida/avroPayloads/Analyzer/SC1_new_AvroHdfs_Cataloger_False_Configuration.json" file for following values
      | jsonPath                               | jsonValues                         | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"               |         |
      | $.configurations..dataSource           | HDFSDataSource_resolveclusterfalse |         |
      | $.configurations..filter..root         | /AVROPIITags                       |         |
      | $.configurations..name                 | SC6_HdfsAvro_PIITags               |         |
      | $.configurations..tags[*]              | SC6_HdfsAvro_PIITags               |         |
      | $.configurations..filter..tags[*]      | Folder                             |         |
      | $.configurations..analyzeCollectedData | false                              | boolean |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC10#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger for Avro  analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                             | response code | response message                   | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                        | ida\hbasePayloads\DataSource\license_DS.json                                     | 204           |                                    |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                       | ida/avroPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                       |                                                                                  | 200           | HDFSDataSource_resolveclusterfalse |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                        | ida/avroPayloads/Analyzer/SC1_new_AvroHdfs_Cataloger_False_Configuration.json    | 204           |                                    |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                        |                                                                                  | 200           | SC6_HdfsAvro_PIITags               |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC6_HdfsAvro_PIITags |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC6_HdfsAvro_PIITags')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC6_HdfsAvro_PIITags  |                                                                                  | 200           |                                    |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC6_HdfsAvro_PIITags |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC6_HdfsAvro_PIITags')].status |


  Scenario: SC10#-MLP_24889_Update the node condition and analyzer graph fields
    And user "update" the json file "ida/avroPayloads/Analyzer/SC1_new_Avro_Analyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues               | type    |
      | $.configurations..nodeCondition    | name=="Cluster Demo"     |         |
      | $.configurations..name             | SC6_AvroAnalyzer_PIItags |         |
      | $.configurations..tags[*]          | SC6_AvroAnalyzer_PIItags |         |
      | $.configurations..histogramBuckets | 100                      | Integer |
      | $.configurations..sampleSize       | 10                       | Integer |
      | $.configurations..topValues        | 10                       | Integer |

    #7152591
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC10#-MLP_24889_Verify AvroAnalyzer does data sampling/data profiling properly for Avro  files when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:False)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                           | body                                                               | response code | response message         | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AvroAnalyzer                                                               | ida/avroPayloads/Analyzer/SC1_new_Avro_Analyzer_Configuration.json | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AvroAnalyzer                                                               |                                                                    | 200           | SC6_AvroAnalyzer_PIItags |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC6_AvroAnalyzer_PIItags |                                                                    | 200           | IDLE                     | $.[?(@.configurationName=='SC6_AvroAnalyzer_PIItags')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC6_AvroAnalyzer_PIItags  |                                                                    | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC6_AvroAnalyzer_PIItags |                                                                    | 200           | IDLE                     | $.[?(@.configurationName=='SC6_AvroAnalyzer_PIItags')].status |

     ###########Set the PIITags for Avro file fields ,typePattern can be set as:VARCHAR or .*VAR.*minimumRatio:0.5, Match Empty=false, Match Full=false##############

  #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093
  @positve @regression @sanity  @PIITag
  Scenario:SC11#MLP_26807_Verify PIItags for AVRO File fields ,typePattern can be set as:VARCHAR or .*VAR.*minimumRatio:0.5, Match Empty=false, Match Full=false
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                    | Column    | Tags                          | Query          | Action      |
      | tagdetails_allmatch_avro.avro                         | GENDER    | Hdfs_Avro_GenderPII_SC1Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_avro.avro                         | SSN       | Hdfs_Avro_SSNPII_SC1Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_avro.avro                         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC1Tag | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_avro.avro                         | FULL_NAME | Hdfs_Avro_FullNamePII_SC1Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_avro.avro                         | EMAIL     | Hdfs_Avro_EmailPII_SC1Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_avro.avro                         | EMAIL     | Hdfs_Avro_EmailPII_SC1Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_avro.avro                         | SSN       | Hdfs_Avro_SSNPII_SC1Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_avro.avro                         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC1Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | EMAIL     | Hdfs_Avro_EmailPII_SC1Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | GENDER    | Hdfs_Avro_GenderPII_SC1Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | IPADDRESS | Hdfs_Avro_IPAddressPII_SC1Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | GENDER    | Hdfs_Avro_GenderPII_SC1Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | SSN       | Hdfs_Avro_SSNPII_SC1Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | IPADDRESS | Hdfs_Avro_IPAddressPII_SC1Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | FULL_NAME | Hdfs_Avro_FullNamePII_SC1Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | EMAIL     | Hdfs_Avro_EmailPII_SC1Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | GENDER    | Hdfs_Avro_GenderPII_SC1Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | SSN       | Hdfs_Avro_SSNPII_SC1Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC1Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | FULL_NAME | Hdfs_Avro_FullNamePII_SC1Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | EMAIL     | Hdfs_Avro_EmailPII_SC1Tag     | FileFieldQuery | TagAssigned |

  ########Set the PIITags for Avro file fields , typePattern can be set as:  NUMBER or .*VAR1.* or .*FLOAT.* or .*NUM.*  minimumRatio:0.5#########

#7170107,7170098,7170094,7170105,7170104,7170103,7170096,7170106
  @positve @regression @sanity  @PIITag
  Scenario:SC12#MLP_26807_Verify PIITags not set for Avro file fields , typePattern can be set as:  NUMBER or .*VAR1.* or .*FLOAT.* or .*NUM.*  minimumRatio:0.5
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                    | Column    | Tags                          | Query          | Action         |
      | tagdetails_allmatch_avro.avro                         | GENDER    | Hdfs_Avro_GenderPII_SC2Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | SSN       | Hdfs_Avro_SSNPII_SC2Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC2Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | FULL_NAME | Hdfs_Avro_FullNamePII_SC2Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | EMAIL     | Hdfs_Avro_EmailPII_SC2Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_avro.avro                         | EMAIL     | Hdfs_Avro_EmailPII_SC2Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_avro.avro                         | SSN       | Hdfs_Avro_SSNPII_SC2Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_avro.avro                         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC2Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | EMAIL     | Hdfs_Avro_EmailPII_SC2Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | GENDER    | Hdfs_Avro_GenderPII_SC2Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | IPADDRESS | Hdfs_Avro_IPAddressPII_SC2Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | GENDER    | Hdfs_Avro_GenderPII_SC2Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | SSN       | Hdfs_Avro_SSNPII_SC2Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | IPADDRESS | Hdfs_Avro_IPAddressPII_SC2Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | FULL_NAME | Hdfs_Avro_FullNamePII_SC2Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | EMAIL     | Hdfs_Avro_EmailPII_SC2Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | GENDER    | Hdfs_Avro_GenderPII_SC2Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | SSN       | Hdfs_Avro_SSNPII_SC2Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC2Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | FULL_NAME | Hdfs_Avro_FullNamePII_SC2Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | EMAIL     | Hdfs_Avro_EmailPII_SC2Tag     | FileFieldQuery | TagNotAssigned |

###############PIITags for Avro file fields , namePattern can be set as:.*FULL.*,IPADDRESS,GENDER,.*EMAIL.*,SSN, minimumRatio:0.5################

    #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  @positve @regression @sanity  @PIITag
  Scenario:SC13#MLP_26807_Verify PIITags for AVRO Files  , namePattern can be set as:.*FULL.*,.*IP.*,GENDER,.*EMAIL.*,SSN.*, minimumRatio:0.5
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                    | Column    | Tags                          | Query          | Action      |
      | tagdetails_allmatch_avro.avro                         | GENDER    | Hdfs_Avro_GenderPII_SC3Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_avro.avro                         | SSN       | Hdfs_Avro_SSNPII_SC3Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_avro.avro                         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC3Tag | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_avro.avro                         | FULL_NAME | Hdfs_Avro_FullNamePII_SC3Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_avro.avro                         | EMAIL     | Hdfs_Avro_EmailPII_SC3Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_avro.avro                         | EMAIL     | Hdfs_Avro_EmailPII_SC3Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_avro.avro                         | SSN       | Hdfs_Avro_SSNPII_SC3Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_avro.avro                         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC3Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | EMAIL     | Hdfs_Avro_EmailPII_SC3Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | GENDER    | Hdfs_Avro_GenderPII_SC3Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | IPADDRESS | Hdfs_Avro_IPAddressPII_SC3Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | GENDER    | Hdfs_Avro_GenderPII_SC3Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | SSN       | Hdfs_Avro_SSNPII_SC3Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | IPADDRESS | Hdfs_Avro_IPAddressPII_SC3Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | FULL_NAME | Hdfs_Avro_FullNamePII_SC3Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | EMAIL     | Hdfs_Avro_EmailPII_SC3Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | GENDER    | Hdfs_Avro_GenderPII_SC3Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | SSN       | Hdfs_Avro_SSNPII_SC3Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC3Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | FULL_NAME | Hdfs_Avro_FullNamePII_SC3Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | EMAIL     | Hdfs_Avro_EmailPII_SC3Tag     | FileFieldQuery | TagAssigned |


###########PIITags for Avro file fields , namePattern set as: .*F1ULL.*,IP1,1GENDER,.*EM1AIL.*,SSN11.*, minimumRatio:0.5###################

#7170107,7170098,7170094,7170105,7170104,7170103,7170096,7170106
  @positve @regression @sanity  @PIITag
  Scenario:SC14#MLP_26807_Verify PIItags not set for AVRO Files , namePattern set as: .*F1ULL.*,IP1,1GENDER,.*EM1AIL.*,SSN11.*, minimumRatio:0.5
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                    | Column    | Tags                          | Query          | Action         |
      | tagdetails_allmatch_avro.avro                         | GENDER    | Hdfs_Avro_GenderPII_SC4Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | SSN       | Hdfs_Avro_SSNPII_SC4Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC4Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | FULL_NAME | Hdfs_Avro_FullNamePII_SC4Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | EMAIL     | Hdfs_Avro_EmailPII_SC4Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_avro.avro                         | EMAIL     | Hdfs_Avro_EmailPII_SC4Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_avro.avro                         | SSN       | Hdfs_Avro_SSNPII_SC4Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_avro.avro                         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC4Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | EMAIL     | Hdfs_Avro_EmailPII_SC4Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | GENDER    | Hdfs_Avro_GenderPII_SC4Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | IPADDRESS | Hdfs_Avro_IPAddressPII_SC4Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | GENDER    | Hdfs_Avro_GenderPII_SC4Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | SSN       | Hdfs_Avro_SSNPII_SC4Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | IPADDRESS | Hdfs_Avro_IPAddressPII_SC4Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | FULL_NAME | Hdfs_Avro_FullNamePII_SC4Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | EMAIL     | Hdfs_Avro_EmailPII_SC4Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | GENDER    | Hdfs_Avro_GenderPII_SC4Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | SSN       | Hdfs_Avro_SSNPII_SC4Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC4Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | FULL_NAME | Hdfs_Avro_FullNamePII_SC4Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | EMAIL     | Hdfs_Avro_EmailPII_SC4Tag     | FileFieldQuery | TagNotAssigned |


    #######Set the PIITags for Avro file fields , valid name and type pattern minimumRatio:0.2#######################

    #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  Scenario:SC15#MLP_26807_Verify PIITags for Avro file fields , valid name and type pattern minimumRatio:0.2
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                             | Column    | Tags                          | Query          | Action      |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro | GENDER    | Hdfs_Avro_GenderPII_SC5Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro | SSN       | Hdfs_Avro_SSNPII_SC5Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro | IPADDRESS | Hdfs_Avro_IPAddressPII_SC5Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro | FULL_NAME | Hdfs_Avro_FullNamePII_SC5Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro | EMAIL     | Hdfs_Avro_EmailPII_SC5Tag     | FileFieldQuery | TagAssigned |

    ###########Set the PIItags for Avro file fields , minimumRatio:0.6 matchfull false and matchempty true###############

    #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  Scenario:SC16#MLP_26807_Verify PIItags for Avro file fields , minimumRatio:0.6 matchfull false and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                    | Column    | Tags                          | Query          | Action      |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | IPADDRESS | Hdfs_Avro_IPAddressPII_SC6Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | EMAIL     | Hdfs_Avro_EmailPII_SC6Tag     | FileFieldQuery | TagAssigned |

    #7170107,7170098,7170094,7170105,7170104,7170103,7170096,7170106

  Scenario:SC17#MLP_26807_Verify PIItags not set for Avro file fields , minimumRatio:0.6 matchfull false and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                    | Column | Tags                       | Query          | Action         |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | GENDER | Hdfs_Avro_GenderPII_SC6Tag | FileFieldQuery | TagNotAssigned |


      ###############Set the PIItags for Avro file fields , minimumRatio:1 matchfull false and matchempty false#####################

    #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  Scenario:SC18#MLP_26807_Verify PIItags for Avro file fields , minimumRatio:1 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename            | Column    | Tags                          | Query          | Action      |
      | tagdetails_allmatch_avro.avro | GENDER    | Hdfs_Avro_GenderPII_SC8Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_avro.avro | SSN       | Hdfs_Avro_SSNPII_SC8Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_avro.avro | IPADDRESS | Hdfs_Avro_IPAddressPII_SC8Tag | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_avro.avro | FULL_NAME | Hdfs_Avro_FullNamePII_SC8Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_allmatch_avro.avro | EMAIL     | Hdfs_Avro_EmailPII_SC8Tag     | FileFieldQuery | TagAssigned |


     ###############Set the PIItags for Avro file fields , minimumRatio:0.5 matchfull false and matchempty false#####################

  #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  Scenario:SC19#MLP_26807_Verify PIItags for Avro file fields , minimumRatio:0.5 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                            | Column    | Tags                          | Query          | Action      |
      | tagdetails_ratioequalto05emptyfalse_avro.avro | GENDER    | Hdfs_Avro_GenderPII_SC9Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro | SSN       | Hdfs_Avro_SSNPII_SC9Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro | IPADDRESS | Hdfs_Avro_IPAddressPII_SC9Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro | FULL_NAME | Hdfs_Avro_FullNamePII_SC9Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro | EMAIL     | Hdfs_Avro_EmailPII_SC9Tag     | FileFieldQuery | TagAssigned |


      ###############PIItags for Avro file fields , minimumRatio:0.2 matchfull false and matchempty false,namePattern can be set as:FULL.*,IPADDRESS,GENDER,.*MAIL,.*SSN.*,#####################

    #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  Scenario:SC20#MLP_26807_Verify PIItags for Avro file fields , minimumRatio:0.2 matchfull false and matchempty false,namePattern can be set as:FULL.*,IPADDRESS,GENDER,.*MAIL,.*SSN.*
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                             | Column    | Tags                           | Query          | Action      |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro | GENDER    | Hdfs_Avro_GenderPII_SC10Tag    | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro | SSN       | Hdfs_Avro_SSNPII_SC10Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro | IPADDRESS | Hdfs_Avro_IPAddressPII_SC10Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro | FULL_NAME | Hdfs_Avro_FullNamePII_SC10Tag  | FileFieldQuery | TagAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro | EMAIL     | Hdfs_Avro_EmailPII_SC10Tag     | FileFieldQuery | TagAssigned |

  ######################PIITags for Avro file fields , namePattern set as: FULL1.*,IPAD1DRESS,GENDER1,.*1MAIL,.*1SSN.*, minimumRatio:0.2################################

  #7170107,7170098,7170094,7170105,7170104,7170103,7170096,7170106

  @positve @regression @sanity  @PIITag
  Scenario:SC21#MLP_26807_Verify PIITags not set for Avro file fields , namePattern set as: FULL1.*,IPAD1DRESS,GENDER1,.*1MAIL,.*1SSN.*, minimumRatio:0.2
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                    | Column    | Tags                           | Query          | Action         |
      | tagdetails_allmatch_avro.avro                         | GENDER    | Hdfs_Avro_GenderPII_SC11Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | SSN       | Hdfs_Avro_SSNPII_SC11Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC11Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | FULL_NAME | Hdfs_Avro_FullNamePII_SC11Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | EMAIL     | Hdfs_Avro_EmailPII_SC11Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_avro.avro                         | EMAIL     | Hdfs_Avro_EmailPII_SC11Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_avro.avro                         | SSN       | Hdfs_Avro_SSNPII_SC11Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_avro.avro                         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC11Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | EMAIL     | Hdfs_Avro_EmailPII_SC11Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | GENDER    | Hdfs_Avro_GenderPII_SC11Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | IPADDRESS | Hdfs_Avro_IPAddressPII_SC11Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | GENDER    | Hdfs_Avro_GenderPII_SC11Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | SSN       | Hdfs_Avro_SSNPII_SC11Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | IPADDRESS | Hdfs_Avro_IPAddressPII_SC11Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | FULL_NAME | Hdfs_Avro_FullNamePII_SC11Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | EMAIL     | Hdfs_Avro_EmailPII_SC11Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | GENDER    | Hdfs_Avro_GenderPII_SC11Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | SSN       | Hdfs_Avro_SSNPII_SC11Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC11Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | FULL_NAME | Hdfs_Avro_FullNamePII_SC11Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | EMAIL     | Hdfs_Avro_EmailPII_SC11Tag     | FileFieldQuery | TagNotAssigned |



    ##############################PIItags for Avro file fields , name pattern (Invalid columns) minimumRatio:0.2 matchfull false and matchempty false##################

  #7170107,7170098,7170094,7170105,7170104,7170103,7170096,7170106

  Scenario:SC22#MLP_26807_Verify PIITags not set for Avro file fields , name pattern (Invalid columns) minimumRatio:0.2 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                    | Column    | Tags                           | Query          | Action         |
      | tagdetails_allmatch_avro.avro                         | GENDER    | Hdfs_Avro_GenderPII_SC12Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | SSN       | Hdfs_Avro_SSNPII_SC12Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC12Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | FULL_NAME | Hdfs_Avro_FullNamePII_SC12Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | EMAIL     | Hdfs_Avro_EmailPII_SC12Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_avro.avro                         | EMAIL     | Hdfs_Avro_EmailPII_SC12Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_avro.avro                         | SSN       | Hdfs_Avro_SSNPII_SC12Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_avro.avro                         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC12Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | EMAIL     | Hdfs_Avro_EmailPII_SC12Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | GENDER    | Hdfs_Avro_GenderPII_SC12Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | IPADDRESS | Hdfs_Avro_IPAddressPII_SC12Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | GENDER    | Hdfs_Avro_GenderPII_SC12Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | SSN       | Hdfs_Avro_SSNPII_SC12Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | IPADDRESS | Hdfs_Avro_IPAddressPII_SC12Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | FULL_NAME | Hdfs_Avro_FullNamePII_SC12Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | EMAIL     | Hdfs_Avro_EmailPII_SC12Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | GENDER    | Hdfs_Avro_GenderPII_SC12Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | SSN       | Hdfs_Avro_SSNPII_SC12Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC12Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | FULL_NAME | Hdfs_Avro_FullNamePII_SC12Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | EMAIL     | Hdfs_Avro_EmailPII_SC12Tag     | FileFieldQuery | TagNotAssigned |

######################PIItags for Avro file fields , data pattern (Invalid regex) minimumRatio:0.2 matchfull false and matchempty false##################

#7170107,7170098,7170094,7170105,7170104,7170103,7170096,7170106

  Scenario:SC23#MLP_26807_Verify PIITags not set for Avro file fields , data pattern (Invalid regex) minimumRatio:0.2 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                    | Column    | Tags                           | Query          | Action         |
      | tagdetails_allmatch_avro.avro                         | GENDER    | Hdfs_Avro_GenderPII_SC13Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | SSN       | Hdfs_Avro_SSNPII_SC13Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | FULL_NAME | Hdfs_Avro_FullNamePII_SC13Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_allmatch_avro.avro                         | EMAIL     | Hdfs_Avro_EmailPII_SC13Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_avro.avro                         | EMAIL     | Hdfs_Avro_EmailPII_SC13Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_avro.avro                         | SSN       | Hdfs_Avro_SSNPII_SC13Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_allempty_avro.avro                         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | EMAIL     | Hdfs_Avro_EmailPII_SC13Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | GENDER    | Hdfs_Avro_GenderPII_SC13Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiolessthan05emptyfalse_avro.avro        | IPADDRESS | Hdfs_Avro_IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | GENDER    | Hdfs_Avro_GenderPII_SC13Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | SSN       | Hdfs_Avro_SSNPII_SC13Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | IPADDRESS | Hdfs_Avro_IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | FULL_NAME | Hdfs_Avro_FullNamePII_SC13Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | EMAIL     | Hdfs_Avro_EmailPII_SC13Tag     | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | GENDER    | Hdfs_Avro_GenderPII_SC13Tag    | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | SSN       | Hdfs_Avro_SSNPII_SC13Tag       | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | IPADDRESS | Hdfs_Avro_IPAddressPII_SC13Tag | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | FULL_NAME | Hdfs_Avro_FullNamePII_SC13Tag  | FileFieldQuery | TagNotAssigned |
      | tagdetails_ratioequalto05emptyfalse_avro.avro         | EMAIL     | Hdfs_Avro_EmailPII_SC13Tag     | FileFieldQuery | TagNotAssigned |



  #################PIItags for Avro file fields , minimumRatio:0.5 matchfull false and matchempty true###########################

    #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  Scenario:SC24#MLP_26807_Verify PIItags for Avro file fields , minimumRatio:0.5 matchfull false and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename            | Column    | Tags                           | Query          | Action      |
      | tagdetails_allempty_avro.avro | EMAIL     | Hdfs_Avro_EmailPII_SC14Tag     | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_avro.avro | SSN       | Hdfs_Avro_SSNPII_SC14Tag       | FileFieldQuery | TagAssigned |
      | tagdetails_allempty_avro.avro | IPADDRESS | Hdfs_Avro_IPAddressPII_SC14Tag | FileFieldQuery | TagAssigned |

   #################PIItags for Avro file fields , minimumRatio:0.6 matchfull true and matchempty false###########################

  #7170107,7170098,7170094,7170105,7170104,7170103,7170096,7170106

  Scenario:SC25#MLP_26807_Verify PIItags for Avro file fields , minimumRatio:0.6 matchfull true and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                   | Column   | Tags                          | Query          | Action         |
      | tagdetails_ratiogreaterthan05matchfulltrue_avro.avro | COMMENTS | Hdfs_Avro_FullMatchPII_SC1Tag | FileFieldQuery | TagNotAssigned |

#################PIItags for Avro file fields , minimumRatio:0.2 matchfull true and matchempty false###########################

  #7170107,7170098,7170094,7170105,7170104,7170103,7170096,7170106

  Scenario:SC26#MLP_26807_Verify PIItags for Avro file fields , minimumRatio:0.2 matchfull true and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                  | Column   | Tags                          | Query          | Action         |
      | tagdetails_ratiolesserthan05matchfulltrue_avro.avro | COMMENTS | Hdfs_Avro_FullMatchPII_SC3Tag | FileFieldQuery | TagNotAssigned |

#############################################################################################################################################################################################
 ##########################################################Re-Run Scenario PII tags#####################################################################################
 #######################################################################################################################################################


  Scenario Outline:Policy2:Create root tag and sub tag for HDFS AVRO Anlayzer and Update policy tags for AvroAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | body                                                     | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions | ida/avroPayloads/API/PolicyEngine/HDFS_AVRO_policy2.json | 204           |                  |          |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC27#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger for Avro  analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body | response code | response message | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC6_HdfsAvro_PIITags |      | 200           | IDLE             | $.[?(@.configurationName=='SC6_HdfsAvro_PIITags')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC6_HdfsAvro_PIITags  |      | 200           |                  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC6_HdfsAvro_PIITags |      | 200           | IDLE             | $.[?(@.configurationName=='SC6_HdfsAvro_PIITags')].status |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC27#-MLP_26807_Verify AvroAnalyzer does data sampling/data profiling properly for Avro  files when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:False)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                           | body | response code | response message | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC6_AvroAnalyzer_PIItags |      | 200           | IDLE             | $.[?(@.configurationName=='SC6_AvroAnalyzer_PIItags')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC6_AvroAnalyzer_PIItags  |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/SC6_AvroAnalyzer_PIItags |      | 200           | IDLE             | $.[?(@.configurationName=='SC6_AvroAnalyzer_PIItags')].status |


#     #################PIItags for Avro file fields , minimumRatio:0.6 matchfull true and matchempty false###########################

    #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  Scenario:SC28#MLP_26807_Verify PIItags for Avro file fields , minimumRatio:0.6 matchfull true and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                   | Column   | Tags                          | Query          | Action      |
      | tagdetails_ratiogreaterthan05matchfulltrue_avro.avro | COMMENTS | Hdfs_Avro_FullMatchPII_SC2Tag | FileFieldQuery | TagAssigned |

#################PIItags for Avro file fields , minimumRatio:0.2 matchfull true and matchempty false###########################

    #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  Scenario:SC29#MLP_26807_Verify PIItags for Avro file fields , minimumRatio:0.2 matchfull true and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                  | Column   | Tags                          | Query          | Action      |
      | tagdetails_ratiolesserthan05matchfulltrue_avro.avro | COMMENTS | Hdfs_Avro_FullMatchPII_SC4Tag | FileFieldQuery | TagAssigned |


    ###############Set the PIItags for Avro file fields , minimumRatio:0.6 matchfull true and matchempty true#####################

  #7170100,7170101,7170099,7170097,7170109,7170095,7170102,7170093

  Scenario:SC30#MLP_26807_Verify PIItags for Avro file fields , minimumRatio:0.6 matchfull true and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | TableName/Filename                                    | Column    | Tags                          | Query          | Action      |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | IPADDRESS | Hdfs_Avro_IPAddressPII_SC7Tag | FileFieldQuery | TagAssigned |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_avro.avro | EMAIL     | Hdfs_Avro_EmailPII_SC7Tag     | FileFieldQuery | TagAssigned |


  @positve @regression @sanity  @ambari
  Scenario:SC31:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC6_HdfsAvro_PIITags/%       | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AvroAnalyzer/SC6_AvroAnalyzer_PIItags/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                                         | Cluster  |       |       |

    ###########################################Delete Amabri folder , BA , Credentials and Config

  @MLP-26087  @MLP-26087 @positve @hdfs @regression @sanity
  Scenario Outline:SC32:Delete folder in Ambaris
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization               | X-Requested-By | type   | url                                        | body | response code | response message |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /AvroAnalyzerTest?op=DELETE&recursive=true |      | 200           | true             |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /AVROPIITags?op=DELETE&recursive=true      |      | 200           | true             |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline:SC11:MLP-24889:Deleting the Credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                               | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/hdfsDBValidCredential                                        |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HdfsDataSource                                                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HdfsCataloger                                                  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AvroAnalyzer                                                   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | policy/tagging/analysis?dataType=STRUCTURED&pluginName=AvroAnalyzer&technologies= |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | /tags/Default/tags/HDFS_AVRO_PII                                                  |      | 204           |                  |          |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario:SC11:Delete Bussiness Application
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name             | type                | query | param |
      | SingleItemDelete | Default | HDFS_BA          | BusinessApplication |       |       |
      | SingleItemDelete | Default | AVRO_ANALYZER_BA | BusinessApplication |       |       |




#    ######Test case to validate only avro files are analyzed and collected in UI with metadata properties######
#  @sanity @positive @MLP-7674 @IDA-10.0
#  Scenario:MLP-7674:SC1#MLP_7674_Avro_Create a catalog for Avro Analyzer
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "ida/avroPayloads/CreateAvroCatalog.json"
#    When user makes a REST Call for POST request with url "/settings/catalogs"
#    Then Status code 204 must be returned
#    And verify created schema "AvroCatalog" exists in database
#
#
#  @sanity @positive @MLP-7674 @IDA-10.0
#  Scenario: MLP-7674:SC1#Update the host in all dependent plugins
#    Given User update the ambari host in following files using json path
#      | filePath                                  | jsonPath              | node               |
#      | ida/avroPayloads/ambariResolver.json      | $..clusterManagerHost | clusterManagerHost |
#      | ida/avroPayloads/hdfsCatalogerConfig.json | $..clusterManagerHost | clusterManagerHost |
#    And user update the json file "ida/avroPayloads/ambariResolver.json" file for following values
#      | jsonPath       | jsonValues  |
#      | $..catalogName | AvroCatalog |
#
#
#  Scenario: MLP-7674:SC1#Update the host in all dependent plugins
#    Given User update the ambari host in following files using json path
#      | filePath                             | jsonPath              | node               |
#      | ida/avroPayloads/ambariResolver.json | $..clusterManagerHost | clusterManagerHost |
#    And user update the json file "ida/avroPayloads/ambariResolver.json" file for following values
#      | jsonPath       | jsonValues  |
#      | $..catalogName | AvroCatalog |
#
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario Outline:SC#2Creating a directory in Ambari Files View and Uploading a avro file into the directory
#    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                               | body                           | response code | response message |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | avroFolder?op=MKDIRS&recursive=true&overwrite=true                                                                                                |                                | 200           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | avroFolder/user.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true     | ida/avroPayloads/user.avro     | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | avroFolder/userInfo.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/avroPayloads/userInfo.avro | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | avroFolder/usertag.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true  | ida/avroPayloads/usertag.avro  | 201           |                  |
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario: SC#3 Update File extension as avro and folder as avro folder in HdfsCataloger
#    Given user update the json file "ida/avroPayloads/hdfsCatalogerConfig.json" file for following values
#      | jsonPath             | jsonValues      |
#      | $..root              | /avroFolder     |
#      | $..nodeCondition     | type=='bigdata' |
#      | $..fileExtensions[0] | avro            |
#      | $..fileExtensions[1] |                 |
#      | $..fileExtensions[2] |                 |
#      | $..catalogName       | AvroCatalog     |
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario Outline:SC#4 Configure the cluster demo node with avro configuration and avro catalog
#    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | Header           | Query | Param | type | url                               | body                                      | response code | response message |
#      | application/json | raw   | false | Put  | settings/analyzers/AmbariResolver | ida/avroPayloads/ambariResolver.json      | 204           |                  |
#      | application/json |       |       | Get  | settings/analyzers/AmbariResolver |                                           | 200           | AvroCatalog      |
#      | application/json | raw   | false | Put  | settings/analyzers/HdfsCataloger  | ida/avroPayloads/hdfsCatalogerConfig.json | 204           |                  |
#      | application/json |       |       | Get  | settings/analyzers/HdfsCataloger  |                                           | 200           | AvroCatalog      |
#      | application/json |       |       | Put  | settings/analyzers/AvroAnalyzer   | ida/avroPayloads/avroAnalyzer.json        | 204           |                  |
#      | application/json |       |       | Get  | settings/analyzers/AvroAnalyzer   |                                           | 200           | AvroCatalog      |
#
#  @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario: SC#5 Start running the Hdfs Cataloger and wait for status to be idle
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                    | body | response code | response message | jsonPath                                           |
#      | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/*   |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/*    |      | 200           |                  |                                                    |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/*   |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/* |      | 200           | IDLE             | $.[?(@.configurationName=='AvroAnalyzer')].status  |
#
#  @webtest @MLP-7674 @positive @regression @IDA-10.0
#  Scenario: SC#6 Verify field attribute count in UI and postgres database are updated
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "All" catalog and search "AvroCatalog" items at top end
#    And user performs "facet selection" in "Field" attribute under "Type" facets in Item Search results page
#    Then results panel "items count" should be displayed as "18 items were found" in Item Search results page
#    And user connect to the database and execute query for the following parameters
#      | dataBaseName  | dataBaseType | queryPath     | queryPage   | queryField          | storeResults |
#      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | avroQueries | getAvroItemRowCount | rowCount     |
#    Then Postgres item count for "Field" attribute should be "18"
#
#  @webtest @MLP-7674 @positive @regression @IDA-10.0
#  Scenario: SC#7 Verify metadata property values are updated in IDC UI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "All" catalog and search "AvroCatalog" items at top end
#    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
#    And user performs "item click" on "usertag.avro" item from search results
#    Then user "verify metadata properties" section has following values
#      | Last analyzed at | Last catalogued at | Creator | File size | Group | ID | Location | MIME type | Modified | Percentage of non null values | Permission | Number of rows |
#    And user perfroms "item view click" on  item "username" in Item View Page "FIELDS" section
#    Then user "verify metadata property values" with following expected parameters for item "username"
#      | avgLength | avgWordCount | Data type | ID                     | Maximum length | Maximum value | maxWordCount | Minimum length | Minimum value | minWordCount | Number of non null values | Percentage of non null values | Number of null values | Number of unique values | Percentage of unique values |
#      | 12.5      | 2            | string    | AvroCatalog.Field:::13 | 14             | Lionel Messi  | 2            | 11             | Alex Ferguson | 2            | 4                         | 80                            | 1                     | 4                       | 80                          |
#    And user clicks on "Item Full View Close" icon in item full view page
#    And user perfroms "item view click" on  item "userid" in Item View Page "FIELDS" section
#    Then user "verify metadata property values" with following expected parameters for item "userid"
#      | Average | Data type | ID                    | Maximum value | Median | Minimum value | Number of non null values | Percentage of non null values | Standard deviation | sum | Number of unique values | Percentage of unique values | Variance |
#      | 30      | integer   | AvroCatalog.Field:::6 | 50            | 25     | 10            | 5                         | 100                           | 14.14              | 150 | 5                       | 100                         | 250      |
#
#
#  @webtest @MLP-7674 @positive @regression @IDA-10.0
#  Scenario: SC#8 Verify tags are assigned at Field level in IDC UI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "All" catalog and search "AvroCatalog" items at top end
#    And user performs "facet selection" in "Field" attribute under "Type" facets in Item Search results page
#    And user performs "item click" on "email" item from search results
#    Then user "verify presence" of following "Tag List" in Item View Page
#      | Email Address |
#      | Data Files    |
#      | Avro          |
#
#
#  @webtest @MLP-7674 @positive @regression @IDA-10.0
#  Scenario: SC#9 Verify first level records in avro file appears under files collected in UI Catalog
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "All" catalog and search "AvroCatalog" items at top end
#    And user performs "facet selection" in "usertag.avro [File]" attribute under "Parent hierarchy" facets in Item Search results page
#    Then user "verify presence" of following "Items List" in Item Search Results Page
#      | address |
#
#
#  @webtest @MLP-7674 @positive @regression @IDA-10.0
#  Scenario: SC#10 Verify the avro file properties in IDC UI and postgres database
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "All" catalog and search "AvroCatalog" items at top end
#    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
#    And user performs "item click" on "usertag.avro" item from search results
#    Then user "verify metadata property values" with following expected parameters for item "usertag.avro"
#      | File size | ID                   | Location    | MIME type                | Percentage of non null values | Permission | Number of rows |
#      | 1.44 KB   | AvroCatalog.File:::2 | /avroFolder | application/octet-stream | 97.5                          | rwxr-xr-x  | 5              |
#
#  @webtest @MLP-7674 @positive @regression @IDA-10.0
#  Scenario: SC#11 Verify data sampling tab is displayed and json values are displayed in UI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user "Click" on "Administration" dashboard
#    And user "Click" on "ITEM VIEW MANAGER" dashboard
#    And user configure below parameters for item "itemView_Table" from "ITEM VIEW MANAGER" list
#      | CATALOGS    | SUPPORTED TYPES |
#      | AvroCatalog | DataSample      |
#    And user select "All" catalog and search "AvroCatalog" items at top end
#    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
#    And user performs "item click" on "user.avro" item from search results
#    And user "navigatesToTab" name "Data Sample" in item view page
#    Then following "Data Sample" values should get displayed in item view page
#      | username | age | phone  | housenum | address                                       |
#      | Sehwag   | 38  | 123445 | test 101 | [Anna street,Chennai,Tamil Nadu,India,600035] |
#      | Kamal    | 45  | 435435 | test 10  | [Periyar street,Bangalore,Karnataka,US,60034] |
#      | Kamal    | 45  | 435435 | test 10  | [null,Bangalore,Andhra,US,6002]               |
#      |          | 45  | 435435 | test 10  | [null,Bangalore,Karnataka,US,60034]           |
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario Outline:SC#12 Delete the created avro files in Ambari
#    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization               | X-Requested-By | type   | url                                 | body | response code | response message |
#      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | avroFolder?op=DELETE&recursive=true |      | 200           | true             |
#
#  @MLP-7674 @IDA-10.0
#  Scenario:SC#13 MLP-7674 To verify created catalog is deleted
#    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for DELETE request with url "/settings/catalogs/AvroCatalog"
#    Then Status code 204 must be returned
#    When user makes a REST Call for Get request with url "/settings/catalogs/AvroCatalog"
#    And response message contains value "CONFIG-0007"
#    And verify created schema "AvroCatalog" doesn't exists in database
#
#     ######Test case to validate non avro files are not analyzed and collected in UI######
#  @sanity @positive @MLP-7674 @IDA-10.0
#  Scenario:SC#14 MLP-7674:SC1#Create a new catalog for Avro Analyzer
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "ida/avroPayloads/CreateAvroCatalog.json"
#    When user makes a REST Call for POST request with url "/settings/catalogs"
#    Then Status code 204 must be returned
#    And verify created schema "AvroCatalog" exists in database
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario Outline:SC#15 Creating a directory in Ambari Files View and Uploading a avro file into the directory
#    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                      | body                                  | response code | response message |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | avroFolder?op=MKDIRS&recursive=true&overwrite=true                                                                                                       |                                       | 200           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | avroFolder/customer_details.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/avroPayloads/customer_details.csv | 201           |                  |
#
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario: SC#16 Update File extension in HdfsCataloger
#    Given user update the json file "ida/avroPayloads/hdfsCatalogerConfig.json" file for following values
#      | jsonPath             | jsonValues  |
#      | $..root              | /avroFolder |
#      | $..fileExtensions[0] | avro        |
#      | $..catalogName       | AvroCatalog |
#    And user update the json file "ida/avroPayloads/parquetAnalyzer.json" file for following values
#      | jsonPath       | jsonValues  |
#      | $..catalogName | AvroCatalog |
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario Outline:SC#17 Configure the big data node with avro configuration and avro catalog
#    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | Header           | Query | Param | type | url                                | body                                      | response code | response message |
#      | application/json |       |       | Put  | settings/analyzers/HdfsCataloger   | ida/avroPayloads/hdfsCatalogerConfig.json | 204           |                  |
#      | application/json |       |       | Get  | settings/analyzers/HdfsCataloger   |                                           | 200           | AvroCatalog      |
#      | application/json |       |       | Put  | settings/analyzers/AvroAnalyzer    | ida/avroPayloads/avroAnalyzer.json        | 204           |                  |
#      | application/json |       |       | Get  | settings/analyzers/AvroAnalyzer    |                                           | 200           | AvroCatalog      |
#      | application/json |       |       | Put  | settings/analyzers/ParquetAnalyzer | ida/avroPayloads/parquetAnalyzer.json     | 204           |                  |
#      | application/json |       |       | Get  | settings/analyzers/ParquetAnalyzer |                                           | 200           | AvroCatalog      |
#      | application/json |       |       | Put  | settings/analyzers/BigDataAnalyzer | ida/avroPayloads/bigDataAnalyzer.json     | 204           |                  |
#      | application/json |       |       | Get  | settings/analyzers/BigDataAnalyzer |                                           | 200           | AvroCatalog      |
#
#
#  @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario: SC#18 Start running the Hdfs Cataloger and wait for status to be idle
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                       | body | response code | response message | jsonPath                                           |
#      | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/*      |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/*       |      | 200           |                  |                                                    |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/*      |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/*    |      | 200           | IDLE             | $.[?(@.configurationName=='AvroAnalyzer')].status  |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/* |      | 200           | IDLE             | $.[?(@.configurationName=='Data Analyzer')].status |
#
#
#  @webtest @MLP-7674 @positive @regression @IDA-10.0
#  Scenario: SC#19 Verify non avro files is not analyzed and displayed in IDC UI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "All" catalog and search "AvroCatalog" items at top end
#    Then user verify "catalog not contains" any "File" attribute under "Type" facets
# #    Then results panel "items count" should be displayed as "1 item was found"
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario Outline:SC#20 Delete the created avro files in Ambari
#    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization               | X-Requested-By | type   | url                                 | body | response code | response message |
#      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | avroFolder?op=DELETE&recursive=true |      | 200           | true             |
#
#
#  @MLP-7674 @IDA-10.0
#  Scenario: SC#21 MLP-7674 To verify created area name is deleted
#    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for DELETE request with url "/settings/catalogs/AvroCatalog"
#    Then Status code 204 must be returned
#    When user makes a REST Call for Get request with url "/settings/catalogs/AvroCatalog"
#    And response message contains value "CONFIG-0007"
#    And verify created schema "AvroCatalog" doesn't exists in database
#
#      ######Test case to validate only Parquet files are analyzed and collected in UI with metadata properties######
#  @sanity @positive @MLP-7674 @IDA-10.0
#  Scenario:MLP-7674:SC22#Create a catalog for parquet Analyzer
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "ida/avroPayloads/CreateParquetCatalog.json"
#    When user makes a REST Call for POST request with url "/settings/catalogs"
#    Then Status code 204 must be returned
#    And verify created schema "ParCatalog" exists in database
#
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario Outline:SC#23Creating a directory in Ambari Files View and Uploading a parquet file into the directory
#    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                              | body                           | response code | response message |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | parFolder?op=MKDIRS&recursive=true&overwrite=true                                                                                                |                                | 200           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | parFolder/users.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/avroPayloads/users.parquet | 201           |                  |
#
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario: SC#24 Update File extension as avro in HdfsCataloger
#    Given user update the json file "ida/avroPayloads/hdfsCatalogerConfig.json" file for following values
#      | jsonPath             | jsonValues |
#      | $..root              | /parFolder |
#      | $..fileExtensions[0] | parquet    |
#      | $..catalogName       | ParCatalog |
#    And user update the json file "ida/avroPayloads/parquetAnalyzer.json" file for following values
#      | jsonPath       | jsonValues |
#      | $..catalogName | ParCatalog |
#    And user update the json file "ida/avroPayloads/ambariResolver.json" file for following values
#      | jsonPath       | jsonValues |
#      | $..catalogName | ParCatalog |
#
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario Outline:SC#25 Configure the big data node with  parquet configuration and parquet catalog
#    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | Header           | Query | Param | type | url                                | body                                      | response code | response message |
#      | application/json | raw   | false | Put  | settings/analyzers/AmbariResolver  | ida/avroPayloads/ambariResolver.json      | 204           |                  |
#      | application/json |       |       | Get  | settings/analyzers/AmbariResolver  |                                           | 200           | ParCatalog       |
#      | application/json |       |       | Put  | settings/analyzers/HdfsCataloger   | ida/avroPayloads/hdfsCatalogerConfig.json | 204           |                  |
#      | application/json |       |       | Get  | settings/analyzers/HdfsCataloger   |                                           | 200           | ParCatalog       |
#      | application/json |       |       | Put  | settings/analyzers/ParquetAnalyzer | ida/avroPayloads/parquetAnalyzer.json     | 204           |                  |
#      | application/json |       |       | Get  | settings/analyzers/ParquetAnalyzer |                                           | 200           | ParCatalog       |
#
#
#  @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario: SC#26 Start running the Hdfs Cataloger and wait for status to be idle
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                       | body | response code | response message | jsonPath                                             |
#      | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/*      |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status   |
#      |                  |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/*       |      | 200           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/* |      | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer')].status |
#
#  @webtest @MLP-7674 @positive @regression @IDA-10.0
#  Scenario: SC#27 Verify field attribute count of Parquet in UI and postgres database are updated
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "All" catalog and search "ParCatalog" items at top end
#    And user performs "facet selection" in "Field" attribute under "Type" facets in Item Search results page
#    Then results panel "items count" should be displayed as "3 items were found" in Item Search results page
#    And user connect to the database and execute query for the following parameters
#      | dataBaseName  | dataBaseType | queryPath     | queryPage   | queryField             | storeResults |
#      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | avroQueries | getParquetItemRowCount | rowCount     |
#    Then Postgres item count for "Field" attribute should be "3"
#
#  @webtest @MLP-7674 @positive @regression @IDA-10.0
#  Scenario: SC#28 Verify metadata property values for parquet files are updated in IDC UI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "All" catalog and search "ParCatalog" items at top end
#    And user performs "facet selection" in "File" attribute under "Type" facets in Item Search results page
#    And user performs "item click" on "users.parquet" item from search results
#    Then user "verify metadata properties" section has following values
#      | Last analyzed at | Last catalogued at | Creator | fileSize | group | ID | Location | mimeType | Modified | Percentage of non null values | permission | Number of rows |
#    And user perfroms "item view click" on  item "name" in Item View Page "FIELDS" section
#    Then user "verify metadata property values" with following expected parameters for item "username"
#      | avgLength | avgWordCount | Data type | ID                   | Maximum length | Maximum value | maxWordCount | Minimum length | Minimum value | minWordCount | Number of non null values | Percentage of non null values | Number of unique values | Percentage of unique values |
#      | 4.5       | 1            | string    | ParCatalog.Field:::3 | 6              | Ben           | 1            | 3              | Alyssa        | 1            | 2                         | 100                           | 2                       | 100                         |
#    And user clicks on "Item Full View Close" icon in item full view page
#    And user perfroms "item view click" on  item "favorite_numbers" in Item View Page "FIELDS" section
#    Then user "verify metadata property values" with following expected parameters for item "username"
#      | Data type | ID                   | Maximum value              | Minimum value  | Number of non null values | Percentage of non null values | Number of unique values | Percentage of unique values |
#      | array     | ParCatalog.Field:::1 | WrappedArray(3, 9, 15, 20) | WrappedArray() | 2                         | 100                           | 2                       | 100                         |
#
#  @MLP-7674 @IDA-10.0
#  Scenario Outline:SC#29 Delete the created parquet files in Ambari
#    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization               | X-Requested-By | type   | url                                | body | response code | response message |
#      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | parFolder?op=DELETE&recursive=true |      | 200           | true             |
#
#
#  @MLP-7674 @IDA-10.0
#  Scenario: SC#30 MLP-7674 To verify created area name is deleted
#    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for DELETE request with url "/settings/catalogs/ParCatalog"
#    Then Status code 204 must be returned
#    When user makes a REST Call for Get request with url "/settings/catalogs/ParCatalog"
#    And response message contains value "CONFIG-0007"
#    And verify created schema "ParCatalog" doesn't exists in database
#
#        ####Test case to validate  new tags added in policy engine is assigned in IDC UI########
#  @sanity @positive @MLP-7674 @IDA-10.0
#  Scenario:MLP-7674:SC31#Create a catalog for Avro Analyzer
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "ida/avroPayloads/CreateAvroCatalog.json"
#    When user makes a REST Call for POST request with url "/settings/catalogs"
#    Then Status code 204 must be returned
#    And verify created schema "AvroCatalog" exists in database
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario Outline:SC#32Creating a directory in Ambari Files View and Uploading a avro file into the directory
#    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                               | body                           | response code | response message |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | avroFolder?op=MKDIRS&recursive=true&overwrite=true                                                                                                |                                | 200           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | avroFolder/user.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true     | ida/avroPayloads/user.avro     | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | avroFolder/userInfo.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/avroPayloads/userInfo.avro | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | avroFolder/usertag.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true  | ida/avroPayloads/usertag.avro  | 201           |                  |
#
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario: SC#33 Update File extension in HdfsCataloger
#    Given user update the json file "ida/avroPayloads/hdfsCatalogerConfig.json" file for following values
#      | jsonPath             | jsonValues  |
#      | $..root              | /avroFolder |
#      | $..fileExtensions[0] | avro        |
#      | $..fileExtensions[1] |             |
#      | $..fileExtensions[2] |             |
#      | $..catalogName       | AvroCatalog |
#    And user update the json file "ida/avroPayloads/ambariResolver.json" file for following values
#      | jsonPath       | jsonValues  |
#      | $..catalogName | AvroCatalog |
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario Outline:SC#34 Configure the big data node with avro configuration and avro catalog
#    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | Header           | Query | Param | type | url                               | body                                      | response code | response message |
#      | application/json | raw   | false | Put  | settings/analyzers/HdfsCataloger  | ida/avroPayloads/hdfsCatalogerConfig.json | 204           |                  |
#      | application/json |       |       | Get  | settings/analyzers/HdfsCataloger  |                                           | 200           | AvroCatalog      |
#      | application/json |       |       | Put  | settings/analyzers/AvroAnalyzer   | ida/avroPayloads/avroAnalyzer.json        | 204           |                  |
#      | application/json |       |       | Get  | settings/analyzers/AvroAnalyzer   |                                           | 200           | AvroCatalog      |
#      | application/json |       |       | Put  | settings/analyzers/AmbariResolver | ida/avroPayloads/ambariResolver.json      | 204           |                  |
#      | application/json |       |       | Get  | settings/analyzers/AmbariResolver |                                           | 200           | AvroCatalog      |
#
#
#  @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario: SC#35 Start running the Hdfs Cataloger and wait for status to be idle
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                    | body | response code | response message | jsonPath                                           |
#      | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/*   |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/*    |      | 200           |                  |                                                    |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/*   |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/* |      | 200           | IDLE             | $.[?(@.configurationName=='AvroAnalyzer')].status  |
#
#
#  @webtest @MLP-7674 @positive @regression @IDA-10.0
#  Scenario: SC#36 Verify first level records in avro file appears under files collected in UI Catalog
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "All" catalog and search "AvroCatalog" items at top end
#    And user performs "facet selection" in "Field" attribute under "Type" facets in Item Search results page
#    And user performs "item click" on "email" item from search results
#    Then user "verify presence" of following "Tag List" in Item View Page
#      | Email Address |
#      | Data Files    |
#      | Avro          |
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario Outline:SC#37 Validate if policy engine is up and user is able to retrieve all policy tags
#    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
#    And user "encodePolicyEngine" value from file "ida/policyEngine/dynamicPassword.txt" and write to file "ida/policyEngine/webToken.txt"
#    Examples:
#      | ServiceName | user       | Header       | Query | Param | type | url                                                 | body | response code | response message | filePath                                      | jsonPath   |
#      | IDC         | TestSystem | AcceptFormat |       |       | Get  | settings/user?path=com/asg/dis/platform/policy.json |      | 200           |                  | payloads/ida/policyEngine/dynamicPassword.txt | $.password |
#    Examples:
#      | ServiceName  | user       | Header               | Query | Param | type | url                                                                               | body | response code | response message | filePath                                   | jsonPath |
#      | PolicyEngine | policyUser | AcceptDecisionTables |       |       | Get  | policy/decisionmodels/ASG.DI.DataAnalysis/decisiontables/ASG.DI.DataAnalysisTable |      | 200           |                  | payloads/ida/policyEngine/defaultTags.json |          |
#
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario Outline:SC#38 update policy engine with new tag
#    Given user copy the data from "rest/payloads/ida/policyEngine/defaultTags.json" file to "rest/payloads/ida/policyEngine/updatedTags.json" file
#    And user "append" the json file "ida/policyEngine/newTag.json" file for following values
#      | jsonPath | jsonObjectFilePath                |
#      | $.rules  | ida/policyEngine/updatedTags.json |
#    And user copy the data from "rest/payloads/ida/policyEngine/updatedTags.json" file to "rest/payloads/ida/policyEngine/updatedTags.txt" file
#    And user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
#    Examples:
#      | ServiceName  | user       | Header              | Query | Param | type | url                                                                               | body                                      | response code | response message | filePath | jsonPath |
#      | PolicyEngine | policyUser | AcceptDecisionRules |       |       | Put  | policy/decisionmodels/ASG.DI.DataAnalysis/decisiontables/ASG.DI.DataAnalysisTable | payloads/ida/policyEngine/updatedTags.txt | 200           |                  |          |          |
#
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario Outline:SC#38 update policy engine for the existing tag
#    Given user copy the data from "rest/payloads/ida/policyEngine/defaultTags.json" file to "rest/payloads/ida/policyEngine/existingTagModify.json" file
#    And user "update" the json file "ida/policyEngine/existingTagModify.json" file for following values
#      | jsonPath                          | jsonValues |
#      | $.rules.[13].outputEntry.[1].text | "Fax"      |
#    And user copy the data from "rest/payloads/ida/policyEngine/existingTagModify.json" file to "rest/payloads/ida/policyEngine/existingTagModify.txt" file
#    And user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
#    Examples:
#      | ServiceName  | user       | Header              | Query | Param | type | url                                                                               | body                                            | response code | response message | filePath | jsonPath |
#      | PolicyEngine | policyUser | AcceptDecisionRules |       |       | Put  | policy/decisionmodels/ASG.DI.DataAnalysis/decisiontables/ASG.DI.DataAnalysisTable | payloads/ida/policyEngine/existingTagModify.txt | 200           |                  |          |          |
#
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario Outline:SC#38 Delete policy engine for the existing tag
#    Given user copy the data from "rest/payloads/ida/policyEngine/defaultTags.json" file to "rest/payloads/ida/policyEngine/existingTagDelete.json" file
#    And user "delete" the json file "ida/policyEngine/existingTagDelete.json" file for following values
#      | jsonPath     |
#      | $.rules.[13] |
#    And user copy the data from "rest/payloads/ida/policyEngine/existingTagDelete.json" file to "rest/payloads/ida/policyEngine/existingTagDelete.txt" file
#    And user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
#    Examples:
#      | ServiceName  | user       | Header              | Query | Param | type | url                                                                               | body                                            | response code | response message | filePath | jsonPath |
#      | PolicyEngine | policyUser | AcceptDecisionRules |       |       | Put  | policy/decisionmodels/ASG.DI.DataAnalysis/decisiontables/ASG.DI.DataAnalysisTable | payloads/ida/policyEngine/existingTagDelete.txt | 200           |                  |          |          |
#
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario Outline:SC#38 user reset the policy tags with default list
#    Given user copy the data from "rest/payloads/ida/policyEngine/defaultTags.json" file to "rest/payloads/ida/policyEngine/defaultTags.txt" file
#    And user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
#    Examples:
#      | ServiceName  | user       | Header              | Query | Param | type | url                                                                               | body                                      | response code | response message | filePath | jsonPath |
#      | PolicyEngine | policyUser | AcceptDecisionRules |       |       | Put  | policy/decisionmodels/ASG.DI.DataAnalysis/decisiontables/ASG.DI.DataAnalysisTable | payloads/ida/policyEngine/defaultTags.txt | 200           |                  |          |          |
#
#  @MLP-7674 @IDA-10.0
#  Scenario: SC#41 MLP-7674 To verify created area name is deleted
#    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for DELETE request with url "/settings/catalogs/AvroCatalog"
#    Then Status code 204 must be returned
#    When user makes a REST Call for Get request with url "/settings/catalogs/AvroCatalog"
#    And response message contains value "CONFIG-0007"
#    And verify created schema "AvroCatalog" doesn't exists in database
#
#
#         #####Test case to validate  avro,csv and parquet  files are analyzed and collected in UI########
#  @sanity @positive @MLP-7674 @IDA-10.0
#  Scenario:MLP-7674:SC42#Create a catalog for Avro Analyzer
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "ida/avroPayloads/CreateAvroCatalog.json"
#    When user makes a REST Call for POST request with url "/settings/catalogs"
#    Then Status code 204 must be returned
#    And verify created schema "AvroCatalog" exists in database
#
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario Outline:SC#43Creating a directory in Ambari Files View and Uploading a avro file into the directory
#    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                      | body                                  | response code | response message |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | avroFolder?op=MKDIRS&recursive=true&overwrite=true                                                                                                       |                                       | 200           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | avroFolder/user.avro?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true            | ida/avroPayloads/user.avro            | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | avroFolder/customer_details.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/avroPayloads/customer_details.csv | 201           |                  |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | avroFolder/users.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true        | ida/avroPayloads/users.parquet        | 201           |                  |
#
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario: SC#44 Update File extension in HdfsCataloger
#    Given user update the json file "ida/avroPayloads/hdfsCatalogerConfig.json" file for following values
#      | jsonPath             | jsonValues  |
#      | $..root              | /avroFolder |
#      | $..fileExtensions[0] | avro        |
#      | $..fileExtensions[1] | parquet     |
#      | $..fileExtensions[2] | csv         |
#      | $..catalogName       | AvroCatalog |
#    And user update the json file "ida/avroPayloads/parquetAnalyzer.json" file for following values
#      | jsonPath       | jsonValues  |
#      | $..catalogName | AvroCatalog |
#    And user update the json file "ida/avroPayloads/ambariResolver.json" file for following values
#      | jsonPath       | jsonValues  |
#      | $..catalogName | AvroCatalog |
#
#  @MLP-7674 @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario Outline:SC#45 Configure the big data node with avro configuration and avro catalog
#    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | Header           | Query | Param | type | url                                | body                                      | response code | response message |
#      | application/json | raw   | false | Put  | settings/analyzers/AmbariResolver  | ida/avroPayloads/ambariResolver.json      | 204           |                  |
#      | application/json |       |       | Get  | settings/analyzers/AmbariResolver  |                                           | 200           | AvroCatalog      |
#      | application/json |       |       | Put  | settings/analyzers/HdfsCataloger   | ida/avroPayloads/hdfsCatalogerConfig.json | 204           |                  |
#      | application/json |       |       | Get  | settings/analyzers/HdfsCataloger   |                                           | 200           | AvroCatalog      |
#      | application/json |       |       | Put  | settings/analyzers/AvroAnalyzer    | ida/avroPayloads/avroAnalyzer.json        | 204           |                  |
#      | application/json |       |       | Get  | settings/analyzers/AvroAnalyzer    |                                           | 200           | AvroCatalog      |
#      | application/json |       |       | Put  | settings/analyzers/ParquetAnalyzer | ida/avroPayloads/parquetAnalyzer.json     | 204           |                  |
#      | application/json |       |       | Get  | settings/analyzers/ParquetAnalyzer |                                           | 200           | AvroCatalog      |
#      | application/json |       |       | Put  | settings/analyzers/BigDataAnalyzer | ida/avroPayloads/bigDataAnalyzer.json     | 204           |                  |
#      | application/json |       |       | Get  | settings/analyzers/BigDataAnalyzer |                                           | 200           | AvroCatalog      |
#
#  @positve @hdfs @regression @sanity @IDA-10.0
#  Scenario: SC#46 Start running the Hdfs Cataloger and wait for status to be idle
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                       | body | response code | response message | jsonPath                                             |
#      | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/*      |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status   |
#      |                  |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/*       |      | 200           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/*      |      | 200           | IDLE             | $.[?(@.configurationName=='HdfsCataloger')].status   |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/AvroAnalyzer/*    |      | 200           | IDLE             | $.[?(@.configurationName=='AvroAnalyzer')].status    |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/ParquetAnalyzer/* |      | 200           | IDLE             | $.[?(@.configurationName=='ParquetAnalyzer')].status |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/* |      | 200           | IDLE             | $.[?(@.configurationName=='Data Analyzer')].status   |
#
#
#  @webtest @MLP-7674 @positive @regression @IDA-10.0
#  Scenario: SC#47 Verify field attribute count in UI for Avro,BigData and Parquet analyzer
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "All" catalog and search "AvroCatalog" items at top end
#    And user performs "facet selection" in "customer_details.csv" attribute under "Parent hierarchy" facets in Item Search results page
#    Then results panel "items count" should be displayed as "30 items were found" in Item Search results page
#    And user select "All" catalog and search "AvroCatalog" items at top end
#    And user performs "facet selection" in "users.parquet" attribute under "Parent hierarchy" facets in Item Search results page
#    Then results panel "items count" should be displayed as "4 items were found" in Item Search results page
#    And user select "All" catalog and search "AvroCatalog" items at top end
#    And user performs "facet selection" in "Field" attribute under "Type" facets in Item Search results page
#    And user performs "facet selection" in "customer_details.csv" attribute under "Parent hierarchy" facets in Item Search results page
#    And user performs "facet selection" in "user.avro" attribute under "Parent hierarchy" facets in Item Search results page
#    And user performs "facet selection" in "users.parquet" attribute under "Parent hierarchy" facets in Item Search results page
#    Then results panel "items count" should be displayed as "37 items were found" in Item Search results page
#
#
#  @MLP-7674 @IDA-10.0
#  Scenario Outline:SC#48 Delete the created csv files in Ambari
#    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization               | X-Requested-By | type   | url                                 | body | response code | response message |
#      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | avroFolder?op=DELETE&recursive=true |      | 200           | true             |
#
#
#  @MLP-7674 @IDA-10.0
#  Scenario: SC#49 MLP-7674 To verify created area name is deleted
#    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for DELETE request with url "/settings/catalogs/AvroCatalog"
#    Then Status code 204 must be returned
#    When user makes a REST Call for Get request with url "/settings/catalogs/AvroCatalog"
#    And response message contains value "CONFIG-0007"
#    And verify created schema "AvroCatalog" doesn't exists in database
#
