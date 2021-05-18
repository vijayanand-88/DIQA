@MLP-1960,@MLP-24889,@MLP-24196
Feature:MLP-1960: Rework of Catalog H dfs to IDA Plugin
  Description: Hdfs bundle(previously known as IDC Prototype CatalogHdfs project ) is a set of plugins for gathering metadata, parsing directories and monitoring events in Hdfs File system

#############################################Pre-condition###################################################

  Scenario:Pre-Condition:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                      | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo              | Cluster  |       |       |
      | SingleItemDelete | Default | Sandbox                   | Cluster  |       |       |

   ########################################## Tool Tip validation #################################################

#7132255
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC2#Get the HDFS Cataloger and DataSource Configuration response
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                               | body                               | response code | response message | filePath                             | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | /schemes/analyzers/configurations | response/HDFS/body/ToolTip.json    | 200           |                  | response/HDFS/actual/ToolTip.json    |          |
      | IDC         | TestSystem | application/json |       |       | Post | /schemes/analyzers/configurations | response/HDFS/body/ToolTip_DS.json | 200           |                  | response/HDFS/actual/ToolTip_DS.json |          |

       #7132255
  @positve @regression @sanity  @MLP-24196 @IDA-1.1.0
  Scenario Outline:SC2# Validate ToolTip for all the fields in HDFS Db Datasource plugin(HDFSDataSourceType,Name,PluginVersion,label,Credential,hbaseRestUrl,PoresolveClusterNamert,clusterManager,clusterManagerName,clusterManagerHost,clusterManagerPort,clusterManagerApiVersion)
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                      | actualValues                         | valueType     | expectedJsonPath                                     | actualJsonPath                                                  |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hdfs.hdfsDataSourceType.tooltip       | $.properties[0].value.prototype.properties[0].tooltip           |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_DS.json | stringCompare | $.Commonfields.Name.tooltip                          | $.properties[0].value.prototype.properties[1].tooltip           |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_DS.json | stringCompare | $.Commonfields.pluginVersion.tooltip                 | $.properties[0].value.prototype.properties[2].tooltip           |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_DS.json | stringCompare | $.Commonfields.label.tooltip                         | $.properties[0].value.prototype.properties[3].tooltip           |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_DS.json | stringCompare | $.Commonfields.credential.tooltip                    | $.properties[0].value.prototype.properties[13].tooltip          |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hdfs.HDFSUsername.tooltip             | $.properties[0].value.prototype.properties[15].tooltip          |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hdfs.resolveClusterName.tooltip       | $.properties[0].value.prototype.properties[17].tooltip          |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hdfs.clusterManager.tooltip           | $.properties[0].value.prototype.properties[18].tooltip          |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hdfs.clusterManagerName.tooltip       | $.properties[0].value.prototype.properties[18].value[0].tooltip |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hdfs.clusterManagerHost.tooltip       | $.properties[0].value.prototype.properties[18].value[1].tooltip |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hdfs.clusterManagerPort.tooltip       | $.properties[0].value.prototype.properties[18].value[2].tooltip |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hdfs.clusterManagerApiVersion.tooltip | $.properties[0].value.prototype.properties[18].value[3].tooltip |


  #7157353
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline:SC2# Validate ToolTip for all the fields in HDFS Db Cataloger plugin(Type,Plugin,Name,Plugin version,label,BA, Data Source, Credential,Event Condition,Dry Run, Event class,Max Work sixe,node condition,Auto Start,tags,Unique Filter)
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                      | actualValues                      | valueType     | expectedJsonPath                                 | actualJsonPath                                                  |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Commonfields..[?(@.label=='Type')].tooltip     | $..[?(@.label=='Type')].tooltip                                 |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Commonfields..[?(@.label=='Plugin')].tooltip   | $..[?(@.label=='Plugin')].tooltip                               |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Commonfields.Name.tooltip                      | $.properties[0].value.prototype.properties[2].tooltip           |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Commonfields.pluginVersion.tooltip             | $.properties[0].value.prototype.properties[3].tooltip           |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Commonfields.label.tooltip                     | $.properties[0].value.prototype.properties[4].tooltip           |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Commonfields.businessApplicationName.tooltip   | $.properties[0].value.prototype.properties[17].tooltip          |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Commonfields.dataSource.tooltip                | $.properties[0].value.prototype.properties[14].tooltip          |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Commonfields.credential.tooltip                | $.properties[0].value.prototype.properties[16].tooltip          |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Commonfields.eventCondition.tooltip            | $.properties[0].value.prototype.properties[5].tooltip           |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Commonfields.dryRun.tooltip                    | $.properties[0].value.prototype.properties[6].tooltip           |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Commonfields.eventClass.tooltip                | $.properties[0].value.prototype.properties[7].tooltip           |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Commonfields.maxWorkSize.tooltip               | $.properties[0].value.prototype.properties[8].tooltip           |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Commonfields.nodeCondition.tooltip             | $.properties[0].value.prototype.properties[10].tooltip          |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Commonfields.autoStart.tooltip                 | $.properties[0].value.prototype.properties[11].tooltip          |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Commonfields.tags.tooltip                      | $.properties[0].value.prototype.properties[12].tooltip          |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Uniquefilter.hdfs.filter.tooltip               | $.properties[0].value.prototype.properties[18].tooltip          |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Uniquefilter.hdfs.maxHits.tooltip              | $.properties[0].value.prototype.properties[18].value[0].tooltip |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Uniquefilter.hdfs.deltaTime.tooltip            | $.properties[0].value.prototype.properties[18].value[1].tooltip |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Uniquefilter.hdfs.filters.tooltip              | $.properties[0].value.prototype.properties[18].value[2].tooltip |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Uniquefilter.hdfs.analyzeCollectedData.tooltip | $.properties[0].value.prototype.properties[19].tooltip          |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Uniquefilter.hdfs.scanHdfs.tooltip             | $.properties[0].value.prototype.properties[20].tooltip          |
      | response/HDFS/expected/ToolTip.json | response/HDFS/actual/ToolTip.json | stringCompare | $.Uniquefilter.hdfs.scanServices.tooltip         | $.properties[0].value.prototype.properties[21].tooltip          |


   ############## setting the Credentials, BA , Data Source and Cataloger###################

  Scenario: SC2#-MLP_24889_Update the Host name respect to the docker
    And user update json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |
    And user update the json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values
      | jsonPath                              | jsonValues |
      | $.configurations[0].catalogerHdfsUser | hdfs       |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC2#-MLP_24889_Set the Credentials, Datasource, Bussiness Application and Cataloger for HDFSDB Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                          | body                                                             | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hdfsDBValidCredential   | ida/hdfsPayloads/Credentials/hdfsdbValidCredentials.json         | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hdfsDBInValidCredential | ida/hdfsPayloads/Credentials/hdfsdbInValidCredentials.json       | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hdfsDBEmptyCredential   | ida/hdfsPayloads/Credentials/hdfsdbEmptyCredentials.json         | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hdfsDBValidCredential   |                                                                  | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hdfsDBInValidCredential |                                                                  | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hdfsDBEmptyCredential   |                                                                  | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root                           | ida\hdfsPayloads\Bussiness_Application\BussinessApplication.json | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/license                             | ida\hbasePayloads\DataSource\license_DS.json                     | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsDataSource            | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json     | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HdfsDataSource            |                                                                  | 200           | HDFSDataSource_valid |          |


   ######################################Data Source mandatory field error validation#####################################
#7132256
  @MLP-24196 @webtest @regression @positive
  Scenario:SC3#MLP_24196_Verify proper error message is thrown in UI if Sample Name field values are not provided within valid range in HdfsDB data source
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute             |
      | Data Source Type | HdfsDataSource        |
#      | Plugin version   | LATEST                |
      | Credential       | hdfsDBValidCredential |
      | Node             | LocalNode             |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  | HDFSDataSource_valid   |
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



  ######################################Data Source connection valid HDFS username valid credentials#####################################
#7132244
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is  success for Hdfs DataSource with valid credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute             |
      | Data Source Type | HdfsDataSource        |
#      | Plugin version   | LATEST                |
      | Credential       | hdfsDBValidCredential |
      | Node             | Cluster Demo          |
    And user "enter text" in Add Data Source Page
      | fieldName     | attribute      |
      | Name          | HdfsDataSource |
      | Label         | HdfsDataSource |
      | HDFS username | hdfs           |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"



  ######################################Data Source connection valid HDFS username invalid credentials#####################################
#7132245
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is success for Hdfs DataSource with Invalid credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute               |
      | Data Source Type | HdfsDataSource          |
#      | Plugin version   | LATEST                  |
      | Credential       | hdfsDBInValidCredential |
      | Node             | Cluster Demo            |
    And user "enter text" in Add Data Source Page
      | fieldName     | attribute      |
      | Name          | HdfsDataSource |
      | Label         | HdfsDataSource |
      | HDFS username | hdfs           |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"


  ######################################Data Source connection valid HDFS empty invalid credentials#####################################
#7132247
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is  success for Hdfs DataSource with Invalid credentialsand Hdfs username empty
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute             |
      | Data Source Type | HdfsDataSource        |
#      | Plugin version   | LATEST                |
      | Credential       | hdfsDBEmptyCredential |
      | Node             | Cluster Demo          |
    And user "enter text" in Add Data Source Page
      | fieldName     | attribute      |
      | Name          | HdfsDataSource |
      | Label         | HdfsDataSource |
      | HDFS username |                |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"

  ######################################Data Source connection invalid host (HORTONWORKS)#####################################
#7132251
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for Hdfs DataSource with valid credentials , resolve cluster true and Invalid hostname
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute             |
      | Data Source Type | HdfsDataSource        |
#      | Plugin version   | LATEST                |
      | Credential       | hdfsDBValidCredential |
      | Node             | Cluster Demo          |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "click" on "field" button in "Cluster manager configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute      |
      | Name                        | HdfsDataSource |
      | Label                       | HdfsDataSource |
      | HDFS username               | hdfs           |
      | Cluster manager hostname    | 35             |
      | Cluster manager port        | 8080           |
      | Cluster manager API version | api/v1         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"


 ######################################Data Source connection invalid Port (HORTONWORKS)#####################################
#7132251
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for Hdfs DataSource with valid credentials , resolve cluster true and Invalid Port
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute             |
      | Data Source Type | HdfsDataSource        |
#      | Plugin version   | LATEST                |
      | Credential       | hdfsDBValidCredential |
      | Node             | Cluster Demo          |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "click" on "field" button in "Cluster manager configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       | pageName       |
      | Name                        | HdfsDataSource  |                |
      | Label                       | HdfsDataSource  |                |
      | HDFS username               |                 |                |
      | Cluster manager hostname    | clusterHostName | PropertyLoader |
      | Cluster manager port        | 75              |                |
      | Cluster manager API version | api/v1          |                |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"


  ######################################Data Source connection invalid cluster manger API (HORTONWORKS)#####################################
#7132251
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for hdfs DataSource with empty credentials , resolve cluster true and Invalid Cluster manager API
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute             |
      | Data Source Type | HdfsDataSource        |
#      | Plugin version   | LATEST                |
      | Credential       | hdfsDBEmptyCredential |
      | Node             | Cluster Demo          |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "click" on "field" button in "Cluster manager configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       | pageName       |
      | Name                        | HdfsDataSource  |                |
      | Label                       | HdfsDataSource  |                |
      | HDFS username               | hdfs            |                |
      | Cluster manager hostname    | clusterHostName | PropertyLoader |
      | Cluster manager port        | 8080            |                |
      | Cluster manager API version | api/v12         |                |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"


# ######################################Data Source connection invalid host (CLOUDERA)#####################################
##7130020 Now it is passing
#  @MLP-24196 @webtest @regression @positive
#  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for hdfs DataSource with valid credentials , resolve cluster true and Invalid hostname in CLOUDERA
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem          |
#      | click      | Settings Icon       |
#      | click      | Manage Data Sources |
#    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName        | attribute              |
#      | Data Source Type | HdfsDataSource        |
#      | Plugin version   | LATEST                 |
#      | Credential       | hdfsDBValidCredential |
#      | Node       | Cluster Demo              |
#    And user "click" on "slide bar" button in "resolveClusterName"
#    And user "click" on "field" button in "Cluster manager configuration settings"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName            | attribute |
#      | Cluster manager name | CLOUDERA  |
#    And user "enter text" in Add Data Source Page
#      | fieldName                   | attribute                 |
#      | Name                        | HdfsDataSource           |
#      | Label                       | HdfsDataSource           |
#      | HDFS username               | hdfs           |
#      | Cluster manager hostname    | 35                        |
#      | Cluster manager port        | 8080                      |
#      | Cluster manager API version | api/v1                    |
#    And user "click" on "Test Connection" button in "Add Data Sources pop up"
#    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
#
# ######################################Data Source connection invalid Port (CLOUDERA)#####################################
##7130020 Now it is passing
#  @MLP-24196 @webtest @regression @positive
#  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for hdfs DataSource with valid credentials , resolve cluster true and Invalid Port in CLOUDERA
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem          |
#      | click      | Settings Icon       |
#      | click      | Manage Data Sources |
#    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName        | attribute              |
#      | Data Source Type | HdfsDataSource        |
#      | Plugin version   | LATEST                 |
#      | Credential       | hdfsDBValidCredential |
#      | Node       | Cluster Demo              |
#    And user "click" on "slide bar" button in "resolveClusterName"
#    And user "click" on "field" button in "Cluster manager configuration settings"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName            | attribute |
#      | Cluster manager name | CLOUDERA  |
#    And user "enter text" in Add Data Source Page
#      | fieldName                   | attribute                 |
#      | Name                        | HdfsDataSource           |
#      | Label                       | HdfsDataSource           |
#      | HDFS username               | hdfs           |
#      | Cluster manager hostname    | 10.33.10.138              |
#      | Cluster manager port        | 75                        |
#      | Cluster manager API version | api/v1                    |
#    And user "click" on "Test Connection" button in "Add Data Sources pop up"
#    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

#######################################Data Source connection invalid cluster manger API (HORTONWORKS)#####################################
##7130020
#  @MLP-24196 @webtest @regression @positive
#  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for hdfs DataSource with valid credentials , resolve cluster true and Invalid Cluster manager API in CLOUDERA
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem          |
#      | click      | Settings Icon       |
#      | click      | Manage Data Sources |
#    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName        | attribute              |
#      | Data Source Type | HdfsDataSource        |
#      | Plugin version   | LATEST                 |
#      | Credential       | hdfsDBValidCredential |
#      | Node       | Cluster Demo              |
#    And user "click" on "slide bar" button in "resolveClusterName"
#    And user "click" on "field" button in "Cluster manager configuration settings"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName            | attribute |
#      | Cluster manager name | CLOUDERA  |
#    And user "enter text" in Add Data Source Page
#      | fieldName                   | attribute                 |
#      | Name                        | HdfsDataSource           |
#      | Label                       | HdfsDataSource           |
#      | HDFS username               | hdfs           |
#      | Cluster manager hostname    | 10.33.10.138              |
#      | Cluster manager port        | 8080                      |
#      | Cluster manager API version | api/v12                   |
#    And user "click" on "Test Connection" button in "Add Data Sources pop up"
#    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"


  ######################################Data Source connection empty resolve cluster fields(HORTONWORKS)#####################################
#7132253
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for hdfs DataSource with valid credentials , resolve cluster true and empty resolve cluster fields - HORTONWORKS
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute             |
      | Data Source Type | HdfsDataSource        |
#      | Plugin version   | LATEST                |
      | Credential       | hdfsDBValidCredential |
      | Node             | Cluster Demo          |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "click" on "field" button in "Cluster manager configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute      |
      | Name                        | HdfsDataSource |
      | Label                       | HdfsDataSource |
      | HDFS username               | hdfs           |
      | Cluster manager hostname    |                |
      | Cluster manager port        |                |
      | Cluster manager API version |                |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

    ######################################Data Source connection valid Cluster resolve settings invalid credentials#####################################
#7132254
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for hdfs DataSource with Invalid credentials and valid URL
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute               |
      | Data Source Type | HdfsDataSource          |
#      | Plugin version   | LATEST                  |
      | Credential       | hdfsDBInValidCredential |
      | Node             | Cluster Demo            |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "click" on "field" button in "Cluster manager configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       | pageName       |
      | Name                        | HdfsDataSource  |                |
      | Label                       | HdfsDataSource  |                |
      | HDFS username               | hdfs            |                |
      | Cluster manager hostname    | clusterHostName | PropertyLoader |
      | Cluster manager port        | 8080            |                |
      | Cluster manager API version | api/v1          |                |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

    ######################################Data Source connection valid Cluster resolve settings empty credentials#####################################
#7132254
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for hdfs DataSource with Empty credentials and valid URL
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute             |
      | Data Source Type | HdfsDataSource        |
#      | Plugin version   | LATEST                |
      | Credential       | hdfsDBEmptyCredential |
      | Node             | Cluster Demo          |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "click" on "field" button in "Cluster manager configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       | pageName       |
      | Name                        | HdfsDataSource  |                |
      | Label                       | HdfsDataSource  |                |
      | HDFS username               | hdfs            |                |
      | Cluster manager hostname    | clusterHostName | PropertyLoader |
      | Cluster manager port        | 8080            |                |
      | Cluster manager API version | api/v1          |                |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

  ######################################Data Source connection valid Cluster resolve settings valid credentials#####################################
#7132249
  @MLP-24196 @webtest @regression @positive
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is  success for hdfs DataSource with valid credentials and valid URL
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute             |
      | Data Source Type | HdfsDataSource        |
#      | Plugin version   | LATEST                |
      | Credential       | hdfsDBValidCredential |
      | Node             | Cluster Demo          |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "click" on "field" button in "Cluster manager configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       | pageName       |
      | Name                        | HdfsDataSource  |                |
      | Label                       | HdfsDataSource  |                |
      | HDFS username               | hdfs            |                |
      | Cluster manager hostname    | clusterHostName | PropertyLoader |
      | Cluster manager port        | 8080            |                |
      | Cluster manager API version | api/v1          |                |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"

       ######################################HDFS cataloger successfull connection with valid DS(cluster resolve TRUE) valid credentials#####################################

  #7148475
  @MLP-24889 @webtest @regression @positive
  Scenario:SC3#MLP_24196_Verify HDFS cataloger connection success with valid Data Source with cluster resolve TRUE with valid credentials
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
      | Type      | Cataloger     |
      | Plugin    | HdfsCataloger |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName      | attribute             |
      | Plugin version | LATEST                |
      | Credential     | hdfsDBValidCredential |
      | Data Source    | HDFSDataSource_valid  |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  | HbaseCataloger         |
      | Max hits              | 100                    |
      | Delta time            | 30                     |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"

     ######################################HDFS cataloger failure connection with valid DS(cluster resolve TRUE) Invalid credentials#####################################

  #7148474
  @MLP-24889 @webtest @regression @positive
  Scenario:SC3#MLP_24196_Verify HDFS cataloger connection failure with valid Data Source with cluster resolve TRUE with Invalid credentials
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
      | Type      | Cataloger     |
      | Plugin    | HdfsCataloger |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName      | attribute               |
      | Plugin version | LATEST                  |
      | Credential     | hdfsDBInValidCredential |
      | Data Source    | HDFSDataSource_valid    |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  | HbaseCataloger         |
      | Max hits              | 100                    |
      | Delta time            | 30                     |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

   ######################################HDFS cataloger failure connection with valid DS(cluster resolve TRUE) empty credentials#####################################

  #7148473
  @MLP-24889 @webtest @regression @positive
  Scenario:SC3#MLP_24196_Verify HDFS cataloger connection failure with valid Data Source with cluster resolve TRUE with empty credentials
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
      | Type      | Cataloger     |
      | Plugin    | HdfsCataloger |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName      | attribute             |
      | Plugin version | LATEST                |
      | Credential     | hdfsDBEmptyCredential |
      | Data Source    | HDFSDataSource_valid  |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  | HbaseCataloger         |
      | Max hits              | 100                    |
      | Delta time            | 30                     |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

      ######################################HDFS cataloger successfull connection with valid DS(cluster resolve FALSE) valid credentials#####################################


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC2#-MLP_24889_set HDFS data source with cluter resolve name false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                               | body                                                                             | response code | response message                   | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HdfsDataSource | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HdfsDataSource |                                                                                  | 200           | HDFSDataSource_resolveclusterfalse |          |

    #7148471
  @MLP-24889 @webtest @regression @positive
  Scenario:SC3#MLP_24196_Verify HDFS cataloger connection success with valid Data Source with cluster resolve FALSE with valid credentials
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
      | Type      | Cataloger     |
      | Plugin    | HdfsCataloger |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName      | attribute                          |
      | Plugin version | LATEST                             |
      | Credential     | hdfsDBValidCredential              |
      | Data Source    | HDFSDataSource_resolveclusterfalse |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  | HbaseCataloger         |
      | Max hits              | 100                    |
      | Delta time            | 30                     |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"

       ######################################HDFS cataloger successfull connection with valid DS(cluster resolve FALSE) Invalid credentials#####################################

#7148470
  @MLP-24889 @webtest @regression @positive
  Scenario:SC3#MLP_24196_Verify HDFS cataloger connection Failure with valid Data Source with cluster resolve FALSE with Invalid credentials
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
      | Type      | Cataloger     |
      | Plugin    | HdfsCataloger |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName      | attribute                          |
      | Plugin version | LATEST                             |
      | Credential     | hdfsDBInValidCredential            |
      | Data Source    | HDFSDataSource_resolveclusterfalse |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  | HbaseCataloger         |
      | Max hits              | 100                    |
      | Delta time            | 30                     |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"

      ######################################HDFS cataloger successfull connection with valid DS(cluster resolve FALSE) Empty credentials#####################################

#7148472
  @MLP-24889 @webtest @regression @positive
  Scenario:SC3#MLP_24196_Verify HDFS cataloger connection Failure with valid Data Source with cluster resolve FALSE with Empty credentials
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
      | Type      | Cataloger     |
      | Plugin    | HdfsCataloger |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName      | attribute                          |
      | Plugin version | LATEST                             |
      | Credential     | hdfsDBEmptyCredential              |
      | Data Source    | HDFSDataSource_resolveclusterfalse |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  | HbaseCataloger         |
      | Max hits              | 100                    |
      | Delta time            | 30                     |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"


#

    ###############################################Cataloger- doesn't collects the data when the scanHDFS field is set FALSE cluster name FALSE  in CLUSTER DEMO node########################

  Scenario: SC4#-MLP_24889_Update the Host name respect to the docker for second run
    And user update the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_scanHdfs_False_Configuration.json" file for following values
      | jsonPath                          | jsonValues           |
      | $.configurations..nodeCondition   | name=="Cluster Demo" |
      | $.configurations..filter..root    | /MaxHits1            |
      | $.configurations..name            | SC5_ScanHdfs         |
      | $.configurations..tags[*]         | SC5_ScanHdfs         |
      | $.configurations..filter..tags[*] | scanHdfsFalse        |
      | $.configurations..filter..maxHits | 100                  |


  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline: SC4#Upload 4 subfolders in ambari
    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                   | body                                                  | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | MaxHits1/Sub1/Sub2/Sub3/Sub4/uploadFile2.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/HdfsAutomationTestData2.csv | 201           |                  |

    #7148478
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC4#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                             | body                                                                                | response code | response message                   | jsonPath                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                | ida\hbasePayloads\DataSource\license_DS.json                                        | 204           |                                    |                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                               | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json    | 204           |                                    |                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                               |                                                                                     | 200           | HDFSDataSource_resolveclusterfalse |                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_scanHdfs_False_Configuration.json | 204           |                                    |                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                |                                                                                     | 200           | SC5_ScanHdfs                       |                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC5_ScanHdfs |                                                                                     | 200           | IDLE                               | $.[?(@.configurationName=='SC5_ScanHdfs')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC5_ScanHdfs  |                                                                                     | 200           |                                    |                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC5_ScanHdfs |                                                                                     | 200           | IDLE                               | $.[?(@.configurationName=='SC5_ScanHdfs')].status |

  #bug-26140
  @sanity @positive @webtest @hbase
  Scenario:SC4#MLP_24889_Verify the cataloger doesn't collects the data when the scanHDFS field is set FALSE
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC5_ScanHdfs" and clicks on search
    And user performs "facet selection" in "SC5_ScanHdfs" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Directory |
      | File      |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/HdfsCataloger/SC5_ScanHdfs%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of errors          | 0             |
      | Number of processed items | 0             |
    And user "widget not present" on "Processed Items" in Item view page

  Scenario:SC4:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC5_ScanHdfs/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                           | Cluster  |       |       |

  @MLP-1960  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC4:Delete folder in Ambaris
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization               | X-Requested-By | type   | url                                     | body | response code | response message |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /MaxHits1?op=DELETE&recursive=true      |      | 200           | true             |

    #########################################################SCAN HDFS FALSE and SCAN SERVICE FALSE############################################
  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline: SC5#Upload 4 subfolders in ambari
    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                          | body                                                  | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | ScanServiceTest/Sub1/Sub2/Sub3/Sub4/uploadFile2.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/HdfsAutomationTestData2.csv | 201           |                  |

  Scenario: SC5#-MLP_24269_Update the Host name respect to the docker
    And user update json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |
    And user update the json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values
      | jsonPath                              | jsonValues |
      | $.configurations[0].catalogerHdfsUser | hdfs       |

  Scenario: SC5#-MLP_24269_Update the plugin name and tag name
    And user "update" the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_scanHdfs_scanServices_Configuration.json" file for following values
      | jsonPath                               | jsonValues                          | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"                |         |
      | $.configurations..dataSource           | HDFSDataSource_valid                |         |
      | $.configurations..filter..root         | /ScanServiceTest                    |         |
      | $.configurations..name                 | SC13_scanHdfsFALSE_scanServiceFALSE |         |
      | $.configurations..tags[*]              | SC13_scanHdfsFALSE_scanServiceFALSE |         |
      | $.configurations..filter..tags[*]      | Positive                            |         |
      | $.configurations..analyzeCollectedData | false                               | boolean |
      | $.configurations..scanHdfs             | false                               | boolean |
      | $.configurations..scanServices         | false                               | boolean |


  @positve @regression @sanity  @MLP-24269 @IDA-1.1.0
  Scenario Outline: SC5#-MLP_24269_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                    | body                                                                                       | response code | response message                    | jsonPath                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                                       | ida\hbasePayloads\DataSource\license_DS.json                                               | 204           |                                     |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                                      | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json                               | 204           |                                     |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                                      |                                                                                            | 200           | HDFSDataSource_valid                |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                                       | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_scanHdfs_scanServices_Configuration.json | 204           |                                     |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                                       |                                                                                            | 200           | SC13_scanHdfsFALSE_scanServiceFALSE |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC13_scanHdfsFALSE_scanServiceFALSE |                                                                                            | 200           | IDLE                                | $.[?(@.configurationName=='SC13_scanHdfsFALSE_scanServiceFALSE')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC13_scanHdfsFALSE_scanServiceFALSE  |                                                                                            | 200           |                                     |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC13_scanHdfsFALSE_scanServiceFALSE |                                                                                            | 200           | IDLE                                | $.[?(@.configurationName=='SC13_scanHdfsFALSE_scanServiceFALSE')].status |

    #7190160
  @webtest
  Scenario:SC5#MLP_24269_Verify scan services are not collected and directory/files are not collected if  scan services is OFF and Scan Hdfs : OFF
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC13_scanHdfsFALSE_scanServiceFALSE" and clicks on search
    And user performs "facet selection" in "SC13_scanHdfsFALSE_scanServiceFALSE" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | File           |
      | Configurations |
      | Roles          |

  Scenario:SC5:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                          | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC13_scanHdfsFALSE_scanServiceFALSE/% | Analysis |       |       |

    #############################################Create directory and upload a file#########################################################

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC#6Creating a directory in Ambari Files View and Uploading a file into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                      | body                                                  | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/sub1/testdata.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/HdfsAutomationTestData1.csv | 201           |                  |



  Scenario: SC6#-MLP_24889_Update the Host name respect to the docker
    And user update the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_Configuration.json" file for following values
      | jsonPath                          | jsonValues               |
      | $.configurations..nodeCondition   | name=="Cluster Demo"     |
      | $.configurations..filter..root    | /idaautomation           |
      | $.configurations..name            | SC1_folderwith1subfolder |
      | $.configurations..tags[*]         | SC1_folderwith1subfolder |
      | $.configurations..filter..tags[*] | createDir                |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC6#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                                             | response code | response message                   | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                            | ida\hbasePayloads\DataSource\license_DS.json                                     | 204           |                                    |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                           | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                           |                                                                                  | 200           | HDFSDataSource_resolveclusterfalse |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                            | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_Configuration.json             | 204           |                                    |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                            |                                                                                  | 200           | SC1_folderwith1subfolder           |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_folderwith1subfolder |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC1_folderwith1subfolder')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC1_folderwith1subfolder  |                                                                                  | 200           |                                    |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_folderwith1subfolder |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC1_folderwith1subfolder')].status |


    ###############################Cluster , Metadata , Host , Column , Table Metadata validation and Bread crumbs validation######################################

  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0
  Scenario Outline: SC6#user retrieves ID for Cluster , service , Host , Directory . sub-directory and File
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type      | name          | asg_scopeid | targetFile                        | jsonpath            |
      | APPDBPOSTGRES | ID      | Default | File      | testdata.csv  |             | response/HDFS/actual/itemIds.json | $..has_Table.id     |
      | APPDBPOSTGRES | ID      | Default | Service   | HDFS          |             | response/HDFS/actual/itemIds.json | $..has_Service.id   |
      | APPDBPOSTGRES | ID      | Default | Directory | idaautomation |             | response/HDFS/actual/itemIds.json | $..has_Database.id  |
      | APPDBPOSTGRES | ID      | Default | Directory | sub1          |             | response/HDFS/actual/itemIds.json | $..has_Database.id2 |
      | APPDBPOSTGRES | ID      | Default | Cluster   | Cluster Demo  |             | response/HDFS/actual/itemIds.json | $..Cluster.id       |

  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0
  Scenario Outline: SC6#user retrieves the metadata of each data type for a catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                           | responseCode | inputJson           | inputFile                         | outPutFile                                        | outPutJson |
      | components/Default/item/Default.Cluster:::dynamic?pages=ALL   | 200          | $..Cluster.id       | response/HDFS/actual/itemIds.json | response/HDFS/actual/clusterMetadata.json         |            |
      | components/Default/item/Default.Service:::dynamic?pages=ALL   | 200          | $..has_Service.id   | response/HDFS/actual/itemIds.json | response/HDFS/actual/serviceMetadata.json         |            |
      | components/Default/item/Default.Directory:::dynamic?pages=ALL | 200          | $..has_Database.id  | response/HDFS/actual/itemIds.json | response/HDFS/actual/parentDirectoryMetadata.json |            |
      | components/Default/item/Default.Directory:::dynamic?pages=ALL | 200          | $..has_Database.id2 | response/HDFS/actual/itemIds.json | response/HDFS/actual/childDirectorydata.json      |            |
      | components/Default/item/Default.File:::dynamic?pages=ALL      | 200          | $..has_Table.id     | response/HDFS/actual/itemIds.json | response/HDFS/actual/fileMetadata.json            |            |

  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0
  Scenario Outline: SC6#validate the total count and facets count for a catalog
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                          | response code | response message | filePath                                 | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | response/HDFS/body/getFacetsCountRequest.json | 200           |                  | response/HDFS/actual/facetWiseCount.json |          |

       #Bug-25946
  #7148464
  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0
  Scenario Outline:SC6# Validate Cluster,Host,Service,Database,Table,BreadCrumb and Constraint should have the appropriate metadata information in IDC UI
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                   | actualValues                                      | valueType      | expectedJsonPath                                                                     | actualJsonPath                                                |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/facetWiseCount.json          | intCompare     | $..totalCount                                                                        | $..count                                                      |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/facetWiseCount.json          | intListCompare | $..MetaData.facetCounts.type_s..count                                                | $.facetCounts..type_s..count                                  |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/clusterMetadata.json         | stringCompare  | $..clusterMetaData..table..values.[?(@.type=='Services')].name                       | $..[?(@.caption=='Services')].data..[?(@.name=='HDFS')]..name |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/serviceMetadata.json         | stringCompare  | $.MetaData.serviceMetaData.name                                                      | $.caption.name                                                |
#      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/serviceMetadata.json         | stringCompare     | $.MetaData.serviceMetaData.table.values[0].name                                      | $..[?(@.caption=='has_Directory')].data..[?(@.name=='ROOT')]..name                     |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/parentDirectoryMetadata.json | stringCompare  | $.MetaData.parentdirectoryMetaData.name                                              | $.caption.name                                                |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/parentDirectoryMetadata.json | stringCompare  | $.MetaData.parentdirectoryMetaData.Description.location                              | $.data[0].data[0].data.attributes[0].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/parentDirectoryMetadata.json | stringCompare  | $.MetaData.parentdirectoryMetaData.Description.permission                            | $.data[0].data[0].data.attributes[2].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/parentDirectoryMetadata.json | stringCompare  | $.MetaData.parentdirectoryMetaData.Description.group                                 | $.data[0].data[0].data.attributes[1].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/parentDirectoryMetadata.json | stringCompare  | $.MetaData.parentdirectoryMetaData.Description.Createdby                             | $.data[0].data[0].data.attributes[3].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/parentDirectoryMetadata.json | stringCompare  | $.MetaData.parentdirectoryMetaData.Lifecycle.Modified                                | $.data[0].data[1].data.attributes[0].caption                  |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/parentDirectoryMetadata.json | stringCompare  | $.MetaData.parentdirectoryMetaData.Statistics.Numberoffiles                          | $.data[0].data[2].data.attributes[0].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/parentDirectoryMetadata.json | stringCompare  | $.MetaData.parentdirectoryMetaData.Statistics.Sizeoffiles                            | $.data[0].data[2].data.attributes[1].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/parentDirectoryMetadata.json | stringCompare  | $.MetaData.parentdirectoryMetaData.Statistics.Sizeofsub_directories                  | $.data[0].data[2].data.attributes[3].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/parentDirectoryMetadata.json | stringCompare  | $.MetaData.parentdirectoryMetaData.Statistics.Numberofsub_directories                | $.data[0].data[2].data.attributes[2].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/parentDirectoryMetadata.json | stringCompare  | $.MetaData.parentdirectoryMetaData.Statistics.Directorysize                          | $.data[0].data[2].data.attributes[4].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/childDirectorydata.json      | stringCompare  | $.MetaData.parentdirectoryMetaData.childdirectory.name                               | $.caption.name                                                |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/childDirectorydata.json      | stringCompare  | $.MetaData.parentdirectoryMetaData.childdirectory.Description.location               | $.data[0].data[0].data.attributes[0].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/childDirectorydata.json      | stringCompare  | $.MetaData.parentdirectoryMetaData.childdirectory.Description.permission             | $.data[0].data[0].data.attributes[2].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/childDirectorydata.json      | stringCompare  | $.MetaData.parentdirectoryMetaData.childdirectory.Description.group                  | $.data[0].data[0].data.attributes[1].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/childDirectorydata.json      | stringCompare  | $.MetaData.parentdirectoryMetaData.childdirectory.Description.Createdby              | $.data[0].data[0].data.attributes[3].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/childDirectorydata.json      | stringCompare  | $.MetaData.parentdirectoryMetaData.childdirectory.Lifecycle.Modified                 | $.data[0].data[1].data.attributes[0].caption                  |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/childDirectorydata.json      | stringCompare  | $.MetaData.parentdirectoryMetaData.childdirectory.Statistics.Numberoffiles           | $.data[0].data[2].data.attributes[0].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/childDirectorydata.json      | stringCompare  | $.MetaData.parentdirectoryMetaData.childdirectory.Statistics.Sizeoffiles             | $.data[0].data[2].data.attributes[1].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/childDirectorydata.json      | stringCompare  | $.MetaData.parentdirectoryMetaData.childdirectory.Statistics.Sizeofsub_directories   | $.data[0].data[2].data.attributes[3].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/childDirectorydata.json      | stringCompare  | $.MetaData.parentdirectoryMetaData.childdirectory.Statistics.Numberofsub_directories | $.data[0].data[2].data.attributes[2].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/childDirectorydata.json      | stringCompare  | $.MetaData.parentdirectoryMetaData.childdirectory.Statistics.Directorysize           | $.data[0].data[2].data.attributes[4].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/fileMetadata.json            | stringCompare  | $.MetaData.fileMetaData.name                                                         | $.caption.name                                                |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/fileMetadata.json            | stringCompare  | $.MetaData.fileMetaData.Description.location                                         | $.data[0].data[0].data.attributes[0].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/fileMetadata.json            | stringCompare  | $.MetaData.fileMetaData.Description.permission                                       | $.data[0].data[0].data.attributes[4].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/fileMetadata.json            | stringCompare  | $.MetaData.fileMetaData.Description.group                                            | $.data[0].data[0].data.attributes[3].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/fileMetadata.json            | stringCompare  | $.MetaData.fileMetaData.Description.Createdby                                        | $.data[0].data[0].data.attributes[5].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/fileMetadata.json            | stringCompare  | $.MetaData.fileMetaData.Description.MIMEtype                                         | $.data[0].data[0].data.attributes[1].data.value               |
      | response/HDFS/expected/HDFSExpectedJsonData.json | response/HDFS/actual/fileMetadata.json            | stringCompare  | $.MetaData.fileMetaData.Description.Filesize                                         | $.data[0].data[0].data.attributes[2].data.value               |


 ###############################################Cataloger - Rename the files in ambari and verify the existing and renamed file presence ,resolve cluster name FALSE###################################

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline: SC7#Renaming the already created file in the existing directory
    Given sync the test execution for "10" seconds
    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                             | body | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/sub1/testdata.csv?user.name=raj_ops&op=RENAME&destination=/idaautomation/sub1/testdataRenamed.csv |      | 200           | true             |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC7#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                                             | response code | response message                   | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                            | ida\hbasePayloads\DataSource\license_DS.json                                     | 204           |                                    |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                           | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                           |                                                                                  | 200           | HDFSDataSource_resolveclusterfalse |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                            | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_Configuration.json             | 204           |                                    |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                            |                                                                                  | 200           | SC1_folderwith1subfolder           |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_folderwith1subfolder |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC1_folderwith1subfolder')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC1_folderwith1subfolder  |                                                                                  | 200           |                                    |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC1_folderwith1subfolder |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC1_folderwith1subfolder')].status |


#  @MLP-1960  @sftp @positve @hdfs @regression @sanity
#  Scenario: SC#2Verify the message.log has the entry for running of HdfsCataloger.
#    Given sync the test execution for "10" seconds
#    When user connects to the SFTP server and downloads the "messages.log"
#    Then user validates the entries in "messages.log"
#      | logEntry                 |
#      | HdfsMonitorScanInitiated |

#7148464
  @MLP-24889  @sanity @positive
  Scenario Outline: SC7 MLP_24889_Verify Hdfs Catalog functionality by renaming a directory
    And user update the json file "ida/hdfsPayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                       |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC1_folderwith1subfolder                         |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/Cluster Demo/Service/HDFS/Directory/ROOT |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                  | body                                          | response code | response message | filePath                                         | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC1_folderwith1subfolder&limitFacet=10&offset=0&limit=2500 | payloads/ida/hdfsPayloads/API/SC2_Filter.json | 200           |                  | response\HDFS\TableFilter\Actual\SC1_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#7 MLP_24889_Compare the tables with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                     | actualValues                                     | valueType         | expectedJsonPath           | actualJsonPath                   |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC1_Filter.json | stringListCompare | $.SC1.Directory.name       | $..[?(@.type=='Directory')].name |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC1_Filter.json | stringListCompare | $.SC1.Directory.files.name | $..[?(@.type=='File')].name      |

  @positve @regression @sanity  @ambari
  Scenario:SC7:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC1_folderwith1subfolder/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                                       | Cluster  |       |       |

  @MLP-1960  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC7:Delete the created files in Ambaris
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization               | X-Requested-By | type   | url                                     | body | response code | response message |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /idaautomation?op=DELETE&recursive=true |      | 200           | true             |



 ###############################################Cataloger -Create new directory and new files cluster name FALSE  in CLUSTER DEMO node########################

  #7148466
  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline: SC8#Upload one file into the directory
    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                            | body                                                  | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/upload1/uploadFile1.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/HdfsAutomationTestData1.csv | 201           |                  |

  Scenario: SC8#-MLP_24889_Update the Host name respect to the docker
    And user update the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_Configuration.json" file for following values
      | jsonPath                          | jsonValues           |
      | $.configurations..nodeCondition   | name=="Cluster Demo" |
      | $.configurations..filter..root    | /idaautomation       |
      | $.configurations..name            | SC2_Uploadfolders    |
      | $.configurations..tags[*]         | SC2_Uploadfolders    |
      | $.configurations..filter..tags[*] | folder1              |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC8#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | body                                                                             | response code | response message                   | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                     | ida\hbasePayloads\DataSource\license_DS.json                                     | 204           |                                    |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                    | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                    |                                                                                  | 200           | HDFSDataSource_resolveclusterfalse |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                     | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_Configuration.json             | 204           |                                    |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                     |                                                                                  | 200           | SC2_Uploadfolders                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC2_Uploadfolders |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC2_Uploadfolders')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC2_Uploadfolders  |                                                                                  | 200           |                                    |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC2_Uploadfolders |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC2_Uploadfolders')].status |

#  @MLP-1960 @negative @hdfs @sftp
#  Scenario: SC#5Verify the message.log has the entry for running of HdfsCataloger.
#    Given sync the test execution for "2" seconds
#    When user connects to the SFTP server and downloads the "messages.log"
#    Then user validates the entries in "messages.log"
#      | logEntry                                |
#      | HdfsMonitorScanInitiatedForExclsnFilter |

  #7148464
  @MLP-24889  @sanity @positive
  Scenario Outline: SC8 MLP_24889_Verify Hdfs Catalog functionality by adding a new directory and new file to directory
    And user update the json file "ida/hdfsPayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                       |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC2_Uploadfolders                                |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/Cluster Demo/Service/HDFS/Directory/ROOT |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                           | body                                          | response code | response message | filePath                                         | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC2_Uploadfolders&limitFacet=10&offset=0&limit=2500 | payloads/ida/hdfsPayloads/API/SC2_Filter.json | 200           |                  | response\HDFS\TableFilter\Actual\SC2_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#8 MLP_24889_Compare the tables with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                     | actualValues                                     | valueType         | expectedJsonPath                | actualJsonPath                   |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC2_Filter.json | stringListCompare | $.SC2.Run1.Directory.name       | $..[?(@.type=='Directory')].name |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC2_Filter.json | stringListCompare | $.SC2.Run1.Directory.files.name | $..[?(@.type=='File')].name      |

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline: SC8#Upload second file into the new directory
    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                            | body                                                  | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/upload2/uploadFile2.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/HdfsAutomationTestData2.csv | 201           |                  |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC8#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger for second run
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | body                                                                             | response code | response message                   | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                     | ida\hbasePayloads\DataSource\license_DS.json                                     | 204           |                                    |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                    | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                    |                                                                                  | 200           | HDFSDataSource_resolveclusterfalse |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                     | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_Configuration.json             | 204           |                                    |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                     |                                                                                  | 200           | SC2_Uploadfolders                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC2_Uploadfolders |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC2_Uploadfolders')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC2_Uploadfolders  |                                                                                  | 200           |                                    |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC2_Uploadfolders |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC2_Uploadfolders')].status |

  @MLP-24889  @sanity @positive
  Scenario Outline: SC8 MLP_24889_Verify Hdfs Catalog functionality by adding a second new directory and second new file to directory
    And user update the json file "ida/hdfsPayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                       |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC2_Uploadfolders                                |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/Cluster Demo/Service/HDFS/Directory/ROOT |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                           | body                                          | response code | response message | filePath                                         | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC2_Uploadfolders&limitFacet=10&offset=0&limit=2500 | payloads/ida/hdfsPayloads/API/SC2_Filter.json | 200           |                  | response\HDFS\TableFilter\Actual\SC2_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#8 MLP_24889_Compare the tables with respect to filters for 2nd run
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                     | actualValues                                     | valueType         | expectedJsonPath                | actualJsonPath                   |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC2_Filter.json | stringListCompare | $.SC2.Run2.Directory.name       | $..[?(@.type=='Directory')].name |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC2_Filter.json | stringListCompare | $.SC2.Run2.Directory.files.name | $..[?(@.type=='File')].name      |


  Scenario:SC8:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                        | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC2_Uploadfolders/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                                | Cluster  |       |       |

  @MLP-1960  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC8:Delete the created files in Ambaris
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization               | X-Requested-By | type   | url                                     | body | response code | response message |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /idaautomation?op=DELETE&recursive=true |      | 200           | true             |

###############################################Cataloger- > 10 directory and >10 files >100 charectors file name and Empty folder cluster name FALSE  in CLUSTER DEMO node########################

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline: SC9#Upload >10 Dir , >10 files ,  >100 charectors in file name and directory name , empty directory and file wiht no extension
    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                                                                                                                                                                            | body                                                                                                                                                                                                         | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/sub1/uploadFile1.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                                                                                    | ida/hdfsPayloads/TestData/HdfsAutomationTestData1.csv                                                                                                                                                        | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/sub2/Test+Results+-+Scenario__SC#33_2_Verify_Tag_is_set_for_the_column_when_namePattern_and_dataPattern_minimumRatio_matches_with_the_column_name_value_ratio_in_Oracle_table_ (4).html?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/Test+Results+-+Scenario__SC#33_2_Verify_Tag_is_set_for_the_column_when_namePattern_and_dataPattern_minimumRatio_matches_with_the_column_name_value_ratio_in_Oracle_table_ (4).html | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/sub3/uploadFile3.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                                                                                    | ida/hdfsPayloads/TestData/HdfsAutomationTestData1.csv                                                                                                                                                        | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/sub4/dummy.pdf?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                                                                                          | ida/hdfsPayloads/TestData/dummy.pdf                                                                                                                                                                          | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/sub5/CALC-1985.doc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                                                                                      | ida/hdfsPayloads/TestData/CALC-1985.doc                                                                                                                                                                      | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/sub6/insert_cycling_cassandra.txt?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                                                                       | ida/hdfsPayloads/TestData/insert_cycling_cassandra.txt                                                                                                                                                       | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/sub7/hdfs (1).zip?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                                                                                       | ida/hdfsPayloads/TestData/hdfs (1).zip                                                                                                                                                                       | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/sub8/userdata1.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                                                                                  | ida/hdfsPayloads/TestData/userdata1.parquet                                                                                                                                                                  | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/sub9/userdata2.parquet?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                                                                                  | ida/hdfsPayloads/TestData/userdata1.parquet                                                                                                                                                                  | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/sub10/uploadFile4.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                                                                                   | ida/hdfsPayloads/TestData/HdfsAutomationTestData1.csv                                                                                                                                                        | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/sub11/insert_cycling.txt?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                                                                                | ida/hdfsPayloads/TestData/insert_cycling_cassandra.txt                                                                                                                                                       | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/asdsadfffffffffffffffffffffffffsaaaaaaaaaaaaaaaaaaaacdefghifklmnopqrstuvxyzqwertyuioasdfghjklzxcvbnmokmijnuhygvtfcrdxeszqawsxedcrfvtgbyhnujio/uploadFile5.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                           | ida/hdfsPayloads/TestData/HdfsAutomationTestData1.csv                                                                                                                                                        | 201           |                  |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/sub12?op=MKDIRS&recursive=true&overwrite=true                                                                                                                                                                                                                                                                    |                                                                                                                                                                                                              | 200           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/sub11/insert_cycling1?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                                                                                   | ida/hdfsPayloads/TestData/insert_cycling_cassandra.txt                                                                                                                                                       | 201           |                  |

  Scenario: SC9#-MLP_24889_Update the Host name respect to the docker
    And user update the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_Configuration.json" file for following values
      | jsonPath                          | jsonValues           |
      | $.configurations..nodeCondition   | name=="Cluster Demo" |
      | $.configurations..filter..root    | /idaautomation       |
      | $.configurations..name            | SC3_MultiCombination |
      | $.configurations..tags[*]         | SC3_MultiCombination |
      | $.configurations..filter..tags[*] | MultiCombo           |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC9#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                             | response code | response message                   | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                        | ida\hbasePayloads\DataSource\license_DS.json                                     | 204           |                                    |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                       | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                       |                                                                                  | 200           | HDFSDataSource_resolveclusterfalse |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                        | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_Configuration.json             | 204           |                                    |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                        |                                                                                  | 200           | SC3_MultiCombination               |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC3_MultiCombination |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC3_MultiCombination')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC3_MultiCombination  |                                                                                  | 200           |                                    |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC3_MultiCombination |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC3_MultiCombination')].status |

    #7148464
  @MLP-24889  @sanity @positive
  Scenario Outline: SC9 MLP_24889_Verify Hdfs Catalog functionality by > 10 directory and >10 files >100 charectors file name and Empty folder
    And user update the json file "ida/hdfsPayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                       |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC3_MultiCombination                             |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/Cluster Demo/Service/HDFS/Directory/ROOT |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                              | body                                          | response code | response message | filePath                                         | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC3_MultiCombination&limitFacet=10&offset=0&limit=2500 | payloads/ida/hdfsPayloads/API/SC2_Filter.json | 200           |                  | response\HDFS\TableFilter\Actual\SC3_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#9 MLP_24889_Compare the tables with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                     | actualValues                                     | valueType         | expectedJsonPath                | actualJsonPath                   |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC3_Filter.json | stringListCompare | $.SC3.Run1.Directory.name       | $..[?(@.type=='Directory')].name |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC3_Filter.json | stringListCompare | $.SC3.Run1.Directory.files.name | $..[?(@.type=='File')].name      |



    ###############################################Cataloger- > Deleting directory cluster name FALSE  in CLUSTER DEMO node########################

  @MLP-1960  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC10:Delete the one of the sub directory  in Ambari
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization               | X-Requested-By | type   | url                                           | body | response code | response message |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /idaautomation/sub12?op=DELETE&recursive=true |      | 200           | true             |

  Scenario: SC10#-MLP_24889_Update the Host name respect to the docker for second run
    And user update the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_Configuration.json" file for following values
      | jsonPath                          | jsonValues                     |
      | $.configurations..nodeCondition   | name=="Cluster Demo"           |
      | $.configurations..filter..root    | /idaautomation                 |
      | $.configurations..name            | SC3_MultiCombination_deletedir |
      | $.configurations..tags[*]         | SC3_MultiCombination_deletedir |
      | $.configurations..filter..tags[*] | MultiCombo                     |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC10#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger second run
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                               | body                                                                             | response code | response message                   | jsonPath                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                                  | ida\hbasePayloads\DataSource\license_DS.json                                     | 204           |                                    |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                                 | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                                 |                                                                                  | 200           | HDFSDataSource_resolveclusterfalse |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                                  | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_Configuration.json             | 204           |                                    |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                                  |                                                                                  | 200           | SC3_MultiCombination_deletedir     |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC3_MultiCombination_deletedir |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC3_MultiCombination_deletedir')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC3_MultiCombination_deletedir  |                                                                                  | 200           |                                    |                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC3_MultiCombination_deletedir |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC3_MultiCombination_deletedir')].status |

    #7148464
  @MLP-24889  @sanity @positive
  Scenario Outline: SC10 MLP_24889_Verify Hdfs Catalog functionality after deleting the directory
    And user update the json file "ida/hdfsPayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                       |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC3_MultiCombination_deletedir                   |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/Cluster Demo/Service/HDFS/Directory/ROOT |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                        | body                                          | response code | response message | filePath                                         | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC3_MultiCombination_deletedir&limitFacet=10&offset=0&limit=2500 | payloads/ida/hdfsPayloads/API/SC2_Filter.json | 200           |                  | response\HDFS\TableFilter\Actual\SC4_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#10 MLP_24889_Compare the tables with respect to filters for second run
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                     | actualValues                                     | valueType         | expectedJsonPath                | actualJsonPath                   |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC4_Filter.json | stringListCompare | $.SC3.Run2.Directory.name       | $..[?(@.type=='Directory')].name |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC4_Filter.json | stringListCompare | $.SC3.Run2.Directory.files.name | $..[?(@.type=='File')].name      |

  Scenario:SC10:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                     | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC3_MultiCombination/%           | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC3_MultiCombination_deletedir/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                                             | Cluster  |       |       |

 ###############################################Cataloger- max Hits(5) field(one parent folder with 12 child folders) cluster name FALSE  in CLUSTER DEMO node########################


  Scenario: SC11#-MLP_24889_Update the Host name respect to the docker
    And user update the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_maxHits_Configuration.json" file for following values
      | jsonPath                          | jsonValues           |
      | $.configurations..nodeCondition   | name=="Cluster Demo" |
      | $.configurations..filter..root    | /idaautomation       |
      | $.configurations..name            | SC4_Manxhits_5       |
      | $.configurations..tags[*]         | SC4_Manxhits_5       |
      | $.configurations..filter..tags[*] | maxhits5             |
      | $.configurations..filter..maxHits | 5                    |

    #7148480
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC11#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                               | body                                                                             | response code | response message                   | jsonPath                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                  | ida\hbasePayloads\DataSource\license_DS.json                                     | 204           |                                    |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                 | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                 |                                                                                  | 200           | HDFSDataSource_resolveclusterfalse |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                  | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_maxHits_Configuration.json     | 204           |                                    |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                  |                                                                                  | 200           | SC4_Manxhits_5                     |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC4_Manxhits_5 |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC4_Manxhits_5')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC4_Manxhits_5  |                                                                                  | 200           |                                    |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC4_Manxhits_5 |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC4_Manxhits_5')].status |

  @MLP-24889  @sanity @positive
  Scenario Outline: SC11 MLP_24889_Verify whether the cataloger collects the directories withrespect to the count provided in the max Hits(5) field(one parent folder with 12 child folders)
    And user update the json file "ida/hdfsPayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                       |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC4_Manxhits_5                                   |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/Cluster Demo/Service/HDFS/Directory/ROOT |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                        | body                                          | response code | response message | filePath                                         | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC4_Manxhits_5&limitFacet=10&offset=0&limit=2500 | payloads/ida/hdfsPayloads/API/SC2_Filter.json | 200           |                  | response\HDFS\TableFilter\Actual\SC5_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#11 MLP_24889_Compare the tables with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                     | actualValues                                     | valueType         | expectedJsonPath                | actualJsonPath                   |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC5_Filter.json | stringListCompare | $.SC4.Run1.Directory.name       | $..[?(@.type=='Directory')].name |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC5_Filter.json | stringListCompare | $.SC4.Run1.Directory.files.name | $..[?(@.type=='File')].name      |

 ###############################################Cataloger-  max Hits(2) field(one parent folder with 2 child folders, 1st child folder has a directory with a subdirectory[upto 5 levels] within) cluster name FALSE  in CLUSTER DEMO node########################

  Scenario: SC12#-MLP_24889_Update the Host name respect to the docker for second run
    And user update the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_maxHits_Configuration.json" file for following values
      | jsonPath                          | jsonValues           |
      | $.configurations..nodeCondition   | name=="Cluster Demo" |
      | $.configurations..filter..root    | /MaxHits             |
      | $.configurations..name            | SC4_Manxhits_2       |
      | $.configurations..tags[*]         | SC4_Manxhits_2       |
      | $.configurations..filter..tags[*] | maxhits2             |
      | $.configurations..filter..maxHits | 2                    |

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline: SC12#Upload 4 subfolders in ambari
    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                  | body                                                  | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | MaxHits/Sub1/Sub2/Sub3/Sub4/uploadFile2.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/HdfsAutomationTestData2.csv | 201           |                  |

    #7148466,7148481
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC12#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                               | body                                                                             | response code | response message                   | jsonPath                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                  | ida\hbasePayloads\DataSource\license_DS.json                                     | 204           |                                    |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                 | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                 |                                                                                  | 200           | HDFSDataSource_resolveclusterfalse |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                  | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_maxHits_Configuration.json     | 204           |                                    |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                  |                                                                                  | 200           | SC4_Manxhits_2                     |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC4_Manxhits_2 |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC4_Manxhits_2')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC4_Manxhits_2  |                                                                                  | 200           |                                    |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC4_Manxhits_2 |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC4_Manxhits_2')].status |

  @MLP-24889  @sanity @positive
  Scenario Outline: SC12 MLP_24889_Verify Hdfs Catalog functionality after deleting the directory
    And user update the json file "ida/hdfsPayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                       |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC4_Manxhits_2                                   |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/Cluster Demo/Service/HDFS/Directory/ROOT |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                        | body                                          | response code | response message | filePath                                         | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC4_Manxhits_2&limitFacet=10&offset=0&limit=2500 | payloads/ida/hdfsPayloads/API/SC2_Filter.json | 200           |                  | response\HDFS\TableFilter\Actual\SC6_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#12 MLP_24889_Compare the tables with respect to filters for second run
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                     | actualValues                                     | valueType         | expectedJsonPath          | actualJsonPath                   |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC6_Filter.json | stringListCompare | $.SC4.Run2.Directory.name | $..[?(@.type=='Directory')].name |

  Scenario:SC12:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC4_Manxhits_5/% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC4_Manxhits_2/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                             | Cluster  |       |       |

  @MLP-1960  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC12:Delete folder in Ambaris
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization               | X-Requested-By | type   | url                               | body | response code | response message |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /MaxHits?op=DELETE&recursive=true |      | 200           | true             |


  ###############################################Cataloger-  exclude mode without regex patter field cluster Resolve TRUE  in CLUSTER DEMO node########################

  Scenario: SC13#-MLP_24889_Update the Host name respect to the docker
    And user update json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |
    And user update the json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values
      | jsonPath                              | jsonValues |
      | $.configurations[0].catalogerHdfsUser | hdfs       |


  Scenario: SC13#-MLP_24889_Update the Host name respect to the docker for second run
    And user update the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_exclude_Configuration.json" file for following values
      | jsonPath                                    | jsonValues           |
      | $.configurations..nodeCondition             | name=="Cluster Demo" |
      | $.configurations..dataSource                | HDFSDataSource_valid |
      | $.configurations..filter..root              | /idaautomation       |
      | $.configurations..name                      | SC6_cxcludecsv       |
      | $.configurations..tags[*]                   | SC6_cxcludecsv       |
      | $.configurations..filter..tags[*]           | excludecsv           |
      | $.configurations..filter..fileMode          | exclude              |
      | $.configurations..filter..maxHits           | 100                  |
      | $.configurations..filter..fileExtensions[*] | csv                  |

#7148467
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC13#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                               | body                                                                         | response code | response message     | jsonPath                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                 | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json                 | 204           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                 |                                                                              | 200           | HDFSDataSource_valid |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                  | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_exclude_Configuration.json | 204           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                  |                                                                              | 200           | SC6_cxcludecsv       |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC6_cxcludecsv |                                                                              | 200           | IDLE                 | $.[?(@.configurationName=='SC6_cxcludecsv')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC6_cxcludecsv  |                                                                              | 200           |                      |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC6_cxcludecsv |                                                                              | 200           | IDLE                 | $.[?(@.configurationName=='SC6_cxcludecsv')].status |

  @MLP-24889  @sanity @positive
  Scenario Outline: SC13 MLP_24889_Verify cataloger colects the data properly when All mandatory field and optional field are provided in file filters- ( exclude mode without regex patter field)
    And user update the json file "ida/hdfsPayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                  |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC6_cxcludecsv                              |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/Sandbox/Service/HDFS/Directory/ROOT |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                        | body                                          | response code | response message | filePath                                         | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC6_cxcludecsv&limitFacet=10&offset=0&limit=2500 | payloads/ida/hdfsPayloads/API/SC2_Filter.json | 200           |                  | response\HDFS\TableFilter\Actual\SC7_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#13 MLP_24889_Compare the tables with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                     | actualValues                                     | valueType         | expectedJsonPath           | actualJsonPath                   |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC7_Filter.json | stringListCompare | $.SC5.Directory.name       | $..[?(@.type=='Directory')].name |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC7_Filter.json | stringListCompare | $.SC5.Directory.files.name | $..[?(@.type=='File')].name      |

  Scenario Outline: SC13#user retrieves ID with catalog ,name and type
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type    | name    | asg_scopeid | targetFile                        | jsonpath      |
      | APPDBPOSTGRES | ID      | Default | Cluster | Sandbox |             | response/HDFS/actual/itemIds.json | $..Cluster.id |

  Scenario Outline: SC13#user hit API and save the response for each type's
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                         | responseCode | inputJson     | inputFile                         | outPutFile                                | outPutJson |
      | components/Default/item/Default.Cluster:::dynamic?pages=ALL | 200          | $..Cluster.id | response/HDFS/actual/itemIds.json | response/HDFS/actual/clusterMetadata.json |            |

#7148476
  Scenario Outline:SC13# Validate Cluster name when resolve cluster name is enables as TRUE
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                     | actualValues                              | valueType     | expectedJsonPath                | actualJsonPath |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response/HDFS/actual/clusterMetadata.json | stringcompare | $.SC5.Directory.Cluster.name[*] | $.caption.name |

  @sanity @positive @webtest @hdfs
  Scenario:SC13#MLP_24889_Verify Processed Items widget is available inside logs
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC6_cxcludecsv" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/HdfsCataloger/SC6_cxcludecsv%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of errors          | 0             |
      | Number of processed items | 2             |
    And user "widget presence" on "Processed Items" in Item view page

  Scenario:SC13:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC6_cxcludecsv/% | Analysis |       |       |
      | SingleItemDelete | Default | Sandbox                                  | Cluster  |       |       |


  @MLP-1960  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC13:Delete folder in Ambaris
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization               | X-Requested-By | type   | url                                     | body | response code | response message |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /idaautomation?op=DELETE&recursive=true |      | 200           | true             |

    ###############################################Cataloger-  Multiple exclude and Multiple include mode with regex patter field cluster Resolve TRUE(HDFS username BLANK)  in CLUSTER DEMO node########################


  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline: SC14#Upload >10 Dir , >10 files ,  >100 charectors in file name and directory name , empty directory and file wiht no extension
    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                                                                                                                                                                                | body                                                                                                                                                                                                         | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/F1/uploadFile1.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                                                                                          | ida/hdfsPayloads/TestData/HdfsAutomationTestData1.csv                                                                                                                                                        | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/F1/f1_s1/Test+Results+-+Scenario__SC#33_2_Verify_Tag_is_set_for_the_column_when_namePattern_and_dataPattern_minimumRatio_matches_with_the_column_name_value_ratio_in_Oracle_table_ (4).html?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/Test+Results+-+Scenario__SC#33_2_Verify_Tag_is_set_for_the_column_when_namePattern_and_dataPattern_minimumRatio_matches_with_the_column_name_value_ratio_in_Oracle_table_ (4).html | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/f2/uploadFile3.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                                                                                          | ida/hdfsPayloads/TestData/HdfsAutomationTestData1.csv                                                                                                                                                        | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/f2/f2_s1/dummy.pdf?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                                                                                          | ida/hdfsPayloads/TestData/dummy.pdf                                                                                                                                                                          | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idaautomation/f2/f2_s1/f2_s1_s1/CALC-1985.doc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                                                                             | ida/hdfsPayloads/TestData/CALC-1985.doc                                                                                                                                                                      | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | unique/F1/uploadFile1.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                                                                                                 | ida/hdfsPayloads/TestData/HdfsAutomationTestData1.csv                                                                                                                                                        | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | unique/F1/f1_s1/Test+Results+-+Scenario__SC#33_2_Verify_Tag_is_set_for_the_column_when_namePattern_and_dataPattern_minimumRatio_matches_with_the_column_name_value_ratio_in_Oracle_table_ (4).html?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true        | ida/hdfsPayloads/TestData/Test+Results+-+Scenario__SC#33_2_Verify_Tag_is_set_for_the_column_when_namePattern_and_dataPattern_minimumRatio_matches_with_the_column_name_value_ratio_in_Oracle_table_ (4).html | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | unique/f2/uploadFile3.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                                                                                                 | ida/hdfsPayloads/TestData/HdfsAutomationTestData1.csv                                                                                                                                                        | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | unique/f2/f2_s1/dummy.pdf?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                                                                                                 | ida/hdfsPayloads/TestData/dummy.pdf                                                                                                                                                                          | 201           |                  |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | unique/f2/f2_s1/f2_s1_s1/CALC-1985.doc?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true                                                                                                                                                                    | ida/hdfsPayloads/TestData/CALC-1985.doc                                                                                                                                                                      | 201           |                  |

  Scenario: SC14#-MLP_24889_Update the Host name respect to the docker
    And user update json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |
    And user update the json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values
      | jsonPath                              | jsonValues |
      | $.configurations[0].catalogerHdfsUser |            |


  Scenario: SC14#-MLP_24889_Update the Host name respect to the docker for second run
    And user update the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_Multiple_exclude_Configuration.json" file for following values
      | jsonPath                          | jsonValues           |
      | $.configurations..nodeCondition   | name=="Cluster Demo" |
      | $.configurations..dataSource      | HDFSDataSource_valid |
      | $.configurations..filter..maxHits | 100                  |

#7148468
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC14#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | body                                                                                  | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                        | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json                          | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                        |                                                                                       | 200           | HDFSDataSource_valid  |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                         | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_Multiple_exclude_Configuration.json | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                         |                                                                                       | 200           | SC7_Multi_Inc_Exclude |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC7_Multi_Inc_Exclude |                                                                                       | 200           | IDLE                  | $.[?(@.configurationName=='SC7_Multi_Inc_Exclude')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC7_Multi_Inc_Exclude  |                                                                                       | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC7_Multi_Inc_Exclude |                                                                                       | 200           | IDLE                  | $.[?(@.configurationName=='SC7_Multi_Inc_Exclude')].status |

  @MLP-24889  @sanity @positive
  Scenario Outline: SC14 MLP_24889_Verify cataloger colects the data properly when All mandatory field and optional field are provided in file filters- ( include and exclude mode with wildcard regex patter field *) and HDFS Username BLANK in Data source
    And user update the json file "ida/hdfsPayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                  |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC7_Multi_Inc_Exclude                       |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/Sandbox/Service/HDFS/Directory/ROOT |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                               | body                                          | response code | response message | filePath                                         | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC7_Multi_Inc_Exclude&limitFacet=10&offset=0&limit=2500 | payloads/ida/hdfsPayloads/API/SC2_Filter.json | 200           |                  | response\HDFS\TableFilter\Actual\SC8_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#14 MLP_24889_Compare the tables with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                     | actualValues                                     | valueType         | expectedJsonPath           | actualJsonPath                   |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC8_Filter.json | stringListCompare | $.SC6.Directory.name       | $..[?(@.type=='Directory')].name |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC8_Filter.json | stringListCompare | $.SC6.Directory.files.name | $..[?(@.type=='File')].name      |


  Scenario:SC14:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC7_Multi_Inc_Exclude/% | Analysis |       |       |
      | SingleItemDelete | Default | Sandbox                                         | Cluster  |       |       |

  @MLP-1960  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC14:Delete folder in Ambaris
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization               | X-Requested-By | type   | url                                     | body | response code | response message |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /idaautomation?op=DELETE&recursive=true |      | 200           | true             |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /unique?op=DELETE&recursive=true        |      | 200           | true             |

    ###############################################Cataloger-   max Hits field value is negative cluster  resolve name TRUE  in CLUSTER DEMO node########################

  Scenario: SC15#-MLP_24889_Update the Host name respect to the docker for second run
    And user update the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_maxHits_Configuration.json" file for following values
      | jsonPath                          | jsonValues            |
      | $.configurations..nodeCondition   | name=="Cluster Demo"  |
      | $.configurations..filter..root    | /MaxHits              |
      | $.configurations..name            | SC8_Manxhits_Negative |
      | $.configurations..tags[*]         | SC8_Manxhits_Negative |
      | $.configurations..filter..tags[*] | Manxhits_Negative     |
      | $.configurations..filter..maxHits | -1                    |

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline: SC15#Upload 4 subfolders in ambari
    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                  | body                                                  | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | MaxHits/Sub1/Sub2/Sub3/Sub4/uploadFile2.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/HdfsAutomationTestData2.csv | 201           |                  |

    #7148466,7148479
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC15#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | body                                                                             | response code | response message                   | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                         | ida\hbasePayloads\DataSource\license_DS.json                                     | 204           |                                    |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                        | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                        |                                                                                  | 200           | HDFSDataSource_resolveclusterfalse |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                         | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_maxHits_Configuration.json     | 204           |                                    |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                         |                                                                                  | 200           | SC8_Manxhits_Negative              |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC8_Manxhits_Negative |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC8_Manxhits_Negative')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC8_Manxhits_Negative  |                                                                                  | 200           |                                    |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC8_Manxhits_Negative |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC8_Manxhits_Negative')].status |

  @MLP-24889  @sanity @positive
  Scenario Outline: SC15 MLP_24889_Verify cataloger collects all the data if the max Hits field value is negative.
    And user update the json file "ida/hdfsPayloads/API/SC2_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                       |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC8_Manxhits_Negative                            |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/Cluster Demo/Service/HDFS/Directory/ROOT |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                               | body                                          | response code | response message | filePath                                         | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC8_Manxhits_Negative&limitFacet=10&offset=0&limit=2500 | payloads/ida/hdfsPayloads/API/SC2_Filter.json | 200           |                  | response\HDFS\TableFilter\Actual\SC9_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#15 MLP_24889_Compare the tables with respect to filters for second run
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                     | actualValues                                     | valueType         | expectedJsonPath             | actualJsonPath                   |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC9_Filter.json | stringListCompare | $.SC6_1.Directory.name       | $..[?(@.type=='Directory')].name |
      | response\HDFS\TableFilter\Expected\SC1_Filter.json | response\HDFS\TableFilter\Actual\SC9_Filter.json | stringListCompare | $.SC6_1.Directory.files.name | $..[?(@.type=='File')].name      |

################################################Explicit, Technology, Bussiness Application Tag###############################################

  #7148477,7148469
  @positve @regression @sanity  @PIITag
  Scenario:Commoncase#MLP_24889_Verify Technology tag , Explicit tag , Bussiness Application tag and File Filter tag
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName  | ServiceName | directoryName | TableName/Filename | Tags                                                         | Query          | Action      |
      |              |             | Sub4          | uploadFile2.csv    | HDFS_BA,Manxhits_Negative,Hadoop Files,SC8_Manxhits_Negative | FileQuery      | TagAssigned |
      |              |             | Sub4          |                    | HDFS_BA,Manxhits_Negative,Hadoop Files,SC8_Manxhits_Negative | DirectoryQuery | TagAssigned |
      | Cluster Demo | HDFS        |               |                    | HDFS_BA,Hadoop Files,SC8_Manxhits_Negative | ServiceQuery   | TagAssigned |
      | Cluster Demo |             |               |                    | HDFS_BA,Hadoop Files,SC8_Manxhits_Negative | ClusterQuery   | TagAssigned |

#####################################################Logging enhancement##########################################################################


  #7148477
  @MLP-24889 @sanity @positive
  Scenario:Commoncase:MLP-24889_Parsing the repository and validating the HDFS Cataloger Log
    Then Analysis log "cataloger/HdfsCataloger/SC8_Manxhits_Negative/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | logCode       | pluginName    | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | ANALYSIS-0019 |               |                |
      | INFO | ANALYSIS-0071: Plugin Name:HdfsCataloger, Plugin Type:cataloger, Plugin Version:1.1.0.SNAPSHOT, Node Name:Cluster Demo, Host Name:sandbox.hortonworks.com, Plugin Configuration name:SC8_Manxhits_Negative                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0071 | HdfsCataloger | Plugin Version |
      | INFO | Plugin HdfsCataloger Configuration: ---  2020-09-27 18:20:23.219 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: name: "SC8_Manxhits_Negative"  2020-09-27 18:20:23.219 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: pluginVersion: "LATEST"  2020-09-27 18:20:23.219 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: label:  2020-09-27 18:20:23.219 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: : ""  2020-09-27 18:20:23.219 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: catalogName: "Default"  2020-09-27 18:20:23.219 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: eventClass: null  2020-09-27 18:20:23.219 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: eventCondition: null  2020-09-27 18:20:23.219 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: nodeCondition: "name==\"Cluster Demo\""  2020-09-27 18:20:23.219 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: maxWorkSize: 100  2020-09-27 18:20:23.219 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: tags:  2020-09-27 18:20:23.220 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: - "SC8_Manxhits_Negative"  2020-09-27 18:20:23.220 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: pluginType: "cataloger"  2020-09-27 18:20:23.220 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: dataSource: "HDFSDataSource_resolveclusterfalse"  2020-09-27 18:20:23.220 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: credential: "hdfsDBValidCredential"  2020-09-27 18:20:23.220 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: businessApplicationName: "HDFS_BA"  2020-09-27 18:20:23.220 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: dryRun: false  2020-09-27 18:20:23.220 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: schedule: null  2020-09-27 18:20:23.220 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: filter:  2020-09-27 18:20:23.220 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: filters:  2020-09-27 18:20:23.220 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: - class: "com.asg.dis.common.analysis.dom.HdfsFilter"  2020-09-27 18:20:23.221 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: label:  2020-09-27 18:20:23.221 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: : "NewDirectory"  2020-09-27 18:20:23.221 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: tags:  2020-09-27 18:20:23.221 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: - "Manxhits_Negative"  2020-09-27 18:20:23.221 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: root: "/MaxHits"  2020-09-27 18:20:23.221 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: excludeRegexp: []  2020-09-27 18:20:23.221 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: fileMode: "include"  2020-09-27 18:20:23.221 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: fileExtensions: []  2020-09-27 18:20:23.221 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: deltaTime: "30"  2020-09-27 18:20:23.221 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: extraFilters: {}  2020-09-27 18:20:23.221 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: maxHits: "-1"  2020-09-27 18:20:23.222 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: scanHdfs: true  2020-09-27 18:20:23.222 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: analyzeCollectedData: true  2020-09-27 18:20:23.222 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: scanServices: false  2020-09-27 18:20:23.222 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: pluginName: "HdfsCataloger"  2020-09-27 18:20:23.222 INFO  - ANALYSIS-0073: Plugin HdfsCataloger Configuration: type: "Cataloger" | ANALYSIS-0073 | HdfsCataloger |                |
      | INFO | ANALYSIS-0072: Plugin HdfsCataloger Start Time:2020-07-30 17:11:18.233, End Time:2020-07-30 17:11:19.831, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | ANALYSIS-0072 | HdfsCataloger |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:01:40.205)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | ANALYSIS-0020 |               |                |


  Scenario:SC15:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC8_Manxhits_Negative/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                                    | Cluster  |       |       |

  ###############################################Cataloger-  Invalid Root folder cluster  resolve name TRUE  in CLUSTER DEMO node########################

  Scenario: SC16#-MLP_24889_Update the Host name respect to the docker for second run
    And user update the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_Configuration.json" file for following values
      | jsonPath                          | jsonValues           |
      | $.configurations..nodeCondition   | name=="Cluster Demo" |
      | $.configurations..filter..root    | /invalidroot         |
      | $.configurations..name            | SC8_InvalidRoot      |
      | $.configurations..tags[*]         | SC8_InvalidRoot      |
      | $.configurations..filter..tags[*] | InvalidRootFilter    |
      | $.configurations..filter..maxHits | 100                  |


    #7148466
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC16#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                | body                                                                             | response code | response message                   | jsonPath                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                   | ida\hbasePayloads\DataSource\license_DS.json                                     | 204           |                                    |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                  | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                  |                                                                                  | 200           | HDFSDataSource_resolveclusterfalse |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                   | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_Configuration.json             | 204           |                                    |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                   |                                                                                  | 200           | SC8_InvalidRoot                    |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC8_InvalidRoot |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC8_InvalidRoot')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC8_InvalidRoot  |                                                                                  | 200           |                                    |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC8_InvalidRoot |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC8_InvalidRoot')].status |


  @sanity @positive @webtest @hbase
  Scenario:SC16#MLP_24889_Verify the proper message is disolayed in log and only analysis items are collected when we provide invlaid root folder name .
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC8_InvalidRoot" and clicks on search
    And user performs "facet selection" in "SC8_InvalidRoot" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | File |

  #7148477
  @MLP-24889 @sanity @positive
  Scenario:SC16:MLP-24889_Check error message in logs
    Then Analysis log "cataloger/HdfsCataloger/SC8_InvalidRoot/%" should display below info/error/warning
      | type | logValue                                                                               | logCode           | pluginName | removableText |
      | WARN | Failed accessing file/directory /invalidroot. Probably it was deleted from the cluster | CATALOG-HDFS-0067 |            |               |

  Scenario:SC16:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC8_InvalidRoot/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                              | Cluster  |       |       |

   ###############################################Cataloger-  Invalid Sub folder folder cluster  resolve name TRUE  in CLUSTER DEMO node########################

  Scenario: SC17#-MLP_24889_Update the Host name respect to the docker for second run
    And user update the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_Configuration.json" file for following values
      | jsonPath                          | jsonValues                |
      | $.configurations..nodeCondition   | name=="Cluster Demo"      |
      | $.configurations..filter..root    | /MaxHits/invalidsubfolder |
      | $.configurations..name            | SC9_InvalidSubfolder      |
      | $.configurations..tags[*]         | SC9_InvalidSubfolder      |
      | $.configurations..filter..tags[*] | InvalidSubfolder          |
      | $.configurations..filter..maxHits | 100                       |


    #7148466
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC17#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                             | response code | response message                   | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                        | ida\hbasePayloads\DataSource\license_DS.json                                     | 204           |                                    |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                       | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                       |                                                                                  | 200           | HDFSDataSource_resolveclusterfalse |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                        | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_Configuration.json             | 204           |                                    |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                        |                                                                                  | 200           | SC9_InvalidSubfolder               |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC9_InvalidSubfolder |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC9_InvalidSubfolder')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC9_InvalidSubfolder  |                                                                                  | 200           |                                    |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC9_InvalidSubfolder |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC9_InvalidSubfolder')].status |


  @sanity @positive @webtest @hbase
  Scenario:SC17#MLP_24889_Verify the proper message is disolayed in log and valid folder alone are collected when we provide valid root invalid folder name .
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC9_InvalidSubfolder" and clicks on search
    And user performs "facet selection" in "SC9_InvalidSubfolder" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | File |

  #7148477
  @MLP-24889 @sanity @positive
  Scenario:SC17:MLP-24889_Check error message in logs
    Then Analysis log "cataloger/HdfsCataloger/SC9_InvalidSubfolder/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                           | logCode | pluginName | removableText |
      | WARN | Failed accessing file/directory /MaxHits/invalidsubfolder. Probably it was deleted from the cluster  java.io.FileNotFoundException: File does not exist: /MaxHits/invalidsubfolder |         |            |               |

  Scenario:SC17:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC9_InvalidSubfolder/% | Analysis |       |       |
      | SingleItemDelete | Default | Cluster Demo                                   | Cluster  |       |       |

    ####################################################Dry run set as True#############################################

#7148477
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline:CommonCase#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                                             | response code | response message                   | jsonPath                                         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                               | ida\hbasePayloads\DataSource\license_DS.json                                     | 204           |                                    |                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                              | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json | 204           |                                    |                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                              |                                                                                  | 200           | HDFSDataSource_resolveclusterfalse |                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                               | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_DryRun_Configuration.json      | 204           |                                    |                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                               |                                                                                  | 200           | SC10_DryRun                        |                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC10_DryRun |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC10_DryRun')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC10_DryRun  |                                                                                  | 200           |                                    |                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC10_DryRun |                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='SC10_DryRun')].status |

    #7148477
  @sanity @positive @webtest @MLP-24889 @IDA-1.1.0
  Scenario:CommonCase:MLP_24889_Verify no Cluster , Table , Database , Host and service facets are cataloged and verify log message
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "hdfs" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/HdfsCataloger/SC10_DryRun/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/HdfsCataloger/SC10_DryRun/%" should display below info/error/warning
      | type | logValue                                                                                 | logCode       | pluginName    | removableText |
      | INFO | Plugin HdfsCataloger running on dry run mode                                             | ANALYSIS-0069 | HdfsCataloger |               |
      | INFO | Plugin HdfsCataloger processed 2 items on dry run mode and not written to the repository | ANALYSIS-0070 | HdfsCataloger |               |
      | INFO | Plugin completed                                                                         | ANALYSIS-0020 |               |               |

#7148477
  Scenario:CommonCase:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                  | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC10_DryRun/% | Analysis |       |       |
      | SingleItemDelete | Default | Sandbox                               | Cluster  |       |       |

  @MLP-1960  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC17:Delete folder in Ambaris
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization               | X-Requested-By | type   | url                               | body | response code | response message |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /MaxHits?op=DELETE&recursive=true |      | 200           | true             |

#########################################################SCAN HDFS TRUE and SCAN SERVICE TRUE############################################

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline: SC18#Upload 4 subfolders in ambari
    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                                          | body                                                  | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | ScanServiceTest/Sub1/Sub2/Sub3/Sub4/uploadFile2.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/hdfsPayloads/TestData/HdfsAutomationTestData2.csv | 201           |                  |

  Scenario: SC18#-MLP_24269_Update the Host name respect to the docker
    And user update json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |
    And user update the json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values
      | jsonPath                              | jsonValues |
      | $.configurations[0].catalogerHdfsUser | hdfs       |

  Scenario: SC18#-MLP_24269_Update the plugin name and tag name
    And user "update" the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_scanHdfs_scanServices_Configuration.json" file for following values
      | jsonPath                               | jsonValues                    | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"          |         |
      | $.configurations..dataSource           | HDFSDataSource_valid          |         |
      | $.configurations..filter..root         | /ScanServiceTest              |         |
      | $.configurations..name                 | SC11_scanHdfs_scanServiceTRUE |         |
      | $.configurations..tags[*]              | SC11_scanHdfs_scanServiceTRUE |         |
      | $.configurations..filter..tags[*]      | Positive                      |         |
      | $.configurations..analyzeCollectedData | false                         | boolean |
      | $.configurations..scanHdfs             | true                          | boolean |
      | $.configurations..scanServices         | true                          | boolean |


  @positve @regression @sanity  @MLP-24269 @IDA-1.1.0
  Scenario Outline: SC18#-MLP_24269_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | body                                                                                       | response code | response message              | jsonPath                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                                 | ida\hbasePayloads\DataSource\license_DS.json                                               | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                                | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json                               | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                                |                                                                                            | 200           | HDFSDataSource_valid          |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                                 | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_scanHdfs_scanServices_Configuration.json | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                                 |                                                                                            | 200           | SC11_scanHdfs_scanServiceTRUE |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC11_scanHdfs_scanServiceTRUE |                                                                                            | 200           | IDLE                          | $.[?(@.configurationName=='SC11_scanHdfs_scanServiceTRUE')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC11_scanHdfs_scanServiceTRUE  |                                                                                            | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC11_scanHdfs_scanServiceTRUE |                                                                                            | 200           | IDLE                          | $.[?(@.configurationName=='SC11_scanHdfs_scanServiceTRUE')].status |

    #7190151,7190162
  @webtest
  Scenario:SC18#MLP_24269_ Verify all services are collected(Hdfs/configuration/files) and directory/files are also collected if scan services is ON and Scan Hdfs : ON
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Sandbox" and clicks on search
    And user performs "facet selection" in "SC11_scanHdfs_scanServiceTRUE" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "Sandbox" item from search results
    Then user performs click and verify in new window
      | Table    | value   | Action                 | RetainPrevwindow | indexSwitch |
      | Services | HBASE   | verify widget contains | No               |             |
      | Services | HIVE    | verify widget contains | No               |             |
      | Services | IDANODE | verify widget contains | No               |             |
      | Services | SPARK   | verify widget contains | No               |             |
      | Services | HDFS    | click and switch tab   | No               |             |
    Then user performs click and verify in new window
      | Table             | value              | Action                 | RetainPrevwindow | indexSwitch |
      | has_Configuration | hdfs-log4j_INITIAL | verify widget contains | No               |             |
      | has_Configuration | hdfs-site_INITIAL  | click and switch tab   | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Description       | Parameters |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table         | value    | Action                 | RetainPrevwindow | indexSwitch |
      | has_Directory | ROOT     | verify widget contains | No               |             |
      | has_Role      | DATANODE | verify widget contains | No               |             |
      | has_Role      | NAMENODE | click and switch tab   | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | roleState         | STARTED       |
      | roleType          | NAMENODE      |
    Then user performs click and verify in new window
      | Table        | value                   | Action                 | RetainPrevwindow | indexSwitch |
      | assignedHost | sandbox.hortonworks.com | verify widget contains | No               |             |
    And user enters the search text "SC11_scanHdfs_scanServiceTRUE" and clicks on search
    And user performs "facet selection" in "SC11_scanHdfs_scanServiceTRUE" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/HdfsCataloger/SC11_scanHdfs_scanServiceTRUE%"
    And user "widget presence" on "Processed Items" in Item view page

       #################################### HDFS cataloger fails if a wrong credential is provided and saved in cataloger without using test connection#############################
    #7197203
  @sanity @positive @webtest @hdfs
  Scenario:SC18#MLP_24889_Update the credential name to Invalid and save the configuration without TestConnection check.
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion and click menu option" operation in Manage Configurations panel
      | button       | actionItem | attribute                     | itemName               |
      | Cluster Demo | Cataloger  | SC11_scanHdfs_scanServiceTRUE | Edit the configuration |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute               |
      | Credential  | hdfsDBInValidCredential |
      | Data Source | HDFSDataSource_valid    |
    And user verifies "Save Button" is "enabled" in "Add Configuration pop up"
    And user "click" on "Save" button in "Add Data Sources Page"

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC18#-MLP_24889_Run Hdfs cataloger with InvalidCredentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | body | response code | response message | jsonPath                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC11_scanHdfs_scanServiceTRUE |      | 200           | IDLE             | $.[?(@.configurationName=='SC11_scanHdfs_scanServiceTRUE')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC11_scanHdfs_scanServiceTRUE  |      | 200           |                  |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC11_scanHdfs_scanServiceTRUE |      | 200           | IDLE             | $.[?(@.configurationName=='SC11_scanHdfs_scanServiceTRUE')].status |

   #7197203
  @webtest
  Scenario:SC18#MLP_24269_Verify HDFS cataloger fails if a wrong credential is provided and saved in cataloger without using test connection.(even if there were successful cataloger runs earlier with a correct credential).
    Then Analysis log "cataloger/HdfsCataloger/SC11_scanHdfs_scanServiceTRUE/%" should display below info/error/warning
      | type  | logValue                                                                  | logCode           | pluginName | removableText |
      | ERROR | Error: HTTP 403 Unable to sign in. Invalid username/password combination. | CATALOG-HDFS-0002 |            |               |

  Scenario:SC18:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                    | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC11_scanHdfs_scanServiceTRUE/% | Analysis |       |       |
      | SingleItemDelete | Default | Sandbox                                                 | Cluster  |       |       |

    #########################################################SCAN HDFS FALSE and SCAN SERVICE TRUE############################################

  Scenario: SC19#-MLP_24269_Update the Host name respect to the docker
    And user update json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |
    And user update the json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json" file for following values
      | jsonPath                              | jsonValues |
      | $.configurations[0].catalogerHdfsUser | hdfs       |

  Scenario: SC19#-MLP_24269_Update the plugin name and tag name
    And user "update" the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_scanHdfs_scanServices_Configuration.json" file for following values
      | jsonPath                               | jsonValues                         | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"               |         |
      | $.configurations..dataSource           | HDFSDataSource_valid               |         |
      | $.configurations..filter..root         | /ScanServiceTest                   |         |
      | $.configurations..name                 | SC12_scanHdfsFALSE_scanServiceTRUE |         |
      | $.configurations..tags[*]              | SC12_scanHdfsFALSE_scanServiceTRUE |         |
      | $.configurations..filter..tags[*]      | Positive                           |         |
      | $.configurations..analyzeCollectedData | false                              | boolean |
      | $.configurations..scanHdfs             | false                              | boolean |
      | $.configurations..scanServices         | true                               | boolean |


  @positve @regression @sanity  @MLP-24269 @IDA-1.1.0
  Scenario Outline: SC19#-MLP_24269_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                   | body                                                                                       | response code | response message                   | jsonPath                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                                      | ida\hbasePayloads\DataSource\license_DS.json                                               | 204           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                                     | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig.json                               | 204           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                                     |                                                                                            | 200           | HDFSDataSource_valid               |                                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                                      | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_scanHdfs_scanServices_Configuration.json | 204           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                                      |                                                                                            | 200           | SC12_scanHdfsFALSE_scanServiceTRUE |                                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC12_scanHdfsFALSE_scanServiceTRUE |                                                                                            | 200           | IDLE                               | $.[?(@.configurationName=='SC12_scanHdfsFALSE_scanServiceTRUE')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC12_scanHdfsFALSE_scanServiceTRUE  |                                                                                            | 200           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC12_scanHdfsFALSE_scanServiceTRUE |                                                                                            | 200           | IDLE                               | $.[?(@.configurationName=='SC12_scanHdfsFALSE_scanServiceTRUE')].status |

    #7190148,7190162
  @webtest
  Scenario:SC19#MLP_24269_Verify all services are collected(Hdfs/configuration/files) and directory/files are not collected if  scan services is ON and Scan Hdfs : OFF
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Sandbox" and clicks on search
    And user performs "facet selection" in "SC12_scanHdfsFALSE_scanServiceTRUE" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "Sandbox" item from search results
    Then user performs click and verify in new window
      | Table    | value   | Action                 | RetainPrevwindow | indexSwitch |
      | Services | HBASE   | verify widget contains | No               |             |
      | Services | HIVE    | verify widget contains | No               |             |
      | Services | IDANODE | verify widget contains | No               |             |
      | Services | SPARK   | verify widget contains | No               |             |
      | Services | HDFS    | click and switch tab   | No               |             |
    Then user performs click and verify in new window
      | Table             | value              | Action                 | RetainPrevwindow | indexSwitch |
      | has_Configuration | hdfs-log4j_INITIAL | verify widget contains | No               |             |
      | has_Configuration | hdfs-site_INITIAL  | click and switch tab   | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Description       | Parameters |
    And user navigates to the index "0" to perform actions
    And user "widget not present" on "has_Directory" in Item view page
    Then user performs click and verify in new window
      | Table    | value    | Action                 | RetainPrevwindow | indexSwitch |
      | has_Role | DATANODE | verify widget contains | No               |             |
      | has_Role | NAMENODE | click and switch tab   | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | roleState         | STARTED       |
      | roleType          | NAMENODE      |
    Then user performs click and verify in new window
      | Table        | value                   | Action                 | RetainPrevwindow | indexSwitch |
      | assignedHost | sandbox.hortonworks.com | verify widget contains | No               |             |
    And user enters the search text "SC12_scanHdfsFALSE_scanServiceTRUE" and clicks on search
    And user performs "facet selection" in "SC12_scanHdfsFALSE_scanServiceTRUE" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/HdfsCataloger/SC12_scanHdfsFALSE_scanServiceTRUE%"
    And user "widget presence" on "Processed Items" in Item view page

  Scenario:SC19:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                         | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC12_scanHdfsFALSE_scanServiceTRUE/% | Analysis |       |       |
      | SingleItemDelete | Default | Sandbox                                                      | Cluster  |       |       |


    #########################################################SCAN HDFS TRUE and SCAN SERVICE TRUE,CLUSTER RESOLVE FALSE(Empty Hostname)############################################


  Scenario: SC20#-MLP_24269_Update the plugin name and tag name
    And user "update" the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_scanHdfs_scanServices_Configuration.json" file for following values
      | jsonPath                               | jsonValues                                           | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"                                 |         |
      | $.configurations..dataSource           | HDFSDataSource_resolveclusterfalse                   |         |
      | $.configurations..filter..root         | /ScanServiceTest                                     |         |
      | $.configurations..name                 | SC14_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |         |
      | $.configurations..tags[*]              | SC14_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |         |
      | $.configurations..filter..tags[*]      | Positive                                             |         |
      | $.configurations..analyzeCollectedData | false                                                | boolean |
      | $.configurations..scanHdfs             | true                                                 | boolean |
      | $.configurations..scanServices         | true                                                 | boolean |


  @positve @regression @sanity  @MLP-24269 @IDA-1.1.0
  Scenario Outline: SC20#-MLP_24269_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                                     | body                                                                                       | response code | response message                                     | jsonPath                                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                                                        | ida\hbasePayloads\DataSource\license_DS.json                                               | 204           |                                                      |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                                                       | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE.json           | 204           |                                                      |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                                                       |                                                                                            | 200           | HDFSDataSource_resolveclusterfalse                   |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                                                        | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_scanHdfs_scanServices_Configuration.json | 204           |                                                      |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                                                        |                                                                                            | 200           | SC14_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC14_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |                                                                                            | 200           | IDLE                                                 | $.[?(@.configurationName=='SC14_scanHdfsandscanServiceFALSE_ClusterResolveFALSE')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC14_scanHdfsandscanServiceFALSE_ClusterResolveFALSE  |                                                                                            | 200           |                                                      |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC14_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |                                                                                            | 200           | IDLE                                                 | $.[?(@.configurationName=='SC14_scanHdfsandscanServiceFALSE_ClusterResolveFALSE')].status |

    #7190164
  @webtest
  Scenario:SC20#MLP_24269_Verify HdfsCataloger fails and does not collect info when cluster name manager settings is wrong.(Empty hostname)
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC14_scanHdfsandscanServiceFALSE_ClusterResolveFALSE" and clicks on search
    And user performs "facet selection" in "SC14_scanHdfsandscanServiceFALSE_ClusterResolveFALSE" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | File           |
      | Cluster        |
      | Configurations |
      | Roles          |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/HdfsCataloger/SC14_scanHdfsandscanServiceFALSE_ClusterResolveFALSE%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 2             |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/HdfsCataloger/SC14_scanHdfsandscanServiceFALSE_ClusterResolveFALSE/%" should display below info/error/warning
      | type  | logValue                                                                                                                                                                         | logCode           | pluginName | removableText |
      | ERROR | Error: CATALOG-COMMON-CLUSTER-NAME-RESOLVER-0013:Required attribute Cluster manager hostname for cluster manager connection is not provided. Check the datasource configuration. | CATALOG-HDFS-0002 |            |               |

  Scenario:SC20:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                           | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC14_scanHdfsandscanServiceFALSE_ClusterResolveFALSE/% | Analysis |       |       |

        #########################################################SCAN HDFS TRUE and SCAN SERVICE TRUE,CLUSTER RESOLVE FALSE(Invalid Port)############################################

  Scenario: SC21#-MLP_24269_Update the Cluster manager name configs
    And user update json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE_toChange.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |
    And user "update" the json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE_toChange.json" file for following values
      | jsonPath                                                    | jsonValues | type |
      | $.configurations[0].clusterManager.clusterManagerPort       | 8088       |      |
      | $.configurations[0].clusterManager.clusterManagerApiVersion | api/v1     |      |

  Scenario: SC21#-MLP_24269_Update the plugin name and tag name
    And user "update" the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_scanHdfs_scanServices_Configuration.json" file for following values
      | jsonPath                               | jsonValues                                           | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"                                 |         |
      | $.configurations..dataSource           | HDFSDataSource_resolveclusterfalse                   |         |
      | $.configurations..filter..root         | /ScanServiceTest                                     |         |
      | $.configurations..name                 | SC15_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |         |
      | $.configurations..tags[*]              | SC15_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |         |
      | $.configurations..filter..tags[*]      | Positive                                             |         |
      | $.configurations..analyzeCollectedData | false                                                | boolean |
      | $.configurations..scanHdfs             | true                                                 | boolean |
      | $.configurations..scanServices         | true                                                 | boolean |


  @positve @regression @sanity  @MLP-24269 @IDA-1.1.0
  Scenario Outline: SC21#-MLP_24269_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                                     | body                                                                                       | response code | response message                                     | jsonPath                                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                                                        | ida\hbasePayloads\DataSource\license_DS.json                                               | 204           |                                                      |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                                                       | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE_toChange.json  | 204           |                                                      |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                                                       |                                                                                            | 200           | HDFSDataSource_resolveclusterfalse                   |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                                                        | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_scanHdfs_scanServices_Configuration.json | 204           |                                                      |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                                                        |                                                                                            | 200           | SC15_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC15_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |                                                                                            | 200           | IDLE                                                 | $.[?(@.configurationName=='SC15_scanHdfsandscanServiceFALSE_ClusterResolveFALSE')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC15_scanHdfsandscanServiceFALSE_ClusterResolveFALSE  |                                                                                            | 200           |                                                      |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC15_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |                                                                                            | 200           | IDLE                                                 | $.[?(@.configurationName=='SC15_scanHdfsandscanServiceFALSE_ClusterResolveFALSE')].status |

    #7190164
  @webtest
  Scenario:SC21#MLP_24269_Verify HdfsCataloger fails and does not collect info when cluster name manager settings is wrong.(Incorrect Portname)
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC15_scanHdfsandscanServiceFALSE_ClusterResolveFALSE" and clicks on search
    And user performs "facet selection" in "SC15_scanHdfsandscanServiceFALSE_ClusterResolveFALSE" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | File           |
      | Cluster        |
      | Configurations |
      | Roles          |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/HdfsCataloger/SC15_scanHdfsandscanServiceFALSE_ClusterResolveFALSE%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 2             |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/HdfsCataloger/SC15_scanHdfsandscanServiceFALSE_ClusterResolveFALSE/%" should display below info/error/warning
      | type  | logValue                  | logCode           | pluginName | removableText |
      | ERROR | Error: HTTP 404 Not Found | CATALOG-HDFS-0002 |            |               |

  Scenario:SC21:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                           | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC15_scanHdfsandscanServiceFALSE_ClusterResolveFALSE/% | Analysis |       |       |

       #########################################################SCAN HDFS TRUE and SCAN SERVICE TRUE,CLUSTER RESOLVE FALSE(Invalid Hostname)############################################

  Scenario: SC22#-MLP_24269_Update the Cluster manager name configs
    And user "update" the json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE_toChange.json" file for following values
      | jsonPath                                                    | jsonValues | type |
      | $.configurations[0].clusterManager.clusterManagerPort       | 8088       |      |
      | $.configurations[0].clusterManager.clusterManagerApiVersion | api/v1     |      |
      | $.configurations[0].clusterManager.clusterManagerHost       | 10.33.6542 |      |

  Scenario: SC22#-MLP_24269_Update the plugin name and tag name
    And user "update" the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_scanHdfs_scanServices_Configuration.json" file for following values
      | jsonPath                               | jsonValues                                           | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"                                 |         |
      | $.configurations..dataSource           | HDFSDataSource_resolveclusterfalse                   |         |
      | $.configurations..filter..root         | /ScanServiceTest                                     |         |
      | $.configurations..name                 | SC16_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |         |
      | $.configurations..tags[*]              | SC16_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |         |
      | $.configurations..filter..tags[*]      | Positive                                             |         |
      | $.configurations..analyzeCollectedData | false                                                | boolean |
      | $.configurations..scanHdfs             | true                                                 | boolean |
      | $.configurations..scanServices         | true                                                 | boolean |


  @positve @regression @sanity  @MLP-24269 @IDA-1.1.0
  Scenario Outline: SC22#-MLP_24269_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                                     | body                                                                                       | response code | response message                                     | jsonPath                                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                                                        | ida\hbasePayloads\DataSource\license_DS.json                                               | 204           |                                                      |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                                                       | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE_toChange.json  | 204           |                                                      |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                                                       |                                                                                            | 200           | HDFSDataSource_resolveclusterfalse                   |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                                                        | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_scanHdfs_scanServices_Configuration.json | 204           |                                                      |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                                                        |                                                                                            | 200           | SC16_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC16_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |                                                                                            | 200           | IDLE                                                 | $.[?(@.configurationName=='SC16_scanHdfsandscanServiceFALSE_ClusterResolveFALSE')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC16_scanHdfsandscanServiceFALSE_ClusterResolveFALSE  |                                                                                            | 200           |                                                      |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC16_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |                                                                                            | 200           | IDLE                                                 | $.[?(@.configurationName=='SC16_scanHdfsandscanServiceFALSE_ClusterResolveFALSE')].status |

    #7190164
  @webtest
  Scenario:SC22#MLP_24269_Verify HdfsCataloger fails and does not collect info when cluster name manager settings is wrong.(Incorrect hostname)
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC16_scanHdfsandscanServiceFALSE_ClusterResolveFALSE" and clicks on search
    And user performs "facet selection" in "SC16_scanHdfsandscanServiceFALSE_ClusterResolveFALSE" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | File           |
      | Cluster        |
      | Configurations |
      | Roles          |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/HdfsCataloger/SC16_scanHdfsandscanServiceFALSE_ClusterResolveFALSE%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 2             |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/HdfsCataloger/SC16_scanHdfsandscanServiceFALSE_ClusterResolveFALSE/%" should display below info/error/warning
      | type  | logValue                                                                      | logCode           | pluginName | removableText |
      | ERROR | Error: java.net.ConnectException: Connection timed out (Connection timed out) | CATALOG-HDFS-0002 |            |               |

  Scenario:SC22:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                           | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC16_scanHdfsandscanServiceFALSE_ClusterResolveFALSE/% | Analysis |       |       |

       #########################################################SCAN HDFS TRUE and SCAN SERVICE TRUE,CLUSTER RESOLVE FALSE(Invalid ApiVersion)############################################

  Scenario: SC23#-MLP_24269_Update the Cluster manager name configs
    And user update json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE_toChange.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |
    And user "update" the json file "ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE_toChange.json" file for following values
      | jsonPath                                                    | jsonValues | type |
      | $.configurations[0].clusterManager.clusterManagerPort       | 8080       |      |
      | $.configurations[0].clusterManager.clusterManagerApiVersion | api/v5     |      |

  Scenario: SC23#-MLP_24269_Update the plugin name and tag name
    And user "update" the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_scanHdfs_scanServices_Configuration.json" file for following values
      | jsonPath                               | jsonValues                                           | type    |
      | $.configurations..nodeCondition        | name=="Cluster Demo"                                 |         |
      | $.configurations..dataSource           | HDFSDataSource_resolveclusterfalse                   |         |
      | $.configurations..filter..root         | /ScanServiceTest                                     |         |
      | $.configurations..name                 | SC17_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |         |
      | $.configurations..tags[*]              | SC17_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |         |
      | $.configurations..filter..tags[*]      | Positive                                             |         |
      | $.configurations..analyzeCollectedData | false                                                | boolean |
      | $.configurations..scanHdfs             | true                                                 | boolean |
      | $.configurations..scanServices         | true                                                 | boolean |


  @positve @regression @sanity  @MLP-24269 @IDA-1.1.0
  Scenario Outline: SC23#-MLP_24269_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                                     | body                                                                                       | response code | response message                                     | jsonPath                                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/license                                                                                                        | ida\hbasePayloads\DataSource\license_DS.json                                               | 204           |                                                      |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                                                       | ida/hdfsPayloads/DataSource/hdfsdbValidDataSourceConfig_resolveclusterFALSE_toChange.json  | 204           |                                                      |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                                                       |                                                                                            | 200           | HDFSDataSource_resolveclusterfalse                   |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                                                        | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_scanHdfs_scanServices_Configuration.json | 204           |                                                      |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                                                        |                                                                                            | 200           | SC17_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC17_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |                                                                                            | 200           | IDLE                                                 | $.[?(@.configurationName=='SC17_scanHdfsandscanServiceFALSE_ClusterResolveFALSE')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC17_scanHdfsandscanServiceFALSE_ClusterResolveFALSE  |                                                                                            | 200           |                                                      |                                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC17_scanHdfsandscanServiceFALSE_ClusterResolveFALSE |                                                                                            | 200           | IDLE                                                 | $.[?(@.configurationName=='SC17_scanHdfsandscanServiceFALSE_ClusterResolveFALSE')].status |

    #7190164
  @webtest
  Scenario:SC23#MLP_24269_Verify HdfsCataloger fails and does not collect info when cluster name manager settings is wrong.(Incorrect apiversion)
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC17_scanHdfsandscanServiceFALSE_ClusterResolveFALSE" and clicks on search
    And user performs "facet selection" in "SC17_scanHdfsandscanServiceFALSE_ClusterResolveFALSE" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | File           |
      | Cluster        |
      | Configurations |
      | Roles          |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/HdfsCataloger/SC17_scanHdfsandscanServiceFALSE_ClusterResolveFALSE%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 2             |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/HdfsCataloger/SC17_scanHdfsandscanServiceFALSE_ClusterResolveFALSE/%" should display below info/error/warning
      | type  | logValue                  | logCode           | pluginName | removableText |
      | ERROR | Error: HTTP 404 Not Found | CATALOG-HDFS-0002 |            |               |

  Scenario:SC23:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                           | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC17_scanHdfsandscanServiceFALSE_ClusterResolveFALSE/% | Analysis |       |       |


#######################################invalid Credentials in caltaloger and Datasource##############################


  Scenario: SC24#-MLP_24889_Update the Host name respect to the docker
    And user update json file "ida/hdfsPayloads/DataSource/hdfsdbInValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |
    And user update the json file "ida/hdfsPayloads/DataSource/hdfsdbInValidDataSourceConfig.json" file for following values
      | jsonPath                                              | jsonValues               |
      | $.configurations[0].catalogerHdfsUser                 | hdfs                     |
      | $.configurations[0].credential                        | hdfsdbInValidCredentials |
      | $.configurations[0].clusterManager.clusterManagerName | HORTONWORKS              |


  Scenario: SC24#-MLP_24889_Update the Host name respect to the docker for second run
    And user update the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_InvalidCred_Configuration.json" file for following values
      | jsonPath                                    | jsonValues              |
      | $.configurations..nodeCondition             | name=="Cluster Demo"    |
      | $.configurations..dataSource                | HDFSDataSource_Invalid  |
      | $.configurations..filter..root              | /ScanServiceTest        |
      | $.configurations..name                      | SC18_invalidCredentials |
      | $.configurations..tags[*]                   | SC18_invalidCredentials |
      | $.configurations..filter..tags[*]           | InvalidCredentials      |
      | $.configurations..filter..fileMode          | include                 |
      | $.configurations..filter..maxHits           | 100                     |
      | $.configurations..filter..fileExtensions[*] |                         |

#7148467
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC24#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                                             | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                          | ida/hdfsPayloads/DataSource/hdfsdbInValidDataSourceConfig.json                   | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                          |                                                                                  | 200           | HDFSDataSource_Invalid  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                           | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_InvalidCred_Configuration.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                           |                                                                                  | 200           | SC18_invalidCredentials |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC18_invalidCredentials |                                                                                  | 200           | IDLE                    | $.[?(@.configurationName=='SC18_invalidCredentials')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC18_invalidCredentials  |                                                                                  | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC18_invalidCredentials |                                                                                  | 200           | IDLE                    | $.[?(@.configurationName=='SC18_invalidCredentials')].status |

      #7190164
  @webtest
  Scenario:SC24#MLP_24269_Verify Hdfs cataloger fails if a wrong credential is provided and saved in cataloger without using test connection.(even if there were successful cataloger runs earlier with a correct credential).
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC18_invalidCredentials" and clicks on search
    And user performs "facet selection" in "SC18_invalidCredentials" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | File           |
      | Cluster        |
      | Configurations |
      | Roles          |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/HdfsCataloger/SC18_invalidCredentials%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 2             |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/HdfsCataloger/SC18_invalidCredentials/%" should display below info/error/warning
      | type  | logValue                                                                                                                   | logCode           | pluginName | removableText |
      | ERROR | Error: CATALOG-COMMON-CLUSTER-NAME-RESOLVER-0012:Illegal argument exception while retrieving credential configuration name | CATALOG-HDFS-0002 |            |               |

  Scenario:SC24:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC18_invalidCredentials/% | Analysis |       |       |

    ##########################################Cluster manager name CLOUDERA ##########################################

  Scenario: SC25#-MLP_24889_Update the Host name respect to the docker
    And user update json file "ida/hdfsPayloads/DataSource/hdfsdbInValidDataSourceConfig.json" file for following values using property loader
      | jsonPath                                              | jsonValues      |
      | $.configurations[0].clusterManager.clusterManagerHost | clusterHostName |
    And user update the json file "ida/hdfsPayloads/DataSource/hdfsdbInValidDataSourceConfig.json" file for following values
      | jsonPath                                              | jsonValues           |
      | $.configurations[0].catalogerHdfsUser                 | hdfs                 |
      | $.configurations[0].credential                        | HDFSDataSource_valid |
      | $.configurations[0].clusterManager.clusterManagerName | CLOUDERA             |


  Scenario: SC25#-MLP_24889_Update the Host name respect to the docker for second run
    And user update the json file "ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_InvalidCred_Configuration.json" file for following values
      | jsonPath                                    | jsonValues              |
      | $.configurations..nodeCondition             | name=="Cluster Demo"    |
      | $.configurations..dataSource                | HDFSDataSource_valid    |
      | $.configurations..filter..root              | /ScanServiceTest        |
      | $.configurations..name                      | SC19_invalidClusterName |
      | $.configurations..tags[*]                   | SC19_invalidClusterName |
      | $.configurations..filter..tags[*]           | invalidClusterName      |
      | $.configurations..filter..fileMode          | include                 |
      | $.configurations..filter..maxHits           | 100                     |
      | $.configurations..filter..fileExtensions[*] |                         |

#7148467
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC25#-MLP_24889_set HDFS data source with cluter resolve name false and run Hdfs cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                                             | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsDataSource                                                          | ida/hdfsPayloads/DataSource/hdfsdbInValidDataSourceConfig.json                   | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsDataSource                                                          |                                                                                  | 200           | HDFSDataSource_Invalid  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HdfsCataloger                                                           | ida/hdfsPayloads/Cataloger/SC1_new_Hdfs_Cataloger_InvalidCred_Configuration.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                           |                                                                                  | 200           | SC19_invalidClusterName |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC19_invalidClusterName |                                                                                  | 200           | IDLE                    | $.[?(@.configurationName=='SC19_invalidClusterName')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/SC19_invalidClusterName  |                                                                                  | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/SC19_invalidClusterName |                                                                                  | 200           | IDLE                    | $.[?(@.configurationName=='SC19_invalidClusterName')].status |

      #7190164
  @webtest
  Scenario:SC25#MLP_24269_Verify Hdfs cataloger fails if a wrong credential is provided and saved in cataloger without using test connection.(even if there were successful cataloger runs earlier with a correct credential).
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC19_invalidClusterName" and clicks on search
    And user performs "facet selection" in "SC19_invalidClusterName" attribute under "Tags" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | File           |
      | Cluster        |
      | Configurations |
      | Roles          |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/HdfsCataloger/SC19_invalidClusterName%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 2             |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/HdfsCataloger/SC19_invalidClusterName/%" should display below info/error/warning
      | type  | logValue                | logCode           | pluginName | removableText |
      | ERROR | Error: No value present | CATALOG-HDFS-0002 |            |               |

  Scenario:SC25:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type     | query | param |
      | MultipleIDDelete | Default | cataloger/HdfsCataloger/SC19_invalidClusterName/% | Analysis |       |       |



      ############### Deleting the credentials , Data Source & Bussiness Application######################

  @MLP-1960  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC26:Delete folder in Ambaris
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization               | X-Requested-By | type   | url                                       | body | response code | response message |
      | HdfsNameNode | Basic cmFq X29wczpyYWpfb3Bz | ambari         | Delete | /ScanServiceTest?op=DELETE&recursive=true |      | 200           | true             |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline:SC26:MLP-24889:Deleting the Credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                          | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/hdfsDBValidCredential   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/hdfsDBInValidCredential |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/hdfsDBEmptyCredential   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HdfsDataSource            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/HdfsCataloger             |      | 204           |                  |          |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario:SC26:Delete Bussiness Application
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name    | type                | query | param |
      | SingleItemDelete | Default | HDFS_BA | BusinessApplication |       |       |
