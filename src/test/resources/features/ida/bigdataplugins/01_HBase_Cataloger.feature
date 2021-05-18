Feature: MLP-7802 Implementation of Hbase Cataloger


#############################################Pre-condition###################################################

  Scenario:Pre-Condition:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo               | Cluster  |       |       |
      | SingleItemDelete | Default | Sandbox                    | Cluster  |       |       |


  ########################################## Tool Tip validation #################################################

#7132315
  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC2#Get the HBASE Cataloger and DataSource Configuration response
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                               | body                                | response code | response message | filePath                              | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | /schemes/analyzers/configurations | response/HBASE/body/ToolTip.json    | 200           |                  | response/HBASE/actual/ToolTip.json    |          |
      | IDC         | TestSystem | application/json |       |       | Post | /schemes/analyzers/configurations | response/HBASE/body/ToolTip_DS.json | 200           |                  | response/HBASE/actual/ToolTip_DS.json |          |


   #7132315
  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline:SC2# Validate ToolTip for all the fields in HBASE Db Datasource plugin(HBASEDataSourceType,Name,PluginVersion,label,Credential,hbaseRestUrl,PoresolveClusterNamert,clusterManager,clusterManagerName,clusterManagerHost,clusterManagerPort,clusterManagerApiVersion)
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                       | actualValues                          | valueType     | expectedJsonPath                                      | actualJsonPath                                                  |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hbase.hbaseDataSourceType.tooltip      | $.properties[0].value.prototype.properties[0].tooltip           |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip_DS.json | stringCompare | $.Commonfields.Name.tooltip                           | $.properties[0].value.prototype.properties[1].tooltip           |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip_DS.json | stringCompare | $.Commonfields.pluginVersion.tooltip                  | $.properties[0].value.prototype.properties[2].tooltip           |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip_DS.json | stringCompare | $.Commonfields.label.tooltip                          | $.properties[0].value.prototype.properties[3].tooltip           |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip_DS.json | stringCompare | $.Commonfields.credential.tooltip                     | $.properties[0].value.prototype.properties[13].tooltip          |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hbase.hbaseRestUrl.tooltip             | $.properties[0].value.prototype.properties[15].tooltip          |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hbase.resolveClusterName.tooltip       | $.properties[0].value.prototype.properties[16].tooltip          |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hbase.clusterManager.tooltip           | $.properties[0].value.prototype.properties[17].tooltip          |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hbase.clusterManagerName.tooltip       | $.properties[0].value.prototype.properties[17].value[0].tooltip |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hbase.clusterManagerHost.tooltip       | $.properties[0].value.prototype.properties[17].value[1].tooltip |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hbase.clusterManagerPort.tooltip       | $.properties[0].value.prototype.properties[17].value[2].tooltip |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hbase.clusterManagerApiVersion.tooltip | $.properties[0].value.prototype.properties[17].value[3].tooltip |


        #7157351
  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline:SC2# Validate ToolTip for all the fields in HBASE Db Cataloger plugin(Type,Plugin,Name,Plugin version,label,BA, Data Source, Credential,Event Condition,Dry Run, Event class,Max Work sixe,node condition,Auto Start,tags,Unique Filter)
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                       | actualValues                       | valueType     | expectedJsonPath                               | actualJsonPath                                                  |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Commonfields..[?(@.label=='Type')].tooltip   | $..[?(@.label=='Type')].tooltip                                 |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Commonfields..[?(@.label=='Plugin')].tooltip | $..[?(@.label=='Plugin')].tooltip                               |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Commonfields.Name.tooltip                    | $.properties[0].value.prototype.properties[2].tooltip           |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Commonfields.pluginVersion.tooltip           | $.properties[0].value.prototype.properties[3].tooltip           |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Commonfields.label.tooltip                   | $.properties[0].value.prototype.properties[4].tooltip           |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Commonfields.businessApplicationName.tooltip | $.properties[0].value.prototype.properties[17].tooltip          |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Commonfields.dataSource.tooltip              | $.properties[0].value.prototype.properties[14].tooltip          |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Commonfields.credential.tooltip              | $.properties[0].value.prototype.properties[16].tooltip          |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Commonfields.eventCondition.tooltip          | $.properties[0].value.prototype.properties[5].tooltip           |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Commonfields.dryRun.tooltip                  | $.properties[0].value.prototype.properties[6].tooltip           |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Commonfields.eventClass.tooltip              | $.properties[0].value.prototype.properties[7].tooltip           |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Commonfields.maxWorkSize.tooltip             | $.properties[0].value.prototype.properties[8].tooltip           |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Commonfields.nodeCondition.tooltip           | $.properties[0].value.prototype.properties[10].tooltip          |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Commonfields.autoStart.tooltip               | $.properties[0].value.prototype.properties[11].tooltip          |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Commonfields.tags.tooltip                    | $.properties[0].value.prototype.properties[12].tooltip          |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Uniquefilter.hbase.scanRows.tooltip          | $.properties[0].value.prototype.properties[18].tooltip          |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Uniquefilter.hbase.scanRows.value            | $.properties[0].value.prototype.properties[18].value            |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Uniquefilter.hbase.includeItems.tooltip      | $.properties[0].value.prototype.properties[19].tooltip          |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Uniquefilter.hbase.includeNamespaces.tooltip | $.properties[0].value.prototype.properties[19].value[0].tooltip |
      | response/HBASE/expected/ToolTip.json | response/HBASE/actual/ToolTip.json | stringCompare | $.Uniquefilter.hbase.includeTables.tooltip     | $.properties[0].value.prototype.properties[19].value[1].tooltip |

  ############## setting the Credentials, BA , Data Source and Cataloger###################

  Scenario: SC2#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                       | jsonValues |
      | $.configurations..hbaseRestUrl | HBaseUri   |


  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC2#-MLP_24886_Set the Credentials, Datasource, Bussiness Application and Cataloger for HBASEDB Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                           | body                                                              | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hbaseDBValidCredential   | ida/hbasePayloads/Credentials/hbasedbValidCredentials.json        | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hbaseDBInValidCredential | ida/hbasePayloads/Credentials/hbasedbInValidCredentials.json      | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hbaseDBEmptyCredential   | ida/hbasePayloads/Credentials/hbasedbEmptyCredentials.json        | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hbaseDBValidCredential   |                                                                   | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hbaseDBInValidCredential |                                                                   | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hbaseDBEmptyCredential   |                                                                   | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root                            | ida\hbasePayloads\Bussiness_Application\BussinessApplication.json | 200           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/license                              | ida\hbasePayloads\DataSource\license_DS.json                      | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HBaseDataSource            | ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json    | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HBaseDataSource            |                                                                   | 200           | HbaseDataSource_Valid |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HBaseCataloger             | ida/hbasePayloads/Cataloger/hbasedbValidCatalogerConfig.json      | 204           |                       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HBaseCataloger             |                                                                   | 200           | HBaseCataloger_Valid  |          |


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


   ######################################Data Source mandatory field error validation#####################################

  #7132316
  @MLP-24196 @webtest @regression @positive
  Scenario:SC3#MLP_24196_Verify proper error message is thrown in UI if Sample Name field values are not provided within valid range in HbaseDB data source
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | HBaseDataSource        |
#      | Plugin version   | LATEST                 |
      | Credential       | hbaseDBValidCredential |
      | Deployment       | LocalNode              |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  | HbaseDataSource_Valid  |
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
      | pluginConfigFieldName   | pluginConfigFieldValue |
      | HBase Rest API base URL |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName               | errorMessage                                      |
      | HBase Rest API base URL | HBase Rest API base URL field should not be empty |


  ######################################Data Source connection invalid URL#####################################
#7132308
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for HbaseDb DataSource with valid credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | HBaseDataSource        |
#      | Plugin version   | LATEST                 |
      | Credential       | hbaseDBValidCredential |
      | Deployment       | LocalNode              |
    And user "enter text" in Add Data Source Page
      | fieldName               | attribute                 |
      | Name                    | HBaseDataSource           |
      | Label                   | HBaseDataSource           |
      | HBase Rest API base URL | http://10.33.10.145:2100/ |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"


  ######################################Data Source connection invalid host (HORTONWORKS)#####################################
#7132311
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for HbaseDb DataSource with valid credentials , resolve cluster true and Invalid hostname
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | HBaseDataSource        |
#      | Plugin version   | LATEST                 |
      | Credential       | hbaseDBValidCredential |
      | Deployment       | LocalNode              |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "click" on "field" button in "Cluster name configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       | pageName       |
      | Name                        | HBaseDataSource |                |
      | Label                       | HBaseDataSource |                |
      | HBase Rest API base URL     | HBaseUri        | PropertyLoader |
      | Cluster manager hostname    | 35              |                |
      | Cluster manager port        | 8080            |                |
      | Cluster manager API version | api/v1          |                |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

 ######################################Data Source connection invalid Port (HORTONWORKS)#####################################
#7132311 Now it is passing
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for HbaseDb DataSource with valid credentials , resolve cluster true and Invalid Port
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | HBaseDataSource        |
#      | Plugin version   | LATEST                 |
      | Credential       | hbaseDBValidCredential |
      | Deployment       | LocalNode              |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "click" on "field" button in "Cluster name configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       | pageName       |
      | Name                        | HBaseDataSource |                |
      | Label                       | HBaseDataSource |                |
      | HBase Rest API base URL     | HBaseUri        | PropertyLoader |
      | Cluster manager hostname    | clusterHostName | PropertyLoader |
      | Cluster manager port        | 75              |                |
      | Cluster manager API version | api/v1          |                |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

######################################Data Source connection invalid cluster manger API (HORTONWORKS)#####################################
#7132311
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for HbaseDb DataSource with valid credentials , resolve cluster true and Invalid Cluster manager API
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | HBaseDataSource        |
#      | Plugin version   | LATEST                 |
      | Credential       | hbaseDBValidCredential |
      | Deployment       | LocalNode              |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "click" on "field" button in "Cluster name configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       | pageName       |
      | Name                        | HBaseDataSource |                |
      | Label                       | HBaseDataSource |                |
      | HBase Rest API base URL     | HBaseUri        | PropertyLoader |
      | Cluster manager hostname    | clusterHostName | PropertyLoader |
      | Cluster manager port        | 8080            |                |
      | Cluster manager API version | api/v12         |                |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

# ######################################Data Source connection invalid host (CLOUDERA)#####################################
##7130020 Now it is passing
#  @MLP-24196 @webtest @regression @positive
#  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for HbaseDb DataSource with valid credentials , resolve cluster true and Invalid hostname in CLOUDERA
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem          |
#      | click      | Settings Icon       |
#      | click      | Manage Data Sources |
#    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName        | attribute              |
#      | Data Source Type | HBaseDataSource        |
#      | Plugin version   | LATEST                 |
#      | Credential       | hbaseDBValidCredential |
#      | Deployment       | LocalNode              |
#    And user "click" on "slide bar" button in "resolveClusterName"
#    And user "click" on "field" button in "Cluster name configuration settings"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName            | attribute |
#      | Cluster manager name | CLOUDERA  |
#    And user "enter text" in Add Data Source Page
#      | fieldName                   | attribute                 |
#      | Name                        | HBaseDataSource           |
#      | Label                       | HBaseDataSource           |
#      | HBase Rest API base URL     | http://10.33.10.138:2100/ |
#      | Cluster manager hostname    | 35                        |
#      | Cluster manager port        | 8080                      |
#      | Cluster manager API version | api/v1                    |
#    And user "click" on "Test Connection" button in "Add Data Sources pop up"
#    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
#
# ######################################Data Source connection invalid Port (CLOUDERA)#####################################
##7130020 Now it is passing
#  @MLP-24196 @webtest @regression @positive
#  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for HbaseDb DataSource with valid credentials , resolve cluster true and Invalid Port in CLOUDERA
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem          |
#      | click      | Settings Icon       |
#      | click      | Manage Data Sources |
#    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName        | attribute              |
#      | Data Source Type | HBaseDataSource        |
#      | Plugin version   | LATEST                 |
#      | Credential       | hbaseDBValidCredential |
#      | Deployment       | LocalNode              |
#    And user "click" on "slide bar" button in "resolveClusterName"
#    And user "click" on "field" button in "Cluster name configuration settings"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName            | attribute |
#      | Cluster manager name | CLOUDERA  |
#    And user "enter text" in Add Data Source Page
#      | fieldName                   | attribute                 |
#      | Name                        | HBaseDataSource           |
#      | Label                       | HBaseDataSource           |
#      | HBase Rest API base URL     | http://10.33.10.138:2100/ |
#      | Cluster manager hostname    | 10.33.10.138              |
#      | Cluster manager port        | 75                        |
#      | Cluster manager API version | api/v1                    |
#    And user "click" on "Test Connection" button in "Add Data Sources pop up"
#    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

#######################################Data Source connection invalid cluster manger API (HORTONWORKS)#####################################
##7130020
#  @MLP-24196 @webtest @regression @positive
#  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for HbaseDb DataSource with valid credentials , resolve cluster true and Invalid Cluster manager API in CLOUDERA
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem          |
#      | click      | Settings Icon       |
#      | click      | Manage Data Sources |
#    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName        | attribute              |
#      | Data Source Type | HBaseDataSource        |
#      | Plugin version   | LATEST                 |
#      | Credential       | hbaseDBValidCredential |
#      | Deployment       | LocalNode              |
#    And user "click" on "slide bar" button in "resolveClusterName"
#    And user "click" on "field" button in "Cluster name configuration settings"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName            | attribute |
#      | Cluster manager name | CLOUDERA  |
#    And user "enter text" in Add Data Source Page
#      | fieldName                   | attribute                 |
#      | Name                        | HBaseDataSource           |
#      | Label                       | HBaseDataSource           |
#      | HBase Rest API base URL     | http://10.33.10.138:2100/ |
#      | Cluster manager hostname    | 10.33.10.138              |
#      | Cluster manager port        | 8080                      |
#      | Cluster manager API version | api/v12                   |
#    And user "click" on "Test Connection" button in "Add Data Sources pop up"
#    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

######################################Data Source connection empty resolve cluster fields(HORTONWORKS)#####################################
#7132314
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for HbaseDb DataSource with valid credentials , resolve cluster true and empty resolve cluster fields - HORTONWORKS
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | HBaseDataSource        |
#      | Plugin version   | LATEST                 |
      | Credential       | hbaseDBValidCredential |
      | Deployment       | LocalNode              |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "click" on "field" button in "Cluster name configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       | pageName       |
      | Name                        | HBaseDataSource |                |
      | Label                       | HBaseDataSource |                |
      | HBase Rest API base URL     | HBaseUri        | PropertyLoader |
      | Cluster manager hostname    |                 |                |
      | Cluster manager port        |                 |                |
      | Cluster manager API version |                 |                |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

  ######################################Data Source connection valid Cluster resolve settings invalid credentials#####################################
#7132310
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for HbaseDb DataSource with Invalid credentials and valid URL
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute                |
      | Data Source Type | HBaseDataSource          |
#      | Plugin version   | LATEST                   |
      | Credential       | hbaseDBInValidCredential |
      | Deployment       | LocalNode                |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "click" on "field" button in "Cluster name configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       | pageName       |
      | Name                        | HBaseDataSource |                |
      | Label                       | HBaseDataSource |                |
      | HBase Rest API base URL     | HBaseUri        | PropertyLoader |
      | Cluster manager hostname    | clusterHostName | PropertyLoader |
      | Cluster manager port        | 8080            |                |
      | Cluster manager API version | api/v1          |                |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

      ######################################Data Source connection valid Cluster resolve settings invalid credentials(Cluster Demo)#####################################
#7136161
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for HbaseDb DataSource with Invalid credentials and valid URL-Cluster demo
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute                |
      | Data Source Type | HBaseDataSource          |
#      | Plugin version   | LATEST                   |
      | Credential       | hbaseDBInValidCredential |
      | Deployment       | Cluster Demo             |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "click" on "field" button in "Cluster name configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       | pageName       |
      | Name                        | HBaseDataSource |                |
      | Label                       | HBaseDataSource |                |
      | HBase Rest API base URL     | HBaseUri        | PropertyLoader |
      | Cluster manager hostname    | clusterHostName | PropertyLoader |
      | Cluster manager port        | 8080            |                |
      | Cluster manager API version | api/v1          |                |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

     ######################################Data Source connection valid Cluster resolve settings empty credentials#####################################
#7132308
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for HbaseDb DataSource with empty credentials and valid URL
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | HBaseDataSource        |
#      | Plugin version   | LATEST                 |
      | Credential       | hbaseDBEmptyCredential |
      | Deployment       | LocalNode              |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "click" on "field" button in "Cluster name configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       | pageName       |
      | Name                        | HBaseDataSource |                |
      | Label                       | HBaseDataSource |                |
      | HBase Rest API base URL     | HBaseUri        | PropertyLoader |
      | Cluster manager hostname    | clusterHostName | PropertyLoader |
      | Cluster manager port        | 8080            |                |
      | Cluster manager API version | api/v1          |                |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"


  ######################################Data Source connection valid Cluster resolve settings valid credentials#####################################
#7132309
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is success for HbaseDb DataSource with valid credentials and valid URL
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | HBaseDataSource        |
#      | Plugin version   | LATEST                 |
      | Credential       | hbaseDBValidCredential |
      | Deployment       | LocalNode              |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "click" on "field" button in "Cluster name configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       | pageName       |
      | Name                        | HBaseDataSource |                |
      | Label                       | HBaseDataSource |                |
      | HBase Rest API base URL     | HBaseUri        | PropertyLoader |
      | Cluster manager hostname    | clusterHostName | PropertyLoader |
      | Cluster manager port        | 8080            |                |
      | Cluster manager API version | api/v1          |                |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"


         ######################################Data Source connection valid Cluster resolve settings valid credentials(Cluster Demo)#####################################
#7136162
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is success for HbaseDb DataSource with valid credentials and valid URL
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | HBaseDataSource        |
#      | Plugin version   | LATEST                 |
      | Credential       | hbaseDBValidCredential |
      | Deployment       | Cluster Demo           |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "click" on "field" button in "Cluster name configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       | pageName       |
      | Name                        | HBaseDataSource |                |
      | Label                       | HBaseDataSource |                |
      | HBase Rest API base URL     | HBaseUri        | PropertyLoader |
      | Cluster manager hostname    | clusterHostName | PropertyLoader |
      | Cluster manager port        | 8080            |                |
      | Cluster manager API version | api/v1          |                |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"

     ######################################Data Source connection valid credentials (Cluster Demo)#####################################
#7136163
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is success for HbaseDb DataSource with valid credentials with cluster demo
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | HBaseDataSource        |
#      | Plugin version   | LATEST                 |
      | Credential       | hbaseDBValidCredential |
      | Deployment       | Cluster Demo           |
    And user "enter text" in Add Data Source Page
      | fieldName               | attribute       | pageName       |
      | Name                    | HBaseDataSource |                |
      | Label                   | HBaseDataSource |                |
      | HBase Rest API base URL | HBaseUri        | PropertyLoader |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"



  ######################################Data Source connection valid credentials#####################################
#7132304
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is success for HbaseDb DataSource with valid credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | HBaseDataSource        |
#      | Plugin version   | LATEST                 |
      | Credential       | hbaseDBValidCredential |
      | Deployment       | LocalNode              |
    And user "enter text" in Add Data Source Page
      | fieldName               | attribute       | pageName       |
      | Name                    | HBaseDataSource |                |
      | Label                   | HBaseDataSource |                |
      | HBase Rest API base URL | HBaseUri        | PropertyLoader |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"
   ######################################Data Source connection Invalid credentials#####################################
#7132305
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is success for HbaseDb DataSource with Invalid credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute                |
      | Data Source Type | HBaseDataSource          |
#      | Plugin version   | LATEST                   |
      | Credential       | hbaseDBInValidCredential |
      | Deployment       | LocalNode                |
    And user "enter text" in Add Data Source Page
      | fieldName               | attribute       | pageName       |
      | Name                    | HBaseDataSource |                |
      | Label                   | HBaseDataSource |                |
      | HBase Rest API base URL | HBaseUri        | PropertyLoader |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"

    ######################################Data Source connection Empty credentials#####################################
#7132307
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is success for HbaseDb DataSource with Empty credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | HBaseDataSource        |
#      | Plugin version   | LATEST                 |
      | Credential       | hbaseDBEmptyCredential |
      | Deployment       | LocalNode              |
    And user "enter text" in Add Data Source Page
      | fieldName               | attribute       | pageName       |
      | Name                    | HBaseDataSource |                |
      | Label                   | HBaseDataSource |                |
      | HBase Rest API base URL | HBaseUri        | PropertyLoader |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"


     ######################################HBase cataloger successfull connection with valid DS(cluster resolve FALSE) valid credentials#####################################

  #7148930
  @MLP-24196 @webtest @regression @positive
  Scenario:SC3#MLP_24196_Verify HBase cataloger connection succes with valid Data Source with cluster resolve False
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute      |
      | Type      | Cataloger      |
      | Plugin    | HBaseCataloger |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName      | attribute              |
      | Plugin version | LATEST                 |
      | Credential     | hbaseDBValidCredential |
      | Data Source    | HbaseDataSource_Valid  |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName  | pluginConfigFieldValue |
      | Name                   | HbaseCataloger         |
      | Namespace Include Name | NS                     |
      | Tables Include Name    | Table1                 |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"

         ######################################HBase cataloger successfull connection with valid DS(cluster resolve FALSE) Empty credentials#####################################

#7148929
  @MLP-24196 @webtest @regression @positive
  Scenario:SC3#MLP_24196_Verify HBase cataloger connection succes with valid Data Source, Empty credentials with cluster resolve False
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute      |
      | Type      | Cataloger      |
      | Plugin    | HBaseCataloger |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName      | attribute              |
      | Plugin version | LATEST                 |
      | Credential     | hbaseDBEmptyCredential |
      | Data Source    | HbaseDataSource_Valid  |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName  | pluginConfigFieldValue |
      | Name                   | HbaseCataloger         |
      | Namespace Include Name | NS                     |
      | Tables Include Name    | Table1                 |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"

  ######################################HBase cataloger successfull connection with valid DS(cluster resolve FALSE) Invalid credentials#####################################

#7148928
  @MLP-24196 @webtest @regression @positive
  Scenario:SC3#MLP_24196_Verify HBase cataloger connection succes with valid Data Source, Invalid credentials with cluster resolve False
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute      |
      | Type      | Cataloger      |
      | Plugin    | HBaseCataloger |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName      | attribute                |
      | Plugin version | LATEST                   |
      | Credential     | hbaseDBInValidCredential |
      | Data Source    | HbaseDataSource_Valid    |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName  | pluginConfigFieldValue |
      | Name                   | HbaseCataloger         |
      | Namespace Include Name | NS                     |
      | Tables Include Name    | Table1                 |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"

  ######################################HBase cataloger failure connection with Invalid DS(cluster resolve FALSE) Empty credentials#####################################

  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC3#-MLP_24886_Set Invalid HBASEDB Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                | body                                                             | response code | response message        | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/license                   | ida\hbasePayloads\DataSource\license_DS.json                     | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HBaseDataSource | ida/hbasePayloads/DataSource/hbasedbInValidDataSourceConfig.json | 204           |                         |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HBaseDataSource |                                                                  | 200           | HbaseDataSource_InValid |          |

#7148927
  @MLP-24196 @webtest @regression @positive
  Scenario:SC3#MLP_24196_Verify HBase cataloger connection is not succes with Invalid Data Source, valid credentials with cluster resolve False
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute      |
      | Type      | Cataloger      |
      | Plugin    | HBaseCataloger |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName      | attribute               |
      | Plugin version | LATEST                  |
      | Credential     | hbaseDBValidCredential  |
      | Data Source    | HbaseDataSource_InValid |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName  | pluginConfigFieldValue |
      | Name                   | HbaseCataloger         |
      | Namespace Include Name | NS                     |
      | Tables Include Name    | Table1                 |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

      ######################################HBase cataloger successfull connection with valid DS(cluster resolve TRUE) Valid credentials#####################################


  Scenario: SC3#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSource_ResolveClusterTRUE.json" file for following values using property loader
      | jsonPath                                            | jsonValues      |
      | $.configurations..hbaseRestUrl                      | HBaseUri        |
      | $.configurations..clusterManager.clusterManagerHost | clusterHostName |


  Scenario Outline: SC3#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                | body                                                                        | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/HBaseDataSource | ida/hbasePayloads/DataSource/hbasedbValidDataSource_ResolveClusterTRUE.json | 204           |                       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/HBaseDataSource |                                                                             | 200           | HbaseDataSource_Valid |          |

    #7148926
  @MLP-24196 @webtest @regression @positive
  Scenario:SC3#MLP_24196_Verify HBase cataloger connection succes with valid Data Source, valid credentials with cluster resolve False
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute      |
      | Type      | Cataloger      |
      | Plugin    | HBaseCataloger |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName      | attribute              |
      | Plugin version | LATEST                 |
      | Credential     | hbaseDBValidCredential |
      | Data Source    | HbaseDataSource_Valid  |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName  | pluginConfigFieldValue |
      | Name                   | HbaseCataloger         |
      | Namespace Include Name | NS                     |
      | Tables Include Name    | Table1                 |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"

    ########################################Set data##############################################################


    ## hbase shell
    ## create_namespace 'Automation_QA1'
    ## create_namespace 'Automation_QA'
    ## create_namespace 'Automation_QA2'
    ## create_namespace 'pyspark'
  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC5#-MLP_24886_Create tables in HBASE
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

########################################Cluster,Service,Database,Table and Column related count, name and type validations#############################

  Scenario: SC5#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                       | jsonValues |
      | $.configurations..hbaseRestUrl | HBaseUri   |

  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC5#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | body                                                           | response code | response message      | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseDataSource                                                  | ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json | 204           |                       |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseDataSource                                                  |                                                                | 200           | HbaseDataSource_Valid |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HBaseCataloger                                                   | ida/hbasePayloads/Cataloger/hbasedbValidCatalogerConfig.json   | 204           |                       |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HBaseCataloger                                                   |                                                                | 200           | HBaseCataloger_Valid  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_Valid |                                                                | 200           | IDLE                  | $.[?(@.configurationName=='HBaseCataloger_Valid')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_Valid  |                                                                | 200           |                       |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_Valid |                                                                | 200           | IDLE                  | $.[?(@.configurationName=='HBaseCataloger_Valid')].status |

  Scenario Outline: SC5#user retrieves ID with catalog name and type
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type     | name      | asg_scopeid | targetFile                         | jsonpath           |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | default   | employee    | response/HBASE/actual/itemIds.json | $..has_Table.id    |
      | APPDBPOSTGRES | ID          | Default | Service  | HBASE     |             | response/HBASE/actual/itemIds.json | $..has_Service.id  |
      | APPDBPOSTGRES | ID          | Default | Database | default   |             | response/HBASE/actual/itemIds.json | $..has_Database.id |
      | APPDBPOSTGRES | ID          | Default | Cluster  | LocalNode |             | response/HBASE/actual/itemIds.json | $..Cluster.id      |


  Scenario Outline: SC5#user hit API and save the response for each type's
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                          | responseCode | inputJson          | inputFile                          | outPutFile                                  | outPutJson |
      | components/Default/item/Default.Cluster:::dynamic?pages=ALL  | 200          | $..Cluster.id      | response/HBASE/actual/itemIds.json | response/HBASE/actual/clusterMetadata.json  |            |
      | components/Default/item/Default.Service:::dynamic?pages=ALL  | 200          | $..has_Service.id  | response/HBASE/actual/itemIds.json | response/HBASE/actual/serviceMetadata.json  |            |
      | components/Default/item/Default.Database:::dynamic?pages=ALL | 200          | $..has_Database.id | response/HBASE/actual/itemIds.json | response/HBASE/actual/databaseMetadata.json |            |
      | components/Default/item/Default.Table:::dynamic?pages=ALL    | 200          | $..has_Table.id    | response/HBASE/actual/itemIds.json | response/HBASE/actual/tableMetadata.json    |            |


  Scenario Outline: SC5#user retrieves and save the response of facet type's in a file
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                           | response code | response message | filePath                                  | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | response/HBASE/body/getFacetsCountRequest.json | 200           |                  | response/HBASE/actual/facetWiseCount.json |          |

#7148912
  #commented some scenarios since Technical data is removed from UI
  Scenario Outline:SC5# Validate Cluster,Service,Database and Table should have the appropriate metadata information in IDC UI and Database
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                     | actualValues                                | valueType         | expectedJsonPath                                                | actualJsonPath                                                            |
      | response/HBASE/expected/hbaseExpectedJsonData.json | response/HBASE/actual/facetWiseCount.json   | intCompare        | $..totalCount                                                   | $..count                                                                  |
      | response/HBASE/expected/hbaseExpectedJsonData.json | response/HBASE/actual/facetWiseCount.json   | intListCompare    | $..MetaData.facetCounts.type_s..count                           | $.facetCounts..type_s..count                                              |
      | response/HBASE/expected/hbaseExpectedJsonData.json | response/HBASE/actual/clusterMetadata.json  | stringListCompare | $..clusterMetaData..taglist..techTag                            | $..[?(@.type=='taglist')].data..name                                      |
      | response/HBASE/expected/hbaseExpectedJsonData.json | response/HBASE/actual/clusterMetadata.json  | stringListCompare | $..clusterMetaData..table..values.[?(@.type=='Services')].name  | $..[?(@.caption=='Services')].data..name                                  |
      | response/HBASE/expected/hbaseExpectedJsonData.json | response/HBASE/actual/serviceMetadata.json  | stringListCompare | $..serviceMetaData..taglist..techTag                            | $..[?(@.type=='taglist')].data..name                                      |
      | response/HBASE/expected/hbaseExpectedJsonData.json | response/HBASE/actual/serviceMetadata.json  | stringCompare     | $..serviceMetaData..table..values.[?(@.type=='Databases')].name | $..[?(@.caption=='Databases')].data..[?(@.name=='default')].name          |
      | response/HBASE/expected/hbaseExpectedJsonData.json | response/HBASE/actual/databaseMetadata.json | stringListCompare | $..databaseMetaData..taglist..techTag                           | $..[?(@.type=='taglist')].data..name                                      |
      | response/HBASE/expected/hbaseExpectedJsonData.json | response/HBASE/actual/databaseMetadata.json | stringCompare     | $..databaseMetaData.table.values..employee.name                 | $..[?(@.caption=='Tables')].data..[?(@.name=='employee')].name            |
      | response/HBASE/expected/hbaseExpectedJsonData.json | response/HBASE/actual/databaseMetadata.json | stringCompare     | $..databaseMetaData.table.values..products.name                 | $..[?(@.caption=='Tables')].data..[?(@.name=='products')].name            |
      | response/HBASE/expected/hbaseExpectedJsonData.json | response/HBASE/actual/databaseMetadata.json | stringCompare     | $..databaseMetaData.table.values..testtable.name                | $..[?(@.caption=='Tables')].data..[?(@.name=='testtable')].name           |
      | response/HBASE/expected/hbaseExpectedJsonData.json | response/HBASE/actual/databaseMetadata.json | stringCompare     | $..databaseMetaData.table.values..information.name              | $..[?(@.caption=='Tables')].data..[?(@.name=='information')].name         |
      | response/HBASE/expected/hbaseExpectedJsonData.json | response/HBASE/actual/tableMetadata.json    | stringListCompare | $..tableMetaData..taglist..techTag                              | $..[?(@.type=='taglist')].data..name                                      |
      | response/HBASE/expected/hbaseExpectedJsonData.json | response/HBASE/actual/tableMetadata.json    | stringCompare     | $..tableMetaData.tableType                                      | $..[?(@.caption=='Description')]..[?(@.caption=='Table Type')].data.value |
      | response/HBASE/expected/hbaseExpectedJsonData.json | response/HBASE/actual/facetWiseCount.json   | intCompare        | $.MetaData..type_s..[?(@.value=='Column')].count                | $.facetCounts..type_s..[?(@.value=='Column')].count                       |
      | response/HBASE/expected/hbaseExpectedJsonData.json | response/HBASE/actual/facetWiseCount.json   | intCompare        | $.MetaData..type_s..[?(@.value=='Table')].count                 | $.facetCounts..type_s..[?(@.value=='Table')].count                        |

  @positve @regression @sanity  @MLP-8191 @IDA-1.1.0
  Scenario:SC5:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type     | query | param |
      | SingleItemDelete | Default | cataloger/HBaseCataloger/HBaseCataloger_Valid% | Analysis |       |       |
      | SingleItemDelete | Default | LocalNode                                      | Cluster  |       |       |

############################################Cataloger Filter cases- Only Namespace with resolve cluster name TRUE and Cluster name is SANDBOX##########################################


  Scenario: SC6#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSource_ResolveClusterTRUE.json" file for following values using property loader
      | jsonPath                                            | jsonValues      |
      | $.configurations..hbaseRestUrl                      | HBaseUri        |
      | $.configurations..clusterManager.clusterManagerHost | clusterHostName |


  Scenario Outline: SC6#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                                        | response code | response message             | jsonPath                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HBaseDataSource                                                          | ida/hbasePayloads/DataSource/hbasedbValidDataSource_ResolveClusterTRUE.json | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HBaseDataSource                                                          |                                                                             | 200           | HbaseDataSource_Valid        |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseCataloger                                                           | ida/hbasePayloads/Cataloger/HBaseCataloger_one_Namespace_Configuration.json | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseCataloger                                                           |                                                                             | 200           | HBaseCataloger_onlyNamespace |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_onlyNamespace |                                                                             | 200           | IDLE                         | $.[?(@.configurationName=='HBaseCataloger_onlyNamespace')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_onlyNamespace  |                                                                             | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_onlyNamespace |                                                                             | 200           | IDLE                         | $.[?(@.configurationName=='HBaseCataloger_onlyNamespace')].status |

#7148913
  @MLP-24886  @sanity @positive
  Scenario Outline: SC6 MLP_24886_verify whether one Namespace filter collects only the table from the particular NAMESPACE
    And user update the json file "ida/hbasePayloads/API/SC1_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                     |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC1_onlyNamespace                              |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/Sandbox/Service/HBASE/Database/pyspark |
      | $..selections.['type_s'][*]                             | Table                                          |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                           | body                                           | response code | response message | filePath                                          | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC1_onlyNamespace&limitFacet=10&offset=0&limit=2500 | payloads/ida/hbasePayloads/API/SC1_Filter.json | 200           |                  | response\HBASE\TableFilter\Actual\SC1_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#6 MLP_24886_Compare the tables with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                      | actualValues                                      | valueType         | expectedJsonPath | actualJsonPath               |
      | response\HBASE\TableFilter\Expected\SC1_Filter.json | response\HBASE\TableFilter\Actual\SC1_Filter.json | stringListCompare | $.SC1.Tables[*]  | $..[?(@.type=='Table')].name |

  Scenario Outline: SC6#user retrieves ID with catalog ,name and type
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type    | name    | asg_scopeid | targetFile                         | jsonpath      |
      | APPDBPOSTGRES | ID      | Default | Cluster | Sandbox |             | response/HBASE/actual/itemIds.json | $..Cluster.id |

  Scenario Outline: SC6#user hit API and save the response for each type's
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                         | responseCode | inputJson     | inputFile                          | outPutFile                                 | outPutJson |
      | components/Default/item/Default.Cluster:::dynamic?pages=ALL | 200          | $..Cluster.id | response/HBASE/actual/itemIds.json | response/HBASE/actual/clusterMetadata.json |            |

#7148914
  Scenario Outline:SC6# Validate Cluster name as 'Sandbox'when resolve cluster name is enables as TRUE
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                      | actualValues                               | valueType     | expectedJsonPath               | actualJsonPath |
      | response\HBASE\TableFilter\Expected\SC1_Filter.json | response/HBASE/actual/clusterMetadata.json | stringcompare | $..[?(@.type=='Cluster')].name | $.caption.name |

  @positve @regression @sanity  @MLP-8191 @IDA-1.1.0
  Scenario:SC6:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                   | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/HBaseCataloger_onlyNamespace% | Analysis |       |       |
      | SingleItemDelete | Default | Sandbox                                                | Cluster  |       |       |


###############################################Cataloger Filter cases- No Namespace one Table(available in mutiple namespaces) with resolve cluster name TRUE########################


  Scenario: SC7#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSource_ResolveClusterTRUE.json" file for following values using property loader
      | jsonPath                                            | jsonValues      |
      | $.configurations..hbaseRestUrl                      | HBaseUri        |
      | $.configurations..clusterManager.clusterManagerHost | clusterHostName |


  Scenario Outline: SC7#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | body                                                                        | response code | response message          | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HBaseDataSource                                                       | ida/hbasePayloads/DataSource/hbasedbValidDataSource_ResolveClusterTRUE.json | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HBaseDataSource                                                       |                                                                             | 200           | HbaseDataSource_Valid     |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseCataloger                                                        | ida/hbasePayloads/Cataloger/HBaseCataloger_Only_Table_Configuration.json    | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseCataloger                                                        |                                                                             | 200           | HBaseCataloger_onlyTables |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_onlyTables |                                                                             | 200           | IDLE                      | $.[?(@.configurationName=='HBaseCataloger_onlyTables')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_onlyTables  |                                                                             | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_onlyTables |                                                                             | 200           | IDLE                      | $.[?(@.configurationName=='HBaseCataloger_onlyTables')].status |

#7148916
  @MLP-24886  @sanity @positive
  Scenario Outline: SC7 MLP_24886_verify whether table filter collects all the tables across namespaces when available in same name
    And user update the json file "ida/hbasePayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                    |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC1_onlyTables                |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/Sandbox/Service/HBASE |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                        | body                                           | response code | response message | filePath                                          | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC1_onlyTables&limitFacet=10&offset=0&limit=2500 | payloads/ida/hbasePayloads/API/SC2_Filter.json | 200           |                  | response\HBASE\TableFilter\Actual\SC2_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#7 MLP_24886_Compare the tables and Database with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                      | actualValues                                      | valueType         | expectedJsonPath   | actualJsonPath                  |
      | response\HBASE\TableFilter\Expected\SC1_Filter.json | response\HBASE\TableFilter\Actual\SC2_Filter.json | stringListCompare | $.SC2.Tables[*]    | $..[?(@.type=='Table')].name    |
      | response\HBASE\TableFilter\Expected\SC1_Filter.json | response\HBASE\TableFilter\Actual\SC2_Filter.json | stringListCompare | $.SC2.hierarchy[*] | $..[?(@.type=='Database')].name |


  @positve @regression @sanity  @MLP-8191 @IDA-1.1.0
  Scenario:SC7:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/HBaseCataloger_onlyTables% | Analysis |       |       |
      | SingleItemDelete | Default | Sandbox                                             | Cluster  |       |       |


###############################################Cataloger Filter cases- One Namespace Multiple Tables(2 out of 3 Table) with resolve cluster name FALSE########################


  Scenario: SC8#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                       | jsonValues |
      | $.configurations..hbaseRestUrl | HBaseUri   |


  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC8#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                       | body                                                                                             | response code | response message                           | jsonPath                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseDataSource                                                                        | ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json                                   | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseDataSource                                                                        |                                                                                                  | 200           | HbaseDataSource_Valid                      |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseCataloger                                                                         | ida/hbasePayloads/Cataloger/HBaseCataloger_with_one_namespace_multiple_tables_Configuration.json | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseCataloger                                                                         |                                                                                                  | 200           | HBaseCataloger_oneNamespace_MultipleTables |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_oneNamespace_MultipleTables |                                                                                                  | 200           | IDLE                                       | $.[?(@.configurationName=='HBaseCataloger_oneNamespace_MultipleTables')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_oneNamespace_MultipleTables  |                                                                                                  | 200           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_oneNamespace_MultipleTables |                                                                                                  | 200           | IDLE                                       | $.[?(@.configurationName=='HBaseCataloger_oneNamespace_MultipleTables')].status |

#7148921
  @MLP-24886  @sanity @positive
  Scenario Outline: SC8 MLP_24886_verify whether table filter collects the 2 tables in the namespaces leaving the 3rd table and Cluster name is either 'LocalNode'/'Cluster Demo'
    And user update the json file "ida/hbasePayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                      |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC1_oneNS_MultiTables           |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/LocalNode/Service/HBASE |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                               | body                                           | response code | response message | filePath                                          | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC1_oneNS_MultiTables&limitFacet=10&offset=0&limit=2500 | payloads/ida/hbasePayloads/API/SC2_Filter.json | 200           |                  | response\HBASE\TableFilter\Actual\SC3_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#8 MLP_24886_Compare the tables and Database with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                      | actualValues                                      | valueType         | expectedJsonPath   | actualJsonPath                  |
      | response\HBASE\TableFilter\Expected\SC1_Filter.json | response\HBASE\TableFilter\Actual\SC3_Filter.json | stringListCompare | $.SC3.Tables[*]    | $..[?(@.type=='Table')].name    |
      | response\HBASE\TableFilter\Expected\SC1_Filter.json | response\HBASE\TableFilter\Actual\SC3_Filter.json | stringListCompare | $.SC3.hierarchy[*] | $..[?(@.type=='Database')].name |

  @positve @regression @sanity  @MLP-8191 @IDA-1.1.0
  Scenario:SC8:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/HBaseCataloger_oneNamespace_MultipleTables% | Analysis |       |       |
      | SingleItemDelete | Default | LocalNode                                                            | Cluster  |       |       |


###############################################Cataloger Filter cases- Multiple Namespace No Tables with resolve cluster name FALSE########################


  Scenario: SC9#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                       | jsonValues |
      | $.configurations..hbaseRestUrl | HBaseUri   |


  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC9#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | body                                                                                           | response code | response message                  | jsonPath                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseDataSource                                                               | ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json                                 | 204           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseDataSource                                                               |                                                                                                | 200           | HbaseDataSource_Valid             |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseCataloger                                                                | ida/hbasePayloads/Cataloger/HBaseCataloger_with_Mutiple_namespace_No_tables_Configuration.json | 204           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseCataloger                                                                |                                                                                                | 200           | HBaseCataloger_MultipleNamespaces |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespaces |                                                                                                | 200           | IDLE                              | $.[?(@.configurationName=='HBaseCataloger_MultipleNamespaces')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespaces  |                                                                                                | 200           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespaces |                                                                                                | 200           | IDLE                              | $.[?(@.configurationName=='HBaseCataloger_MultipleNamespaces')].status |

#7148917
  @MLP-24886  @sanity @positive
  Scenario Outline: SC9 MLP_24886_verify whether table filter collects all the tables across provided namespaces when multiple namespace alone provided
    And user update the json file "ida/hbasePayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                      |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC1_MultiNamespaces             |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/LocalNode/Service/HBASE |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                             | body                                           | response code | response message | filePath                                          | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC1_MultiNamespaces&limitFacet=10&offset=0&limit=2500 | payloads/ida/hbasePayloads/API/SC2_Filter.json | 200           |                  | response\HBASE\TableFilter\Actual\SC4_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#9 MLP_24886_Compare the tables and Database with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                      | actualValues                                      | valueType         | expectedJsonPath   | actualJsonPath                  |
      | response\HBASE\TableFilter\Expected\SC1_Filter.json | response\HBASE\TableFilter\Actual\SC4_Filter.json | stringListCompare | $.SC4.Tables[*]    | $..[?(@.type=='Table')].name    |
      | response\HBASE\TableFilter\Expected\SC1_Filter.json | response\HBASE\TableFilter\Actual\SC4_Filter.json | stringListCompare | $.SC4.hierarchy[*] | $..[?(@.type=='Database')].name |

  @positve @regression @sanity  @MLP-8191 @IDA-1.1.0
  Scenario:SC9:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                        | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespaces% | Analysis |       |       |
      | SingleItemDelete | Default | LocalNode                                                   | Cluster  |       |       |


###############################################Cataloger Filter cases- Multiple Namespace Multiple Tables(Same tables present in more than one Namespace) with resolve cluster name FALSE########################


  Scenario: SC10#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                       | jsonValues |
      | $.configurations..hbaseRestUrl | HBaseUri   |


  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC10#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                            | body                                                                                                 | response code | response message                                | jsonPath                                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseDataSource                                                                             | ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json                                       | 204           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseDataSource                                                                             |                                                                                                      | 200           | HbaseDataSource_Valid                           |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseCataloger                                                                              | ida/hbasePayloads/Cataloger/HBaseCataloger_with_Mutiple_namespace_Multiple_tables_Configuration.json | 204           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseCataloger                                                                              |                                                                                                      | 200           | HBaseCataloger_MultipleNamespacesMultipleTables |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesMultipleTables |                                                                                                      | 200           | IDLE                                            | $.[?(@.configurationName=='HBaseCataloger_MultipleNamespacesMultipleTables')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesMultipleTables  |                                                                                                      | 200           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesMultipleTables |                                                                                                      | 200           | IDLE                                            | $.[?(@.configurationName=='HBaseCataloger_MultipleNamespacesMultipleTables')].status |

#7148916
  @sanity @positive @MLP-24886 @webtest @IDA-10.3
  Scenario:SC10#MLP_24886_Verify the Multiple Namespace and Multiple table filters (Same tables present in more than one Namespace)are collected as per the hierarchy
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1_MultiNamespaces_MultipleTables" and clicks on search
    And user performs "facet selection" in "SC1_MultiNamespaces_MultipleTables" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Cluster" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "LocalNode" item from search results
    Then user performs click and verify in new window
      | Table     | value          | Action                 | RetainPrevwindow | indexSwitch |
      | Services  | HBASE          | click and switch tab   |                  |             |
      | Databases | Automation_QA1 | verify widget contains |                  |             |
      | Databases | Automation_QA  | verify widget contains |                  |             |
      | Databases | Automation_QA2 | verify widget contains |                  |             |
      | Databases | Automation_QA1 | click and switch tab   |                  |             |
      | Tables    | employee       | verify widget contains |                  |             |
      | Tables    | employee1      | verify widget contains |                  |             |
      | Tables    | employee_test  | verify widget contains |                  | 0           |
      | Databases | Automation_QA2 | click and switch tab   |                  |             |
      | Tables    | employee       | verify widget contains |                  |             |
      | Tables    | employee_test  | verify widget contains |                  | 0           |
      | Databases | Automation_QA  | click and switch tab   |                  |             |
      | Tables    | employee       | verify widget contains |                  |             |
      | Tables    | employee_test  | verify widget contains |                  | 0           |

  @positve @regression @sanity  @MLP-8191 @IDA-1.1.0
  Scenario:SC10:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                      | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesMultipleTables% | Analysis |       |       |
      | SingleItemDelete | Default | LocalNode                                                                 | Cluster  |       |       |

###############################################Cataloger Filter cases- Multiple Namespace(wildcard) Multiple Tables(wildcard) with resolve cluster name FALSE########################


  Scenario: SC11#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                       | jsonValues |
      | $.configurations..hbaseRestUrl | HBaseUri   |
    And user update the json file "ida/hbasePayloads/Cataloger/HBaseCataloger_with_Mutiple_namespace_Multiple_tables(wildcard)_Configuration.json" file for following values
      | jsonPath                        | jsonValues        |
      | $.configurations..nodeCondition | name=="LocalNode" |


  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC11#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                                | body                                                                                                           | response code | response message                                    | jsonPath                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseDataSource                                                                                 | ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json                                                 | 204           |                                                     |                                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseDataSource                                                                                 |                                                                                                                | 200           | HbaseDataSource_Valid                               |                                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseCataloger                                                                                  | ida/hbasePayloads/Cataloger/HBaseCataloger_with_Mutiple_namespace_Multiple_tables(wildcard)_Configuration.json | 204           |                                                     |                                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseCataloger                                                                                  |                                                                                                                | 200           | HBaseCataloger_MultipleNamespacesandTables_wildcard |                                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesandTables_wildcard |                                                                                                                | 200           | IDLE                                                | $.[?(@.configurationName=='HBaseCataloger_MultipleNamespacesandTables_wildcard')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesandTables_wildcard  |                                                                                                                | 200           |                                                     |                                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesandTables_wildcard |                                                                                                                | 200           | IDLE                                                | $.[?(@.configurationName=='HBaseCataloger_MultipleNamespacesandTables_wildcard')].status |

#7148920
  @sanity @positive @MLP-24886 @webtest @IDA-10.3
  Scenario:SC11#MLP_24886_Verify Namespace(wildcard) Multiple Tables(wildcard) with resolve cluster name FALSE are collected with wildcard provided as per the hierarchy
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1_wildcard" and clicks on search
    And user performs "facet selection" in "SC1_wildcard" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Cluster" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "LocalNode" item from search results
    Then user performs click and verify in new window
      | Table     | value          | Action                 | RetainPrevwindow | indexSwitch |
      | Services  | HBASE          | click and switch tab   |                  |             |
      | Databases | Automation_QA1 | verify widget contains |                  |             |
      | Databases | Automation_QA  | verify widget contains |                  |             |
      | Databases | Automation_QA2 | verify widget contains |                  |             |
      | Databases | Automation_QA1 | click and switch tab   |                  |             |
      | Tables    | employee       | verify widget contains |                  |             |
      | Tables    | employee1      | verify widget contains |                  |             |
      | Tables    | employee_test  | verify widget contains |                  | 0           |
      | Databases | Automation_QA2 | click and switch tab   |                  |             |
      | Tables    | employee       | verify widget contains |                  |             |
      | Tables    | employee_test  | verify widget contains |                  | 0           |
      | Databases | Automation_QA  | click and switch tab   |                  |             |
      | Tables    | employee       | verify widget contains |                  |             |
      | Tables    | employee_test  | verify widget contains |                  | 0           |


################################################Explicit, Technology, Bussiness Application Tag###############################################

#7148911
  @positve @regression @sanity  @PIITag
  Scenario:Commoncase#MLP_24886_Verify Technology tag , Explicit tag , Bussiness Application tag
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName | DatabaseName   | TableName/Filename | SchemaName | Column             | Tags                        | Query                    | Action      |
      | LocalNode   | HBASE       | Automation_QA1 | employee           |            | personal data:city | HBASE_BA,HBase,SC1_wildcard | ColumnQuerywithoutSchema | TagAssigned |
      | LocalNode   | HBASE       | Automation_QA1 | employee           |            |                    | HBASE_BA,HBase,SC1_wildcard | TableQuerywithoutSchema  | TagAssigned |
      | LocalNode   | HBASE       | Automation_QA1 |                    |            |                    | HBASE_BA,HBase,SC1_wildcard | DatabaseQuery            | TagAssigned |
      | LocalNode   | HBASE       |                |                    |            |                    | HBASE_BA,HBase,SC1_wildcard | ServiceQuery             | TagAssigned |
      | LocalNode   |             |                |                    |            |                    | HBASE_BA,HBase,SC1_wildcard | ClusterQuery             | TagAssigned |

#####################################################Logging enhancement##########################################################################

     #7148911
  @MLP-24886 @sanity @positive
  Scenario:Commoncase:MLP-24886_Parsing the repository and validating the HBase Cataloger Log
    Then Analysis log "cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesandTables_wildcard/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | logCode       | pluginName     | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | ANALYSIS-0019 |                |                |
      | INFO | ANALYSIS-0071: Plugin Name:HBaseCataloger, Plugin Type:cataloger, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:1f0562baa159, Plugin Configuration name:HBaseCataloger_MultipleNamespacesandTables_wildcard                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0071 | HBaseCataloger | Plugin Version |
      | INFO | INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: ---  2020-10-02 14:34:11.741 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: name: "HBaseCataloger_MultipleNamespacesandTables_wildcard"  2020-10-02 14:34:11.741 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: pluginVersion: "LATEST"  2020-10-02 14:34:11.741 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: label:  2020-10-02 14:34:11.741 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: : ""  2020-10-02 14:34:11.741 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: catalogName: "Default"  2020-10-02 14:34:11.741 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: eventClass: null  2020-10-02 14:34:11.741 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: eventCondition: null  2020-10-02 14:34:11.741 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: nodeCondition: "name==\"LocalNode\""  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: maxWorkSize: 100  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: tags:  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: - "SC1_wildcard"  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: pluginType: "cataloger"  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: dataSource: "HbaseDataSource_Valid"  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: credential: "hbaseDBValidCredential"  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: businessApplicationName: "HBASE_BA"  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: dryRun: false  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: schedule: null  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: filter: null  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: pluginName: "HBaseCataloger"  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: type: "Cataloger"  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: includeItems:  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: includeTables:  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: - "*employee*"  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: - "*employee1"  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: - "employee_test*"  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: includeNamespaces:  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: - "*Automation_QA*"  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: - "*Automation_QA1"  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: - "Automation_QA2*"  2020-10-02 14:34:11.742 INFO  - ANALYSIS-0073: Plugin HBaseCataloger Configuration: scanRows: "100" | ANALYSIS-0073 | HBaseCataloger |                |
      | INFO | ANALYSIS-0072: Plugin HBaseCataloger Start Time:2020-07-23 15:49:13.303, End Time:2020-07-23 15:49:13.985, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0072 | HBaseCataloger |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:01:40.205)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | ANALYSIS-0020 |                |                |

  @positve @regression @sanity  @MLP-8191 @IDA-1.1.0
  Scenario:SC11:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                          | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesandTables_wildcard% | Analysis |       |       |
      | SingleItemDelete | Default | LocalNode                                                                     | Cluster  |       |       |


###############################################Cataloger Filter cases- Multiple Namespace(wildcard) Multiple Tables(wildcard) with resolve cluster name FALSE  in CLUSTER DEMO node########################



  Scenario: SC12#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                       | jsonValues |
      | $.configurations..hbaseRestUrl | HBaseUri   |
    And user update the json file "ida/hbasePayloads/Cataloger/HBaseCataloger_with_Mutiple_namespace_Multiple_tables(wildcard)_Configuration.json" file for following values
      | jsonPath                        | jsonValues           |
      | $.configurations..nodeCondition | name=="Cluster Demo" |


  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC12#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                                     | body                                                                                                           | response code | response message                                    | jsonPath                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseDataSource                                                                                      | ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json                                                 | 204           |                                                     |                                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseDataSource                                                                                      |                                                                                                                | 200           | HbaseDataSource_Valid                               |                                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseCataloger                                                                                       | ida/hbasePayloads/Cataloger/HBaseCataloger_with_Mutiple_namespace_Multiple_tables(wildcard)_Configuration.json | 204           |                                                     |                                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseCataloger                                                                                       |                                                                                                                | 200           | HBaseCataloger_MultipleNamespacesandTables_wildcard |                                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesandTables_wildcard |                                                                                                                | 200           | IDLE                                                | $.[?(@.configurationName=='HBaseCataloger_MultipleNamespacesandTables_wildcard')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesandTables_wildcard  |                                                                                                                | 200           |                                                     |                                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesandTables_wildcard |                                                                                                                | 200           | IDLE                                                | $.[?(@.configurationName=='HBaseCataloger_MultipleNamespacesandTables_wildcard')].status |

#7148919
  @sanity @positive @MLP-24886 @webtest @IDA-10.3
  Scenario:SC12#MLP_24886_Verify the tables are cataloged with Multiple Namespace and Multiple table filters are collected with wildcard provided as per the hierarchy in Cluster Demo (cluster)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1_wildcard" and clicks on search
    And user performs "facet selection" in "SC1_wildcard" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Cluster" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "Cluster Demo" item from search results
    Then user performs click and verify in new window
      | Table     | value          | Action                 | RetainPrevwindow | indexSwitch |
      | Services  | HBASE          | click and switch tab   |                  |             |
      | Databases | Automation_QA1 | verify widget contains |                  |             |
      | Databases | Automation_QA  | verify widget contains |                  |             |
      | Databases | Automation_QA2 | verify widget contains |                  |             |
      | Databases | Automation_QA1 | click and switch tab   |                  |             |
      | Tables    | employee       | verify widget contains |                  |             |
      | Tables    | employee1      | verify widget contains |                  |             |
      | Tables    | employee_test  | verify widget contains |                  | 0           |
      | Databases | Automation_QA2 | click and switch tab   |                  |             |
      | Tables    | employee       | verify widget contains |                  |             |
      | Tables    | employee_test  | verify widget contains |                  | 0           |
      | Databases | Automation_QA  | click and switch tab   |                  |             |
      | Tables    | employee       | verify widget contains |                  |             |
      | Tables    | employee_test  | verify widget contains |                  | 0           |

  @positve @regression @sanity  @MLP-8191 @IDA-1.1.0
  Scenario:SC12:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                          | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/HBaseCataloger_MultipleNamespacesandTables_wildcard% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                                                                  | Cluster  |       |       |

###############################################Cataloger Filter cases- Invalid Namespace Valid Tables with resolve cluster name FALSE  in Local Node node########################


  Scenario: SC13#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                       | jsonValues |
      | $.configurations..hbaseRestUrl | HBaseUri   |


  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC13#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                       | body                                                                                 | response code | response message                           | jsonPath                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseDataSource                                                                        | ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json                       | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseDataSource                                                                        |                                                                                      | 200           | HbaseDataSource_Valid                      |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseCataloger                                                                         | ida/hbasePayloads/Cataloger/HBaseCataloger_non_existent_Namespace_Configuration.json | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseCataloger                                                                         |                                                                                      | 200           | HBaseCataloger_InvalidNamespace_validtable |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_InvalidNamespace_validtable |                                                                                      | 200           | IDLE                                       | $.[?(@.configurationName=='HBaseCataloger_InvalidNamespace_validtable')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_InvalidNamespace_validtable  |                                                                                      | 200           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_InvalidNamespace_validtable |                                                                                      | 200           | IDLE                                       | $.[?(@.configurationName=='HBaseCataloger_InvalidNamespace_validtable')].status |

    #7148922
  @sanity @positive @webtest @hbase
  Scenario:SC13#MLP_24886_Verify Hbase cataloger doesn't collect any tables when provided with invalid namespace and valid table name in filter
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1_InvalidNamespace_validTable" and clicks on search
    Then user verify "verify non presence" with following values under "Metadata Type" section in item search results page
      | Column   |
      | Table    |
      | Cluster  |
      | Database |
      | Service  |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/HBaseCataloger/HBaseCataloger_InvalidNamespace_validtable%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of errors          | 0             |
      | Number of processed items | 0             |
    And user "widget not present" on "Processed Items" in Item view page

  @positve @regression @sanity  @MLP-8191 @IDA-1.1.0
  Scenario:SC13:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/HBaseCataloger_InvalidNamespace_validtable% | Analysis |       |       |


###############################################Cataloger Filter cases- Valid Namespace InValid Tables with resolve cluster name FALSE  in CLUSTER DEMO node########################


  Scenario: SC14#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                       | jsonValues |
      | $.configurations..hbaseRestUrl | HBaseUri   |
    And user update the json file "ida/hbasePayloads/Cataloger/HBaseCataloger_non_existent_Table_Configuration.json" file for following values
      | jsonPath                        | jsonValues           |
      | $.configurations..nodeCondition | name=="Cluster Demo" |

  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC14#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                            | body                                                                             | response code | response message                           | jsonPath                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseDataSource                                                                             | ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json                   | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseDataSource                                                                             |                                                                                  | 200           | HbaseDataSource_Valid                      |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseCataloger                                                                              | ida/hbasePayloads/Cataloger/HBaseCataloger_non_existent_Table_Configuration.json | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseCataloger                                                                              |                                                                                  | 200           | HBaseCataloger_ValidNamespace_Invalidtable |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HBaseCataloger/HBaseCataloger_ValidNamespace_Invalidtable |                                                                                  | 200           | IDLE                                       | $.[?(@.configurationName=='HBaseCataloger_ValidNamespace_Invalidtable')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HBaseCataloger/HBaseCataloger_ValidNamespace_Invalidtable  |                                                                                  | 200           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HBaseCataloger/HBaseCataloger_ValidNamespace_Invalidtable |                                                                                  | 200           | IDLE                                       | $.[?(@.configurationName=='HBaseCataloger_ValidNamespace_Invalidtable')].status |

    #7148923
  @sanity @positive @webtest @hbase
  Scenario:SC14#MLP_24886_Verify Hbase cataloger doesn't collect tables but collects Namespace in IDC UI when provided with Valid namespace and Invalid table name in filter
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1_ValidNamespace_InvalidTable" and clicks on search
    Then user verify "verify non presence" with following values under "Metadata Type" section in item search results page
      | Column  |
      | Table   |
      | Cluster |
      | Service |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/HBaseCataloger/HBaseCataloger_ValidNamespace_Invalidtable%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of errors          | 0             |
      | Number of processed items | 1             |
    And user "widget not present" on "Processed Items" in Item view page

  @positve @regression @sanity  @MLP-8191 @IDA-1.1.0
  Scenario:SC14:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/HBaseCataloger_ValidNamespace_Invalidtable% | Analysis |       |       |
      | SingleItemDelete | Default | Automation_QA1                                                       | Database |       |       |
      | SingleItemDelete | Default | Cluster Demo                                                         | Cluster  |       |       |

##############################################Cataloger Filter cases- Duplicate Namespace unique Table with resolve cluster name FALSE  in LocalNode node########################

  Scenario: SC15#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                       | jsonValues |
      | $.configurations..hbaseRestUrl | HBaseUri   |
    And user update the json file "ida/hbasePayloads/Cataloger/HBaseCataloger_Duplicate_namespace_uniqueTable_Configuration.json" file for following values
      | jsonPath                        | jsonValues        |
      | $.configurations..nodeCondition | name=="LocalNode" |

  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC15#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                          | body                                                                                          | response code | response message                              | jsonPath                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseDataSource                                                                           | ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json                                | 204           |                                               |                                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseDataSource                                                                           |                                                                                               | 200           | HbaseDataSource_Valid                         |                                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseCataloger                                                                            | ida/hbasePayloads/Cataloger/HBaseCataloger_Duplicate_namespace_uniqueTable_Configuration.json | 204           |                                               |                                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseCataloger                                                                            |                                                                                               | 200           | HBaseCataloger_DuplicateNamespace_Uniquetable |                                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_DuplicateNamespace_Uniquetable |                                                                                               | 200           | IDLE                                          | $.[?(@.configurationName=='HBaseCataloger_DuplicateNamespace_Uniquetable')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_DuplicateNamespace_Uniquetable  |                                                                                               | 200           |                                               |                                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_DuplicateNamespace_Uniquetable |                                                                                               | 200           | IDLE                                          | $.[?(@.configurationName=='HBaseCataloger_DuplicateNamespace_Uniquetable')].status |

#7148924
  @MLP-24886  @sanity @positive
  Scenario Outline: SC15 MLP_24886_verify whether table filter collects all the tables across provided namespaces when multiple duplicate namespace and unique table is provided
    And user update the json file "ida/hbasePayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                         |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC1_DuplicateNamespace_uniqueTable |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/LocalNode/Service/HBASE    |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                            | body                                           | response code | response message | filePath                                          | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC1_DuplicateNamespace_uniqueTable&limitFacet=10&offset=0&limit=2500 | payloads/ida/hbasePayloads/API/SC2_Filter.json | 200           |                  | response\HBASE\TableFilter\Actual\SC5_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#15 MLP_24886_Compare the tables and Database with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                      | actualValues                                      | valueType         | expectedJsonPath   | actualJsonPath                  |
      | response\HBASE\TableFilter\Expected\SC1_Filter.json | response\HBASE\TableFilter\Actual\SC5_Filter.json | stringListCompare | $.SC5.Tables[*]    | $..[?(@.type=='Table')].name    |
      | response\HBASE\TableFilter\Expected\SC1_Filter.json | response\HBASE\TableFilter\Actual\SC5_Filter.json | stringListCompare | $.SC5.hierarchy[*] | $..[?(@.type=='Database')].name |


  @positve @regression @sanity  @MLP-8191 @IDA-1.1.0
  Scenario:SC15:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                    | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/HBaseCataloger_DuplicateNamespace_Uniquetable% | Analysis |       |       |
      | SingleItemDelete | Default | LocalNode                                                               | Cluster  |       |       |

  ###############################################Scan rows 2 and total 6 rows in table with 7 columns########################################################################################################

  Scenario: SC16#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                       | jsonValues |
      | $.configurations..hbaseRestUrl | HBaseUri   |
    And user update the json file "ida/hbasePayloads/Cataloger/HBaseCataloger_ScanRows_Configuration.json" file for following values
      | jsonPath                        | jsonValues               |
      | $.configurations..nodeCondition | name=="LocalNode"        |
      | $.configurations..scanRows      | 2                        |
      | $.configurations..name          | HBaseCataloger_ScanRows2 |
      | $.configurations..tags[*]       | SC1_ScanRows2            |

  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC16#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                   | response code | response message         | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseDataSource                                                      | ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json         | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseDataSource                                                      |                                                                        | 200           | HbaseDataSource_Valid    |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseCataloger                                                       | ida/hbasePayloads/Cataloger/HBaseCataloger_ScanRows_Configuration.json | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseCataloger                                                       |                                                                        | 200           | HBaseCataloger_ScanRows2 |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_ScanRows2 |                                                                        | 200           | IDLE                     | $.[?(@.configurationName=='HBaseCataloger_ScanRows2')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_ScanRows2  |                                                                        | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_ScanRows2 |                                                                        | 200           | IDLE                     | $.[?(@.configurationName=='HBaseCataloger_ScanRows2')].status |

#7149109
  @MLP-24886  @sanity @positive
  Scenario Outline: SC16 MLP_24886_Verify cataloger collects the table rows properly and the columns collected should be 4 when the scan rows is set as a value less than the total number of rows[total rows 6 ,5 rows having 4 columns and 6 th row having 7 columns,max row =2]
    And user update the json file "ida/hbasePayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                      |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC1_ScanRows2                   |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/LocalNode/Service/HBASE |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                       | body                                           | response code | response message | filePath                                          | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC1_ScanRows2&limitFacet=10&offset=0&limit=2500 | payloads/ida/hbasePayloads/API/SC2_Filter.json | 200           |                  | response\HBASE\TableFilter\Actual\SC6_Filter.json |          |

    #7149109
  @MLP-24048  @sanity @positive
  Scenario Outline: SC#16 MLP_24886_Compare the columns and Database with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                      | actualValues                                      | valueType         | expectedJsonPath                | actualJsonPath                  |
      | response\HBASE\TableFilter\Expected\SC1_Filter.json | response\HBASE\TableFilter\Actual\SC6_Filter.json | stringListCompare | $.SC6.Tables.employee.column[*] | $..[?(@.type=='Column')].name   |
      | response\HBASE\TableFilter\Expected\SC1_Filter.json | response\HBASE\TableFilter\Actual\SC6_Filter.json | stringListCompare | $.SC6.hierarchy[*]              | $..[?(@.type=='Database')].name |


  @positve @regression @sanity  @MLP-8191 @IDA-1.1.0
  Scenario:SC16:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/HBaseCataloger_ScanRows2% | Analysis |       |       |
      | SingleItemDelete | Default | LocalNode                                          | Cluster  |       |       |

 ###############################################Scan rows 10 and total 6 rows in table with 7 columns########################################################################################################

  Scenario: SC17#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                       | jsonValues |
      | $.configurations..hbaseRestUrl | HBaseUri   |
    And user update the json file "ida/hbasePayloads/Cataloger/HBaseCataloger_ScanRows_Configuration.json" file for following values
      | jsonPath                        | jsonValues                |
      | $.configurations..nodeCondition | name=="LocalNode"         |
      | $.configurations..scanRows      | 10                        |
      | $.configurations..name          | HBaseCataloger_ScanRows10 |
      | $.configurations..tags[*]       | SC1_ScanRows10            |


  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC17#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | body                                                                   | response code | response message          | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseDataSource                                                       | ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json         | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseDataSource                                                       |                                                                        | 200           | HbaseDataSource_Valid     |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseCataloger                                                        | ida/hbasePayloads/Cataloger/HBaseCataloger_ScanRows_Configuration.json | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseCataloger                                                        |                                                                        | 200           | HBaseCataloger_ScanRows10 |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_ScanRows10 |                                                                        | 200           | IDLE                      | $.[?(@.configurationName=='HBaseCataloger_ScanRows10')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_ScanRows10  |                                                                        | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_ScanRows10 |                                                                        | 200           | IDLE                      | $.[?(@.configurationName=='HBaseCataloger_ScanRows10')].status |

#7149108
  @MLP-24886  @sanity @positive
  Scenario Outline: SC17 MLP_24886_Verify cataloger collects the table rows properly and the columns collected should be 7 when the scan rows is set as a value greater than the total number of rows[total rows 6 ,5 rows having 4 columns and 6 th row having 7 columns,max row =10]
    And user update the json file "ida/hbasePayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                      |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC1_ScanRows10                  |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/LocalNode/Service/HBASE |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                        | body                                           | response code | response message | filePath                                          | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC1_ScanRows10&limitFacet=10&offset=0&limit=2500 | payloads/ida/hbasePayloads/API/SC2_Filter.json | 200           |                  | response\HBASE\TableFilter\Actual\SC7_Filter.json |          |

    #7149108
  @MLP-24048  @sanity @positive
  Scenario Outline: SC#17 MLP_24886_Compare the columns and Database with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                      | actualValues                                      | valueType         | expectedJsonPath                | actualJsonPath                  |
      | response\HBASE\TableFilter\Expected\SC1_Filter.json | response\HBASE\TableFilter\Actual\SC7_Filter.json | stringListCompare | $.SC7.Tables.employee.column[*] | $..[?(@.type=='Column')].name   |
      | response\HBASE\TableFilter\Expected\SC1_Filter.json | response\HBASE\TableFilter\Actual\SC7_Filter.json | stringListCompare | $.SC7.hierarchy[*]              | $..[?(@.type=='Database')].name |


  @positve @regression @sanity  @MLP-8191 @IDA-1.1.0
  Scenario:SC17:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/HBaseCataloger_ScanRows10% | Analysis |       |       |
      | SingleItemDelete | Default | LocalNode                                           | Cluster  |       |       |


######################################################Dry Run Cataloger#########################################################

  Scenario: CommonCase#-MLP_24886_Update the Host name respect to the docker
    And user update json file "ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                       | jsonValues |
      | $.configurations..hbaseRestUrl | HBaseUri   |


  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: CommonCase#-MLP_24886_Verify HBase collects DB items specific to the Table
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | body                                                                 | response code | response message          | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseDataSource                                                       | ida/hbasePayloads/DataSource/hbasedbValidDataSourceConfig.json       | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseDataSource                                                       |                                                                      | 200           | HbaseDataSource_Valid     |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HBaseCataloger                                                        | ida/hbasePayloads/Cataloger/hbasedbDryRunCatalogCatalogerConfig.json | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HBaseCataloger                                                        |                                                                      | 200           | HBaseCataloger_DryRunTrue |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_DryRunTrue |                                                                      | 200           | IDLE                      | $.[?(@.configurationName=='HBaseCataloger_DryRunTrue')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_DryRunTrue  |                                                                      | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/HBaseCataloger/HBaseCataloger_DryRunTrue |                                                                      | 200           | IDLE                      | $.[?(@.configurationName=='HBaseCataloger_DryRunTrue')].status |

#7148911
  @sanity @positive @webtest @MLP-24886 @IDA-1.1.0
  Scenario:CommonCase:MLP_24886_Verify no Cluster , Table , Database , Host and service facets are cataloged and verify log message
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "hbase" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Analysis |
      | Cluster  |
      | Database |
      | Table    |
      | Service  |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/HBaseCataloger/HBaseCataloger_DryRunTrue/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/HBaseCataloger/HBaseCataloger_DryRunTrue/%" should display below info/error/warning
      | type | logValue                                                                                  | logCode       | pluginName     | removableText |
      | INFO | Plugin HBaseCataloger running on dry run mode                                             | ANALYSIS-0069 | HBaseCataloger |               |
      | INFO | Plugin HBaseCataloger processed 2 items on dry run mode and not written to the repository | ANALYSIS-0070 | HBaseCataloger |               |
      | INFO | Plugin completed                                                                          | ANALYSIS-0020 |                |               |


  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario:CommonCase:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HBaseCataloger/HBaseCataloger_DryRunTrue% | Analysis |       |       |


    #################### Deleting the credentials , Data Source & Bussiness Application######################
  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline:SC18:MLP-24886:Deleting the Credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                           | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/hbaseDBValidCredential   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/hbaseDBInValidCredential |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/hbaseDBEmptyCredential   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HBaseDataSource            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HBaseCataloger             |      | 204           |                  |          |

  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario:SC18:Delete Bussiness Application
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name     | type                | query | param |
      | SingleItemDelete | Default | HBASE_BA | BusinessApplication |       |       |


    #############################################Delete data in HBASE#############################################################

  @positve @regression @sanity  @MLP-24886 @IDA-1.1.0
  Scenario Outline: SC19#-MLP_24886_Delete the tables from HBASE
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser | Header   | Query | Param | type   | url                                 | body | response code | response message | jsonPath |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | Automation_QA:employee/schema       |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | Automation_QA:employee_test/schema  |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | Automation_QA1:employee/schema      |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | Automation_QA1:employee1/schema     |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | Automation_QA1:employee_test/schema |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | Automation_QA2:employee/schema      |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | Automation_QA2:employee_test/schema |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | employee/schema                     |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | products/schema                     |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | testtable/schema                    |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | pyspark:employee/schema             |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | pyspark:emp/schema                  |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | pyspark:hremployee/schema           |      | 200           |                  |          |
      | HBase       | hbaseuser   | text/xml |       |       | Delete | information/schema                  |      | 200           |                  |          |

    ############################### STOP HBASE service############################################################

  @MLP-7802 @sanity @positive @regression @hbase @ambari
  Scenario: Configuring and Stop HBase REST server
    Given user connects to the sftp server and run the "STOP_HBASE" command
