Feature: MLP-8272 Implementation of Hbase Analyzer

 ###################################################Delete existing Anlaysis and CLuster if any#############################
  @positve @regression @sanity  @ambari
  Scenario:Pre-Condition:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/HBaseAnalyzer/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                 | Cluster  |       |       |
      | SingleItemDelete | Default | Sandbox                      | Cluster  |       |       |
      | SingleItemDelete | Default | Cluster 1                    | Cluster  |       |       |
      | SingleItemDelete | Default | LocalNode                    | Cluster  |       |       |


  ###############################################################################################################################
#7170448
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC1#Get the HBASE Analyzer Configuration response
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                               | body                                      | response code | response message | filePath                                    | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | /schemes/analyzers/configurations | response/HBASE_Analyzer/body/ToolTip.json | 200           |                  | response/HBASE_Analyzer/actual/ToolTip.json |          |

 ##bug-26785
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline:SC2# Validate ToolTip for all the fields in HBASE Analyzer plugin(Type,Plugin,Name,Plugin version,label,BA, Data Source, Credential,Event Condition,Dry Run, Event class,Max Work sixe,node condition,Auto Start,tags,Unique Filter)
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                | actualValues                                | valueType     | expectedJsonPath                                      | actualJsonPath                                                  |
      | response/HBASE_Analyzer/expected/ToolTip.json | response/HBASE_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields..[?(@.label=='Type')].tooltip          | $..[?(@.label=='Type')].tooltip                                 |
      | response/HBASE_Analyzer/expected/ToolTip.json | response/HBASE_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields..[?(@.label=='Plugin')].tooltip        | $..[?(@.label=='Plugin')].tooltip                               |
      | response/HBASE_Analyzer/expected/ToolTip.json | response/HBASE_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.Name.tooltip                           | $.properties[0].value.prototype.properties[2].tooltip           |
      | response/HBASE_Analyzer/expected/ToolTip.json | response/HBASE_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.pluginVersion.tooltip                  | $.properties[0].value.prototype.properties[3].tooltip           |
      | response/HBASE_Analyzer/expected/ToolTip.json | response/HBASE_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.label.tooltip                          | $.properties[0].value.prototype.properties[4].tooltip           |
      | response/HBASE_Analyzer/expected/ToolTip.json | response/HBASE_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.businessApplicationName.tooltip        | $.properties[0].value.prototype.properties[15].tooltip          |
      | response/HBASE_Analyzer/expected/ToolTip.json | response/HBASE_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.eventCondition.tooltip                 | $.properties[0].value.prototype.properties[5].tooltip           |
      | response/HBASE_Analyzer/expected/ToolTip.json | response/HBASE_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.dryRun.tooltip                         | $.properties[0].value.prototype.properties[6].tooltip           |
      | response/HBASE_Analyzer/expected/ToolTip.json | response/HBASE_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.eventClass.tooltip                     | $.properties[0].value.prototype.properties[7].tooltip           |
      | response/HBASE_Analyzer/expected/ToolTip.json | response/HBASE_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.maxWorkSize.tooltip                    | $.properties[0].value.prototype.properties[8].tooltip           |
      | response/HBASE_Analyzer/expected/ToolTip.json | response/HBASE_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.nodeCondition.tooltip                  | $.properties[0].value.prototype.properties[10].tooltip          |
      | response/HBASE_Analyzer/expected/ToolTip.json | response/HBASE_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.autoStart.tooltip                      | $.properties[0].value.prototype.properties[11].tooltip          |
      | response/HBASE_Analyzer/expected/ToolTip.json | response/HBASE_Analyzer/actual/ToolTip.json | stringCompare | $.Commonfields.tags.tooltip                           | $.properties[0].value.prototype.properties[12].tooltip          |
      | response/HBASE_Analyzer/expected/ToolTip.json | response/HBASE_Analyzer/actual/ToolTip.json | stringCompare | $.Uniquefilter.HBASEAnlayzer.sampleSize.tooltip       | $.properties[0].value.prototype.properties[16].value[0].tooltip |
      | response/HBASE_Analyzer/expected/ToolTip.json | response/HBASE_Analyzer/actual/ToolTip.json | stringCompare | $.Uniquefilter.HBASEAnlayzer.histogramBuckets.tooltip | $.properties[0].value.prototype.properties[17].tooltip          |
      | response/HBASE_Analyzer/expected/ToolTip.json | response/HBASE_Analyzer/actual/ToolTip.json | stringCompare | $.Uniquefilter.HBASEAnlayzer.topValues.tooltip        | $.properties[0].value.prototype.properties[18].tooltip          |

 ############## setting the Credentials, BA , Data Source and Cataloger###################

  Scenario: SC3#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                       | jsonValues |
      | $.configurations..hbaseRestUrl | HBaseUri   |

  Scenario: SC3#-MLP_24889_Update the plugin name and tag name
    And user "update" the json file "ida/hbasePayloads/Analyzer/HBaseAnalyzer_Configuration.json" file for following values
      | jsonPath                        | jsonValues        | type |
      | $.configurations..nodeCondition | name=="LocalNode" |      |
      | $.configurations..name          | SC1_HBaseAnalyzer |      |

  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC3#-MLP_24886_Set the Credentials, Datasource, Bussiness Application and Cataloger for HBASEDB Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                         | body                                                                       | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hbaseDBValidCredential | ida/hbasePayloads/Credentials/hbasedbValidCredentials.json                 | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hbaseDBValidCredential |                                                                            | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root                          | ida\hbasePayloads\Bussiness_Application\BussinessApplication.json          | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root                          | ida\hbasePayloads\Bussiness_Application\BussinessApplication_Analyzer.json | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/license                            | ida\hbasePayloads\DataSource\license_DS.json                               | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HBaseDataSource          | ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json             | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HBaseDataSource          |                                                                            | 200           | HbaseDataSource_Valid |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HBaseCataloger           | ida/hbasePayloads/Cataloger/hbasedbValidCatalogerConfig.json               | 204           |                       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HBaseCataloger           |                                                                            | 200           | HBaseCataloger_Valid  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HBaseAnalyzer            | ida/hbasePayloads/Analyzer/HBaseAnalyzer_Configuration.json                | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HBaseAnalyzer            |                                                                            | 200           | SC1_HBaseAnalyzer     |          |

  @MLP-7802 @sanity @positive @regression @hbase
  Scenario: Configuring and Running HBase server
    Given configure a new REST API for the service "Ambari"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
      | X-Requested-By | ambari                     |
    And supply payload with file name "ida/hbasePayloads/HBASE_Data/HBase_StartServiceComponent.json"
    And user makes a REST Call for PUT request with url "clusters/Sandbox/services/HBASE"
    And sync the test execution for "35" seconds

  @MLP-7802 @sanity @positive @regression @hbase @ambari
  Scenario: Configuring and Running HBase REST server
    Given user connects to the sftp server and run the "START_HBASE" command
    And sync the test execution for "35" seconds


   ###################################################Data Set up###############################################################

    ## hbase shell
    ## create_namespace 'Automation_QA1'
    ## create_namespace 'Automation_QA'
    ## create_namespace 'Automation_QA2'
    ## create_namespace 'pyspark'
    ## create_namespace 'pattern_matching'

  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC3#-MLP_24886_Create tables in HBASE
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser | Header   | Query | Param | type | url                                   | body                                                                                           | response code | response message | jsonPath |
      | HBase       | hbaseuser   | text/xml |       |       | Post | Automation_QA:employee/schema         | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA_employee_CreateTable.xml                      | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | Automation_QA:employee_test/schema    | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA_employee_test_CreateTable.xml                 | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | Automation_QA1:employee/schema        | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA1_employee_CreateTable.xml                     | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | Automation_QA1:employee_test/schema   | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA_employee_test_CreateTable.xml                 | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | Automation_QA1:employee1/schema       | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA1_employee1_CreateTable.xml                    | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | Automation_QA2:employee/schema        | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA2_employee_CreateTable.xml                     | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | Automation_QA2:employee_test/schema   | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA2_employee_test_CreateTable.xml                | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | employee/schema                       | ida/hbasePayloads/HBASE_Data/Hbase_employee_CreateTable.xml                                    | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | products/schema                       | ida/hbasePayloads/HBASE_Data/Hbase_products_CreateTable.xml                                    | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | testtable/schema                      | ida/hbasePayloads/HBASE_Data/Hbase_testtable_CreateTable.xml                                   | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | information/schema                    | ida/hbasePayloads/HBASE_Data/Hbase_information_CreateTable.xml                                 | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | pyspark:employee/schema               | ida/hbasePayloads/HBASE_Data/Hbase_pyspark_employee_Create_ColumnFamily_and_ColumnValues.xml   | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | pyspark:emp/schema                    | ida/hbasePayloads/HBASE_Data/Hbase_pyspark_emp_Create_ColumnFamily_and_ColumnValues.xml        | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | pyspark:hremployee/schema             | ida/hbasePayloads/HBASE_Data/Hbase_pyspark_hremployee_Create_ColumnFamily_and_ColumnValues.xml | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | Automation_QA:employee/row_key/       | ida/hbasePayloads/HBASE_Data/Hbase_employee_Create_ColumnFamily_and_ColumnValues.xml           | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | Automation_QA:employee_test/row_key/  | ida/hbasePayloads/HBASE_Data/Hbase_employee_Create_ColumnFamily_and_ColumnValues.xml           | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | Automation_QA1:employee/row_key/      | ida/hbasePayloads/HBASE_Data/Hbase_employee_Create_ColumnFamily_and_ColumnValues.xml           | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | Automation_QA1:employee_test/row_key/ | ida/hbasePayloads/HBASE_Data/Hbase_employee_Create_ColumnFamily_and_ColumnValues.xml           | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | employee/row_key/                     | ida/hbasePayloads/HBASE_Data/Hbase_employee_Create_ColumnFamily_and_ColumnValues.xml           | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | products/row_key/                     | ida/hbasePayloads/HBASE_Data/Hbase_products_Create_ColumnFamily_and_ColumnValues.xml           | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | testtable/row_key/                    | ida/hbasePayloads/HBASE_Data/Hbase_testtable_Create_ColumnFamily_and_ColumnValues.xml          | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | information/row_key/                  | ida/hbasePayloads/HBASE_Data/Hbase_information_Create_ColumnFamily_and_ColumnValues.xml        | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | Automation_QA1:employee1/row_key/     | ida/hbasePayloads/HBASE_Data/Hbase_employee_Create_ColumnFamily_and_ColumnValues.xml           | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | Automation_QA2:employee/row_key/      | ida/hbasePayloads/HBASE_Data/Hbase_employee_Create_ColumnFamily_and_ColumnValues.xml           | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | Automation_QA2:employee/row_key/      | ida/hbasePayloads/HBASE_Data/Hbase_employee_Create_ColumnFamily_and_ColumnValues.xml           | 200           |                  |          |

       ######################################Analyzer mandatory field error validation#####################################
#7170451
   #Bug-26017
  @MLP-24196 @webtest @regression @positive
  Scenario:SC3#MLP_24196_Verify HBase Analyzer empty field validation messaged
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
      | fieldName | attribute     |
      | Type      | Dataanalyzer  |
      | Plugin    | HBaseAnalyzer |
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
      | Name                  | SC1_HBaseAnalyzer      |
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

#7170451
    #Bug-26017
  @MLP-24196 @webtest @regression @positive
  Scenario:SC3#MLP_24196_Verify HBase Analyzer field Histogram Bucket, Top values and Sample data Count shows proper error message for higher values
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
      | fieldName | attribute     |
      | Type      | Dataanalyzer  |
      | Plugin    | HBaseAnalyzer |
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



 ############################################Cataloger Filter cases- Only Namespace with resolve cluster name TRUE and Cluster name is SANDBOX##########################################
############################################Run Hbase Analyzer for above cataloger config##########################################

  Scenario: SC4#-MLP_24886_Update the Host name respect to the docker
    And sync the test execution for "30" seconds
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSource_ResolveClusterTRUE.json" file for following values using property loader
      | jsonPath                                            | jsonValues      |
      | $.configurations..hbaseRestUrl                      | HBaseUri        |
      | $.configurations..clusterManager.clusterManagerHost | clusterHostName |


  Scenario Outline: SC4#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                                        | response code | response message             | jsonPath                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HBaseDataSource                                                          | ida/hbasePayloads/DataSource/hbasedbValidDataSource_ResolveClusterTRUE.json | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HBaseDataSource                                                          |                                                                             | 200           | HbaseDataSource_Valid        |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseCataloger                                                           | ida/hbasePayloads/Analyzer/HBaseCataloger_one_Namespace_Configuration.json  | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseCataloger                                                           |                                                                             | 200           | HBaseCataloger_onlyNamespace |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_onlyNamespace |                                                                             | 200           | IDLE                         | $.[?(@.configurationName=='HBaseCataloger_onlyNamespace')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_onlyNamespace  |                                                                             | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_onlyNamespace |                                                                             | 200           | IDLE                         | $.[?(@.configurationName=='HBaseCataloger_onlyNamespace')].status |


  Scenario: SC4#-MLP_24889_Update the plugin name and tag name
    And user "update" the json file "ida/hbasePayloads/Analyzer/HBaseAnalyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues        | type    |
      | $.configurations..nodeCondition    | name=="LocalNode" |         |
      | $.configurations..name             | SC1_HBaseAnalyzer |         |
      | $.configurations..tags[*]          | SC1_HBaseAnalyzer |         |
      | $.configurations..histogramBuckets | 100               | Integer |
      | $.configurations..sampleSize       | 10                | Integer |
      | $.configurations..topValues        | 10                | Integer |
      | $.configurations..autoStart        | false             | boolean |
      | $.configurations..dryRun           | false             | boolean |

    #7170442
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC4#-MLP_24889_Verify HBaseAnalyzer does data sampling/data profiling properly for HBase tables when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:True)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                | body                                                        | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseAnalyzer                                                   | ida/hbasePayloads/Analyzer/HBaseAnalyzer_Configuration.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseAnalyzer                                                   |                                                             | 200           | SC1_HBaseAnalyzer |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/HBaseAnalyzer/SC1_HBaseAnalyzer |                                                             | 200           | IDLE              | $.[?(@.configurationName=='SC1_HBaseAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/HBaseAnalyzer/SC1_HBaseAnalyzer  |                                                             | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/HBaseAnalyzer/SC1_HBaseAnalyzer |                                                             | 200           | IDLE              | $.[?(@.configurationName=='SC1_HBaseAnalyzer')].status |


  ###################################################Data Profiling########################################################################

#7170442
  @webtest
  Scenario: SC#4 Verify Data profiling  displayed for Long/Numeric/String and Boolean (long, String) datatype in HBase Table.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1_HBaseAnalyzer" and clicks on search
    And user performs "definite facet selection" in "SC1_HBaseAnalyzer" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Automation_QA [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Automation_QA" item from search results
    Then user performs click and verify in new window
      | Table   | value                         | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | employee                      | click and switch tab | No               |             |
      | Columns | professional data:designation | click and switch tab | No               |             |
    And user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section not presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value                    | Action               | RetainPrevwindow | indexSwitch |
      | Columns | professional data:salary | click and switch tab | No               |             |
    And user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value              | Action               | RetainPrevwindow | indexSwitch |
      | Columns | personal data:name | click and switch tab | No               |             |
    And user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section not presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value                         | Action                    | RetainPrevwindow | indexSwitch | filePath                                    | jsonPath                             | metadataSection |
      | Columns | professional data:designation | click and verify metadata | Yes              | 0           | ida/hbasePayloads/API/expectedMetadata.json | $.Automation_QA_employee.designation | Statistics      |
      | Columns | professional data:salary      | click and verify metadata | Yes              | 0           | ida/hbasePayloads/API/expectedMetadata.json | $.Automation_QA_employee.salary      | Statistics      |
      | Columns | personal data:name            | click and verify metadata | Yes              | 0           | ida/hbasePayloads/API/expectedMetadata.json | $.Automation_QA_employee.name        | Statistics      |

        ########################################################Data Sample validation############################################################################

  Scenario Outline:SC4:user get the Dynamic ID's (Database ID) for the Database "Automation_QA" and Table "employee,employee_test"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type     | name          | asg_scopeid   | targetFile                                | jsonpath                               |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | Automation_QA | employee      | payloads/ida/hbasePayloads/API/items.json | $.Database.Automation_QA.employee      |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | Automation_QA | employee_test | payloads/ida/hbasePayloads/API/items.json | $.Database.Automation_QA.employee_test |

  Scenario Outline: SC4:user hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                              | inputFile                                 | outPutFile                                                             | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.Automation_QA.employee      | payloads/ida/hbasePayloads/API/items.json | payloads\ida\hbasePayloads\API\Actual\Automation_QA_employee.json      |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.Automation_QA.employee_test | payloads/ida/hbasePayloads/API/items.json | payloads\ida\hbasePayloads\API\Actual\Automation_QA_employee_test.json |            |

#7170442
  #Bug-26785
  Scenario: SC#4 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\hbasePayloads\API\Actual\Automation_QA_employee.json" should be same as the content in "ida\hbasePayloads\API\Expected\Automation_QA_employee.json"
    Then file content in "ida\hbasePayloads\API\Actual\Automation_QA_employee_test.json" should be same as the content in "ida\hbasePayloads\API\Expected\Automation_QA_employee_test.json"

 ##########################################################Technology ,BA and explicit tag validation######################################################

  #Bug-26107
  #7170449
  @positve @regression @sanity  @PIITag
  Scenario:Commoncase#MLP_24889_Verify Technology tag , Explicit tag , Bussiness Application tag and File Filter tag
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName  | TableName/Filename | Column                   | Tags                                      | Query                    | Action      |
      | Sandbox     | HBASE       | Automation_QA | employee           |                          | SC1_HBaseAnalyzer,HBase,HBASE_BA_ANALYZER | TableQuerywithoutSchema  | TagAssigned |
      | Sandbox     | HBASE       | Automation_QA | employee           | professional data:salary | SC1_HBaseAnalyzer,HBase,HBASE_BA_ANALYZER | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | Automation_QA |                    |                          | SC1_HBaseAnalyzer,HBase,HBASE_BA_ANALYZER | DatabaseQuery            | TagAssigned |
      | Sandbox     | HBASE       |               |                    |                          | SC1_HBaseAnalyzer,HBase,HBASE_BA_ANALYZER | ServiceQuery             | TagAssigned |
      | Sandbox     |             |               |                    |                          | SC1_HBaseAnalyzer,HBase,HBASE_BA_ANALYZER | ClusterQuery             | TagAssigned |

    ############################################################Log Enhancemnt #################################################################################

   #7170449
  @sanity @positive @webtest @MLP-24889 @IDA-1.1.0
  Scenario:CommonCase:MLP_24889_Verify the Processed Items widget presence and Logging Enhancement validation
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1_HBaseAnalyzer" and clicks on search
    And user performs "facet selection" in "SC1_HBaseAnalyzer" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/HBaseAnalyzer/SC1_HBaseAnalyzer/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 2             |
      | Number of errors          | 0             |
    And user "widget presence" on "Processed Items" in Item view page
    Then Analysis log "dataanalyzer/HBaseAnalyzer/SC1_HBaseAnalyzer/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | logCode       | pluginName    | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0019 |               |                |
      | INFO | ANALYSIS-0071: Plugin Name:HBaseAnalyzer, Plugin Type:dataanalyzer, Plugin Version:1.1.0.SNAPSHOT, Node Name:Cluster Demo, Host Name:sandbox.hortonworks.com, Plugin Configuration name:SC1_HBaseAnalyzer                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0071 | HBaseAnalyzer | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: ---  2020-10-02 15:44:23.441 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: name: "SC1_HBaseAnalyzer"  2020-10-02 15:44:23.441 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: pluginVersion: "LATEST"  2020-10-02 15:44:23.441 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: label:  2020-10-02 15:44:23.441 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: : ""  2020-10-02 15:44:23.441 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: catalogName: "Default"  2020-10-02 15:44:23.441 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: eventClass: null  2020-10-02 15:44:23.441 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: eventCondition: null  2020-10-02 15:44:23.441 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: nodeCondition: "name==\"LocalNode\""  2020-10-02 15:44:23.441 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: maxWorkSize: 100  2020-10-02 15:44:23.441 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: tags:  2020-10-02 15:44:23.441 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: - "SC1_HBaseAnalyzer"  2020-10-02 15:44:23.441 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: pluginType: "dataanalyzer"  2020-10-02 15:44:23.441 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: dataSource: null  2020-10-02 15:44:23.442 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: credential: null  2020-10-02 15:44:23.442 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: businessApplicationName: "HBASE_BA_ANALYZER"  2020-10-02 15:44:23.442 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: dryRun: false  2020-10-02 15:44:23.442 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: schedule: null  2020-10-02 15:44:23.442 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: filter: null  2020-10-02 15:44:23.442 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: histogramBuckets: 100  2020-10-02 15:44:23.442 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: pluginName: "HBaseAnalyzer"  2020-10-02 15:44:23.442 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: runAfter: []  2020-10-02 15:44:23.442 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: dataSample:  2020-10-02 15:44:23.442 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: sampleSize: 10  2020-10-02 15:44:23.442 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: type: "Dataanalyzer"  2020-10-02 15:44:23.442 INFO  - ANALYSIS-0073: Plugin HBaseAnalyzer Configuration: topValues: 10 | ANALYSIS-0073 | HBaseAnalyzer |                |
      | INFO | ANALYSIS-0072: Plugin HBaseAnalyzer Start Time:2020-08-09 18:12:37.887, End Time:2020-08-09 18:15:28.864, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0072 | HBaseAnalyzer |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:01:55.385)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0020 |               |                |

  Scenario:SC4:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                    | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/HBaseCataloger_onlyNamespace/% | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/HBaseAnalyzer/SC1_HBaseAnalyzer/%          | Analysis |       |       |
      | SingleItemDelete | Default | Sandbox                                                 | Cluster  |       |       |

###############################################Cataloger Filter cases- Multiple NamespaceMultiple Tables with resolve cluster name FALSE  in CLUSTER DEMO node########################
############################################Run Hbase Analyzer for above cataloger config##########################################


  Scenario: SC5#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                       | jsonValues |
      | $.configurations..hbaseRestUrl | HBaseUri   |
    And user update the json file "ida/hbasePayloads/Analyzer/HBaseCataloger_with_Mutiple_namespace_Multiple_tables_Configuration.json" file for following values
      | jsonPath                        | jsonValues           |
      | $.configurations..nodeCondition | name=="Cluster Demo" |


  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC5#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                                 | body                                                                                                | response code | response message                                | jsonPath                                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseDataSource                                                                                  | ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json                                      | 204           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseDataSource                                                                                  |                                                                                                     | 200           | HbaseDataSource_Valid                           |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseCataloger                                                                                   | ida/hbasePayloads/Analyzer/HBaseCataloger_with_Mutiple_namespace_Multiple_tables_Configuration.json | 204           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseCataloger                                                                                   |                                                                                                     | 200           | HBaseCataloger_MultipleNamespacesMultipleTables |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesMultipleTables |                                                                                                     | 200           | IDLE                                            | $.[?(@.configurationName=='HBaseCataloger_MultipleNamespacesMultipleTables')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesMultipleTables  |                                                                                                     | 200           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesMultipleTables |                                                                                                     | 200           | IDLE                                            | $.[?(@.configurationName=='HBaseCataloger_MultipleNamespacesMultipleTables')].status |

  Scenario: SC5#-MLP_24889_Update the plugin name and tag name
    And user "update" the json file "ida/hbasePayloads/Analyzer/HBaseAnalyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues           | type    |
      | $.configurations..nodeCondition    | name=="Cluster Demo" |         |
      | $.configurations..name             | SC2_HBaseAnalyzer    |         |
      | $.configurations..tags[*]          | SC2_HBaseAnalyzer    |         |
      | $.configurations..histogramBuckets | 50                   | Integer |
      | $.configurations..sampleSize       | 15                   | Integer |
      | $.configurations..topValues        | 15                   | Integer |
      | $.configurations..autoStart        | false                | boolean |
      | $.configurations..dryRun           | false                | boolean |

    #7170440
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC5#-MLP_24889_Verify HBaseAnalyzer does data sampling/data profiling properly for HBase tables when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:False)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                        | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseAnalyzer                                                        | ida/hbasePayloads/Analyzer/HBaseAnalyzer_Configuration.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseAnalyzer                                                        |                                                             | 200           | SC2_HBaseAnalyzer |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HBaseAnalyzer/SC2_HBaseAnalyzer |                                                             | 200           | IDLE              | $.[?(@.configurationName=='SC2_HBaseAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/HBaseAnalyzer/SC2_HBaseAnalyzer  |                                                             | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HBaseAnalyzer/SC2_HBaseAnalyzer |                                                             | 200           | IDLE              | $.[?(@.configurationName=='SC2_HBaseAnalyzer')].status |

#   ###################################################Data Profiling########################################################################
#7170440
  @webtest
  Scenario: SC#5 Verify Data profiling  displayed for Long/Numeric/String and Boolean (long, String) datatype in HBase Table.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC2_HBaseAnalyzer" and clicks on search
    And user performs "definite facet selection" in "SC2_HBaseAnalyzer" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Automation_QA1 [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Automation_QA1" item from search results
    Then user performs click and verify in new window
      | Table   | value                         | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | employee                      | click and switch tab | No               |             |
      | Columns | professional data:designation | click and switch tab | No               |             |
    And user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section not presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value                    | Action               | RetainPrevwindow | indexSwitch |
      | Columns | professional data:salary | click and switch tab | No               |             |
    And user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value              | Action               | RetainPrevwindow | indexSwitch |
      | Columns | personal data:name | click and switch tab | No               |             |
    And user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section not presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value                         | Action                    | RetainPrevwindow | indexSwitch | filePath                                    | jsonPath                             | metadataSection |
      | Columns | professional data:designation | click and verify metadata | Yes              | 0           | ida/hbasePayloads/API/expectedMetadata.json | $.Automation_QA_employee.designation | Statistics      |
      | Columns | professional data:salary      | click and verify metadata | Yes              | 0           | ida/hbasePayloads/API/expectedMetadata.json | $.Automation_QA_employee.salary      | Statistics      |
      | Columns | personal data:name            | click and verify metadata | Yes              | 0           | ida/hbasePayloads/API/expectedMetadata.json | $.Automation_QA_employee.name        | Statistics      |

        ########################################################Data Sample validation############################################################################

  Scenario Outline:SC5:user get the Dynamic ID's (Database ID) for the Database "Automation_QA1" and Table "employee,employee_test"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type     | name           | asg_scopeid   | targetFile                                | jsonpath                                |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | Automation_QA1 | employee      | payloads/ida/hbasePayloads/API/items.json | $.Database.Automation_QA1.employee      |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | Automation_QA1 | employee_test | payloads/ida/hbasePayloads/API/items.json | $.Database.Automation_QA1.employee_test |

  Scenario Outline: SC5:user hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                               | inputFile                                 | outPutFile                                                              | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.Automation_QA1.employee      | payloads/ida/hbasePayloads/API/items.json | payloads\ida\hbasePayloads\API\Actual\Automation_QA1_employee.json      |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.Automation_QA1.employee_test | payloads/ida/hbasePayloads/API/items.json | payloads\ida\hbasePayloads\API\Actual\Automation_QA1_employee_test.json |            |

#7170440
  #Bug-26785
  Scenario: SC#5 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\hbasePayloads\API\Actual\Automation_QA1_employee.json" should be same as the content in "ida\hbasePayloads\API\Expected\Automation_QA_employee.json"
    Then file content in "ida\hbasePayloads\API\Actual\Automation_QA1_employee_test.json" should be same as the content in "ida\hbasePayloads\API\Expected\Automation_QA_employee_test.json"

#################################################################################re-run#########################################################################################

#   #7170454
#  #user story=28085
#  @MLP-3422 @webtest @positve @hdfs @regression @sanity
#  Scenario: SC5#-MLP_24889_Verify whether the last analyzed at value doesn't change for the second run if the collected Tables are not modified.
#    Given User launch browser and traverse to login page
#    And user enter credentials for "system Administrator1" role
#    And user enters the search text "SC2_HBaseAnalyzer" and clicks on search
#    And user performs "definite facet selection" in "SC2_HBaseAnalyzer" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Automation_QA1 [Database]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "Automation_QA1" item from search results
#    Then user performs click and verify in new window
#      | Table   | value                         | Action               | RetainPrevwindow | indexSwitch |
#      | Tables  | employee                      | click and switch tab | No               |             |
#      | Columns | professional data:designation | click and switch tab | No               |             |
#    And user "store" the value of item "professional data:designation" of attribute "Last analyzed at" with temporary text
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                                     | body | response code | response message | jsonPath                                               |
#      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HBaseAnalyzer/SC2_HBaseAnalyzer |      | 200           | IDLE             | $.[?(@.configurationName=='SC2_HBaseAnalyzer')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/HBaseAnalyzer/SC2_HBaseAnalyzer  |      | 200           |                  |                                                        |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/HBaseAnalyzer/SC2_HBaseAnalyzer |      | 200           | IDLE             | $.[?(@.configurationName=='SC2_HBaseAnalyzer')].status |
#    And user enters the search text "SC2_HBaseAnalyzer" and clicks on search
#    And user performs "definite facet selection" in "SC2_HBaseAnalyzer" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Automation_QA1 [Database]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "Automation_QA1" item from search results
#    Then user performs click and verify in new window
#      | Table   | value                         | Action               | RetainPrevwindow | indexSwitch |
#      | Tables  | employee                      | click and switch tab | No               |             |
#      | Columns | professional data:designation | click and switch tab | No               |             |
#    Then user "verify equals" the value of item "professional data:designation" of attribute "Last analyzed at" with temporary text


  Scenario:SC5:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                       | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesMultipleTables/% | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/HBaseAnalyzer/SC2_HBaseAnalyzer/%                             | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                                                               | Cluster  |       |       |

######################################################Cataloger Filter cases-  Non existing Namespace cluster name FALSE in LOCAL node##############################################
###########################################################Run Hbase Analyzer for above cataloger config######################################################################################


  Scenario: SC6#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                       | jsonValues |
      | $.configurations..hbaseRestUrl | HBaseUri   |
    And user update the json file "ida/hbasePayloads/Analyzer/HBaseCataloger_non_existent_Namespace_Configuration.json" file for following values
      | jsonPath                        | jsonValues        |
      | $.configurations..nodeCondition | name=="LocalNode" |


  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC6#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                       | body                                                                                | response code | response message                           | jsonPath                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseDataSource                                                                        | ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json                      | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseDataSource                                                                        |                                                                                     | 200           | HbaseDataSource_Valid                      |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseCataloger                                                                         | ida/hbasePayloads/Analyzer/HBaseCataloger_non_existent_Namespace_Configuration.json | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseCataloger                                                                         |                                                                                     | 200           | HBaseCataloger_InvalidNamespace_validtable |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_InvalidNamespace_validtable |                                                                                     | 200           | IDLE                                       | $.[?(@.configurationName=='HBaseCataloger_InvalidNamespace_validtable')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_InvalidNamespace_validtable  |                                                                                     | 200           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_InvalidNamespace_validtable |                                                                                     | 200           | IDLE                                       | $.[?(@.configurationName=='HBaseCataloger_InvalidNamespace_validtable')].status |

  Scenario: SC6#-MLP_24889_Update the plugin name and tag name
    And user "update" the json file "ida/hbasePayloads/Analyzer/HBaseAnalyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues        | type    |
      | $.configurations..nodeCondition    | name=="LocalNode" |         |
      | $.configurations..name             | SC3_HBaseAnalyzer |         |
      | $.configurations..tags[*]          | SC3_HBaseAnalyzer |         |
      | $.configurations..histogramBuckets | 100               | Integer |
      | $.configurations..sampleSize       | 10                | Integer |
      | $.configurations..topValues        | 10                | Integer |
      | $.configurations..autoStart        | false             | boolean |
      | $.configurations..dryRun           | false             | boolean |

    #7170445
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC6#-MLP_24889_Verify HBaseAnalyzer does data sampling/data profiling properly for HBase tables when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:False)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                | body                                                        | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseAnalyzer                                                   | ida/hbasePayloads/Analyzer/HBaseAnalyzer_Configuration.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseAnalyzer                                                   |                                                             | 200           | SC3_HBaseAnalyzer |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/HBaseAnalyzer/SC3_HBaseAnalyzer |                                                             | 200           | IDLE              | $.[?(@.configurationName=='SC3_HBaseAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/HBaseAnalyzer/SC3_HBaseAnalyzer  |                                                             | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/HBaseAnalyzer/SC3_HBaseAnalyzer |                                                             | 200           | IDLE              | $.[?(@.configurationName=='SC3_HBaseAnalyzer')].status |

  #7170445
  @sanity @positive @webtest @MLP-24886 @IDA-1.1.0
  Scenario:SC6:MLP_24886_Verify no Cluster , Table , Database , Host and service facets are cataloged and verify log message when the cataloger with Non-Existing namespace
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC3_HBaseAnalyzer" and clicks on search
    And user performs "definite facet selection" in "SC3_HBaseAnalyzer" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Cluster  |
      | Database |
      | Table    |
      | Service  |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/HBaseAnalyzer/SC3_HBaseAnalyzer/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "dataanalyzer/HBaseAnalyzer/SC3_HBaseAnalyzer/%" should display below info/error/warning
      | type | logValue                                                                                                                                          | logCode       | pluginName    | removableText |
      | INFO | Plugin started                                                                                                                                    | ANALYSIS-0019 |               |               |
      | INFO | ANALYSIS-0072: Plugin HBaseAnalyzer Start Time:2020-08-09 18:12:37.887, End Time:2020-08-09 18:15:28.864, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | HBaseAnalyzer |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:01:55.385)                                                                                    | ANALYSIS-0020 |               |               |

  Scenario:SC6:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                  | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/HBaseCataloger_InvalidNamespace_validtable/% | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/HBaseAnalyzer/SC3_HBaseAnalyzer/%                        | Analysis |       |       |
      | SingleItemDelete | Default | LocalNode                                                             | Cluster  |       |       |


###############################################Cataloger Filter cases-  Non existing Table cluster name FALSE  in LOCAL  node#########################################################
################################################################Run Hbase Analyzer for above cataloger config####################################################################


  Scenario: SC7#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                       | jsonValues |
      | $.configurations..hbaseRestUrl | HBaseUri   |
    And user update the json file "ida/hbasePayloads/Analyzer/HBaseCataloger_non_existent_Table_Configuration.json" file for following values
      | jsonPath                        | jsonValues        |
      | $.configurations..nodeCondition | name=="LocalNode" |


  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC7#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                       | body                                                                            | response code | response message                           | jsonPath                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseDataSource                                                                        | ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json                  | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseDataSource                                                                        |                                                                                 | 200           | HbaseDataSource_Valid                      |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseCataloger                                                                         | ida/hbasePayloads/Analyzer/HBaseCataloger_non_existent_Table_Configuration.json | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseCataloger                                                                         |                                                                                 | 200           | HBaseCataloger_ValidNamespace_Invalidtable |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_ValidNamespace_Invalidtable |                                                                                 | 200           | IDLE                                       | $.[?(@.configurationName=='HBaseCataloger_ValidNamespace_Invalidtable')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_ValidNamespace_Invalidtable  |                                                                                 | 200           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_ValidNamespace_Invalidtable |                                                                                 | 200           | IDLE                                       | $.[?(@.configurationName=='HBaseCataloger_ValidNamespace_Invalidtable')].status |

  Scenario: SC7#-MLP_24889_Update the plugin name and tag name
    And user "update" the json file "ida/hbasePayloads/Analyzer/HBaseAnalyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues        | type    |
      | $.configurations..nodeCondition    | name=="LocalNode" |         |
      | $.configurations..name             | SC4_HBaseAnalyzer |         |
      | $.configurations..tags[*]          | SC4_HBaseAnalyzer |         |
      | $.configurations..histogramBuckets | 100               | Integer |
      | $.configurations..sampleSize       | 10                | Integer |
      | $.configurations..topValues        | 10                | Integer |
      | $.configurations..autoStart        | false             | boolean |
      | $.configurations..dryRun           | false             | boolean |

    #7170443
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC7#-MLP_24889_Verify HBaseAnalyzer does data sampling/data profiling properly for HBase tables when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:False)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                | body                                                        | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseAnalyzer                                                   | ida/hbasePayloads/Analyzer/HBaseAnalyzer_Configuration.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseAnalyzer                                                   |                                                             | 200           | SC4_HBaseAnalyzer |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/HBaseAnalyzer/SC4_HBaseAnalyzer |                                                             | 200           | IDLE              | $.[?(@.configurationName=='SC4_HBaseAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/HBaseAnalyzer/SC4_HBaseAnalyzer  |                                                             | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/HBaseAnalyzer/SC4_HBaseAnalyzer |                                                             | 200           | IDLE              | $.[?(@.configurationName=='SC4_HBaseAnalyzer')].status |

  #7170443
  @sanity @positive @webtest @MLP-24886 @IDA-1.1.0
  Scenario:SC7:MLP_24886_Verify no Cluster , Table , Database , Host and service facets are cataloged and verify log message when the cataloger with Non-Existing Tables
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC4_HBaseAnalyzer" and clicks on search
    And user performs "definite facet selection" in "SC4_HBaseAnalyzer" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Table |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/HBaseAnalyzer/SC4_HBaseAnalyzer/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "dataanalyzer/HBaseAnalyzer/SC4_HBaseAnalyzer/%" should display below info/error/warning
      | type | logValue                                                                                                                                          | logCode       | pluginName    | removableText |
      | INFO | Plugin started                                                                                                                                    | ANALYSIS-0019 |               |               |
      | INFO | ANALYSIS-0072: Plugin HBaseAnalyzer Start Time:2020-08-09 18:12:37.887, End Time:2020-08-09 18:15:28.864, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | HBaseAnalyzer |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:01:55.385)                                                                                    | ANALYSIS-0020 |               |               |

  Scenario:SC7:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                  | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/HBaseCataloger_ValidNamespace_Invalidtable/% | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/HBaseAnalyzer/SC4_HBaseAnalyzer/%                        | Analysis |       |       |
      | SingleItemDelete | Default | LocalNode                                                             | Cluster  |       |       |

    ########################################################################Auto start- TRUE#####################################################################################################

  Scenario: SC8#-MLP_24889_Update the plugin name and tag name
    And user "update" the json file "ida/hbasePayloads/Analyzer/HBaseAnalyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues        | type    |
      | $.configurations..nodeCondition    | name=="LocalNode" |         |
      | $.configurations..name             | SC5_HBaseAnalyzer |         |
      | $.configurations..tags[*]          | SC5_HBaseAnalyzer |         |
      | $.configurations..histogramBuckets | 100               | Integer |
      | $.configurations..sampleSize       | 10                | Integer |
      | $.configurations..topValues        | 10                | Integer |
      | $.configurations..autoStart        | true              | boolean |
      | $.configurations..dryRun           | false             | boolean |


    #7170453
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC8#-MLP_24889_Verify HBaseAnalyzer does data sampling/data profiling properly for HBase tables when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:False)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                | body                                                        | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseAnalyzer                                                   | ida/hbasePayloads/Analyzer/HBaseAnalyzer_Configuration.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseAnalyzer                                                   |                                                             | 200           | SC5_HBaseAnalyzer |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/HBaseAnalyzer/SC5_HBaseAnalyzer |                                                             | 200           | IDLE              | $.[?(@.configurationName=='SC5_HBaseAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/HBaseAnalyzer/SC5_HBaseAnalyzer |                                                             | 200           | IDLE              | $.[?(@.configurationName=='SC5_HBaseAnalyzer')].status |

 #7170453
  @sanity @positive @webtest @MLP-24886 @IDA-1.1.0
  Scenario:SC8:MLP_24886_Verify no Cluster , Table , Database , Host and service facets are cataloged and verify log message whent the cataloger with Auto Start field is TRUE
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC5_HBaseAnalyzer" and clicks on search
    And user performs "definite facet selection" in "SC5_HBaseAnalyzer" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Cluster  |
      | Database |
      | Table    |
      | Service  |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/HBaseAnalyzer/SC5_HBaseAnalyzer/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "dataanalyzer/HBaseAnalyzer/SC5_HBaseAnalyzer/%" should display below info/error/warning
      | type | logValue                                                                                                                                          | logCode       | pluginName    | removableText |
      | INFO | Plugin started                                                                                                                                    | ANALYSIS-0019 |               |               |
      | INFO | ANALYSIS-0072: Plugin HBaseAnalyzer Start Time:2020-08-09 18:12:37.887, End Time:2020-08-09 18:15:28.864, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | HBaseAnalyzer |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:01:55.385)                                                                                    | ANALYSIS-0020 |               |               |

  Scenario:SC8:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/HBaseAnalyzer/SC5_HBaseAnalyzer/% | Analysis |       |       |

###########################################################################Dry Run Analyzer#####################################################################################################

  Scenario: CommonCase#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                       | jsonValues |
      | $.configurations..hbaseRestUrl | HBaseUri   |
    And user update the json file "ida/hbasePayloads/Analyzer/HBaseCataloger_with_Mutiple_namespace_Multiple_tables_Configuration.json" file for following values
      | jsonPath                        | jsonValues        |
      | $.configurations..nodeCondition | name=="LocalNode" |


  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: CommonCase#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                            | body                                                                                                | response code | response message                                | jsonPath                                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseDataSource                                                                             | ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json                                      | 204           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseDataSource                                                                             |                                                                                                     | 200           | HbaseDataSource_Valid                           |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseCataloger                                                                              | ida/hbasePayloads/Analyzer/HBaseCataloger_with_Mutiple_namespace_Multiple_tables_Configuration.json | 204           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseCataloger                                                                              |                                                                                                     | 200           | HBaseCataloger_MultipleNamespacesMultipleTables |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesMultipleTables |                                                                                                     | 200           | IDLE                                            | $.[?(@.configurationName=='HBaseCataloger_MultipleNamespacesMultipleTables')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesMultipleTables  |                                                                                                     | 200           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesMultipleTables |                                                                                                     | 200           | IDLE                                            | $.[?(@.configurationName=='HBaseCataloger_MultipleNamespacesMultipleTables')].status |

  Scenario: CommonCase#-MLP_24889_Update the plugin name and tag name
    And user "update" the json file "ida/hbasePayloads/Analyzer/HBaseAnalyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues               | type    |
      | $.configurations..nodeCondition    | name=="LocalNode"        |         |
      | $.configurations..name             | SC6_HBaseAnalyzer_DryRun |         |
      | $.configurations..tags[*]          | SC6_HBaseAnalyzer_DryRun |         |
      | $.configurations..histogramBuckets | 50                       | Integer |
      | $.configurations..sampleSize       | 15                       | Integer |
      | $.configurations..topValues        | 15                       | Integer |
      | $.configurations..autoStart        | false                    | boolean |
      | $.configurations..dryRun           | true                     | boolean |

    #7170449
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: CommonCase#-MLP_24889_Verify HBaseAnalyzer does data sampling/data profiling properly for HBase tables when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:False)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                        | response code | response message         | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseAnalyzer                                                          | ida/hbasePayloads/Analyzer/HBaseAnalyzer_Configuration.json | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseAnalyzer                                                          |                                                             | 200           | SC6_HBaseAnalyzer_DryRun |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/HBaseAnalyzer/SC6_HBaseAnalyzer_DryRun |                                                             | 200           | IDLE                     | $.[?(@.configurationName=='SC6_HBaseAnalyzer_DryRun')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/HBaseAnalyzer/SC6_HBaseAnalyzer_DryRun  |                                                             | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/HBaseAnalyzer/SC6_HBaseAnalyzer_DryRun |                                                             | 200           | IDLE                     | $.[?(@.configurationName=='SC6_HBaseAnalyzer_DryRun')].status |

#7170449
  @sanity @positive @webtest @MLP-24886 @IDA-1.1.0
  Scenario:CommonCase:MLP_24886_Verify no Cluster , Table , Database , Host and service facets are cataloged and verify log message with Dryn Run made TRUE
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC6_HBaseAnalyzer_DryRun" and clicks on search
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Cluster  |
      | Database |
      | Table    |
      | Service  |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/HBaseAnalyzer/SC6_HBaseAnalyzer_DryRun/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "dataanalyzer/HBaseAnalyzer/SC6_HBaseAnalyzer_DryRun/%" should display below info/error/warning
      | type | logValue                                                                                 | logCode       | pluginName    | removableText |
      | INFO | Plugin HBaseAnalyzer running on dry run mode                                             | ANALYSIS-0069 | HBaseAnalyzer |               |
      | INFO | Plugin HBaseAnalyzer processed 2 items on dry run mode and not written to the repository | ANALYSIS-0070 | HBaseAnalyzer |               |
      | INFO | Plugin completed                                                                         | ANALYSIS-0020 |               |               |

  Scenario:CommonCase:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/HBaseAnalyzer/SC6_HBaseAnalyzer_DryRun/% | Analysis |       |       |

  Scenario:SC#8:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type     | query | param |
      | SingleItemDelete | Default | Sandbox                      | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/HBaseAnalyzer/% | Analysis |       |       |
      | MultipleIDDelete | Default | LocalNode                    | Cluster  |       |       |

      #############################################Delete data in HBASE#############################################################

  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC9#-MLP_24886_Delete the tables from HBASE
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser | Header   | Query | Param | type   | url                                 | body                                                                                           | response code | response message | jsonPath |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | Automation_QA:employee/schema       | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA_employee_CreateTable.xml                      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | Automation_QA:employee_test/schema  | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA_employee_test_CreateTable.xml                 | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | Automation_QA1:employee/schema      | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA1_employee_CreateTable.xml                     | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | Automation_QA1:employee1/schema     | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA1_employee_CreateTable.xml                     | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | Automation_QA1:employee_test/schema | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA_employee_test_CreateTable.xml                 | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | Automation_QA2:employee/schema      | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA1_employee_CreateTable.xml                     | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | Automation_QA2:employee_test/schema | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA_employee_test_CreateTable.xml                 | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | employee/schema                     | ida/hbasePayloads/HBASE_Data/Hbase_employee_CreateTable.xml                                    | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | products/schema                     | ida/hbasePayloads/HBASE_Data/Hbase_products_CreateTable.xml                                    | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | testtable/schema                    | ida/hbasePayloads/HBASE_Data/Hbase_testtable_CreateTable.xml                                   | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | pyspark:employee/schema             | ida/hbasePayloads/HBASE_Data/Hbase_pyspark_employee_Create_ColumnFamily_and_ColumnValues.xml   | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | pyspark:emp/schema                  | ida/hbasePayloads/HBASE_Data/Hbase_pyspark_emp_Create_ColumnFamily_and_ColumnValues.xml        | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | pyspark:hremployee/schema           | ida/hbasePayloads/HBASE_Data/Hbase_pyspark_hremployee_Create_ColumnFamily_and_ColumnValues.xml | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | information/schema                  | ida/hbasePayloads/HBASE_Data/Hbase_testtable_CreateTable.xml                                   | 200           |                  |          |

    ####################################################PII tags################################################################

  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC5#-MLP_24886_Create tables in HBASE
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser | Header   | Query | Param | type | url                                                                   | body                                                                                                          | response code | response message | jsonPath |
      | HBase       | hbaseuser   | text/xml |       |       | Post | pattern_matching:tagdetails_allmatch/schema                           | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA1_tagdetails_allmatch_CreateTable.xml                         | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | pattern_matching:tagdetails_allmatch/row_key/                         | ida/hbasePayloads/HBASE_Data/Hbase_employee_insertRow_tagdetails_allmatch.xml                                 | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | pattern_matching:tagdetails_allempty/schema                           | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA1_tagdetails_allempty_CreateTable.xml                         | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | pattern_matching:tagdetails_allempty/row_key/                         | ida/hbasePayloads/HBASE_Data/Hbase_employee_insertRow_tagdetails_allempty.xml                                 | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | pattern_matching:tagdetails_ratiolessthan05emptyfalse/schema          | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA1_tagdetails_ratiolessthan05emptyfalse_CreateTable.xml        | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | pattern_matching:tagdetails_ratiolessthan05emptyfalse/row_key/        | ida/hbasePayloads/HBASE_Data/Hbase_employee_insertRow_tagdetails_ratiolessthan05emptyfalse.xml                | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | pattern_matching:tagdetails_ratiogreaterthan05emptyfalsetrue/schema   | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA1_tagdetails_ratiogreaterthan05emptyfalsetrue_CreateTable.xml | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | pattern_matching:tagdetails_ratiogreaterthan05emptyfalsetrue/row_key/ | ida/hbasePayloads/HBASE_Data/Hbase_employee_insertRow_tagdetails_ratiogreaterthan05emptyfalsetrue.xml         | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | pattern_matching:tagdetails_ratioequalto05emptyfalse/schema           | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA1_tagdetails_ratioequalto05emptyfalse_CreateTable.xml         | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | pattern_matching:tagdetails_ratioequalto05emptyfalse/row_key/         | ida/hbasePayloads/HBASE_Data/Hbase_employee_insertRow_tagdetails_ratioequalto05emptyfalse.xml                 | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | pattern_matching:tagdetails_ratiogreaterthan05matchfulltrue/schema    | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA1_tagdetails_ratiogreaterthan05matchfulltrue_CreateTable.xml  | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | pattern_matching:tagdetails_ratiogreaterthan05matchfulltrue/row_key/  | ida/hbasePayloads/HBASE_Data/Hbase_employee_insertRow_tagdetails_ratiogreaterthan05matchfulltrue.xml          | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Post | pattern_matching:tagdetails_ratiolesserthan05matchfulltrue/schema     | ida/hbasePayloads/HBASE_Data/Hbase_Automation_QA1_tagdetails_ratiolesserthan05matchfulltrue_CreateTable.xml   | 201           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Put  | pattern_matching:tagdetails_ratiolesserthan05matchfulltrue/row_key/   | ida/hbasePayloads/HBASE_Data/Hbase_employee_insertRow_tagdetails_ratiolesserthan05matchfulltrue.xml           | 200           |                  |          |

  Scenario Outline:Policy1:Create root tag and sub tag for HDFS CSV Anlayzer and Update policy tags for CsvAnalyzer
    And sync the test execution for "20" seconds
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                                       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | tags/Default/structures | ida/hbasePayloads/API/PolicyEngine/Hbase_TagStructure.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions  | ida/hbasePayloads/API/PolicyEngine/Hbase_policy1.json      | 204           |                  |          |


  Scenario: SC4#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSource_ResolveClusterTRUE.json" file for following values using property loader
      | jsonPath                                            | jsonValues      |
      | $.configurations..hbaseRestUrl                      | HBaseUri        |
      | $.configurations..clusterManager.clusterManagerHost | clusterHostName |


  Scenario Outline: SC4#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                                        | response code | response message             | jsonPath                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HBaseDataSource                                                          | ida/hbasePayloads/DataSource/hbasedbValidDataSource_ResolveClusterTRUE.json | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HBaseDataSource                                                          |                                                                             | 200           | HbaseDataSource_Valid        |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseCataloger                                                           | ida/hbasePayloads/Cataloger/HBaseCataloger_PolicyPattern_Configuration.json | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseCataloger                                                           |                                                                             | 200           | PolicyPattern_HbaseCataloger |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/PolicyPattern_HbaseCataloger |                                                                             | 200           | IDLE                         | $.[?(@.configurationName=='PolicyPattern_HbaseCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/HBaseCataloger/PolicyPattern_HbaseCataloger  |                                                                             | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/PolicyPattern_HbaseCataloger |                                                                             | 200           | IDLE                         | $.[?(@.configurationName=='PolicyPattern_HbaseCataloger')].status |


  Scenario: SC4#-MLP_24889_Update the plugin name and tag name
    And user "update" the json file "ida/hbasePayloads/Analyzer/HBaseAnalyzer_Configuration.json" file for following values
      | jsonPath                           | jsonValues                  | type    |
      | $.configurations..nodeCondition    | name=="LocalNode"           |         |
      | $.configurations..name             | HbaseAnalyzer_policyPattern |         |
      | $.configurations..tags[*]          | HbaseAnalyzer_policyPattern |         |
      | $.configurations..histogramBuckets | 10                          | Integer |
      | $.configurations..sampleSize       | 25                          | Integer |
      | $.configurations..topValues        | 10                          | Integer |
      | $.configurations..autoStart        | false                       | boolean |
      | $.configurations..dryRun           | false                       | boolean |

    #7170442
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC4#-MLP_24889_Verify HBaseAnalyzer does data sampling/data profiling properly for HBase tables when manual triggering of analyzer is done.- (Hdfscataloger having cluster resolution:True)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                          | body                                                        | response code | response message            | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseAnalyzer                                                             | ida/hbasePayloads/Analyzer/HBaseAnalyzer_Configuration.json | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseAnalyzer                                                             |                                                             | 200           | HbaseAnalyzer_policyPattern |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/HBaseAnalyzer/HbaseAnalyzer_policyPattern |                                                             | 200           | IDLE                        | $.[?(@.configurationName=='HbaseAnalyzer_policyPattern')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/HBaseAnalyzer/HbaseAnalyzer_policyPattern  |                                                             | 200           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/HBaseAnalyzer/HbaseAnalyzer_policyPattern |                                                             | 200           | IDLE                        | $.[?(@.configurationName=='HbaseAnalyzer_policyPattern')].status |

    #7203404,7203430,7203432,7203435,7203438,7203439,7203440,7203447,7203534,7203559,7203561
  @positve @regression @sanity  @PIITag
  Scenario:SC11#MLP_26807_Verify PIItags for Hbase Table columns ,typePattern can be set as:VARCHAR or .*VAR.*minimumRatio:0.5, Match Empty=false, Match Full=false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName     | TableName/Filename                          | Column               | Tags                      | Query                    | Action      |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:gender    | HBASE_GenderPII_SC1Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:SSN       | HBASE_SSNPII_SC1Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC1Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC1Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:email     | HBASE_EmailPII_SC1Tag     | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:email     | HBASE_EmailPII_SC1Tag     | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:SSN       | HBASE_SSNPII_SC1Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC1Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:email     | HBASE_EmailPII_SC1Tag     | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:gender    | HBASE_GenderPII_SC1Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC1Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:gender    | HBASE_GenderPII_SC1Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:SSN       | HBASE_SSNPII_SC1Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC1Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC1Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:email     | HBASE_EmailPII_SC1Tag     | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:gender    | HBASE_GenderPII_SC1Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:SSN       | HBASE_SSNPII_SC1Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC1Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC1Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:email     | HBASE_EmailPII_SC1Tag     | ColumnQuerywithoutSchema | TagAssigned |

 ########Set the PIITags for Hbase Table columns , typePattern can be set as:  NUMBER or .*VAR1.* or .*FLOAT.* or .*NUM.*  minimumRatio:0.5#########

#7203431,7203434,7203436,7203437,7203441,7203442,7203443,7203444,7203445,7203446
  @positve @regression @sanity  @PIITag
  Scenario:SC12#MLP_26807_Verify PIITags not set for Hbase Table columns , typePattern can be set as:  NUMBER or .*VAR1.* or .*FLOAT.* or .*NUM.*  minimumRatio:0.5
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName     | TableName/Filename                          | Column               | Tags                      | Query                    | Action         |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:gender    | HBASE_GenderPII_SC2Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:SSN       | HBASE_SSNPII_SC2Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC2Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC2Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:email     | HBASE_EmailPII_SC2Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:email     | HBASE_EmailPII_SC2Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:SSN       | HBASE_SSNPII_SC2Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC2Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:email     | HBASE_EmailPII_SC2Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:gender    | HBASE_GenderPII_SC2Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC2Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:gender    | HBASE_GenderPII_SC2Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:SSN       | HBASE_SSNPII_SC2Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC2Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC2Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:email     | HBASE_EmailPII_SC2Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:gender    | HBASE_GenderPII_SC2Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:SSN       | HBASE_SSNPII_SC2Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC2Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC2Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:email     | HBASE_EmailPII_SC2Tag     | ColumnQuerywithoutSchema | TagNotAssigned |

###############PIITags for Hbase Table columns , namePattern can be set as:.*FULL.*,Tagdetails:IPADDRESS,Tagdetails:gender,.*Tagdetails:email.*,Tagdetails:SSN, minimumRatio:0.5################

    #7203404,7203430,7203432,7203435,7203438,7203439,7203440,7203447,7203534,7203559,7203561

  @positve @regression @sanity  @PIITag
  Scenario:SC13#MLP_26807_Verify PIITags for Hbase Table columns  , namePattern can be set as:.*FULL.*,.*IP.*,Tagdetails:gender,.*Tagdetails:email.*,Tagdetails:SSN.*, minimumRatio:0.5
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName     | TableName/Filename                          | Column               | Tags                      | Query                    | Action      |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:gender    | HBASE_GenderPII_SC3Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:SSN       | HBASE_SSNPII_SC3Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC3Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC3Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:email     | HBASE_EmailPII_SC3Tag     | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:email     | HBASE_EmailPII_SC3Tag     | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:SSN       | HBASE_SSNPII_SC3Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC3Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:email     | HBASE_EmailPII_SC3Tag     | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:gender    | HBASE_GenderPII_SC3Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC3Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:gender    | HBASE_GenderPII_SC3Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:SSN       | HBASE_SSNPII_SC3Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC3Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC3Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:email     | HBASE_EmailPII_SC3Tag     | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:gender    | HBASE_GenderPII_SC3Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:SSN       | HBASE_SSNPII_SC3Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC3Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC3Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:email     | HBASE_EmailPII_SC3Tag     | ColumnQuerywithoutSchema | TagAssigned |


###########PIITags for Hbase Table columns , namePattern set as: .*F1ULL.*,IP1,1Tagdetails:gender,.*EM1AIL.*,Tagdetails:SSN11.*, minimumRatio:0.5###################

#7203431,7203434,7203436,7203437,7203441,7203442,7203443,7203444,7203445,7203446
  @positve @regression @sanity  @PIITag
  Scenario:SC14#MLP_26807_Verify PIItags not set for Hbase Table columns , namePattern set as: .*F1ULL.*,IP1,1Tagdetails:gender,.*EM1AIL.*,Tagdetails:SSN11.*, minimumRatio:0.5
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName     | TableName/Filename                          | Column               | Tags                      | Query                    | Action         |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:gender    | HBASE_GenderPII_SC4Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:SSN       | HBASE_SSNPII_SC4Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC4Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC4Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:email     | HBASE_EmailPII_SC4Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:email     | HBASE_EmailPII_SC4Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:SSN       | HBASE_SSNPII_SC4Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC4Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:email     | HBASE_EmailPII_SC4Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:gender    | HBASE_GenderPII_SC4Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC4Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:gender    | HBASE_GenderPII_SC4Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:SSN       | HBASE_SSNPII_SC4Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC4Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC4Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:email     | HBASE_EmailPII_SC4Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:gender    | HBASE_GenderPII_SC4Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:SSN       | HBASE_SSNPII_SC4Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC4Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC4Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:email     | HBASE_EmailPII_SC4Tag     | ColumnQuerywithoutSchema | TagNotAssigned |


    #######Set the PIITags for Hbase Table columns , valid name and type pattern minimumRatio:0.2#######################

    #7203404,7203430,7203432,7203435,7203438,7203439,7203440,7203447,7203534,7203559,7203561

  Scenario:SC15#MLP_26807_Verify PIITags for Hbase Table columns , valid name and type pattern minimumRatio:0.2
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName     | TableName/Filename                   | Column               | Tags                      | Query                    | Action      |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse | Tagdetails:gender    | HBASE_GenderPII_SC5Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse | Tagdetails:SSN       | HBASE_SSNPII_SC5Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC5Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC5Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse | Tagdetails:email     | HBASE_EmailPII_SC5Tag     | ColumnQuerywithoutSchema | TagAssigned |

    ###########Set the PIItags for Hbase Table columns , minimumRatio:0.6 matchfull false and matchempty true###############

    #7203404,7203430,7203432,7203435,7203438,7203439,7203440,7203447,7203534,7203559,7203561

  Scenario:SC16#MLP_26807_Verify PIItags for Hbase Table columns , minimumRatio:0.6 matchfull false and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName     | TableName/Filename                          | Column               | Tags                      | Query                    | Action      |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC6Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:email     | HBASE_EmailPII_SC6Tag     | ColumnQuerywithoutSchema | TagAssigned |

    #7203431,7203434,7203436,7203437,7203441,7203442,7203443,7203444,7203445,7203446

  Scenario:SC17#MLP_26807_Verify PIItags not set for Hbase Table columns , minimumRatio:0.6 matchfull false and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName     | TableName/Filename                          | Column            | Tags                   | Query                    | Action         |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:gender | HBASE_GenderPII_SC6Tag | ColumnQuerywithoutSchema | TagNotAssigned |


      ###############Set the PIItags for Hbase Table columns , minimumRatio:1 matchfull false and matchempty false#####################

    #7203404,7203430,7203432,7203435,7203438,7203439,7203440,7203447,7203534,7203559,7203561

  Scenario:SC18#MLP_26807_Verify PIItags for Hbase Table columns , minimumRatio:1 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName     | TableName/Filename  | Column               | Tags                      | Query                    | Action      |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch | Tagdetails:gender    | HBASE_GenderPII_SC8Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch | Tagdetails:SSN       | HBASE_SSNPII_SC8Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC8Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC8Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch | Tagdetails:email     | HBASE_EmailPII_SC8Tag     | ColumnQuerywithoutSchema | TagAssigned |


     ###############Set the PIItags for Hbase Table columns , minimumRatio:0.5 matchfull false and matchempty false#####################

#7203404,7203430,7203432,7203435,7203438,7203439,7203440,7203447,7203534,7203559,7203561

  Scenario:SC19#MLP_26807_Verify PIItags for Hbase Table columns , minimumRatio:0.5 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName     | TableName/Filename                  | Column               | Tags                      | Query                    | Action      |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse | Tagdetails:gender    | HBASE_GenderPII_SC9Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse | Tagdetails:SSN       | HBASE_SSNPII_SC9Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC9Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC9Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse | Tagdetails:email     | HBASE_EmailPII_SC9Tag     | ColumnQuerywithoutSchema | TagAssigned |


      ###############PIItags for Hbase Table columns , minimumRatio:0.2 matchfull false and matchempty false,namePattern can be set as:FULL.*,Tagdetails:IPADDRESS,Tagdetails:gender,.*MAIL,.*Tagdetails:SSN.*,#####################

   #7203404,7203430,7203432,7203435,7203438,7203439,7203440,7203447,7203534,7203559,7203561

  Scenario:SC20#MLP_26807_Verify PIItags for Hbase Table columns , minimumRatio:0.2 matchfull false and matchempty false,namePattern can be set as:FULL.*,Tagdetails:IPADDRESS,Tagdetails:gender,.*MAIL,.*Tagdetails:SSN.*
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName     | TableName/Filename                   | Column               | Tags                       | Query                    | Action      |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse | Tagdetails:gender    | HBASE_GenderPII_SC10Tag    | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse | Tagdetails:SSN       | HBASE_SSNPII_SC10Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC10Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC10Tag  | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse | Tagdetails:email     | HBASE_EmailPII_SC10Tag     | ColumnQuerywithoutSchema | TagAssigned |

  ######################PIITags for Hbase Table columns , namePattern set as: FULL1.*,IPAD1DRESS,Tagdetails:gender1,.*1MAIL,.*1Tagdetails:SSN.*, minimumRatio:0.2################################

#7203431,7203434,7203436,7203437,7203441,7203442,7203443,7203444,7203445,7203446

  @positve @regression @sanity  @PIITag
  Scenario:SC21#MLP_26807_Verify PIITags not set for Hbase Table columns , namePattern set as: FULL1.*,IPAD1DRESS,Tagdetails:gender1,.*1MAIL,.*1Tagdetails:SSN.*, minimumRatio:0.2
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName     | TableName/Filename                          | Column               | Tags                       | Query                    | Action         |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:gender    | HBASE_GenderPII_SC11Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:SSN       | HBASE_SSNPII_SC11Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC11Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC11Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:email     | HBASE_EmailPII_SC11Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:email     | HBASE_EmailPII_SC11Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:SSN       | HBASE_SSNPII_SC11Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC11Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:email     | HBASE_EmailPII_SC11Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:gender    | HBASE_GenderPII_SC11Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC11Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:gender    | HBASE_GenderPII_SC11Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:SSN       | HBASE_SSNPII_SC11Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC11Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC11Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:email     | HBASE_EmailPII_SC11Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:gender    | HBASE_GenderPII_SC11Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:SSN       | HBASE_SSNPII_SC11Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC11Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC11Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:email     | HBASE_EmailPII_SC11Tag     | ColumnQuerywithoutSchema | TagNotAssigned |



    ##############################PIItags for Hbase Table columns , name pattern (Invalid columns) minimumRatio:0.2 matchfull false and matchempty false##################

#7203431,7203434,7203436,7203437,7203441,7203442,7203443,7203444,7203445,7203446

  Scenario:SC22#MLP_26807_Verify PIITags not set for Hbase Table columns , name pattern (Invalid columns) minimumRatio:0.2 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName     | TableName/Filename                          | Column               | Tags                       | Query                    | Action         |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:gender    | HBASE_GenderPII_SC12Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:SSN       | HBASE_SSNPII_SC12Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC12Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC12Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:email     | HBASE_EmailPII_SC12Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:email     | HBASE_EmailPII_SC12Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:SSN       | HBASE_SSNPII_SC12Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC12Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:email     | HBASE_EmailPII_SC12Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:gender    | HBASE_GenderPII_SC12Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC12Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:gender    | HBASE_GenderPII_SC12Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:SSN       | HBASE_SSNPII_SC12Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC12Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC12Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:email     | HBASE_EmailPII_SC12Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:gender    | HBASE_GenderPII_SC12Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:SSN       | HBASE_SSNPII_SC12Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC12Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC12Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:email     | HBASE_EmailPII_SC12Tag     | ColumnQuerywithoutSchema | TagNotAssigned |

######################PIItags for Hbase Table columns , data pattern (Invalid regex) minimumRatio:0.2 matchfull false and matchempty false##################

#7203431,7203434,7203436,7203437,7203441,7203442,7203443,7203444,7203445,7203446

  Scenario:SC23#MLP_26807_Verify PIITags not set for Hbase Table columns , data pattern (Invalid regex) minimumRatio:0.2 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName     | TableName/Filename                          | Column               | Tags                       | Query                    | Action         |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:gender    | HBASE_GenderPII_SC13Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:SSN       | HBASE_SSNPII_SC13Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC13Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC13Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allmatch                         | Tagdetails:email     | HBASE_EmailPII_SC13Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:email     | HBASE_EmailPII_SC13Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:SSN       | HBASE_SSNPII_SC13Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty                         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC13Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:email     | HBASE_EmailPII_SC13Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:gender    | HBASE_GenderPII_SC13Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolessthan05emptyfalse        | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC13Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:gender    | HBASE_GenderPII_SC13Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:SSN       | HBASE_SSNPII_SC13Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC13Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC13Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:email     | HBASE_EmailPII_SC13Tag     | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:gender    | HBASE_GenderPII_SC13Tag    | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:SSN       | HBASE_SSNPII_SC13Tag       | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC13Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:FULL_NAME | HBASE_FullNamePII_SC13Tag  | ColumnQuerywithoutSchema | TagNotAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratioequalto05emptyfalse         | Tagdetails:email     | HBASE_EmailPII_SC13Tag     | ColumnQuerywithoutSchema | TagNotAssigned |



  #################PIItags for Hbase Table columns , minimumRatio:0.5 matchfull false and matchempty true###########################

   #7203404,7203430,7203432,7203435,7203438,7203439,7203440,7203447,7203534,7203559,7203561

  Scenario:SC24#MLP_26807_Verify PIItags for Hbase Table columns , minimumRatio:0.5 matchfull false and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName     | TableName/Filename  | Column               | Tags                       | Query                    | Action      |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty | Tagdetails:email     | HBASE_EmailPII_SC14Tag     | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty | Tagdetails:SSN       | HBASE_SSNPII_SC14Tag       | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_allempty | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC14Tag | ColumnQuerywithoutSchema | TagAssigned |

   #################PIItags for Hbase Table columns , minimumRatio:0.6 matchfull true and matchempty false###########################

#7203431,7203434,7203436,7203437,7203441,7203442,7203443,7203444,7203445,7203446

  Scenario:SC25#MLP_26807_Verify PIItags for Hbase Table columns , minimumRatio:0.6 matchfull true and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName     | TableName/Filename                         | Column              | Tags                      | Query                    | Action         |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05matchfulltrue | Tagdetails:Comments | HBASE_FullMatchPII_SC1Tag | ColumnQuerywithoutSchema | TagNotAssigned |

#################PIItags for Hbase Table columns , minimumRatio:0.2 matchfull true and matchempty false###########################

#7203431,7203434,7203436,7203437,7203441,7203442,7203443,7203444,7203445,7203446

  Scenario:SC26#MLP_26807_Verify PIItags for Hbase Table columns , minimumRatio:0.2 matchfull true and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName     | TableName/Filename                        | Column              | Tags                      | Query                    | Action         |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolesserthan05matchfulltrue | Tagdetails:Comments | HBASE_FullMatchPII_SC3Tag | ColumnQuerywithoutSchema | TagNotAssigned |

#############################################################################################################################################################################################
 ##########################################################Re-Run Scenario PII tags#####################################################################################
 #######################################################################################################################################################


  Scenario Outline:Policy2:Create root tag and sub tag for Hbase Analyzer and Update policy tags for Hbase Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | body                                                  | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions | ida/hbasePayloads/API/PolicyEngine/Hbase_policy2.json | 204           |                  |          |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC27#-MLP_26807_Verify Hbase Analyzer set PII tags for the re-run scenario
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                          | body | response code | response message | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/HBaseAnalyzer/HbaseAnalyzer_policyPattern |      | 200           | IDLE             | $.[?(@.configurationName=='HbaseAnalyzer_policyPattern')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/HBaseAnalyzer/HbaseAnalyzer_policyPattern  |      | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/HBaseAnalyzer/HbaseAnalyzer_policyPattern |      | 200           | IDLE             | $.[?(@.configurationName=='HbaseAnalyzer_policyPattern')].status |


     #################PIItags for Hbase Table columns , minimumRatio:0.6 matchfull true and matchempty false###########################

    #7203404,7203430,7203432,7203435,7203438,7203439,7203440,7203447,7203534,7203559,7203561

  Scenario:SC28#MLP_26807_Verify PIItags for Hbase Table columns , minimumRatio:0.6 matchfull true and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName     | TableName/Filename                         | Column              | Tags                      | Query                    | Action      |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05matchfulltrue | Tagdetails:Comments | HBASE_FullMatchPII_SC2Tag | ColumnQuerywithoutSchema | TagAssigned |

#################PIItags for Hbase Table columns , minimumRatio:0.2 matchfull true and matchempty false###########################

 #7203404,7203430,7203432,7203435,7203438,7203439,7203440,7203447,7203534,7203559,7203561

  Scenario:SC29#MLP_26807_Verify PIItags for Hbase Table columns , minimumRatio:0.2 matchfull true and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName     | TableName/Filename                        | Column              | Tags                      | Query                    | Action      |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiolesserthan05matchfulltrue | Tagdetails:Comments | HBASE_FullMatchPII_SC4Tag | ColumnQuerywithoutSchema | TagAssigned |


    ###############Set the PIItags for Hbase Table columns , minimumRatio:0.6 matchfull true and matchempty true#####################

 #7203404,7203430,7203432,7203435,7203438,7203439,7203440,7203447,7203534,7203559,7203561

  Scenario:SC30#MLP_26807_Verify PIItags for Hbase Table columns , minimumRatio:0.6 matchfull true and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName     | TableName/Filename                          | Column               | Tags                      | Query                    | Action      |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:IPADDRESS | HBASE_IPAddressPII_SC7Tag | ColumnQuerywithoutSchema | TagAssigned |
      | Sandbox     | HBASE       | pattern_matching | tagdetails_ratiogreaterthan05emptyfalsetrue | Tagdetails:email     | HBASE_EmailPII_SC7Tag     | ColumnQuerywithoutSchema | TagAssigned |

  @positve @regression @sanity  @ambari
  Scenario:Pre-Condition:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/HBaseAnalyzer/% | Analysis |       |       |
      | SingleItemDelete | Default | Sandbox                      | Cluster  |       |       |
      | SingleItemDelete | Default | Sandbox                      | Cluster  |       |       |
      | SingleItemDelete | Default | Cluster 1                    | Cluster  |       |       |
      | SingleItemDelete | Default | LocalNode                    | Cluster  |       |       |

     #################### Deleting the credentials , Data Source & Bussiness Application######################


  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline:SC9:MLP-24886:Deleting the Credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                                | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/hbaseDBValidCredential                                        |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HBaseDataSource                                                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HBaseCataloger                                                  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HBaseAnalyzer                                                   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | policy/tagging/analysis?dataType=STRUCTURED&pluginName=HBaseAnalyzer&technologies= |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | /tags/Default/tags/HBASE_PII                                                       |      | 204           |                  |          |
#
  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario:SC9:Delete Bussiness Application
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name              | type                | query | param |
      | SingleItemDelete | Default | HBASE_BA          | BusinessApplication |       |       |
      | SingleItemDelete | Default | HBASE_BA_ANALYZER | BusinessApplication |       |       |


    #############################################Delete data in HBASE#############################################################

  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC7#-MLP_24886_Delete the tables from HBASE
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser | Header   | Query | Param | type   | url                                                                 | body | response code | response message | jsonPath |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | pattern_matching:tagdetails_allempty/schema                         |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | pattern_matching:tagdetails_allmatch/schema                         |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | pattern_matching:tagdetails_ratiolessthan05emptyfalse/schema        |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | pattern_matching:tagdetails_ratiogreaterthan05emptyfalsetrue/schema |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | pattern_matching:tagdetails_ratioequalto05emptyfalse/schema         |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | pattern_matching:tagdetails_ratiogreaterthan05matchfulltrue/schema  |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | pattern_matching:tagdetails_ratiolesserthan05matchfulltrue/schema   |      | 200           |                  |          |

    ############################### STOP HBASE service############################################################

  @MLP-7802 @sanity @positive @regression @hbase @ambari
  Scenario: Configuring and Stop HBase REST server
    Given user connects to the sftp server and run the "STOP_HBASE" command
