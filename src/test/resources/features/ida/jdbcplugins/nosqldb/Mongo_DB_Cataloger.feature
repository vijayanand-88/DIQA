@MLP-7660 @MLP-24196
Feature:JDBC Cataloger and Analyzer Support for MongoDB
  Description : To enable JDBC Cataloger and Analyzer support for the MongoDB.

  ##############################Set data###############################

  @sanity @positive @MLP-7660 @webtest @IDA-10.0
  Scenario: SC1#MLP_7660_Insert data into the table "Table1" and "Table2" in database "SampleDB"
    Given user connect to the Mongo DB database and execute query for the below parameters
      | dataBaseName | operation | mongoDBName | queryPath     | columnCount | queryPage    | tableName | column1         | column2  | column3  |
      | MONGO        | INSERT    | SampleDB    | json/IDA.json | 3           | mongoQueries | Table1    | collectionName  | emailId  | phoneNo  |
      | MONGO        | INSERT    | SampleDB    | json/IDA.json | 3           | mongoQueries | Table2    | collectionName1 | emailId1 | phoneNo1 |


  ############## setting the Credentials, BA , Data Source and Cataloger###################

  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0
  Scenario Outline: SC2#-MLP_7660_Set the Credentials, Datasource, Bussiness Application and Cataloger for MONGODB Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | body                                                                    | response code | response message              | jsonPath                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/MongoDBValidCredential                                                    | ida/mongoDBPayloads/Credentials/mongodbValidCredentials.json            | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/MongoDBInValidCredential                                                  | ida/mongoDBPayloads/Credentials/mongodbInValidCredentials.json          | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/MongoDBEmptyCredential                                                    | ida/mongoDBPayloads/Credentials/mongodbEmptyCredentials.json            | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/MongoDBValidCredential                                                    |                                                                         | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/MongoDBInValidCredential                                                  |                                                                         | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/MongoDBEmptyCredential                                                    |                                                                         | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | items/Default/root                                                                             | ida\mongoDBPayloads\API\Bussiness_Application\BussinessApplication.json | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/MongoDBDataSource                                                           | ida/mongoDBPayloads/DataSource/mongodbValidDataSourceConfig.json        | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/MongoDBDataSource                                                           |                                                                         | 200           | MongoDBDataSource_valid       |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/MongoDBCataloger                                                            | ida/mongoDBPayloads/MongoDBCataloger/mongoDBValidConfig.json            | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/MongoDBCataloger                                                            |                                                                         | 200           | MongoDBCataloger_ValidDB&Cred |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/MongoDBCataloger/MongoDBCataloger_ValidDB&Cred |                                                                         | 200           | IDLE                          | $.[?(@.configurationName=='MongoDBCataloger_ValidDB&Cred')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/MongoDBCataloger/MongoDBCataloger_ValidDB&Cred  |                                                                         | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/MongoDBCataloger/MongoDBCataloger_ValidDB&Cred |                                                                         | 200           | IDLE                          | $.[?(@.configurationName=='MongoDBCataloger_ValidDB&Cred')].status |

    #####################################processedCount scenario#################################

  Scenario: ProcessedCount Verification for MondoDB cataloger with no filters
    Given Load the count of the type values to a Map
      | analysis                                                 | type       | DBName | queryName | queryPage | actualcount |
      | cataloger/MongoDBCataloger/MongoDBCataloger_ValidDB&Cred | Analysis   |        |           |           | 1           |
      | cataloger/MongoDBCataloger/MongoDBCataloger_ValidDB&Cred | Cluster    |        |           |           | 1           |
      | cataloger/MongoDBCataloger/MongoDBCataloger_ValidDB&Cred | Host       |        |           |           | 1           |
      | cataloger/MongoDBCataloger/MongoDBCataloger_ValidDB&Cred | Service    |        |           |           | 1           |
      | cataloger/MongoDBCataloger/MongoDBCataloger_ValidDB&Cred | Database   |        |           |           | 1           |
      | cataloger/MongoDBCataloger/MongoDBCataloger_ValidDB&Cred | Table      |        |           |           | 21          |
      | cataloger/MongoDBCataloger/MongoDBCataloger_ValidDB&Cred | Column     |        |           |           | 159         |
      | cataloger/MongoDBCataloger/MongoDBCataloger_ValidDB&Cred | Constraint |        |           |           | 21          |
    Given Verify the Processed Count with the API call
      | Action                    | type       | node      | configName                    | analysisItemName                                         |
      | ItemViewMap               | Analysis   |           |                               | cataloger/MongoDBCataloger/MongoDBCataloger_ValidDB&Cred |
      | ItemViewMap               | Cluster    |           |                               |                                                          |
      | ItemViewMap               | Host       |           |                               |                                                          |
      | ItemViewMap               | Service    |           |                               |                                                          |
      | ItemViewMap               | Database   |           |                               |                                                          |
      | ItemViewMap               | Table      |           |                               |                                                          |
      | ItemViewMap               | Column     |           |                               |                                                          |
      | ItemViewMap               | Constraint |           |                               |                                                          |
      | VerifyCountInItemView     |            |           |                               |                                                          |
      | VerifyCountInPluginConfig |            | LocalNode | MongoDBCataloger_ValidDB&Cred |                                                          |


    ##################################################Common cases############################################

       #7129878
  @webtest @MLP-24196 @sanity @MLPQA-5754
  Scenario:CommonCase:MLP_24889_Verify the Processed Items widget presence and Logging Enhancement validation
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "MongoDBCatalog" and clicks on search
    And user performs "facet selection" in "MongoDBCatalog" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/MongoDBCataloger/MongoDBCataloger_ValidDB&Cred/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 206           |
      | Number of errors          | 0             |
    And user "widget presence" on "Processed Items" in Item view page
    Then Analysis log "cataloger/MongoDBCataloger/MongoDBCataloger_ValidDB&Cred/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | logCode       | pluginName       | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0019 |                  |                |
      | INFO | ANALYSIS-0071: Plugin Name:MongoDBCataloger, Plugin Type:cataloger, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:161395ff0625, Plugin Configuration name:MongoDBCataloger_ValidDB&Cred                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ANALYSIS-0071 | MongoDBCataloger | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin MongoDBCataloger Configuration: ---  2021-04-09 16:54:44.599 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: name: "MongoDBCataloger_ValidDB&Cred"  2021-04-09 16:54:44.599 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: pluginVersion: "LATEST"  2021-04-09 16:54:44.600 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: label:  2021-04-09 16:54:44.600 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: : ""  2021-04-09 16:54:44.600 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: auditFields:  2021-04-09 16:54:44.600 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: createdBy: "TestSystem"  2021-04-09 16:54:44.600 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: createdAt: "2021-04-09T16:54:28.775"  2021-04-09 16:54:44.613 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: modifiedBy: "TestSystem"  2021-04-09 16:54:44.613 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: modifiedAt: "2021-04-09T16:54:28.775"  2021-04-09 16:54:44.613 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: catalogName: "Default"  2021-04-09 16:54:44.613 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: eventClass: null  2021-04-09 16:54:44.613 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: eventCondition: null  2021-04-09 16:54:44.613 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: nodeCondition: "name==\"LocalNode\""  2021-04-09 16:54:44.613 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: maxWorkSize: 100  2021-04-09 16:54:44.613 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: tags:  2021-04-09 16:54:44.613 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: - "MongoDBCatalog"  2021-04-09 16:54:44.613 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: pluginType: "cataloger"  2021-04-09 16:54:44.613 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: dataSource: "MongoDBDataSource_valid"  2021-04-09 16:54:44.613 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: credential: "MongoDBValidCredential"  2021-04-09 16:54:44.613 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: businessApplicationName: "MONGODB_BA"  2021-04-09 16:54:44.613 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: schedule: null  2021-04-09 16:54:44.613 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: filter: null  2021-04-09 16:54:44.613 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: tables: []  2021-04-09 16:54:44.613 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: dryRun: false  2021-04-09 16:54:44.613 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: pluginName: "MongoDBCataloger"  2021-04-09 16:54:44.613 INFO  - ANALYSIS-0073: Plugin MongoDBCataloger Configuration: type: "Cataloger" | ANALYSIS-0073 | MongoDBCataloger |                |
      | INFO | Plugin MongoDBCataloger Start Time:2020-05-26 12:14:42.010, End Time:2020-05-26 12:16:02.187, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | ANALYSIS-0072 | MongoDBCataloger |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:03.914)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0020 |                  |                |

    #7129878
  @positve @regression @sanity @webtest  @MLP-24196 @IDA-1.1.0 @MLPQA-5754
  Scenario:SC2_CommonCase#MLP_24196_Verify the Technology tag appears properly for items collected by DynamoDBCataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "MongoDB" and clicks on search
    And user performs "facet selection" in "MongoDB" attribute under "Tags" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet | Tag                               | fileName                       | userTag                        |
      | Default     | Column     | Type  | MongoDB,MongoDBCatalog,MONGODB_BA | OrderDate                      | OrderDate                      |
      | Default     | Table      | Type  | MongoDB,MongoDBCatalog,MONGODB_BA | orders                         | orders                         |
      | Default     | Cluster    | Type  | MongoDB,MongoDBCatalog,MONGODB_BA | 10.33.6.130                    | 10.33.6.130                    |
      | Default     | Service    | Type  | MongoDB,MongoDBCatalog,MONGODB_BA | MONGODB                        | MONGODB                        |
      | Default     | Database   | Type  | MongoDB,MongoDBCatalog,MONGODB_BA | SampleDB                       | SampleDB                       |
      | Default     | Constraint | Type  | MongoDB,MongoDBCatalog,MONGODB_BA | EMPLOYEETERRITORIES_PRIMARYKEY | EMPLOYEETERRITORIES_PRIMARYKEY |


    ########################################## Tool Tip validation #################################################

#7130029
  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0 @MLPQA-5746
  Scenario Outline: SC2#Get the Mongo Cataloger and DataSource Configuration response
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                               | body                                | response code | response message | filePath                              | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | /schemes/analyzers/configurations | response/mongo/body/ToolTip.json    | 200           |                  | response/mongo/actual/ToolTip.json    |          |
      | IDC         | TestSystem | application/json |       |       | Post | /schemes/analyzers/configurations | response/mongo/body/ToolTip_DS.json | 200           |                  | response/mongo/actual/ToolTip_DS.json |          |

    #7130029
  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0 @MLPQA-5746
  Scenario Outline:SC2# Validate ToolTip for all the fields in Mongo Db Cataloger plugin(Type,Plugin,Name,Plugin version,label,BA, Data Source, Credential,Event Condition,Dry Run, Event class,Max Work sixe,node condition,Auto Start,tags,Unique Filter)
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                       | actualValues                       | valueType     | expectedJsonPath                                        | actualJsonPath                                                                       |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip.json | stringCompare | $.Commonfields..[?(@.label=='Type')].tooltip            | $..[?(@.label=='Type')].tooltip                                                      |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip.json | stringCompare | $.Commonfields..[?(@.label=='Plugin')].tooltip          | $..[?(@.label=='Plugin')].tooltip                                                    |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip.json | stringCompare | $.Commonfields.Name.tooltip                             | $.properties[0].value.prototype.properties[2].tooltip                                |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip.json | stringCompare | $.Commonfields.pluginVersion.tooltip                    | $.properties[0].value.prototype.properties[3].tooltip                                |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip.json | stringCompare | $.Commonfields.label.tooltip                            | $.properties[0].value.prototype.properties[4].tooltip                                |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip.json | stringCompare | $.Commonfields.businessApplicationName.tooltip          | $.properties[0].value.prototype.properties[17].tooltip                               |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip.json | stringCompare | $.Commonfields.dataSource.tooltip                       | $.properties[0].value.prototype.properties[14].tooltip                               |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip.json | stringCompare | $.Commonfields.credential.tooltip                       | $.properties[0].value.prototype.properties[16].tooltip                               |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip.json | stringCompare | $.Commonfields.eventCondition.tooltip                   | $.properties[0].value.prototype.properties[5].tooltip                                |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip.json | stringCompare | $.Commonfields.dryRun.tooltip                           | $.properties[0].value.prototype.properties[6].tooltip                                |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip.json | stringCompare | $.Commonfields.eventClass.tooltip                       | $.properties[0].value.prototype.properties[7].tooltip                                |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip.json | stringCompare | $.Commonfields.maxWorkSize.tooltip                      | $.properties[0].value.prototype.properties[8].tooltip                                |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip.json | stringCompare | $.Commonfields.nodeCondition.tooltip                    | $.properties[0].value.prototype.properties[10].tooltip                               |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip.json | stringCompare | $.Commonfields.autoStart.tooltip                        | $.properties[0].value.prototype.properties[11].tooltip                               |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip.json | stringCompare | $.Commonfields.tags.tooltip                             | $.properties[0].value.prototype.properties[12].tooltip                               |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip.json | stringCompare | $.Uniquefilter.MongoDB.MongoDBCollectionFilters.tooltip | $.properties[0].value.prototype.properties[18].tooltip                               |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip.json | stringCompare | $.Uniquefilter.MongoDB.Collection.tooltip               | $.properties[0].value.prototype.properties[18].value.prototype.properties[0].tooltip |

    #7130029
  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0 @MLPQA-5746
  Scenario Outline:SC2# Validate ToolTip for all the fields in Mongo Db Datasource plugin(mongoDataSourceType,Name,PluginVersion,label,Credential,Host,Port,databasename)
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                       | actualValues                          | valueType     | expectedJsonPath                           | actualJsonPath                                         |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip_DS.json | stringCompare | $.Commonfields.mongoDataSourceType.tooltip | $.properties[0].value.prototype.properties[0].tooltip  |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip_DS.json | stringCompare | $.Commonfields.Name.tooltip                | $.properties[0].value.prototype.properties[1].tooltip  |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip_DS.json | stringCompare | $.Commonfields.pluginVersion.tooltip       | $.properties[0].value.prototype.properties[2].tooltip  |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip_DS.json | stringCompare | $.Commonfields.label.tooltip               | $.properties[0].value.prototype.properties[3].tooltip  |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip_DS.json | stringCompare | $.Commonfields.credential.tooltip          | $.properties[0].value.prototype.properties[13].tooltip |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip_DS.json | stringCompare | $.Commonfields.mongohost.tooltip           | $.properties[0].value.prototype.properties[15].tooltip |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip_DS.json | stringCompare | $.Commonfields.mongoPort.tooltip           | $.properties[0].value.prototype.properties[16].tooltip |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip_DS.json | stringCompare | $.Commonfields.mongoDatabaseName.tooltip   | $.properties[0].value.prototype.properties[17].tooltip |
      | response/mongo/expected/ToolTip.json | response/mongo/actual/ToolTip_DS.json | stringCompare | $.Commonfields.credential.tooltip          | $.properties[0].value.prototype.properties[13].tooltip |

    ######################################Cataloger mandatory field error validation#####################################

    #7130027
  @MLP-24196 @webtest @regression @positive @MLPQA-5747
  Scenario:SC3#MLP_24196_Verify proper error message is thrown in UI if Sample Name field values are not provided within valid range in MongoDBCataloger
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
      | fieldName | attribute        |
      | Type      | Cataloger        |
      | Plugin    | MongoDBCataloger |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue        |
      | Name                  | MongoDBCataloger_ValidDB&Cred |
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

    ######################################Data Source mandatory field error validation#####################################

       #7130027
  @MLP-24196 @webtest @regression @positive @MLPQA-5747
  Scenario:SC3#MLP_24196_Verify proper error message is thrown in UI if Sample Name field values are not provided within valid range in MongoDB data source
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | MongoDBDataSource      |
      | Credential       | MongoDBValidCredential |
      | Node             | LocalNode              |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Name                  |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue  |
      | Name                  | MongoDBDataSource_valid |
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
      | Host                  |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Host      | Host field should not be empty |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Database Name         |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName     | errorMessage                            |
      | Database Name | Database Name field should not be empty |

    ######################################Data Source connection valid credentials#####################################
  #7130017
  @MLP-24196 @webtest @regression @positive @MLPQA-5750
  Scenario:SC#3:MLP-24196 : Verification of TestConnection for is success for MongoDb DataSource with valid credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | MongoDBDataSource      |
      | Credential       | MongoDBValidCredential |
      | Node             | LocalNode              |
    And user "enter text" in Add Data Source Page
      | fieldName     | attribute       |
      | Name          | MongoDataSource |
      | Label         | MongoDataSource |
      | Host          | 10.33.6.130     |
      | Port          | 27017           |
      | Database Name | SampleDB        |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"

  ######################################Data Source connection invalid credentials#####################################
#7130020
  @MLP-24196 @webtest @regression @positive @MLPQA-5749
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for MongoDb DataSource with invalid credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute                |
      | Data Source Type | MongoDBDataSource        |
      | Credential       | MongoDBInValidCredential |
      | Node             | LocalNode                |
    And user "enter text" in Add Data Source Page
      | fieldName     | attribute       |
      | Name          | MongoDataSource |
      | Label         | MongoDataSource |
      | Host          | 10.33.6.130     |
      | Port          | 27017           |
      | Database Name | SampleDB        |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"


     ######################################Data Source connection empty credentials#####################################
#7130020
  @MLP-24196 @webtest @regression @positive @MLPQA-5749
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for MongoDb DataSource with empty credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | MongoDBDataSource      |
      | Credential       | MongoDBEmptyCredential |
      | Node             | LocalNode              |
    And user "enter text" in Add Data Source Page
      | fieldName     | attribute       |
      | Name          | MongoDataSource |
      | Label         | MongoDataSource |
      | Host          | 10.33.6.130     |
      | Port          | 27017           |
      | Database Name | SampleDB        |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

       ######################################Data Source connection invalid host, port and database name#####################################
#7130024
  @MLP-24196 @webtest @regression @positive @MLPQA-5748
  Scenario:SC#3:MLP-24196 : Verification of TestConnection is not success for MongoDb DataSource with invalid data
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute              |
      | Data Source Type | MongoDBDataSource      |
      | Credential       | MongoDBEmptyCredential |
      | Node             | LocalNode              |
    And user "enter text" in Add Data Source Page
      | fieldName     | attribute       |
      | Name          | MongoDataSource |
      | Label         | MongoDataSource |
      | Host          | 10.33.6.142     |
      | Port          | 27017           |
      | Database Name | SampleDB        |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user "enter text" in Add Data Source Page
      | fieldName     | attribute   |
      | Port          | 270         |
      | Database Name | SampleDB    |
      | Host          | 10.33.6.130 |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"

#######################################Mongo Db Cataloger with valid credentials########################################
#7130031
  @sanity @positive @MLP-24196 @webtest @IDA-10.3
  Scenario:SC#03:MLP-24196 : _Verify whether the background in the Cataloger panel is green when connection is successful due to valid Credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute        |
      | Type      | Cataloger        |
      | Plugin    | MongoDBCataloger |
    And user clicks on Add button near to field "MongoDB Collection Filters"
    And user "enter text" in Add Data Source Page
      | fieldName  | attribute        |
      | Collection | Table1           |
      | Name       | MongoDBCataloger |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute               |
      | Credential  | MongoDBValidCredential  |
      | Data Source | MongoDBDataSource_valid |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"



#######################################Mongo Db Cataloger with Invalid credentials########################################
#7130017
  @sanity @positive @MLP-24196 @webtest @IDA-10.3 @MLPQA-5750
  Scenario:SC#03:MLP-24196 : _Verify whether the background in the Cataloger panel is red when connection is unsuccessful due to Invalid Credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute        |
      | Type      | Cataloger        |
      | Plugin    | MongoDBCataloger |
    And user clicks on Add button near to field "MongoDB Collection Filters"
    And user "enter text" in Add Data Source Page
      | fieldName  | attribute        |
      | Collection | Table1           |
      | Name       | MongoDBCataloger |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute                |
      | Data Source | MongoDBDataSource_valid  |
      | Credential  | MongoDBInValidCredential |
    And user "click" on "Add" button in "Add Data Sources Page"
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"


    #######################################Mongo Db Cataloger with empty credentials########################################
#7130020
  @sanity @positive @MLP-24196 @webtest @IDA-10.3 @MLPQA-5749
  Scenario:SC#03:MLP-24196 : _Verify whether the background in the Cataloger panel is red when connection is unsuccessful due to empty Credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute        |
      | Type      | Cataloger        |
      | Plugin    | MongoDBCataloger |
    And user clicks on Add button near to field "MongoDB Collection Filters"
    And user "enter text" in Add Data Source Page
      | fieldName  | attribute        |
      | Collection | Table1           |
      | Name       | MongoDBCataloger |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute               |
      | Data Source | MongoDBDataSource_valid |
      | Credential  | MongoDBEmptyCredential  |
    And user "click" on "Add" button in "Add Data Sources Page"
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"



    ###############################Cluster , Metadata , Host , Column , Table Metadata validation and Bread crumbs validation######################################

  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0 @MLPQA-12790
  Scenario Outline: SC4#user retrieves ID with catalog name and type
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type       | name              | asg_scopeid | targetFile                         | jsonpath             |
      | APPDBPOSTGRES | ID      | Default | Table      | Table1            |             | response/mongo/actual/itemIds.json | $..has_Table.id      |
      | APPDBPOSTGRES | ID      | Default | Column     | emailId           |             | response/mongo/actual/itemIds.json | $..has_Column.id     |
      | APPDBPOSTGRES | ID      | Default | Constraint | TABLE1_PRIMARYKEY |             | response/mongo/actual/itemIds.json | $..has_Constraint.id |
      | APPDBPOSTGRES | ID      | Default | Service    | MONGODB           |             | response/mongo/actual/itemIds.json | $..has_Service.id    |
      | APPDBPOSTGRES | ID      | Default | Database   | SampleDB          |             | response/mongo/actual/itemIds.json | $..has_Database.id   |
      | APPDBPOSTGRES | ID      | Default | Host       | 10.33.6.130       |             | response/mongo/actual/itemIds.json | $..has_Host.id       |
      | APPDBPOSTGRES | ID      | Default | Cluster    | 10.33.6.130       |             | response/mongo/actual/itemIds.json | $..Cluster.id        |

  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0 @MLPQA-12790
  Scenario Outline: SC4#user retrieves the metadata of each datat type for a catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                  | responseCode | inputJson            | inputFile                          | outPutFile                                    | outPutJson |
      | components/Default/item/Default.Host:::dynamic       | 200          | $..has_Host.id       | response/mongo/actual/itemIds.json | response/mongo/actual/hostMetadata.json       |            |
      | components/Default/item/Default.Column:::dynamic     | 200          | $..has_Column.id     | response/mongo/actual/itemIds.json | response/mongo/actual/columnMetadata.json     |            |
      | components/Default/item/Default.Cluster:::dynamic    | 200          | $..Cluster.id        | response/mongo/actual/itemIds.json | response/mongo/actual/clusterMetadata.json    |            |
      | components/Default/item/Default.Service:::dynamic    | 200          | $..has_Service.id    | response/mongo/actual/itemIds.json | response/mongo/actual/serviceMetadata.json    |            |
      | components/Default/item/Default.Database:::dynamic   | 200          | $..has_Database.id   | response/mongo/actual/itemIds.json | response/mongo/actual/databaseMetadata.json   |            |
      | components/Default/item/Default.Table:::dynamic      | 200          | $..has_Table.id      | response/mongo/actual/itemIds.json | response/mongo/actual/tableMetadata.json      |            |
      | components/Default/item/Default.Constraint:::dynamic | 200          | $..has_Constraint.id | response/mongo/actual/itemIds.json | response/mongo/actual/constraintMetadata.json |            |

  @positve @regression @sanity  @MLP-7660 @IDA-1.1. @MLPQA-12790
  Scenario Outline: SC4#validate the total count and facets count for a catalog
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                           | response code | response message | filePath                                  | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | response/mongo/body/getFacetsCountRequest.json | 200           |                  | response/mongo/actual/facetWiseCount.json |          |

  @positve @regression @sanity  @MLP-7660 @IDA-1.1. @MLPQA-12790
  Scenario Outline:SC4# Validate Cluster,Host,Service,Database,Table,BreadCrumb and Constraint should have the appropriate metadata information in IDC UI
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                     | actualValues                                  | valueType         | expectedJsonPath                                                | actualJsonPath                                                            |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/facetWiseCount.json     | intCompare        | $..totalCount                                                   | $..count                                                                  |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/facetWiseCount.json     | intListCompare    | $..MetaData.facetCounts.type_s..count                           | $.facetCounts..type_s..count                                              |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/hostMetadata.json       | stringListCompare | $..hostMetaData..taglist..techTag                               | $..[?(@.type=='taglist')].data..name                                      |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/hostMetadata.json       | stringCompare     | $..hostMetaData..HostName                                       | $..[?(@.caption=='Host name')].data..value                                |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/hostMetadata.json       | intCompare        | $..hostMetaData..NumberofCores                                  | $..[?(@.caption=='Number of cores')].data..value                          |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/clusterMetadata.json    | stringListCompare | $..clusterMetaData..taglist..techTag                            | $..[?(@.type=='taglist')].data..name                                      |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/clusterMetadata.json    | stringListCompare | $..clusterMetaData..table..values.[?(@.type=='Hosts')].name     | $..[?(@.caption=='Hosts')].data..name                                     |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/clusterMetadata.json    | stringListCompare | $..clusterMetaData..table..values.[?(@.type=='Services')].name  | $..[?(@.caption=='Services')].data..name                                  |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/serviceMetadata.json    | stringListCompare | $..serviceMetaData..taglist..techTag                            | $..[?(@.type=='taglist')].data..name                                      |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/serviceMetadata.json    | stringListCompare | $..serviceMetaData..table..values.[?(@.type=='Databases')].name | $..[?(@.caption=='Databases')].data..name                                 |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/serviceMetadata.json    | stringCompare     | $..serviceMetaData.applicationVersion                           | $..[?(@.caption=='Application Version')].data..value                      |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/databaseMetadata.json   | stringListCompare | $..databaseMetaData..taglist..techTag                           | $..[?(@.type=='taglist')].data..name                                      |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/databaseMetadata.json   | stringCompare     | $..storageType                                                  | $..[?(@.caption=='Storage type')]..value                                  |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/databaseMetadata.json   | stringListCompare | $..databaseMetaData.table.values..name                          | $..[?(@.caption=='Tables')].data..name                                    |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/tableMetadata.json      | stringListCompare | $..tableMetaData..taglist..techTag                              | $..[?(@.type=='taglist')].data..name                                      |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/tableMetadata.json      | stringCompare     | $..tableMetaData.tableType                                      | $..[?(@.caption=='Description')]..[?(@.caption=='Table Type')].data.value |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/constraintMetadata.json | stringListCompare | $..constraintMetaData..taglist..techTag                         | $..[?(@.type=='taglist')].data..name                                      |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/constraintMetadata.json | stringCompare     | $..constraintMetaData.constraintType                            | $..[?(@.caption=='Constraint Type')].data.value                           |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/constraintMetadata.json | stringCompare     | $..constraintMetaData.table.values..name                        | $..[?(@.caption=='columns')].data..name                                   |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/facetWiseCount.json     | intCompare        | $.MetaData..type_s..[?(@.value=='Column')].count                | $.facetCounts..type_s..[?(@.value=='Column')].count                       |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/facetWiseCount.json     | intCompare        | $.MetaData..type_s..[?(@.value=='Constraint')].count            | $.facetCounts..type_s..[?(@.value=='Constraint')].count                   |
#      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/facetWiseCount.json     | intCompare        | $.MetaData..type_s..[?(@.value=='Table')].count                 | $.facetCounts..type_s..[?(@.value=='Table')].count                        |
      | response/mongo/expected/mongoExpectedJsonData.json | response/mongo/actual/columnMetadata.json     | stringCompare     | $..columnMetaData.breadCrumbs.values..name                      | $.caption.breadCrumbs..name                                               |

    #7201772
  @positve @regression @sanity @webtest  @MLP-21662 @IDA-1.1.0 @MLPQA-4164
  Scenario:SC4#MLP-21662_Verify data type for both simple and completex columns
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "allDataTypes" and clicks on search
    And user performs "facet selection" in "MongoDBCatalog" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "allDataTypes" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | _id   | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | UUID          | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value  | Action               | RetainPrevwindow | indexSwitch |
      | Columns | itemID | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | FLOAT         | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | item  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | VARCHAR       | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | qty   | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | FLOAT         | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch |
      | Columns | wastedQty | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | DECIMAL       | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Columns | expression | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | VARCHAR       | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | tags  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | ARRAY         | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch |
      | Columns | productID | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | BIGINT        | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch |
      | Columns | QADetails | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | OBJECT        | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | dues  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | NULL          | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value          | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Binarydatatype | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | VARBINARY     | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value    | Action               | RetainPrevwindow | indexSwitch |
      | Columns | itemDate | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | TIMESTAMP     | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | price | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | DECIMAL       | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value   | Action               | RetainPrevwindow | indexSwitch |
      | Columns | forsale | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | BOOLEAN       | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Columns | samplevalue | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | OBJECT        | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Code  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | JSCODE        | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value           | Action               | RetainPrevwindow | indexSwitch |
      | Columns | jscodewithscope | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | OBJECT        | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value  | Action               | RetainPrevwindow | indexSwitch |
      | Columns | symbol | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | VARCHAR       | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | stamp | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | TIMESTAMP     | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Columns | normalDate | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | VARCHAR       | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value   | Action               | RetainPrevwindow | indexSwitch |
      | Columns | newDate | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | TIMESTAMP     | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value   | Action               | RetainPrevwindow | indexSwitch |
      | Columns | isoDate | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | TIMESTAMP     | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | size  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | OBJECT        | Description |


  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0
  Scenario:SC4:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                       | type     | query | param |
      | SingleItemDelete | Default | cataloger/MongoDBCataloger/MongoDBCataloger_ValidDB&Cred/% | Analysis |       |       |
      | SingleItemDelete | Default | 10.33.6.130                                                | Cluster  |       |       |

#######################################Non-Exsit Tables#####################################################

  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0 @MLPQA-12775
  Scenario Outline: SC5#-MLP_7660_Run mongo caltaloger with non existing tables
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                | body                                                             | response code | response message                  | jsonPath                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/MongoDBDataSource                                                               | ida/mongoDBPayloads/DataSource/mongodbValidDataSourceConfig.json | 204           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/MongoDBDataSource                                                               |                                                                  | 200           | MongoDBDataSource_valid           |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/MongoDBCataloger                                                                | ida/mongoDBPayloads/MongoDBCataloger/mongoDBNonExistConfig.json  | 204           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/MongoDBCataloger                                                                |                                                                  | 200           | MongoDBCataloger_nonExistingtable |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/MongoDBCataloger/MongoDBCataloger_nonExistingtable |                                                                  | 200           | IDLE                              | $.[?(@.configurationName=='MongoDBCataloger_nonExistingtable')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/MongoDBCataloger/MongoDBCataloger_nonExistingtable  |                                                                  | 200           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/MongoDBCataloger/MongoDBCataloger_nonExistingtable |                                                                  | 200           | IDLE                              | $.[?(@.configurationName=='MongoDBCataloger_nonExistingtable')].status |

  @sanity @positive @webtest @MLP-7660 @IDA-10.3 @MLPQA-12775
  Scenario:SC5#MLP_7660_Verify no Cluster , Table , Database , Host and service facets are cataloged and verify log message
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "NonExistTable" and clicks on search
    And user performs "facet selection" in "NonExistTable" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Analysis |
      | Cluster  |
      | Database |
      | Host     |
      | Service  |
    Then Analysis log "cataloger/MongoDBCataloger/MongoDBCataloger_nonExistingtable/%" should display below info/error/warning
      | type | logValue                                     | logCode            |
      | WARN | No data is available for cataloging purpose. | ANALYSIS-JDBC-0048 |

  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0
  Scenario:SC5:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                           | type     | query | param |
      | SingleItemDelete | Default | cataloger/MongoDBCataloger/MongoDBCataloger_nonExistingtable/% | Analysis |       |       |
      | SingleItemDelete | Default | 10.33.6.130                                                    | Cluster  |       |       |

#######################################Filter Tables#####################################################

  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0 @MLPQA-12755
  Scenario Outline:SC6#MLP_7660_MongoDB_Verify JDBC Cataloger collects DB items like Service, Database, Schema, Table, Columns with  filters(multiple Table) applied
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                           | body                                                             | response code | response message             | jsonPath                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/MongoDBDataSource                                                          | ida/mongoDBPayloads/DataSource/mongodbValidDataSourceConfig.json | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/MongoDBDataSource                                                          |                                                                  | 200           | MongoDBDataSource_valid      |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/MongoDBCataloger                                                           | ida/mongoDBPayloads/MongoDBCataloger/TwoTable.json               | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/MongoDBCataloger                                                           |                                                                  | 200           | MongoDBCataloger_FilterTable |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/MongoDBCataloger/MongoDBCataloger_FilterTable |                                                                  | 200           | IDLE                         | $.[?(@.configurationName=='MongoDBCataloger_FilterTable')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/MongoDBCataloger/MongoDBCataloger_FilterTable  |                                                                  | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/MongoDBCataloger/MongoDBCataloger_FilterTable |                                                                  | 200           | IDLE                         | $.[?(@.configurationName=='MongoDBCataloger_FilterTable')].status |

  @sanity @positive @webtest @MLP-7660 @IDA-10.3 @MLPQA-12755
  Scenario:SC6#MLP_7660_Verify the filter tables are collected in DD UI
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "FilterTable" and clicks on search
    And user performs "facet selection" in "FilterTable" attribute under "Tags" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | Table1 |
      | Table2 |

  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0
  Scenario:SC6:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                      | type     | query | param |
      | SingleItemDelete | Default | cataloger/MongoDBCataloger/MongoDBCataloger_FilterTable/% | Analysis |       |       |
      | SingleItemDelete | Default | 10.33.6.130                                               | Cluster  |       |       |

#########################################################Dry Run#########################################################################################
   #7129878
  @positve @regression @sanity  @MLP-24196 @IDA-1.1.0
  Scenario Outline:SC7_CommonCase:#MLP_24196_Verify whether the cataloger doesn't collects any tables with Dryn run "TRUE"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | body                                                              | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/MongoDBDataSource                                                     | ida/mongoDBPayloads/DataSource/mongodbValidDataSourceConfig.json  | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/MongoDBDataSource                                                     |                                                                   | 200           | MongoDBDataSource_valid |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/MongoDBCataloger                                                      | ida/mongoDBPayloads/MongoDBCataloger/mongoDBcataloger_DryRun.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/MongoDBCataloger                                                      |                                                                   | 200           | MongoDBCataloger_DryRun |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/MongoDBCataloger/MongoDBCataloger_DryRun |                                                                   | 200           | IDLE                    | $.[?(@.configurationName=='MongoDBCataloger_DryRun')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/MongoDBCataloger/MongoDBCataloger_DryRun  |                                                                   | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/MongoDBCataloger/MongoDBCataloger_DryRun |                                                                   | 200           | IDLE                    | $.[?(@.configurationName=='MongoDBCataloger_DryRun')].status |

    #7129878
  @sanity @positive @webtest @MLP-24196 @IDA-10.3 @MLPQA-5754
  Scenario:SC7_CommonCase:MLP_24196_Verify no Cluster , Table , Database , Host and service facets are cataloged and verify log message
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Mongo" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Analysis |
      | Cluster  |
      | Database |
      | Host     |
      | Service  |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/MongoDBCataloger/MongoDBCataloger_DryRun/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 206           |
      | Number of errors          | 0             |
    And user "widget presence" on "Processed Items" in Item view page
    Then Analysis log "cataloger/MongoDBCataloger/MongoDBCataloger_DryRun/%" should display below info/error/warning
      | type | logValue                                                                                      | logCode       | pluginName           | removableText |
      | INFO | Plugin MongoDBCataloger running on dry run mode                                               | ANALYSIS-0069 | CassandraDBCataloger |               |
      | INFO | Plugin MongoDBCataloger processed 206 items on dry run mode and not written to the repository | ANALYSIS-0070 | CassandraDBCataloger |               |
      | INFO | Plugin completed                                                                              | ANALYSIS-0020 |                      |               |

    #7129878
  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0
  Scenario:SC7_CommonCase:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/MongoDBCataloger/MongoDBCataloger_DryRun/% | Analysis |       |       |


    #################### Deleting the credentials , Data Source & Bussiness Application######################
  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0
  Scenario Outline:SC8:MLP-7660:Deleting the Credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                           | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MongoDBCataloger           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MongoDBDataSource          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/MongoDBValidCredential   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/MongoDBInValidCredential |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/MongoDBEmptyCredential   |      | 200           |                  |          |


  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0
  Scenario:SC8:Delete Bussiness Application
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name       | type                | query | param |
      | SingleItemDelete | Default | MONGODB_BA | BusinessApplication |       |       |
