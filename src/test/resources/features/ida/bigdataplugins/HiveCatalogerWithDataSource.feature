Feature:MLP-24876: Hive Datasource testing and Hive Cataloger functionality


  @positve @regression @sanity @MLP-24876 @IDA-1.1.0
  Scenario Outline: Set the Credentials, Datasource, Bussiness Application and Cataloger for Hive Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                        | body                                                             | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hiveValidCredential   | ida/hivePayloads/Credentials/hiveValidCredentials.json           | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hiveInValidCredential | ida/hivePayloads/Credentials/hiveInValidCredentials.json         | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/hiveEmptyCredential   | ida/hivePayloads/Credentials/hiveEmptyCredentials.json           | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hiveValidCredential   |                                                                  | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hiveInValidCredential |                                                                  | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/hiveEmptyCredential   |                                                                  | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root                         | ida\hivePayloads\Bussiness_Application\BussinessApplication.json | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/HiveDataSource          | ida/hivePayloads/DataSource/hiveValidDataSourceConfig.json       | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/HiveDataSource          |                                                                  | 200           | HiveDataSource_Valid |          |


    #7143366
  @MLP-24876 @webtest @regression @positive
  Scenario:SC1#MLP_24876_Verify error message is thrown if inputs are not provided for mandatory fields and name field is passed with existing value or with value as /
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute           |
      | Data Source Type | HiveDataSource      |
#      | Plugin version   | LATEST              |
      | Credential       | hiveValidCredential |
      | Node             | Cluster Demo        |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  | HiveDataSource_Valid   |
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


  #7143370
  @MLP-24876 @webtest @regression @positive
  Scenario:SC#2:MLP-24196 : Verify Hive DataSource connection is successful when kerberos authentication is blank and Resolve cluster name is disabled with valid cluster manager settings and valid credentials are provided.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute           |
      | Data Source Type | HiveDataSource      |
#      | Plugin version   | LATEST              |
      | Credential       | hiveValidCredential |
      | Node             | Cluster Demo        |
    And user "click" on "field" button in "Cluster name configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute      |
      | Name                        | HiveDataSource |
      | Label                       | HiveDataSource |
      | Cluster manager hostname    | 10.33.10.138   |
      | Cluster manager port        | 8080           |
      | Cluster manager API version | api/v1         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"

#7143363
  @MLP-24876 @webtest @regression @positive
  Scenario:SC#3:MLP-24196:Verify Hive DataSource connection is successful when Resolve cluster name is disabled(cluster manager settings empty) and valid credentials are provided.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute           |
      | Data Source Type | HiveDataSource      |
#      | Plugin version   | LATEST              |
      | Credential       | hiveValidCredential |
      | Node             | Cluster Demo        |
    And user "click" on "field" button in "Cluster name configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       |
      | Name                        | HiveDataSource1 |
      | Label                       | HiveDataSource1 |
      | Cluster manager hostname    |                 |
      | Cluster manager port        |                 |
      | Cluster manager API version |                 |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"

#7143362
  @MLP-24876 @webtest @regression @positive
  Scenario:SC#4:MLP-24876 : Verify Hive DataSource connection is unsuccessful when Resolve cluster name is enabled with valid cluster manager settings and invalid credentials are provided.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute             |
      | Data Source Type | HiveDataSource        |
#      | Plugin version   | LATEST                |
      | Credential       | hiveInValidCredential |
      | Node             | Cluster Demo          |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "click" on "field" button in "Cluster name configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       |
      | Name                        | HiveDataSource3 |
      | Label                       | HiveDataSource3 |
      | Cluster manager hostname    | 10.33.10.138    |
      | Cluster manager port        | 8080            |
      | Cluster manager API version | api/v1          |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"


  #7143369
  @MLP-24876 @webtest @regression @positive
  Scenario:SC#5:MLP-24876 : Verify Hive DataSource connection is successful when kerberos authentication is blank and Resolve cluster name is disabled and empty credentials are provided.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute           |
      | Data Source Type | HiveDataSource      |
#      | Plugin version   | LATEST              |
      | Credential       | hiveEmptyCredential |
      | Node             | Cluster Demo        |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute       |
      | Name      | HiveDataSource3 |
      | Label     | HiveDataSource3 |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"


  #7143368
  @MLP-24876 @webtest @regression @positive
  Scenario:SC#6:MLP-24876 : Verify Hive DataSource connection is unsuccessful when Resolve cluster name is enabled and empty credentials are provided.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute           |
      | Data Source Type | HiveDataSource      |
#      | Plugin version   | LATEST              |
      | Credential       | hiveEmptyCredential |
      | Node             | Cluster Demo        |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "enter text" in Add Data Source Page
      | fieldName | attribute       |
      | Name      | HiveDataSource4 |
      | Label     | HiveDataSource4 |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

#7143289
  @MLP-24876 @webtest @regression @positive
  Scenario:SC#7:MLP-24876 : Verify Hive DS connection is unsuccessful when Resolve cluster name:enabled with invalid cluster manager settings(cluster:HORTONWORKS,cluster manager host/port/api version are invalid) and valid credentials are provided.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute           |
      | Data Source Type | HiveDataSource      |
#      | Plugin version   | LATEST              |
      | Credential       | hiveValidCredential |
      | Node             | Cluster Demo        |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "click" on "field" button in "Cluster name configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       |
      | Name                        | HiveDataSource5 |
      | Label                       | HiveDataSource5 |
      | Cluster manager hostname    | 10.33.10.13     |
      | Cluster manager port        | 8080            |
      | Cluster manager API version | api/v1          |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       |
      | Name                        | HiveDataSource5 |
      | Label                       | HiveDataSource5 |
      | Cluster manager hostname    | 10.33.10.138    |
      | Cluster manager port        | 8081            |
      | Cluster manager API version | api/v1          |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       |
      | Name                        | HiveDataSource5 |
      | Label                       | HiveDataSource5 |
      | Cluster manager hostname    | 10.33.10.138    |
      | Cluster manager port        | 8080            |
      | Cluster manager API version | api/v2          |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"


  #7143333
  @MLP-24876 @webtest @regression @positive
  Scenario:SC#8:MLP-24876 : Verify Hive DS connection is unsuccessful when Resolve cluster name:enabled with invalid cluster manager settings(cluster:HORTONWORKS,cluster manager host/port/api version are empty) and valid credentials are provided.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute           |
      | Data Source Type | HiveDataSource      |
#      | Plugin version   | LATEST              |
      | Credential       | hiveValidCredential |
      | Node             | Cluster Demo        |
    And user "click" on "slide bar" button in "resolveClusterName"
    And user "click" on "field" button in "Cluster name configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       |
      | Name                        | HiveDataSource5 |
      | Label                       | HiveDataSource5 |
      | Cluster manager hostname    |                 |
      | Cluster manager port        |                 |
      | Cluster manager API version |                 |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

#7143365
  @MLP-24876 @webtest @regression @positive
  Scenario:SC#9:MLP-24876:Verify Hive DataSource connection is successful when Resolve cluster name is disabled(cluster manager settings incorrect) and valid credentials are provided.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute           |
      | Data Source Type | HiveDataSource      |
#      | Plugin version   | LATEST              |
      | Credential       | hiveValidCredential |
      | Node             | Cluster Demo        |
    And user "click" on "field" button in "Cluster name configuration settings"
    And user "enter text" in Add Data Source Page
      | fieldName                   | attribute       |
      | Name                        | HiveDataSource1 |
      | Label                       | HiveDataSource1 |
      | Cluster manager hostname    | 10.33.1.1       |
      | Cluster manager port        | 8090            |
      | Cluster manager API version | api/v3          |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"

#7143367
  @MLP-24876 @webtest @positive @regression @sanity
  Scenario: SC#10-Verify captions in HiveDataSource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Settings Icon                                      |
      | click       | Settings Icon                                      |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute      |
      | Data Source Type | HiveDataSource |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                       |
#      | Plugin version              |
      | Label                       |
      | Resolve cluster name        |
      | Cluster manager hostname    |
      | Cluster manager port        |
      | Cluster manager API version |
      | Credential*                 |
      | Node                        |

#7143371
  @MLP-24876 @webtest @positive @regression @sanity
  Scenario: SC#11-Verify captions in HiveCataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem            |
      | mouse hover | Settings Icon         |
      | click       | Settings Icon         |
      | click       | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem   |
      | Open Deployment | Cluster Demo |
    And user "click" on "Add Configuration" button under "Cluster Demo" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute     |
      | Type      | Cataloger     |
      | Plugin    | HiveCataloger |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                  |
#      | Plugin version         |
      | Label                  |
      | Business Application   |
      | Data Source*           |
      | Credential*            |
      | Analyze collected data |


      #7132255
  @positve @regression @sanity  @MLP-24873 @IDA-1.1.0
  Scenario Outline: Get the Hive DataSource Configuration response
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                               | body                                      | response code | response message | filePath                                    | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | /schemes/analyzers/configurations | response/hive/body/ToolTip_Cataloger.json | 200           |                  | response/hive/actual/ToolTip_Cataloger.json |          |
      | IDC         | TestSystem | application/json |       |       | Post | /schemes/analyzers/configurations | response/hive/body/ToolTip_DS.json        | 200           |                  | response/hive/actual/ToolTip_DS.json        |          |

    #7143367
    ##bug- MLP-25288,MLP-25457
  @positve @regression @sanity  @MLP-24873 @IDA-1.1.0
  Scenario Outline:SC12# Validate ToolTip for all the fields in Hive Db Datasource plugin(HiveDataSourceType,Name,PluginVersion,label,Credential,resolveClusterName,clusterManager,clusterManagerName,clusterManagerHost,clusterManagerPort,clusterManagerApiVersion)
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                      | actualValues                         | valueType     | expectedJsonPath                                     | actualJsonPath                                                  |
      #| response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_DS.json | stringCompare | $.Commonfields.hdfsDataSourceType.tooltip            | $.properties[0].value.prototype.properties[0].tooltip           |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_DS.json | stringCompare | $.Commonfields.Name.tooltip                          | $.properties[0].value.prototype.properties[1].tooltip           |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_DS.json | stringCompare | $.Commonfields.pluginVersion.tooltip                 | $.properties[0].value.prototype.properties[2].tooltip           |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_DS.json | stringCompare | $.Commonfields.label.tooltip                         | $.properties[0].value.prototype.properties[3].tooltip           |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_DS.json | stringCompare | $.Commonfields.credential.tooltip                    | $.properties[0].value.prototype.properties[13].tooltip          |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hive.kerberosauthentication.tooltip   | $.properties[0].value.prototype.properties[15].tooltip          |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hive.kerberosKeytabLocation.tooltip   | $.properties[0].value.prototype.properties[15].value[0].tooltip |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hive.kerberosKrb5location.tooltip     | $.properties[0].value.prototype.properties[15].value[1].tooltip |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hive.kerberosPrincipalName.tooltip    | $.properties[0].value.prototype.properties[15].value[2].tooltip |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hive.resolveClusterName.tooltip       | $.properties[0].value.prototype.properties[16].tooltip          |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hive.clusterManager.tooltip           | $.properties[0].value.prototype.properties[17].tooltip          |
      #| response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hive.clusterManagerName.tooltip       | $.properties[0].value.prototype.properties[17].value[0].tooltip |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hive.clusterManagerHost.tooltip       | $.properties[0].value.prototype.properties[17].value[1].tooltip |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hive.clusterManagerPort.tooltip       | $.properties[0].value.prototype.properties[17].value[2].tooltip |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_DS.json | stringCompare | $.Uniquefilter.hive.clusterManagerApiVersion.tooltip | $.properties[0].value.prototype.properties[17].value[3].tooltip |


    #7143371
    ##bug- MLP-25288,MLP-25457
  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0
  Scenario Outline:SC13# Validate ToolTip for all the fields in hive Db Cataloger plugin(Type,Plugin,Name,Plugin version,label,BA, Data Source, Credential,Event Condition,Dry Run, Event class,Max Work sixe,node condition,Auto Start,tags,Unique Filter)
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                      | actualValues                                | valueType     | expectedJsonPath                                 | actualJsonPath                                                                                |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields..[?(@.label=='Type')].tooltip     | $..[?(@.label=='Type')].tooltip                                                               |
      #| response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields..[?(@.label=='Plugin')].tooltip   | $..[?(@.label=='Plugin')].tooltip                                                       |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.pluginName.tooltip                | $.properties[0].value.prototype.properties[1].tooltip                                         |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.PluginConfigName.tooltip          | $.properties[0].value.prototype.properties[2].tooltip                                         |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.pluginVersion.tooltip             | $.properties[0].value.prototype.properties[3].tooltip                                         |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.label.tooltip                     | $.properties[0].value.prototype.properties[4].tooltip                                         |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.businessApplicationName.tooltip   | $.properties[0].value.prototype.properties[17].tooltip                                        |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Uniquefilter.hive.deltaTime.tooltip            | $.properties[0].value.prototype.properties[19].value[0].tooltip                               |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Uniquefilter.hive.analyzeCollectedData.tooltip | $.properties[0].value.prototype.properties[18].tooltip                                        |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.dataSource.tooltip                | $.properties[0].value.prototype.properties[14].tooltip                                        |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.credential.tooltip                | $.properties[0].value.prototype.properties[16].tooltip                                        |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.eventCondition.tooltip            | $.properties[0].value.prototype.properties[5].tooltip                                         |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.dryRun.tooltip                    | $.properties[0].value.prototype.properties[6].tooltip                                         |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.eventClass.tooltip                | $.properties[0].value.prototype.properties[7].tooltip                                         |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.maxWorkSize.tooltip               | $.properties[0].value.prototype.properties[8].tooltip                                         |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.nodeCondition.tooltip             | $.properties[0].value.prototype.properties[10].tooltip                                        |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.autoStart.tooltip                 | $.properties[0].value.prototype.properties[11].tooltip                                        |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.tags.tooltip                      | $.properties[0].value.prototype.properties[12].tooltip                                        |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Uniquefilter.hive.filters.tooltip              | $.properties[0].value.prototype.properties[19].value[1].value.prototype.properties[0].tooltip |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Uniquefilter.hive.Databases.tooltip            | $.properties[0].value.prototype.properties[19].value[1].value.prototype.properties[2].tooltip |
      | response/hive/expected/ToolTip.json | response/hive/actual/ToolTip_Cataloger.json | stringCompare | $.Uniquefilter.hive.tags.tooltip                 | $.properties[0].value.prototype.properties[19].value[1].value.prototype.properties[3].tooltip |


  Scenario: MLP-24873: Verify whether the Hive database and tables are created in Hive.
    Given user executes the following Query in the Hive JDBC
      | queryEntry                  |
      | CreateHiveDatabase          |
      | CreateHiveTable11           |
      | InsertHiveTable1            |
      | InsertHiveTable2            |
      | InsertHiveTable3            |
      | InsertHiveTable4            |
      | InsertHiveTable5            |
      | CreateHiveTable22           |
      | CreateHiveTable2            |
      | CreateHiveTable33           |
      | InsertHiveTable33Row1       |
      | InsertHiveTable33Row2       |
      | InsertHiveTable33Row3       |
      | InsertHiveTable33Row4       |
      | InsertHiveTable33Row5       |
      | CreateHiveDatabase2         |
      | CreateHiveBDADB             |
      | CreateBDATable2             |
      | CreateHivePartitionDatabase |
      | CreateHiveNonPartitionTable |
      | InsertIntoNonPartitionTable |
      | CreateHivePartitionTable    |
      | SetPartitionTrue            |
      | SetPartitionModeNonStrict   |
      | InsertIntoPartitionTable    |


#6822675
  Scenario Outline:MLP-24873:SC14#Run the Plugin configurations for HiveCataloger with single DB filter having tags.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                               | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                 | ida/hivePayloads/PluginConfiguration/HiveConfigSingleDBFilter.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                 |                                                                    | 200           | HiveCataloger    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                    | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  | ida/hivePayloads/PluginConfiguration/empty.json                    | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                    | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |

    #7142554
  @webtest @MLP-1960 @sanity @positive @regression
  Scenario:SC14#:Check the cluster name shows 'Cluster Demo' in UI(Resolve cluster name disabled in DataSource and cluster manager is HORTONWORKS)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | Cluster Demo |


    ##7142556,7142559##
  @webtest @MLP-24873 @sanity @positive @regression
  Scenario:SC#15: Verify the Database Name,Service,Table,Column should have the appropriate metadata information in IDC UI.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "hivesample" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                      | widgetName  |
      | Location          | /apps/hive/warehouse/hivesample.db | Description |
      | Storage type      | rbd/hive                           | Description |
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HIVE" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute   | metaDataValue                       | widgetName  |
      | Definition          | Hive data warehouse                 | Description |
      | Application Version | 1.2.1000.2.5.0.0-1245               | Description |
      | Location            | hdfs://sandbox.hortonworks.com:8020 | Description |
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testtable1" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                 | widgetName  |
      | Location          | /apps/hive/warehouse/hivesample.db/testtable1 | Description |
      | Storage type      | managed                                       | Description |
      | Table Type        | TABLE                                         | Description |
      | Table Type        | TABLE                                         | Description |
      | Created by        | raj_ops                                     | Description |
      | Input type        | org.apache.hadoop.mapred.TextInputFormat      | Description |
      | Number of files   | 5                                             | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "testtable1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "employeeid" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | int           | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |



    ##7142558,7142561##
  @webtest @MLP-24873 @sanity @positive @regression
  Scenario:SC#16: Verify the host Name,table name,Column name,DataPackage and DataType should have the appropriate metadata information in IDC UI.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Host" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "sandbox.hortonworks.com" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue           | widgetName  |
      | Host name         | sandbox.hortonworks.com | Description |
      | hostIp            | 172.18.0.2              | Description |
      | Number of cores   | 0                       | Statistics  |
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testtable1" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                 | widgetName  |
      | Location          | /apps/hive/warehouse/hivesample.db/testtable1 | Description |
      | Storage type      | managed                                       | Description |
      | Table Type        | TABLE                                         | Description |
      | Table Type        | TABLE                                         | Description |
      | Created by        | raj_ops                                       | Description |
      | Input type        | org.apache.hadoop.mapred.TextInputFormat      | Description |
      | Number of files   | 5                                             | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "testtable1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "employeeid" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | int           | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DataPackage" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Cluster Demo" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | stage             | BigData       | Description |
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DataType" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "string" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Definition        | string        | Description |
      | Data type         | STRING        | Description |
      | stage             | BigData       | Description |


#7142562,7143372
  @sanity @positive @webtest @MLP-24873
  Scenario: SC20# Verify the technology tags,explict,Business Application tags got assigned to all HiveCataloged items like Cluster,Service,Database...etc
  Verify HiveCataloger scans and collects data if single filter with DB is provided with tags.
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | testtable1 |
      | hivesample |
      | zone_west  |
      | zone_east  |
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Hive,HiveTag1,Hive_BA" should get displayed for the column "cataloger/HiveCataloger"
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name          | facet         | Tag                   | fileName                | userTag  |
      | Default     | Cluster       | Metadata Type | Hive,HiveTag1,Hive_BA | Cluster Demo            | HiveTag1 |
      | Default     | Host          | Metadata Type | Hive,HiveTag1,Hive_BA | sandbox.hortonworks.com | HiveTag1 |
      | Default     | Column        | Metadata Type | Hive,HiveTag1,Hive_BA | employeeid              | HiveTag1 |
      | Default     | Database      | Metadata Type | Hive,HiveTag1,Hive_BA | hivesample              | HiveTag1 |
      | Default     | Service       | Metadata Type | Hive,HiveTag1,Hive_BA | HIVE                    | HiveTag1 |
      | Default     | Table         | Metadata Type | Hive,HiveTag1,Hive_BA | testtable1              | HiveTag1 |
      | Default     | DataPackage   | Metadata Type | Hive,HiveTag1,Hive_BA | Cluster Demo            | HiveTag1 |
      | Default     | DataType      | Metadata Type | Hive,HiveTag1,Hive_BA | string                  | HiveTag1 |
      | Default     | Configuration | Metadata Type | Hive,HiveTag1,Hive_BA | hive connection         | HiveTag1 |


    #7142563#
  @sanity @positive @MLP-24873 @webtest @IDA-1.1.0
  Scenario:SC21#Verify log entries/log enhancements(processed Items widget and Processed count) check for HiveCataloger plugin logs.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/HiveCataloger/HiveCataloger%"
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | Cluster Demo |
      | HIVE         |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "cataloger/HiveCataloger/HiveCataloger%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | logCode       | pluginName    | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0019 |               |                |
      | INFO | Plugin Name:HiveCataloger, Plugin Type:cataloger, Plugin Version:1.1.0.SNAPSHOT, Node Name:Cluster Demo, Host Name:sandbox.hortonworks.com, Plugin Configuration name:HiveCataloger                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0071 | HiveCataloger | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin HiveCataloger Configuration: ---  2020-10-01 20:50:48.054 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: name: "HiveCataloger"  2020-10-01 20:50:48.054 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: pluginVersion: "LATEST"  2020-10-01 20:50:48.054 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: label:  2020-10-01 20:50:48.054 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: : ""  2020-10-01 20:50:48.054 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: catalogName: "Default"  2020-10-01 20:50:48.054 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: eventClass: null  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: eventCondition: null  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: nodeCondition: "name==\"Cluster Demo\""  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: maxWorkSize: 100  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: tags:  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: - "HiveTag1"  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: pluginType: "cataloger"  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: dataSource: "HiveDataSource_Valid"  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: credential: "hiveValidCredential"  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: businessApplicationName: "Hive_BA"  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: dryRun: false  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: schedule: null  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: filter:  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: filters:  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: - class: "com.asg.dis.common.analysis.dom.HiveFilter"  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: label:  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: : "filter11"  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: tags:  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: - "HiveTag1"  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: dbRegexList:  2020-10-01 20:50:48.055 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: - "hivesample"  2020-10-01 20:50:48.056 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: deltaTime: "30"  2020-10-01 20:50:48.056 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: extraFilters: {}  2020-10-01 20:50:48.056 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: maxHits: null  2020-10-01 20:50:48.056 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: analyzeCollectedData: true  2020-10-01 20:50:48.056 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: pluginName: "HiveCataloger"  2020-10-01 20:50:48.056 INFO  - ANALYSIS-0073: Plugin HiveCataloger Configuration: type: "Cataloger" | ANALYSIS-0073 | HiveCataloger |                |
      | INFO | Plugin HiveCataloger Start Time:2020-07-17 20:43:24.483, End Time:2020-07-17 20:43:25.176, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ANALYSIS-0072 | HiveCataloger |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:35.865)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0020 |               |                |


  @sanity @positive @regression
  Scenario:SC#21_Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | SingleItemDelete | Default | Cluster Demo                           | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger% | Analysis |       |       |


  @ambari @positve @hdfs @regression @sanity
  Scenario: verify the message.log is cleared.
    Given user connects to the sftp server and runs spark commands
      | command         | RemoteMachinePath | Filename     |
      | ClearFileinUnix | /home/log         | messages.log |


    #6822675
  Scenario Outline:MLP-24873:SC22#Run the Plugin configurations for HiveCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                 | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                 | ida/hivePayloads/PluginConfiguration/HiveConfigMultipleDBFilter.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                 |                                                                      | 200           | HiveCataloger    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  | ida/hivePayloads/PluginConfiguration/empty.json                      | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |

#7142564
  @webtest @jdbc @MLP-24873
  Scenario:SC#22:  Verify HiveCataloger scans and collects data if multiple filters with DB is provided in filters with tags.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | testtable1 |
    And user enters the search text "HiveTag2" and clicks on search
    And user performs "facet selection" in "default [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | sample_07  |
      | sample_08  |
      | testtable1 |
    And user enters the search text "HiveTag3" and clicks on search
    And user performs "facet selection" in "HiveTag3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Hive,HiveTag3,Hive_BA" should get displayed for the column "cataloger/HiveCataloger"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name          | facet         | Tag                            | fileName                | userTag  |
      | Default     | Cluster       | Metadata Type | Hive,HiveTag3,Hive_BA          | Cluster Demo            | HiveTag3 |
      | Default     | Host          | Metadata Type | Hive,HiveTag3,Hive_BA          | sandbox.hortonworks.com | HiveTag3 |
      | Default     | Column        | Metadata Type | Hive,HiveTag1,HiveTag3,Hive_BA | employeeid              | HiveTag1 |
      | Default     | Database      | Metadata Type | Hive,HiveTag1,HiveTag3,Hive_BA | hivesample              | HiveTag1 |
      | Default     | Service       | Metadata Type | Hive,HiveTag3,Hive_BA          | HIVE                    | HiveTag3 |
      | Default     | Table         | Metadata Type | Hive,HiveTag1,HiveTag3,Hive_BA | testtable1              | HiveTag1 |
      | Default     | DataPackage   | Metadata Type | Hive,HiveTag3,Hive_BA          | Cluster Demo            | HiveTag3 |
      | Default     | DataType      | Metadata Type | Hive,HiveTag3,Hive_BA          | string                  | HiveTag3 |
      | Default     | Configuration | Metadata Type | Hive,HiveTag3,Hive_BA          | hive connection         | HiveTag3 |
      | Default     | Column        | Metadata Type | Hive,HiveTag2,HiveTag3,Hive_BA | code                    | HiveTag2 |
      | Default     | Database      | Metadata Type | Hive,HiveTag2,HiveTag3,Hive_BA | default                 | HiveTag2 |
      | Default     | Table         | Metadata Type | Hive,HiveTag2,HiveTag3,Hive_BA | sample_08               | HiveTag2 |

#7142567
  @MLP-1983 @sanity @ambari @positive
  Scenario: SC23#MLP-1841:verify the message.log has the entry for running of HiveCataloger.
    Given user connects to the SFTP server and downloads the "messages.log"
    Then user validates the entries in "message.log"
      | logEntry                           |
      | HiveCatalogerScanInitiated         |
      | HiveCatalogerTagsScannedEntry      |
      | HiveCatalogerDatabaseScanEntry     |
      | HiveCatalogerDatabaseRetrivalEntry |
      | HiveCatalogerTableScanEntry1       |
      | HiveCatalogerFieldSchemaEntry1     |
      | HiveCatalogerTableScanEntry2       |
      | HiveCatalogerFieldSchemaEntry2     |
      | HiveCatalogertoDataAnalyzerEntry   |


  @sanity @positive @regression
  Scenario:SC#23_Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | SingleItemDelete | Default | Cluster Demo                           | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger% | Analysis |       |       |


  Scenario Outline:MLP-24873:SC24#Run the Plugin configurations for HiveCataloger with multiple DB in single filter having tags.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                         | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                 | ida/hivePayloads/PluginConfiguration/HiveConfigMultipleDBInSingleFilter.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                 |                                                                              | 200           | HiveCataloger    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  | ida/hivePayloads/PluginConfiguration/empty.json                              | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |

#7142568
  @webtest @jdbc @MLP-24873
  Scenario:SC#24:  Verify HiveCataloger scans and collects data if multiple DB in single filter with tags.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | testtable1 |
      | sample_07  |
      | sample_08  |
    And user enters the search text "HiveTag3" and clicks on search
    And user performs "facet selection" in "HiveTag3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Hive,HiveTag1,HiveTag3,Hive_BA" should get displayed for the column "cataloger/HiveCataloger"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name          | facet         | Tag                            | fileName                | userTag  |
      | Default     | Cluster       | Metadata Type | Hive,HiveTag3,Hive_BA          | Cluster Demo            | HiveTag3 |
      | Default     | Host          | Metadata Type | Hive,HiveTag3,Hive_BA          | sandbox.hortonworks.com | HiveTag3 |
      | Default     | Column        | Metadata Type | Hive,HiveTag1,HiveTag3,Hive_BA | employeeid              | HiveTag1 |
      | Default     | Database      | Metadata Type | Hive,HiveTag1,HiveTag3,Hive_BA | hivesample              | HiveTag1 |
      | Default     | Service       | Metadata Type | Hive,HiveTag3,Hive_BA          | HIVE                    | HiveTag3 |
      | Default     | Table         | Metadata Type | Hive,HiveTag1,HiveTag3,Hive_BA | testtable1              | HiveTag1 |
      | Default     | DataPackage   | Metadata Type | Hive,HiveTag3,Hive_BA          | Cluster Demo            | HiveTag3 |
      | Default     | DataType      | Metadata Type | Hive,HiveTag3,Hive_BA          | string                  | HiveTag3 |
      | Default     | Configuration | Metadata Type | Hive,HiveTag3,Hive_BA          | hive connection         | HiveTag3 |
      | Default     | Column        | Metadata Type | Hive,HiveTag1,HiveTag3,Hive_BA | code                    | HiveTag1 |
      | Default     | Database      | Metadata Type | Hive,HiveTag1,HiveTag3,Hive_BA | default                 | HiveTag1 |
      | Default     | Table         | Metadata Type | Hive,HiveTag1,HiveTag3,Hive_BA | sample_08               | HiveTag1 |


  @sanity @positive @regression
  Scenario:SC#24_Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | SingleItemDelete | Default | Cluster Demo                           | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger% | Analysis |       |       |


#6822675
  Scenario Outline:MLP-24873:SC25#Run the Plugin configurations for HiveCataloger with non existing DB in single filter having tags.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                    | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                 | ida/hivePayloads/PluginConfiguration/HiveConfigNonexistingDBFilter.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                 |                                                                         | 200           | HiveCataloger    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  | ida/hivePayloads/PluginConfiguration/empty.json                         | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |

#7142569
  @jdbc @MLP-24873 @webtest
  Scenario: SC#25:Verify HiveCataloger scans and does not collects data if non existing DB name are provided in filters.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag3" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service  |
      | Cluster  |
      | Database |
      | Table    |
      | Column   |
      | Host     |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis |
    And user performs "latest analysis click" in Item Results page for "cataloger/HiveCataloger/HiveCataloger%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "cataloger/HiveCataloger/HiveCataloger%" should display below info/error/warning
      | type | logValue                                                                                                                                                                   | logCode           | pluginName    | removableText |
      | INFO | CATALOG-HIVE-0020: There is no Hive database that matches filter setting WARN  - CATALOG-HIVE-0022 CatalogHive didn't scan any databases based on current filter settings. | CATALOG-HIVE-0020 | HiveCataloger |               |
    And user clicks on logout button


  @sanity @positive @regression
  Scenario:SC#25_Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | SingleItemDelete | Default | Cluster Demo                           | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger% | Analysis |       |       |


    #6822675
  Scenario Outline:MLP-24873:SC26#Run the Plugin configurations for HiveCataloger with dry run as true.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                         | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                 | ida/hivePayloads/PluginConfiguration/HiveConfigSingleDBFilterDryRunTrue.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                 |                                                                              | 200           | HiveCataloger    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  | ida/hivePayloads/PluginConfiguration/empty.json                              | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |


    #7142570
  @MLP-24873 @webtest @regression @sanity
  Scenario: SC#26- Verify HiveCataloger doesn't collects Cluster,Service,Database,Table,Column,Constraint when run with dryrun as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag1" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service  |
      | Cluster  |
      | Database |
      | Table    |
      | Column   |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/HiveCataloger/HiveCataloger%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "cataloger/HiveCataloger/HiveCataloger%" should display below info/error/warning
      | type | logValue                                                                                                                           | logCode       | pluginName    | removableText |
      | INFO | Plugin HiveCataloger running on dry run mode                                                                                       | ANALYSIS-0069 | HiveCataloger |               |
      | INFO | Plugin HiveCataloger processed 2 items on dry run mode and not written to the repository                                           | ANALYSIS-0070 | HiveCataloger |               |
      | INFO | Plugin HiveCataloger Start Time:2020-06-15 23:31:07.702, End Time:2020-06-15 23:31:09.040, Processed Count:2, Errors:0, Warnings:0 | ANALYSIS-0072 | HiveCataloger |               |
    And user clicks on logout button

  @sanity @positive @regression
  Scenario:SC#26_Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger% | Analysis |       |       |


  Scenario Outline:MLP-24873:SC27#Run the Plugin configurations for HiveCataloger with filter having database with no tables.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                       | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                 | ida/hivePayloads/PluginConfiguration/HiveConfigSingleDBNoTablesFilter.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                 |                                                                            | 200           | HiveCataloger    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  | ida/hivePayloads/PluginConfiguration/empty.json                            | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |

#7143374
  @jdbc @MLP-24873 @webtest @ambari
  Scenario: SC#27:Verify HiveCataloger works properly when filter has database with no tables in it.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis      |
      | Cluster       |
      | Database      |
      | Host          |
      | Service       |
      | DataPackage   |
      | Configuration |
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Table  |
      | Column |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/HiveCataloger/HiveCataloger%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 2             | Description |
      | Number of errors          | 0             | Description |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | Cluster Demo |
      | HIVE         |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "cataloger/HiveCataloger/HiveCataloger%" should display below info/error/warning
      | type | logValue                                                                                                                                          | logCode       | pluginName    | removableText |
      | INFO | ANALYSIS-0072: Plugin HiveCataloger Start Time:2020-07-19 19:20:18.765, End Time:2020-07-19 19:20:19.390, Processed Count:2, Errors:0, Warnings:0 | ANALYSIS-0072 | HiveCataloger |               |
    And user clicks on logout button

  @sanity @positive @regression
  Scenario:SC#27_Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | SingleItemDelete | Default | Cluster Demo                           | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger% | Analysis |       |       |


  Scenario Outline:MLP-24873:SC28#Run the Plugin configurations for HiveCataloger with filter having database with table having 50 columns.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                             | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                 | ida/hivePayloads/PluginConfiguration/HiveConfigSingleDBTable50columnsFilter.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                 |                                                                                  | 200           | HiveCataloger    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  | ida/hivePayloads/PluginConfiguration/empty.json                                  | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |

    #7142572
  @jdbc @MLP-24873 @webtest
  Scenario: SC#28:Verify HiveCataloger works properly when filter has database with table having 50 columns in it.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "bdatable [Table]" attribute under "Hierarchy" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Column    | 50    |

  @sanity @positive @regression
  Scenario:SC#28_Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | SingleItemDelete | Default | Cluster Demo                           | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger% | Analysis |       |       |


    #6822675
  Scenario Outline:MLP-24873:SC29#Run the Plugin configurations for HiveCataloger with multiple DB filters having duplicates and multiple tags.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                                | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                 | ida/hivePayloads/PluginConfiguration/HiveConfigMultipleDBFiltersWithDuplicates.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                 |                                                                                     | 200           | HiveCataloger    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  | ida/hivePayloads/PluginConfiguration/empty.json                                     | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |

  #7142573
  @webtest @jdbc @MLP-24873
  Scenario:SC#29:  Verify HiveCataloger scans and collects data with multiple DB filters having duplicates and multiple tags.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag2" and clicks on search
    And user performs "facet selection" in "HiveTag2" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | testtable1 |
      | sample_07  |
      | sample_08  |
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | testtable1 |
    And user enters the search text "HiveTag3" and clicks on search
    And user performs "facet selection" in "HiveTag3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Hive,HiveTag3,Hive_BA" should get displayed for the column "cataloger/HiveCataloger"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name          | facet         | Tag                                     | fileName                | userTag  |
      | Default     | Cluster       | Metadata Type | Hive,HiveTag3,Hive_BA                   | Cluster Demo            | HiveTag3 |
      | Default     | Host          | Metadata Type | Hive,HiveTag3,Hive_BA                   | sandbox.hortonworks.com | HiveTag3 |
      | Default     | Column        | Metadata Type | Hive,HiveTag1,HiveTag3,HiveTag4,Hive_BA | employeeid              | HiveTag1 |
      | Default     | Database      | Metadata Type | Hive,HiveTag1,HiveTag3,HiveTag4,Hive_BA | hivesample              | HiveTag1 |
      | Default     | Service       | Metadata Type | Hive,HiveTag3,Hive_BA                   | HIVE                    | HiveTag3 |
      | Default     | Table         | Metadata Type | Hive,HiveTag1,HiveTag3,HiveTag4,Hive_BA | testtable1              | HiveTag1 |
      | Default     | DataPackage   | Metadata Type | Hive,HiveTag3,Hive_BA                   | Cluster Demo            | HiveTag3 |
      | Default     | DataType      | Metadata Type | Hive,HiveTag3,Hive_BA                   | string                  | HiveTag3 |
      | Default     | Configuration | Metadata Type | Hive,HiveTag3,Hive_BA                   | hive connection         | HiveTag3 |
      | Default     | Column        | Metadata Type | Hive,HiveTag2,HiveTag3,Hive_BA          | code                    | HiveTag2 |
      | Default     | Database      | Metadata Type | Hive,HiveTag2,HiveTag3,Hive_BA          | default                 | HiveTag2 |
      | Default     | Table         | Metadata Type | Hive,HiveTag2,HiveTag3,Hive_BA          | sample_08               | HiveTag2 |


  @sanity @positive @regression
  Scenario:SC#29_Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | SingleItemDelete | Default | Cluster Demo                           | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger% | Analysis |       |       |


  Scenario Outline:MLP-24873:SC30#Run the Plugin configurations for HiveDataSource and HiveCataloger with Resolve Cluster name true.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                                     | response code | response message                       | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveDataSource                                                | ida/hivePayloads/DataSource/hiveValidDataSourceResolveClusterNameTrueConfig.json         | 204           |                                        |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HiveDataSource                                                |                                                                                          | 200           | HiveDataSource_ValidResolveClusterTrue |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                 | ida/hivePayloads/PluginConfiguration/HiveConfigSingleDBFilterResolveClusterNameTrue.json | 204           |                                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                 |                                                                                          | 200           | HiveCataloger                          |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                                          | 200           | IDLE                                   | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  | ida/hivePayloads/PluginConfiguration/empty.json                                          | 200           |                                        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                                          | 200           | IDLE                                   | $.[?(@.configurationName=='HiveCataloger')].status |


  #7142574
  @webtest @MLP-1960 @sanity @positive @regression
  Scenario:SC30#:Check the cluster name shows 'Sandbox' in UI
    Then User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | Sandbox |
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | hivesample |
      | testtable1 |
      | zone_east  |
      | zone_west  |

  @sanity @positive @regression
  Scenario:Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | SingleItemDelete | Default | Sandbox                                | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger% | Analysis |       |       |

  @MLP-5149 @positve @hive @regression @sanity
  Scenario Outline:MLP-5149:SC31#Run the Plugin configurations for HiveDataSource and HiveCataloger with Table having partition
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                             | response code | response message     | jsonPath                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HiveDataSource                                                | ida/hivePayloads/DataSource/hiveValidDataSourceConfig.json                       | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HiveDataSource                                                |                                                                                  | 200           | HiveDataSource_Valid |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                 | ida/hivePayloads/PluginConfiguration/HiveConfigSingleDBPartitionTableFilter.json | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                 |                                                                                  | 200           | HiveCataloger        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                                  | 200           | IDLE                 | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  | ida/hivePayloads/PluginConfiguration/empty.json                                  | 200           |                      |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                                  | 200           | IDLE                 | $.[?(@.configurationName=='HiveCataloger')].status |


#####################################################################################################################################################################
############## Scenario 1: Verify partition is stored as a separate item by HiveCataloger when the table collected has partition
##############################################################################################################################################################

  #7142575
  @MLP-5149 @webtest @positve @hive @regression @sanity
  Scenario: SC#31 Verify whether the Tables and columns  parsed in the IDC UI for partitioned table
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Partition" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "state" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                                                | widgetName  |
      | Location          | hdfs://sandbox.hortonworks.com:8020/apps/hive/warehouse/testhivepartition.db/partition_table | Description |
      | parentPath        | testhivepartition/partition_table                                                            | Description |



#####################################################################################################################################################################
############## Scenario 2: Verify partition is not stored as a separate item by HiveCataloger when the table collected does not have partition
##############################################################################################################################################################

  #7142576
  @MLP-5149 @webtest @positve @hive @regression @sanity
  Scenario: SC#32 Verify whether the Tables and columns  parsed in the IDC UI for non-partitioned table
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "non_partition_table [Table]" attribute under "Hierarchy" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Partition |


  @sanity @positive @regression
  Scenario:SC#32_Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | SingleItemDelete | Default | Cluster Demo                           | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger% | Analysis |       |       |


  Scenario Outline:MLP-24873:SC34#Run the Plugin configurations for HiveCataloger with DB filter having * at the begining.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                             | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                 | ida/hivePayloads/PluginConfiguration/HiveConfigSingleDBFilterAsterikAtBegin.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                 |                                                                                  | 200           | HiveCataloger    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  | ida/hivePayloads/PluginConfiguration/empty.json                                  | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |

#7143804
  @webtest @jdbc @MLP-24873
  Scenario:SC#34: Verify HiveCataloger scans and collects data if DB is given with * at the begining.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | hivesample    |
      | hivebdasample |
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | testtable1 |
      | bdatable   |

  @sanity @positive @regression
  Scenario:SC#34_Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | SingleItemDelete | Default | Cluster Demo                           | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger% | Analysis |       |       |


  Scenario Outline:MLP-24873:SC35#Run the Plugin configurations for HiveCataloger with DB filter having * at the begining and end.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                                | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                 | ida/hivePayloads/PluginConfiguration/HiveConfigSingleDBFilterAsterikAtBeginEnd.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                 |                                                                                     | 200           | HiveCataloger    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  | ida/hivePayloads/PluginConfiguration/empty.json                                     | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |

#7143806
  @webtest @jdbc @MLP-24873
  Scenario:SC#35: Verify HiveCataloger scans and collects data if DB is given with * at the begining and end.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | hivebdasample |
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | bdatable |


  @sanity @positive @regression
  Scenario:SC#35_Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | SingleItemDelete | Default | Cluster Demo                           | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger% | Analysis |       |       |


  Scenario Outline:MLP-24873:SC36#Run the Plugin configurations for HiveCataloger with DB filter
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                      | response code | response message     | jsonPath                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/HiveDataSource                                                | ida/hivePayloads/DataSource/hiveValidDataSourceConfig.json                | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HiveDataSource                                                |                                                                           | 200           | HiveDataSource_Valid |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                 | ida/hivePayloads/PluginConfiguration/HiveConfigSingleDBDefaultFilter.json | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                 |                                                                           | 200           | HiveCataloger        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                           | 200           | IDLE                 | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  | ida/hivePayloads/PluginConfiguration/empty.json                           | 200           |                      |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                           | 200           | IDLE                 | $.[?(@.configurationName=='HiveCataloger')].status |

#5122903
  @webtest @jdbc @MLP-24873
  Scenario:SC#36: Verify Hive Catalog functionality by adding new table to database(Before adding table)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | default |
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | sample_07 |
      | sample_08 |


  Scenario:SC36#MLP-24873 Verify whether the Hive database and tables are created in Hive.
    Given user executes the following Query in the Hive JDBC
      | queryEntry           |
      | AddNewTableDefaultDB |

  Scenario Outline:MLP-24873:SC36#Run the Plugin configurations for HiveCataloger with DB filter (to check new table added to it)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                                      | response code | response message | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                 | ida/hivePayloads/PluginConfiguration/HiveConfigSingleDBDefaultFilter.json | 204           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                 |                                                                           | 200           | HiveCataloger    |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  | ida/hivePayloads/PluginConfiguration/empty.json                           | 200           |                  |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |


    #5122903
  @webtest @jdbc @MLP-24873
  Scenario:SC#36: Verify Hive Catalog functionality by adding new table to database(After adding table)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | default |
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "HiveTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | sample_07   |
      | sample_08   |
      | addnewtable |


  @sanity @positive @regression
  Scenario:SC#36_Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | SingleItemDelete | Default | Cluster Demo                           | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger% | Analysis |       |       |


#########Scenario8 - Cluster name=Cluster Demo ,Cloudera cluster and cluster name resolution setting disable#####


  Scenario Outline:MLP-24873:SC37#Run the Plugin configurations for HiveDataSource and HiveCataloger with Resolve Cluster name true.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | body                                                               | response code | response message     | jsonPath                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveDataSource                                                | ida/hivePayloads/DataSource/hiveValidDataSourceCloudEraConfig.json | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/HiveDataSource                                                |                                                                    | 200           | HiveDataSource_Valid |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                 | ida/hivePayloads/PluginConfiguration/HiveConfigSingleDBFilter.json | 204           |                      |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/HiveCataloger                                                 |                                                                    | 200           | HiveCataloger        |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                    | 200           | IDLE                 | $.[?(@.configurationName=='HiveCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  | ida/hivePayloads/PluginConfiguration/empty.json                    | 200           |                      |                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                    | 200           | IDLE                 | $.[?(@.configurationName=='HiveCataloger')].status |


  #7142574
  @webtest @MLP-1960 @sanity @positive @regression
  Scenario:SC37#:Check the cluster name shows 'Cluster Demo' in UI and DB items collected.
    Then User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "HiveTag1" and clicks on search
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | Cluster Demo |
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | hivesample |
      | testtable1 |
      | zone_east  |
      | zone_west  |

  @sanity @positive @regression
  Scenario:SC#37_Delete Cluster , Cataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | SingleItemDelete | Default | Cluster Demo                           | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/HiveCataloger/HiveCataloger% | Analysis |       |       |


#####################################################################################################################################################################
############## Deleting the created database/table in hive view
##############################################################################################################################################################

#  @MLP-5149 @sanity @positive
  Scenario: Deleting the created database/table in hive view
    And user executes the following Query in the Hive JDBC
      | queryEntry                |
      | DropHivePartitionTable    |
      | DropHiveNonPartitionTable |
      | DropHivePartitionDatabase |
      | DropBDATable2             |
      | DropHiveBDADB             |
      | DropTable_testtable1      |
      | DropDatabase              |
      | DropHiveDatabase2         |
      | DropNewTableDefaultDB     |


  Scenario Outline:Delete Plugin Configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                        | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/hiveValidCredential   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/hiveInValidCredential |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/hiveEmptyCredential   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveDataSource          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/HiveCataloger           |      | 204           |                  |          |




