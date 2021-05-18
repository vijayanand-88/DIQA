Feature: CAE Testing for zOS_DB2

  @CAE_zOS_DB2
  Scenario:PreCondition#Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                                   | jsonPath                                                        | node            |
      | ida/CAE_zOS_DB2_Payloads/datasource.json   | $.zOSDB2EntryPointDS.configurations..ServerName                 | HeadlessEDINode |
      | ida/CAE_zOS_DB2_Payloads/datasource.json   | $.zOSDB2FeedLoadDS.configurations..ServerName                   | HeadlessEDINode |
      | ida/CAE_zOS_DB2_Payloads/pluginConfig.json | $.zOSDB2EntryPoint.configurations.nodeCondition                 | HeadlessEDINode |
      | ida/CAE_zOS_DB2_Payloads/pluginConfig.json | $.zOSDB2CollectorInvalidCredential.configurations.nodeCondition | HeadlessEDINode |
      | ida/CAE_zOS_DB2_Payloads/pluginConfig.json | $.zOSDB2CollectorInvalidConfig.configurations.nodeCondition     | HeadlessEDINode |
      | ida/CAE_zOS_DB2_Payloads/pluginConfig.json | $.zOSDB2Collector.configurations.nodeCondition                  | HeadlessEDINode |
      | ida/CAE_zOS_DB2_Payloads/pluginConfig.json | $.zOSDB2CollectorExclude.configurations.nodeCondition           | HeadlessEDINode |
      | ida/CAE_zOS_DB2_Payloads/pluginConfig.json | $.zOSDB2CollectorIncludeExclude.configurations.nodeCondition    | HeadlessEDINode |
      | ida/CAE_zOS_DB2_Payloads/pluginConfig.json | $.zOSDB2Feed.configurations.nodeCondition                       | HeadlessEDINode |
      | ida/CAE_zOS_DB2_Payloads/pluginConfig.json | $.zOSDB2DDLoad.configurations.nodeCondition                     | HeadlessEDINode |
      | ida/CAE_zOS_DB2_Payloads/pluginConfig.json | $.zOSDB2IncrAuto.configurations.nodeCondition                   | HeadlessEDINode |
      | ida/CAE_zOS_DB2_Payloads/pluginConfig.json | $.zOSDB2LoadIncrTrue.configurations.nodeCondition               | HeadlessEDINode |



  #######################################Add Credential for the zOS_DB2##############################################

  @CAE_zOS_DB2
  Scenario Outline:SC#Add Credentials for zOS_DB2
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                   | bodyFile                                           | path               | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/zOSDB2Credential | payloads/ida/CAE_zOS_DB2_Payloads/credentials.json | $.zOSDB2Credential | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/zOSDB2Credential |                                                    |                    | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/InvalidzOSDB2Credential | payloads/ida/CAE_zOS_DB2_Payloads/credentials.json | $.InvalidzOSDB2Credential | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/InvalidzOSDB2Credential |                                                    |                           | 200           |                  |          |

  @CAE_zOS_DB2
  Scenario Outline: SC5#Create BusinessApplication tag
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                 | bodyFile                                                   | path            | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | /items/Default/root | payloads/ida/CAE_zOS_DB2_Payloads/BusinessApplication.json | $.db2_collector | 200           |                  |          |



    ############################################################Verify the CAECreator plugin for zOS_DB2 ############################################################
  @CAE_zOS_DB2
  Scenario Outline:SC4# Run the CAE Creator plugin for zOS_DB2
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                | bodyFile                                            | path                                    | response code | response message   | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/zOSDB2EntryPointServer                                        | payloads/ida/CAE_zOS_DB2_Payloads/credentials.json  | $.CAEOracleServer                       | 200           |                    |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/zOSDB2EntryPointServer                                        |                                                     |                                         | 200           |                    |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDataSource/zOSDB2EntryPointDS                                | payloads/ida/CAE_zOS_DB2_Payloads/datasource.json   | $.zOSDB2EntryPointDS.configurations.[0] | 204           |                    |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDataSource/zOSDB2EntryPointDS                                |                                                     |                                         | 200           | zOSDB2EntryPointDS |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreateEntryPoint/zOSDB2EntryPoint                            | payloads/ida/CAE_zOS_DB2_Payloads/pluginConfig.json | $.zOSDB2EntryPoint.configurations       | 204           |                    |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreateEntryPoint/zOSDB2EntryPoint                            |                                                     |                                         | 200           | zOSDB2EntryPoint   |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/zOSDB2EntryPoint |                                                     |                                         | 200           | IDLE               | $.[?(@.configurationName=='zOSDB2EntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAECreateEntryPoint/zOSDB2EntryPoint  |                                                     |                                         | 200           |                    |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAECreateEntryPoint/zOSDB2EntryPoint |                                                     |                                         | 200           | IDLE               | $.[?(@.configurationName=='zOSDB2EntryPoint')].status |


#  @webtest
#  Scenario:SC#04:BA Tag, Tech tag for CAECreatorEntryPoint Plugin
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "zOS_DB2_CREATOR_BA" and clicks on search
#    And user performs "definite facet selection" in "zOS_DB2_CREATOR_BA" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    Then the following tags "zOS_DB2_CREATOR_BA,BEC" should get displayed for the column "tools/CAECreateEntryPoint/zOSDB2EntryPoint"
#    And user delete all "Analysis" log with name "tools/CAECreateEntryPoint/zOSDB2EntryPoint/%" using database


     ##################################################################Verify DES file is not collected when Invalid credentials is used in the zOS_DB2 collector###############################################
  @CAE_zOS_DB2
  Scenario Outline:SC5# Run the zOS_DB2 Collector plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                          | bodyFile                                            | path                                              | response code | response message                 | jsonPath                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDB2zOSDataSource/zOSDB2DataSource                                      | payloads/ida/CAE_zOS_DB2_Payloads/datasource.json   | $.zOSDB2DataSource.configurations.[0]             | 204           |                                  |                                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDB2zOSDataSource/zOSDB2DataSource                                      |                                                     |                                                   | 200           | zOSDB2DataSource                 |                                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/DB2zOSCollector/zOSDB2CollectorInvalidCredential                          | payloads/ida/CAE_zOS_DB2_Payloads/pluginconfig.json | $.zOSDB2CollectorInvalidCredential.configurations | 204           |                                  |                                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/DB2zOSCollector/zOSDB2CollectorInvalidCredential                          |                                                     |                                                   | 200           | zOSDB2CollectorInvalidCredential |                                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorInvalidCredential |                                                     |                                                   | 200           | IDLE                             | $.[?(@.configurationName=='zOSDB2CollectorInvalidCredential')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorInvalidCredential  |                                                     |                                                   | 200           |                                  |                                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorInvalidCredential |                                                     |                                                   | 200           | IDLE                             | $.[?(@.configurationName=='zOSDB2CollectorInvalidCredential')].status |


  ##7143458##
  @CAE_zOS_DB2
  Scenario: SC5# Verify the error count in CAE Collector analysis log
    Given Verify Analysis log "cae/DB2zOSCollector/zOSDB2CollectorInvalidCredential%" info/error/warning for below parameters
      | assertion      | type  | code           | logMessage                                                |
      | should contain | error | VHC-ERR-300105 | VHC-ERR-300105 : DBMS connection could not be established |
    And Analysis log "cae/DB2zOSCollector/zOSDB2CollectorInvalidCredential%" should display below info/error/warning
      | type | logValue                                                                                                                             | logCode       | pluginName      | removableText |
      | INFO | Plugin DB2zOSCollector Start Time:2020-08-20 15:43:58.844, End Time:2020-08-20 15:44:04.500, Processed Count:0, Errors:4, Warnings:0 | ANALYSIS-0072 | DB2zOSCollector |               |
      | INFO | Plugin completed with errors (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                           | ANALYSIS-0075 | DB2zOSCollector |               |
    And user delete all "Analysis" log with name "cae/DB2zOSCollector/zOSDB2CollectorInvalidCredential%" using database


##################################################################Verify DES file is not collected and the log has errors when tilt is used to separate 2 config lines##############################################
  @CAE_zOS_DB2
  Scenario Outline:SC5_1# Run the zOS_DB2 Collector plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                            | path                                          | response code | response message | jsonPath                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DB2zOSCollector/zOSDB2CollectorInvalidConfig                          | payloads/ida/CAE_zOS_DB2_Payloads/pluginconfig.json | $.zOSDB2CollectorInvalidConfig.configurations | 204           |                  |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DB2zOSCollector/zOSDB2CollectorInvalidConfig                          |                                                     |                                               | 200           | zOSDB2Collector  |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorInvalidConfig |                                                     |                                               | 200           | IDLE             | $.[?(@.configurationName=='zOSDB2CollectorInvalidConfig')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorInvalidConfig  |                                                     |                                               | 200           |                  |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorInvalidConfig |                                                     |                                               | 200           | IDLE             | $.[?(@.configurationName=='zOSDB2CollectorInvalidConfig')].status |


  ##7143458##
  @CAE_zOS_DB2
  Scenario: SC5_1# Verify the error count in CAE Collector analysis log
    Given Verify Analysis log "cae/DB2zOSCollector/zOSDB2CollectorInvalidConfig%" info/error/warning for below parameters
      | assertion      | type  | code           | logMessage                                                  |
      | should contain | error | VHC-ERR-300091 | Configuration line contains duplicate parameter = ,PROCESS= |
    And Analysis log "cae/DB2zOSCollector/zOSDB2CollectorInvalidConfig%" should display below info/error/warning
      | type | logValue                                                                                                                                            | logCode       | pluginName      | removableText |
      | INFO | ANALYSIS-0072: Plugin DB2zOSCollector Start Time:2020-10-22 11:46:14.796, End Time:2020-10-22 11:46:16.046, Processed Count:0, Errors:5, Warnings:0 | ANALYSIS-0072 | DB2zOSCollector |               |
      | INFO | Plugin completed with errors (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                          | ANALYSIS-0075 | DB2zOSCollector |               |
    And user delete all "Analysis" log with name "cae/DB2zOSCollector/zOSDB2CollectorInvalidConfig%" using database





    ######################################################Verify if the Schema Included in config of db2 Collector is collected and Loaded into DD Using the CAEDDLoader###########################################################################################
  @CAE_zOS_DB2
  Scenario Outline:SC4#Run the zOS DB2 Collector, feeder and loader plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                         | bodyFile                                            | path                                  | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDB2zOSDataSource/zOSDB2DataSource                     | payloads/ida/CAE_zOS_DB2_Payloads/datasource.json   | $.zOSDB2DataSource.configurations.[0] | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDB2zOSDataSource/zOSDB2DataSource                     |                                                     |                                       | 200           | zOSDB2DataSource |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DB2zOSCollector/zOSDB2Collector                          | payloads/ida/CAE_zOS_DB2_Payloads/pluginconfig.json | $.zOSDB2Collector.configurations      | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/DB2zOSCollector/zOSDB2Collector                          |                                                     |                                       | 200           | zOSDB2Collector  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DB2zOSCollector/zOSDB2Collector |                                                     |                                       | 200           | IDLE             | $.[?(@.configurationName=='zOSDB2Collector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/DB2zOSCollector/zOSDB2Collector  |                                                     |                                       | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DB2zOSCollector/zOSDB2Collector |                                                     |                                       | 200           | IDLE             | $.[?(@.configurationName=='zOSDB2Collector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/zOSDB2EntryPoint                                       | payloads/ida/CAE_zOS_DB2_Payloads/credentials.json  | $.zOSDB2EntryPoint                    | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/zOSDB2EntryPoint                                       |                                                     |                                       | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDataSource/zOSDB2FeedLoadDS                           | payloads/ida/CAE_zOS_DB2_Payloads/datasource.json   | $.zOSDB2FeedLoadDS.configurations.[0] | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDataSource/zOSDB2FeedLoadDS                           |                                                     |                                       | 200           | zOSDB2FeedLoadDS |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/zOSDB2Feed                                       | payloads/ida/CAE_zOS_DB2_Payloads/pluginconfig.json | $.zOSDB2Feed.configurations           | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/zOSDB2Feed                                       |                                                     |                                       | 200           | zOSDB2Feed       |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/zOSDB2Feed              |                                                     |                                       | 200           | IDLE             | $.[?(@.configurationName=='zOSDB2Feed')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/zOSDB2Feed               |                                                     |                                       | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/zOSDB2Feed              |                                                     |                                       | 200           | IDLE             | $.[?(@.configurationName=='zOSDB2Feed')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/zOSDB2DDLoad                                 | payloads/ida/CAE_zOS_DB2_Payloads/pluginconfig.json | $.zOSDB2DDLoad.configurations         | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/zOSDB2DDLoad                                 |                                                     |                                       | 200           | zOSDB2DDLoad     |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/zOSDB2DDLoad       |                                                     |                                       | 200           | IDLE             | $.[?(@.configurationName=='zOSDB2DDLoad')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/zOSDB2DDLoad        |                                                     |                                       | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/zOSDB2DDLoad       |                                                     |                                       | 200           | IDLE             | $.[?(@.configurationName=='zOSDB2DDLoad')].status    |


  ##7185597##
  @webtest @CAE_zOS_DB2
  Scenario: Verify the Breadcrumb hierarchy for the zOS_DB2
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "COMPLEXTABLE1" and clicks on search
    And user performs "definite facet selection" in "zOS_DB2_BA" attribute under "Business Application" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "definite facet selection" in "COMPLEXTABLE1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "ID" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | MVSSYSA.ASG.COM |
      | DB2:6203        |
      | NA01DC1A        |
      | DV538A          |
      | COMPLEXTABLE1   |
      | ID              |


  ##7185465## ##7198367## ##BUG exists##
  @webtest @CAE_zOS_DB2
  Scenario:SC#_Verify Bussiness tag, Technology appears correctly in db2 items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "zOS_DB2_BA" and clicks on search
    And user performs "facet selection" in "zOS_DB2_BA" attribute under "Business Application" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "zOS_DB2_BA,BEC" should get displayed for the column "cae/DB2zOSCollector/zOSDB2Collector"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                | fileName                   | userTag                    |
      | Default     | Table      | Metadata Type | DB2,BEC,zOS_DB2_BA | CUSTOMERDETAILS_TABLE_TEST | CUSTOMERDETAILS_TABLE_TEST |
      | Default     | Column     | Metadata Type | DB2,BEC,zOS_DB2_BA | CONTACTFIRSTNAME           | CONTACTFIRSTNAME           |
      | Default     | Constraint | Metadata Type | DB2,BEC,zOS_DB2_BA | CONTCUST                   | CONTCUST                   |
      | Default     | Routine    | Metadata Type | DB2,BEC,zOS_DB2_BA | RF_INFA_DIFF_META_SQ_PROC  | RF_INFA_DIFF_META_SQ_PROC  |
      | Default     | Index      | Metadata Type | DB2,BEC,zOS_DB2_BA | I_NODEIDXBLOBTEST          | I_NODEIDXBLOBTEST          |
      | Default     | Trigger    | Metadata Type | DB2,BEC,zOS_DB2_BA | DLNDEL                     | DLNDEL                     |
      | Default     | Cluster    | Metadata Type | DB2,BEC,zOS_DB2_BA | MVSSYSA.ASG.COM            | MVSSYSA.ASG.COM            |
      | Default     | Service    | Metadata Type | DB2,BEC,zOS_DB2_BA | DB2:6203                   | DB2:6203                   |
      | Default     | Database   | Metadata Type | DB2,BEC,zOS_DB2_BA | NA01DC1A                   | NA01DC1A                   |
      | Default     | Schema     | Metadata Type | DB2,BEC,zOS_DB2_BA | DV538A                     | DV538A                     |



  ##7143225##
  @TEST_MLPQA-5543 @CAE_zOS_DB2
  Scenario:SC4#Verify the processed count in CAE Collector analysis log for collector
    Given Verify Analysis log "cae/DB2zOSCollector/zOSDB2Collector/%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                                                |
      | should contain | info | VHC-INF-300900 | Total number of directory objects processed  =         80 |
      | should contain | info | VHC-INF-300901 | Total number of objects loaded               =         80 |
      | should contain | info | VHC-INF-300902 | Total number of objects deleted              =          0 |
    And Analysis log "cae/DB2zOSCollector/zOSDB2Collector%" should display below info/error/warning
      | type | logValue                                                                                                                             | logCode       | pluginName                | removableText |
      | INFO | Plugin DB2zOSCollector Start Time:2020-09-20 08:49:55.884, End Time:2020-09-20 08:50:00.351, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_zOS_DB2 |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                       | ANALYSIS-0020 |                           |               |
    And Analysis log "bulk/CAEDDLoader/zOSDB2DDLoad/%" should display below info/error/warning
      | type | logValue                                                                                                                           | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:514, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                     | ANALYSIS-0020 | CAEDDLoader |               |


      ##7236885##  ####
  @webtest
  Scenario: SC#6: Validate the data type counts in db2 after running collector, Feed and CAEDDLoader
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "zOS_DB2_BA" and clicks on search
    And user performs "facet selection" in "zOS_DB2_BA" attribute under "Business Application" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
      |              |              |           |           |            |            |                | Metadata Type | Table      | 70    |
      |              |              |           |           |            |            |                | Metadata Type | Column     | 302   |
      |              |              |           |           |            |            |                | Metadata Type | Index      | 1     |
      |              |              |           |           |            |            |                | Metadata Type | Schema     | 1     |
      |              |              |           |           |            |            |                | Metadata Type | Database   | 1     |
      |              |              |           |           |            |            |                | Metadata Type | Cluster    | 1     |
      |              |              |           |           |            |            |                | Metadata Type | Service    | 1     |


  ##7185467--completed##
  @webtest
  Scenario: Verify the widget and the Metadata attributes for Cluster, Service, Database, Schema, Table, View and Column
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "MVSSYSA.ASG.COM" and clicks on search
    And user performs "definite facet selection" in "DB2" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "MVSSYSA.ASG.COM" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Db2 User      | Description |
    Then user performs click and verify in new window
      | Table    | value    | Action               | RetainPrevwindow | indexSwitch |
      | Services | DB2:6203 | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Db2 User      | Description |
    Then user performs click and verify in new window
      | Table     | value    | Action               | RetainPrevwindow | indexSwitch |
      | Databases | NA01DC1A | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Db2 User      | Description |
      | Storage type      | DB2           | Description |
    Then user performs click and verify in new window
      | Table   | value  | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | DEVDXC | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Db2 User      | Description |
    Then user performs click and verify in new window
      | Table  | value         | Action               | RetainPrevwindow | indexSwitch |
      | Tables | CONTACT_TABLE | click and switch tab | No               |             |
    Then user performs click and verify in new window
      | Table       | value    | Action               | RetainPrevwindow | indexSwitch |
      | Constraints | CONTCUST | click and switch tab | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Constraint Type   | FOREIGN_KEY   | Description |
    Then user performs click and verify in new window
      | Table | value    | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | CONTCUST | verify widget contains | No               |             |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch |
      | Tables | EQUIPMENT | click and switch tab | No               |             |
    Then user performs click and verify in new window
      | Table     | value    | Action               | RetainPrevwindow | indexSwitch |
      | has_Index | EQUIP_NO | click and switch tab | No               |             |
    Then user performs click and verify in new window
      | Table | value    | Action                | RetainPrevwindow | indexSwitch |
      | Data  | EQUIP_NO | verify widgetcontains | No               |             |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table       | value  | Action               | RetainPrevwindow | indexSwitch |
      | has_Trigger | DLNDEL | click and switch tab | No               |             |
    Then user performs click and verify in new window
      | Table        | value   | Action                 | RetainPrevwindow | indexSwitch |
      | dependencies | DLNCUST | verify widget contains | No               |             |
      | SQLSource    | DLNDEL  | verify widget contains | No               |             |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table       | value                     | Action                 | RetainPrevwindow | indexSwitch |
      | has_Routine | RF_INFA_DIFF_META_SQ_PROC | verify widget contains | No               |             |
      | has_Routine | RF_INFA_DIFF_META_SQ_PROC | click and switch tab   | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | routineType       | PROCEDURE     | Description |
    Then user performs click and verify in new window
      | Table     | value                     | Action                 | RetainPrevwindow | indexSwitch |
      | SQLSource | RF_INFA_DIFF_META_SQ_PROC | verify widget contains | No               |             |

                     #############Below Scripts are pending fixes####################################

#       ########################################################################Incrementals Scenario: Add Data to db2 Database and run the zOS_DB2 collector with PROCESSS AUTO and CAEDDLoader with CLEAR(FALSE) and INCREMENTAL(TRUE)###########################################################################################
  @jdbc
  Scenario:SC#9: create Table for incremental scenario
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage       | queryField                |
      | zOS_DB2            | EXECUTEQUERY | json/IDA.json | zOS_DB2_Queries | createTableForIncremental |
      | zOS_DB2            | EXECUTEQUERY | json/IDA.json | zOS_DB2_Queries | createViewForIncremental  |


  Scenario Outline:SC9#Run the db2 Collector, feeder and loader plugin for Incremental
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                         | bodyFile                                            | path                                | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DB2zOSCollector/zOSDB2IncrAuto                           | payloads/ida/CAE_zOS_DB2_Payloads/pluginConfig.json | $.zOSDB2IncrAuto.configurations     | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/DB2zOSCollector/zOSDB2IncrAuto                           |                                                     |                                     | 200           | zOSDB2IncrAuto     |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DB2zOSCollector/zOSDB2IncrAuto  |                                                     |                                     | 200           | IDLE               | $.[?(@.configurationName=='zOSDB2IncrAuto')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/DB2zOSCollector/zOSDB2IncrAuto   |                                                     |                                     | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DB2zOSCollector/zOSDB2IncrAuto  |                                                     |                                     | 200           | IDLE               | $.[?(@.configurationName=='zOSDB2IncrAuto')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/zOSDB2Feed                                       | payloads/ida/CAE_zOS_DB2_Payloads/pluginconfig.json | $.zOSDB2Feed.configurations         | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/zOSDB2Feed                                       |                                                     |                                     | 200           | zOSDB2Feed         |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/zOSDB2Feed              |                                                     |                                     | 200           | IDLE               | $.[?(@.configurationName=='zOSDB2Feed')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/CAEFeed/zOSDB2Feed               |                                                     |                                     | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/CAEFeed/zOSDB2Feed              |                                                     |                                     | 200           | IDLE               | $.[?(@.configurationName=='zOSDB2Feed')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/zOSDB2LoadIncrTrue                           | payloads/ida/CAE_zOS_DB2_Payloads/pluginConfig.json | $.zOSDB2LoadIncrTrue.configurations | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/zOSDB2LoadIncrTrue                           |                                                     |                                     | 200           | zOSDB2LoadIncrTrue |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/zOSDB2LoadIncrTrue |                                                     |                                     | 200           | IDLE               | $.[?(@.configurationName=='zOSDB2LoadIncrTrue')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/bulk/CAEDDLoader/zOSDB2LoadIncrTrue  |                                                     |                                     | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/bulk/CAEDDLoader/zOSDB2LoadIncrTrue |                                                     |                                     | 200           | IDLE               | $.[?(@.configurationName=='zOSDB2LoadIncrTrue')].status |


  @webtest
  Scenario: SC#9: Validate the data type counts in db2 after running collector, Feed and CAEDDLoader for Incremental
#    Given Verify Analysis log "cae/DB2zOSCollector/zOSDB2IncrAuto/%" info/error/warning for below parameters
#      | assertion      | type | code           | logMessage                                                                 |
#      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =         71 |
#      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =         24 |
#      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =          0 |
#    And Analysis log "collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO/%" should display below info/error/warning
#      | type | logValue                                                                                                                                                      | logCode       | pluginName                | removableText |
#      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_zOS_DB2 Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_zOS_DB2 |               |
#      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                                | ANALYSIS-0020 | CAE_Collector_for_zOS_DB2 |               |
    Given Analysis log "bulk/CAEDDLoader/zOSDB2LoadIncrTrue/%" should display below info/error/warning
      | type | logValue                                                                                                                          | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:14, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                    | ANALYSIS-0020 | CAEDDLoader |               |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "DV538A" and clicks on search
    And user performs "facet selection" in "zOS_DB2_BA" attribute under "Business Application" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage       | queryField              | columnName | queryOperation | facet         | facetValue | count      |
      | zOS_DB2      | STRUCTURED   | json/IDA.json | zOS_DB2_Queries | getTableCountforDV538A  | COUNT      | returnValue    | Metadata Type | Table      | fromSource |
      | zOS_DB2      | STRUCTURED   | json/IDA.json | zOS_DB2_Queries | getColumnCountforDV538A | COUNT      | returnValue    | Metadata Type | Column     | fromSource |

#
#  Scenario:SC#09:Delete Cluster and all the Analysis log for db2 for entry point deletion
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                                                                     | type     | query | param |
#      | MultipleIDDelete | Default | other/CAEFeed/zOS_DB2_Feeder/%                                           | Analysis |       |       |
#      | MultipleIDDelete | Default | collector/CAEDDLoader/zOS_DB2_DDLoader/%                                 | Analysis |       |       |
#      | MultipleIDDelete | Default | collector/CAEDDLoader/zOS_DB2_DDLoader_1/%                               | Analysis |       |       |
#      | MultipleIDDelete | Default | collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO/% | Analysis |       |       |
#      | MultipleIDDelete | Default | collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_LOAD/% | Analysis |       |       |
#
#
#
#    #########################################Verify the data is deleted from the Entry Point and removed from DD When db2 Collector has PROCESS DELETE and CAEDDLoader has Clear as TRUE and Incremental as False#################################################################################################################################
#
#  Scenario Outline:SC5#Run the db2 Collector, feeder and loader plugin
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                            | path                  | response code | response message    | jsonPath                                                 |
#      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/DB2zOSCollector/zOSDB2CollectorProcessDelete                          | payloads/ida/CAE_zOS_DB2_Payloads/pluginConfig.json | $.zOSDB2ProcessDelete | 204           |                     |                                                          |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/DB2zOSCollector/zOSDB2CollectorProcessDelete                          |                                                     |                       | 200           | zOSDB2ProcessDelete |                                                          |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorProcessDelete |                                                     |                       | 200           | IDLE                | $.[?(@.configurationName=='zOSDB2ProcessDelete')].status |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorProcessDelete  |                                                     |                       | 200           |                     |                                                          |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorProcessDelete |                                                     |                       | 200           | IDLE                | $.[?(@.configurationName=='zOSDB2ProcessDelete')].status |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEFeed/zOSDB2Feed                         |                                                     |                       | 200           | IDLE                | $.[?(@.configurationName=='zOSDB2Feed')].status          |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/other/CAEFeed/zOSDB2Feed                          |                                                     |                       | 200           |                     |                                                          |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEFeed/zOSDB2Feed                         |                                                     |                       | 200           | IDLE                | $.[?(@.configurationName=='zOSDB2Feed')].status          |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDDLoader/zOSDB2DDLoad                   |                                                     |                       | 200           | IDLE                | $.[?(@.configurationName=='zOSB2DDLoad')].status         |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAEDDLoader/zOSDB2DDLoad                    |                                                     |                       | 200           |                     |                                                          |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDDLoader/zOSDB2DDLoad                   |                                                     |                       | 200           | IDLE                | $.[?(@.configurationName=='zOSB2DDLoad')].status         |
#
#
#  ####
#  @webtest
#  Scenario: SC#5: Verify the Log for the zOS_DB2 collector(PROCESS: DELETE) and CAEDDLoader with Clear True and Incremental False runs and deletes the data from DD.
#    Given Verify Analysis log "cae/DB2zOSCollector/zOSDB2CollectorProcessDelete/%" info/error/warning for below parameters
#      | assertion      | type | code           | logMessage                                                                 |
#      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =          0 |
#      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =          0 |
#      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =       4261 |
#    And Analysis log "cae/DB2zOSCollector/zOSDB2CollectorProcessDelete/%" should display below info/error/warning
#      | type | logValue                                                                                                                                            | logCode       | pluginName      | removableText |
#      | INFO | ANALYSIS-0072: Plugin DB2zOSCollector Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | DB2zOSCollector |               |
#      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                      | ANALYSIS-0020 | DB2zOSCollector |               |
#    And Analysis log "cae/CAEDDLoader/zOSDB2DDLoad/%" should display below info/error/warning
#      | type | logValue                                                                                                                            | logCode       | pluginName  | removableText |
#      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:2056, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
#      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                      | ANALYSIS-0020 | CAEDDLoader |               |
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    Then user "verify non presence" of following "Values" in Search Results Page
#      | MVSSYSA.ASG.COM | No data found |
#
#
#  Scenario:SC#05:Delete Cluster and all the Analysis log for db2
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                                               | type     | query | param |
#      | SingleItemDelete | Default | MVSSYSA.ASG.COM                                    | Cluster  |       |       |
#      | SingleItemDelete | Default | $$CAE Cluster Db2 User                             | Cluster  |       |       |
#      | MultipleIDDelete | Default | other/CAEFeed/zOSDB2Feed/%                         | Analysis |       |       |
#      | MultipleIDDelete | Default | collector/CAEDDLoader/zOSDB2DDLoad/%               | Analysis |       |       |
#      | MultipleIDDelete | Default | cae/DB2zOSCollector/zOSDB2CollectorProcessDelete/% | Analysis |       |       |
#
#
#    ######################################################Verify if the Schema excluded in the zOS_DB2 Collector should exclude and collect other schema and Loaded into DD Using the CAEDDLoader###########################################################################################
#
#
#
#  Scenario Outline:SC7#Run the zOS DB2 Collector, feeder and loader plugin
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                | bodyFile                                            | path                     | response code | response message       | jsonPath                                                    |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DB2zOSCollector/zOSDB2CollectorExclude                          | payloads/ida/CAE_zOS_DB2_Payloads/pluginconfig.json | $.zOSDB2CollectorExclude | 204           |                        |                                                             |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/DB2zOSCollector/zOSDB2CollectorExclude                          |                                                     |                          | 200           | zOSDB2CollectorExclude |                                                             |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorExclude |                                                     |                          | 200           | IDLE                   | $.[?(@.configurationName=='zOSDB2CollectorExclude')].status |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorExclude  |                                                     |                          | 200           |                        |                                                             |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorExclude |                                                     |                          | 200           | IDLE                   | $.[?(@.configurationName=='zOSDB2CollectorExclude')].status |
#      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/zOSDB2EntryPoint                                              | payloads/ida/CAE_zOS_DB2_Payloads/credentials.json  | $.zOSDB2EntryPoint       | 200           |                        |                                                             |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/zOSDB2EntryPoint                                              |                                                     |                          | 200           |                        |                                                             |
#      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDataSource/zOSDB2FeedLoadDS                                  | payloads/ida/CAE_zOS_DB2_Payloads/datasource.json   | $.zOSDB2FeedLoadDS       | 204           |                        |                                                             |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDataSource/zOSDB2FeedLoadDS                                  |                                                     |                          | 200           | zOSDB2FeedLoadDS       |                                                             |
#      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/zOSDB2Feed                                              | payloads/ida/CAE_zOS_DB2_Payloads/pluginconfig.json | $.zOSDB2Feed             | 204           |                        |                                                             |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/zOSDB2Feed                                              |                                                     |                          | 200           | zOSDB2Feed             |                                                             |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEFeed/zOSDB2Feed                   |                                                     |                          | 200           | IDLE                   | $.[?(@.configurationName=='zOSDB2Feed')].status             |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/other/CAEFeed/zOSDB2Feed                    |                                                     |                          | 200           |                        |                                                             |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEFeed/zOSDB2Feed                   |                                                     |                          | 200           | IDLE                   | $.[?(@.configurationName=='zOSDB2Feed')].status             |
#      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/zOSDB2DDLoad                                        | payloads/ida/CAE_zOS_DB2_Payloads/pluginconfig.json | $.zOSB2DDLoad            | 204           |                        |                                                             |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/zOSDB2DDLoad                                        |                                                     |                          | 200           | zOSB2DDLoad            |                                                             |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDDLoader/zOSDB2DDLoad             |                                                     |                          | 200           | IDLE                   | $.[?(@.configurationName=='zOSB2DDLoad')].status            |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAEDDLoader/zOSDB2DDLoad              |                                                     |                          | 200           |                        |                                                             |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDDLoader/zOSDB2DDLoad             |                                                     |                          | 200           | IDLE                   | $.[?(@.configurationName=='zOSB2DDLoad')].status            |
#
#
#
#  ##7236886##  ####
#  @webtest
#  Scenario: SC#7: Validate the data type counts in db2 after running collector, Feed and CAEDDLoader
#    Given Verify Analysis log "cae/DB2zOSCollector/zOSDB2CollectorExclude%" info/error/warning for below parameters
#      | assertion      | type | code           | logMessage                                                                 |
#      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =       1435 |
#      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =       1435 |
#      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =          0 |
#    And Analysis log "cae/DB2zOSCollector/zOSDB2CollectorExclude%" should display below info/error/warning
#      | type | logValue                                                                                                                                            | logCode       | pluginName      | removableText |
#      | INFO | ANALYSIS-0072: Plugin DB2zOSCollector Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | DB2zOSCollector |               |
#      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                      | ANALYSIS-0020 | DB2zOSCollector |               |
#    And Analysis log "bulk/CAEDDLoader/zOSDB2DDLoad/%" should display below info/error/warning
#      | type | logValue                                                                                                                             | logCode       | pluginName  | removableText |
#      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:24533, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
#      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                       | ANALYSIS-0020 | CAEDDLoader |               |
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    Then user "verify non presence" of following "Values" in Search Results Page
#      | DB2_VIEWTOSINGLETABLE | No data found |
#    And user enters the search text "DEVDXC" and clicks on search
#    And user performs "facet selection" in "zOS_DB2_BA" attribute under "Tags" facets in Item Search results page
#    And user connects to data base and get count of below fields and compare with platform analysis count
#      | dataBaseName | dataBaseType | queryPath     | queryPage       | queryField              | columnName | queryOperation | facet         | facetValue | count      |
#      | zOS_DB2      | STRUCTURED   | json/IDA.json | zOS_DB2_Queries | getTableCountforDEVDXC  | COUNT      | returnValue    | Metadata Type | Table      | fromSource |
#      | zOS_DB2      | STRUCTURED   | json/IDA.json | zOS_DB2_Queries | getColumnCountforDEVDXC | COUNT      | returnValue    | Metadata Type | Column     | fromSource |
#    And user enters the search text "zOS_DB2_BA" and clicks on search
#    And user performs "facet selection" in "zOS_DB2_BA" attribute under "Tags" facets in Item Search results page
#    And user connects to data base and get count of below fields and compare with platform analysis count
#      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
#      |              |              |           |           |            |            |                | Metadata Type | Routine    | 90    |
#      |              |              |           |           |            |            |                | Metadata Type | Index      | 853   |
#      |              |              |           |           |            |            |                | Metadata Type | Schema     | 52    |
#      |              |              |           |           |            |            |                | Metadata Type | Database   | 1     |
#      |              |              |           |           |            |            |                | Metadata Type | Cluster    | 1     |
#      |              |              |           |           |            |            |                | Metadata Type | Service    | 1     |
#      |              |              |           |           |            |            |                | Metadata Type | Trigger    | 1     |
#
#
#  Scenario:SC#07:Delete Cluster and all the Analysis log for db2
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                                         | type     | query | param |
#      | MultipleIDDelete | Default | other/CAEFeed/zOSDB2Feed/%                   | Analysis |       |       |
#      | MultipleIDDelete | Default | cae/CAEDDLoader/zOSDB2DDLoad/%               | Analysis |       |       |
#      | MultipleIDDelete | Default | cae/DB2zOSCollector/zOSDB2CollectorExclude/% | Analysis |       |       |
#
#
#  Scenario Outline:SC7#Run the db2 Collector, feeder and loader plugin to delete the items from entry point
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                            | path                  | response code | response message    | jsonPath                                                 |
#      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/DB2zOSCollector/zOSDB2CollectorProcessDelete                          | payloads/ida/CAE_zOS_DB2_Payloads/pluginConfig.json | $.zOSDB2ProcessDelete | 204           |                     |                                                          |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/DB2zOSCollector/zOSDB2CollectorProcessDelete                          |                                                     |                       | 200           | zOSDB2ProcessDelete |                                                          |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorProcessDelete |                                                     |                       | 200           | IDLE                | $.[?(@.configurationName=='zOSDB2ProcessDelete')].status |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorProcessDelete  |                                                     |                       | 200           |                     |                                                          |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorProcessDelete |                                                     |                       | 200           | IDLE                | $.[?(@.configurationName=='zOSDB2ProcessDelete')].status |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEFeed/zOSDB2Feed                         |                                                     |                       | 200           | IDLE                | $.[?(@.configurationName=='zOSDB2Feed')].status          |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/other/CAEFeed/zOSDB2Feed                          |                                                     |                       | 200           |                     |                                                          |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEFeed/zOSDB2Feed                         |                                                     |                       | 200           | IDLE                | $.[?(@.configurationName=='zOSDB2Feed')].status          |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDDLoader/zOSDB2DDLoad                   |                                                     |                       | 200           | IDLE                | $.[?(@.configurationName=='zOSB2DDLoad')].status         |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAEDDLoader/zOSDB2DDLoad                    |                                                     |                       | 200           |                     |                                                          |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDDLoader/zOSDB2DDLoad                   |                                                     |                       | 200           | IDLE                | $.[?(@.configurationName=='zOSB2DDLoad')].status         |
#
#
#  Scenario:SC#07:Delete Cluster and all the Analysis log for db2 for entry point deletion
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                                                   | type     | query | param |
#      | SingleItemDelete | Default | MVSSYSA.ASG.COM                                        | Cluster  |       |       |
#      | SingleItemDelete | Default | $$CAE Cluster Db2 User                                 | Cluster  |       |       |
#      | MultipleIDDelete | Default | tools/CAEFeed/zOSDB2Feed/%                             | Analysis |       |       |
#      | MultipleIDDelete | Default | bulk/CAEDDLoader/zOSDB2DDLoad/%                        | Analysis |       |       |
#      | MultipleIDDelete | Default | cae/DB2zOSCollector/zOS_DB2_Collector_Process_DELETE/% | Analysis |       |       |
#
#
#    ######################################################Verify if the Schema Included & excluded in the zOS_DB2 Collector should Include and exclude schema and Loaded into DD Using the CAEDDLoader###########################################################################################
#
#  Scenario Outline:SC8#Run the db2 Collector, feeder and loader plugin
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                            | path                     | response code | response message       | jsonPath                                                           |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DB2zOSCollector/zOSDB2CollectorIncludeExclude                          | payloads/ida/CAE_zOS_DB2_Payloads/pluginconfig.json | $.zOSDB2CollectorExclude | 204           |                        |                                                                    |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/DB2zOSCollector/zOSDB2CollectorIncludeExclude                          |                                                     |                          | 200           | zOSDB2CollectorExclude |                                                                    |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorIncludeExclude |                                                     |                          | 200           | IDLE                   | $.[?(@.configurationName=='zOSDB2CollectorIncludeExclude')].status |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorIncludeExclude  |                                                     |                          | 200           |                        |                                                                    |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorIncludeExclude |                                                     |                          | 200           | IDLE                   | $.[?(@.configurationName=='zOSDB2CollectorIncludeExclude')].status |
#      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/zOSDB2EntryPoint                                                     | payloads/ida/CAE_zOS_DB2_Payloads/credentials.json  | $.zOSDB2EntryPoint       | 200           |                        |                                                                    |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/zOSDB2EntryPoint                                                     |                                                     |                          | 200           |                        |                                                                    |
#      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDataSource/zOSDB2FeedLoadDS                                         | payloads/ida/CAE_zOS_DB2_Payloads/datasource.json   | $.zOSDB2FeedLoadDS       | 204           |                        |                                                                    |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDataSource/zOSDB2FeedLoadDS                                         |                                                     |                          | 200           | zOSDB2FeedLoadDS       |                                                                    |
#      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEFeed/zOSDB2Feed                                                     | payloads/ida/CAE_zOS_DB2_Payloads/pluginconfig.json | $.zOSDB2Feed             | 204           |                        |                                                                    |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEFeed/zOSDB2Feed                                                     |                                                     |                          | 200           | zOSDB2Feed             |                                                                    |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEFeed/zOSDB2Feed                          |                                                     |                          | 200           | IDLE                   | $.[?(@.configurationName=='zOSDB2Feed')].status                    |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/other/CAEFeed/zOSDB2Feed                           |                                                     |                          | 200           |                        |                                                                    |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEFeed/zOSDB2Feed                          |                                                     |                          | 200           | IDLE                   | $.[?(@.configurationName=='zOSDB2Feed')].status                    |
#      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDDLoader/zOSDB2DDLoad                                               | payloads/ida/CAE_zOS_DB2_Payloads/pluginconfig.json | $.zOSB2DDLoad            | 204           |                        |                                                                    |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDDLoader/zOSDB2DDLoad                                               |                                                     |                          | 200           | zOSB2DDLoad            |                                                                    |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDDLoader/zOSDB2DDLoad                    |                                                     |                          | 200           | IDLE                   | $.[?(@.configurationName=='zOSB2DDLoad')].status                   |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAEDDLoader/zOSDB2DDLoad                     |                                                     |                          | 200           |                        |                                                                    |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDDLoader/zOSDB2DDLoad                    |                                                     |                          | 200           | IDLE                   | $.[?(@.configurationName=='zOSB2DDLoad')].status                   |
#
#
#
#  ##7236887##  ####
#  @webtest
#  Scenario: SC#8: Validate the data type counts in db2 after running collector, Feed and CAEDDLoader
#    Given Verify Analysis log "cae/DB2zOSCollector/zOSDB2CollectorIncludeExclude/%" info/error/warning for below parameters
#      | assertion      | type | code           | logMessage                                                                 |
#      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =         69 |
#      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =         69 |
#      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =          0 |
#    And Analysis log "cae/DB2zOSCollector/zOSDB2CollectorIncludeExclude/%" should display below info/error/warning
#      | type | logValue                                                                                                                                            | logCode       | pluginName      | removableText |
#      | INFO | ANALYSIS-0072: Plugin DB2zOSCollector Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | DB2zOSCollector |               |
#      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                      | ANALYSIS-0020 | DB2zOSCollector |               |
#    And Analysis log "tools/CAEDDLoader/zOSB2DDLoad/%" should display below info/error/warning
#      | type | logValue                                                                                                                            | logCode       | pluginName  | removableText |
#      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:2527, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
#      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                      | ANALYSIS-0020 | CAEDDLoader |               |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    Then user "verify non presence" of following "Values" in Search Results Page
#      | CONTACT_TABLE | No data found |
#    And user enters the search text "DV538A" and clicks on search
#    And user performs "facet selection" in "zOS_DB2_BA" attribute under "Tags" facets in Item Search results page
#    And user connects to data base and get count of below fields and compare with platform analysis count
#      | dataBaseName | dataBaseType | queryPath     | queryPage       | queryField              | columnName | queryOperation | facet         | facetValue | count      |
#      | zOS_DB2      | STRUCTURED   | json/IDA.json | zOS_DB2_Queries | getTableCountforDV538A  | COUNT      | returnValue    | Metadata Type | Table      | fromSource |
#      | zOS_DB2      | STRUCTURED   | json/IDA.json | zOS_DB2_Queries | getColumnCountforDV538A | COUNT      | returnValue    | Metadata Type | Column     | fromSource |
#    And user enters the search text "zOS_DB2_BA" and clicks on search
#    And user performs "facet selection" in "zOS_DB2_BA" attribute under "Tags" facets in Item Search results page
#    And user connects to data base and get count of below fields and compare with platform analysis count
#      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
#      |              |              |           |           |            |            |                | Metadata Type | Routine    | 90    |
#      |              |              |           |           |            |            |                | Metadata Type | Index      | 851   |
#      |              |              |           |           |            |            |                | Metadata Type | Schema     | 52    |
#      |              |              |           |           |            |            |                | Metadata Type | Database   | 1     |
#      |              |              |           |           |            |            |                | Metadata Type | Cluster    | 1     |
#      |              |              |           |           |            |            |                | Metadata Type | Service    | 1     |
#      |              |              |           |           |            |            |                | Metadata Type | Trigger    | 1     |
#
#
#  Scenario:SC#08:Delete Cluster and all the Analysis log for db2
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                                                | type     | query | param |
#      | MultipleIDDelete | Default | cae/CAEFeed/zOSDB2Feed/%                            | Analysis |       |       |
#      | MultipleIDDelete | Default | bulk/CAEDDLoader/zOSDB2DDLoad/%                     | Analysis |       |       |
#      | MultipleIDDelete | Default | cae/DB2zOSCollector/zOSDB2CollectorIncludeExclude/% | Analysis |       |       |
#
#
#  Scenario Outline:SC8#Run the db2 Collector, feeder and loader plugin to delete the items from entry point
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                            | path                  | response code | response message    | jsonPath                                                 |
#      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/DB2zOSCollector/zOSDB2CollectorProcessDelete                          | payloads/ida/CAE_zOS_DB2_Payloads/pluginConfig.json | $.zOSDB2ProcessDelete | 204           |                     |                                                          |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/DB2zOSCollector/zOSDB2CollectorProcessDelete                          |                                                     |                       | 200           | zOSDB2ProcessDelete |                                                          |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorProcessDelete |                                                     |                       | 200           | IDLE                | $.[?(@.configurationName=='zOSDB2ProcessDelete')].status |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorProcessDelete  |                                                     |                       | 200           |                     |                                                          |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/cae/DB2zOSCollector/zOSDB2CollectorProcessDelete |                                                     |                       | 200           | IDLE                | $.[?(@.configurationName=='zOSDB2ProcessDelete')].status |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEFeed/zOSDB2Feed                         |                                                     |                       | 200           | IDLE                | $.[?(@.configurationName=='zOSDB2Feed')].status          |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/other/CAEFeed/zOSDB2Feed                          |                                                     |                       | 200           |                     |                                                          |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEFeed/zOSDB2Feed                         |                                                     |                       | 200           | IDLE                | $.[?(@.configurationName=='zOSDB2Feed')].status          |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDDLoader/zOSDB2DDLoad                   |                                                     |                       | 200           | IDLE                | $.[?(@.configurationName=='zOSB2DDLoad')].status         |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/tools/CAEDDLoader/zOSDB2DDLoad                    |                                                     |                       | 200           |                     |                                                          |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/tools/CAEDDLoader/zOSDB2DDLoad                   |                                                     |                       | 200           | IDLE                | $.[?(@.configurationName=='zOSB2DDLoad')].status         |
#
#
#  Scenario:SC#08:Delete Cluster and all the Analysis log for db2 for entry point deletion
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                                            | type     | query | param |
#      | SingleItemDelete | Default | MVSSYSA.ASG.COM                                 | Cluster  |       |       |
#      | SingleItemDelete | Default | $$CAE Cluster Db2 User                          | Cluster  |       |       |
#      | MultipleIDDelete | Default | cae/CAEFeed/zOSDB2Feed/%                        | Analysis |       |       |
#      | MultipleIDDelete | Default | tools/CAEDDLoader/zOSDB2DDLoad/%                | Analysis |       |       |
#      | MultipleIDDelete | Default | cae/DB2zOSCollector/zOSDB2CollectorProcessDelete/% | Analysis |       |       |
#
#
#
#
#
#    #########################################ncrementals Scenario: Delete Data to zOS_DB2 Database and run the zOS_DB2 collector with PROCESSS AUTO and CAEDDLoader with CLEAR(FALSE) and INCREMENTAL(TRUE) and Negative(TRUE)###########################################################################################
#
#  @jdbc
#  Scenario:SC#10: drop Table for incremental scenario
#    Given user connects to the database and performs the following operation
#      | databaseConnection | Operation    | queryPath     | queryPage       | queryField              |
#      | zOS_DB2            | EXECUTEQUERY | json/IDA.json | zOS_DB2_Queries | dropViewForIncremental  |
#      | zOS_DB2            | EXECUTEQUERY | json/IDA.json | zOS_DB2_Queries | dropTableForIncremental |
#
#
#  Scenario Outline:SC10#Run the db2 Collector, feeder and loader plugin for Incremental
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                            | bodyFile                                                         | path                                 | response code | response message                   | jsonPath                                                                |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_zOS_DB2/zOS_DB2_DataSource                                                   | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_DataSource.json        | $.zOS_DB2_DataSource                 | 204           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_zOS_DB2/zOS_DB2_DataSource                                                   |                                                                  |                                      | 200           | zOS_DB2_DataSource                 |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO                                | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_Collector.json         | $.zOS_DB2_Collector_Incremental_AUTO | 204           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO                                |                                                                  |                                      | 200           | zOS_DB2_Collector_Incremental_AUTO |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO |                                                                  |                                      | 200           | IDLE                               | $.[?(@.configurationName=='zOS_DB2_Collector_Incremental_AUTO')].status |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO  | payloads/ida/CAE_zOS_DB2_Payloads/empty.json                     | $.emptyJson                          | 200           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO |                                                                  |                                      | 200           | IDLE                               | $.[?(@.configurationName=='zOS_DB2_Collector_Incremental_AUTO')].status |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Feeder_zOS_DB2_Cred                                                             |                                                                  |                                      | 200           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/zOS_DB2_Feeder_DS                                                             | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_Feeder_DataSource.json | $.zOS_DB2_Feeder_DataSource          | 204           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/zOS_DB2_Feeder_DS                                                             |                                                                  |                                      | 200           | zOS_DB2_Feeder_DS                  |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEFeed/zOS_DB2_Feeder                                                                      | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_Feeder.json            | $.zOS_DB2_Feeder                     | 204           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEFeed/zOS_DB2_Feeder                                                                      |                                                                  |                                      | 200           | zOS_DB2_Feeder                     |                                                                         |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEFeed/zOS_DB2_Feeder                                           |                                                                  |                                      | 200           | IDLE                               | $.[?(@.configurationName=='zOS_DB2_Feeder')].status                     |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/other/CAEFeed/zOS_DB2_Feeder                                            |                                                                  |                                      | 200           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEFeed/zOS_DB2_Feeder                                           |                                                                  |                                      | 200           | IDLE                               | $.[?(@.configurationName=='zOS_DB2_Feeder')].status                     |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/zOS_DB2_DDLoader_2                                                              | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_ETL.json               | $.zOS_DB2_DDLoader_2                 | 204           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/zOS_DB2_DDLoader_2                                                              |                                                                  |                                      | 200           | zOS_DB2_DDLoader_2                 |                                                                         |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/collector/CAEDDLoader/zOS_DB2_DDLoader_2                               |                                                                  |                                      | 200           | IDLE                               | $.[?(@.configurationName=='zOS_DB2_DDLoader_2')].status                 |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/collector/CAEDDLoader/zOS_DB2_DDLoader_2                                |                                                                  |                                      | 200           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/collector/CAEDDLoader/zOS_DB2_DDLoader_2                               |                                                                  |                                      | 200           | IDLE                               | $.[?(@.configurationName=='zOS_DB2_DDLoader_2')].status                 |
#
#
#  ##7198370##
#  @webtest
#  Scenario: SC#10: Validate the data type counts in db2 after running collector, Feed and CAEDDLoader for Incremental
#    Given Verify Analysis log "collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO/%" info/error/warning for below parameters
#      | assertion      | type | code           | logMessage                                                                 |
#      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =         69 |
#      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =         22 |
#      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =          2 |
#    And Analysis log "collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO/%" should display below info/error/warning
#      | type | logValue                                                                                                                                                      | logCode       | pluginName                | removableText |
#      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_zOS_DB2 Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_zOS_DB2 |               |
#      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                                | ANALYSIS-0020 | CAE_Collector_for_zOS_DB2 |               |
#    And Analysis log "collector/CAEDDLoader/zOS_DB2_DDLoader_2/%" should display below info/error/warning
#      | type | logValue                                                                                                                         | logCode       | pluginName  | removableText |
#      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
#      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                   | ANALYSIS-0020 | CAEDDLoader |               |
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "DV538A" and clicks on search
#    And user performs "facet selection" in "zOS_DB2_BA" attribute under "Tags" facets in Item Search results page
#    And user connects to data base and get count of below fields and compare with platform analysis count
#      | dataBaseName | dataBaseType | queryPath     | queryPage       | queryField              | columnName | queryOperation | facet         | facetValue | count      |
#      | zOS_DB2      | STRUCTURED   | json/IDA.json | zOS_DB2_Queries | getTableCountforDV538A  | COUNT      | returnValue    | Metadata Type | Table      | fromSource |
#      | zOS_DB2      | STRUCTURED   | json/IDA.json | zOS_DB2_Queries | getColumnCountforDV538A | COUNT      | returnValue    | Metadata Type | Column     | fromSource |
#
#
#  Scenario:SC#10:Delete Cluster and all the Analysis log for db2
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                                                                     | type     | query | param |
#      | MultipleIDDelete | Default | other/CAEFeed/zOS_DB2_Feeder/%                                           | Analysis |       |       |
#      | MultipleIDDelete | Default | collector/CAEDDLoader/zOS_DB2_DDLoader_2/%                               | Analysis |       |       |
#      | MultipleIDDelete | Default | collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO/% | Analysis |       |       |
#
#
#    ###############################################Incrementals Scenario: Add Data to zOS_DB2 Database and run the zOS_DB2 collector with PROCESSS AUTO and CAEDDLoader with CLEAR(FALSE) and INCREMENTAL(FALSE)###########################################################################################
#
#
#  @jdbc
#  Scenario:SC11: create Table for incremental scenario
#    Given user connects to the database and performs the following operation
#      | databaseConnection | Operation    | queryPath     | queryPage       | queryField                |
#      | zOS_DB2            | EXECUTEQUERY | json/IDA.json | zOS_DB2_Queries | createTableForIncremental |
#      | zOS_DB2            | EXECUTEQUERY | json/IDA.json | zOS_DB2_Queries | createViewForIncremental  |
#
#
#  Scenario Outline:SC11#Run the db2 Collector, feeder and loader plugin for Incremental
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                            | bodyFile                                                         | path                                 | response code | response message                   | jsonPath                                                                |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_zOS_DB2/zOS_DB2_DataSource                                                   | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_DataSource.json        | $.zOS_DB2_DataSource                 | 204           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_zOS_DB2/zOS_DB2_DataSource                                                   |                                                                  |                                      | 200           | zOS_DB2_DataSource                 |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO                                | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_Collector.json         | $.zOS_DB2_Collector_Incremental_AUTO | 204           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO                                |                                                                  |                                      | 200           | zOS_DB2_Collector_Incremental_AUTO |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO |                                                                  |                                      | 200           | IDLE                               | $.[?(@.configurationName=='zOS_DB2_Collector_Incremental_AUTO')].status |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO  | payloads/ida/CAE_zOS_DB2_Payloads/empty.json                     | $.emptyJson                          | 200           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO |                                                                  |                                      | 200           | IDLE                               | $.[?(@.configurationName=='zOS_DB2_Collector_Incremental_AUTO')].status |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Feeder_zOS_DB2_Cred                                                             |                                                                  |                                      | 200           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/zOS_DB2_Feeder_DS                                                             | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_Feeder_DataSource.json | $.zOS_DB2_Feeder_DataSource          | 204           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/zOS_DB2_Feeder_DS                                                             |                                                                  |                                      | 200           | zOS_DB2_Feeder_DS                  |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEFeed/zOS_DB2_Feeder                                                                      | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_Feeder.json            | $.zOS_DB2_Feeder                     | 204           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEFeed/zOS_DB2_Feeder                                                                      |                                                                  |                                      | 200           | zOS_DB2_Feeder                     |                                                                         |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEFeed/zOS_DB2_Feeder                                           |                                                                  |                                      | 200           | IDLE                               | $.[?(@.configurationName=='zOS_DB2_Feeder')].status                     |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/other/CAEFeed/zOS_DB2_Feeder                                            |                                                                  |                                      | 200           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEFeed/zOS_DB2_Feeder                                           |                                                                  |                                      | 200           | IDLE                               | $.[?(@.configurationName=='zOS_DB2_Feeder')].status                     |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/zOS_DB2_DDLoader_3                                                              | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_ETL.json               | $.zOS_DB2_DDLoader_3                 | 204           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/zOS_DB2_DDLoader_3                                                              |                                                                  |                                      | 200           | zOS_DB2_DDLoader_3                 |                                                                         |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/collector/CAEDDLoader/zOS_DB2_DDLoader_3                               |                                                                  |                                      | 200           | IDLE                               | $.[?(@.configurationName=='zOS_DB2_DDLoader_3')].status                 |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/collector/CAEDDLoader/zOS_DB2_DDLoader_3                                |                                                                  |                                      | 200           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/collector/CAEDDLoader/zOS_DB2_DDLoader_3                               |                                                                  |                                      | 200           | IDLE                               | $.[?(@.configurationName=='zOS_DB2_DDLoader_3')].status                 |
#
#  ##7198370##
#  @webtest
#  Scenario: SC#11: Validate the data type counts in db2 after running collector, Feed and CAEDDLoader for Incremental
#    Given Verify Analysis log "collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO/%" info/error/warning for below parameters
#      | assertion      | type | code           | logMessage                                                                 |
#      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =         71 |
#      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =         24 |
#      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =          0 |
#    And Analysis log "collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO/%" should display below info/error/warning
#      | type | logValue                                                                                                                                                      | logCode       | pluginName                | removableText |
#      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_zOS_DB2 Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_zOS_DB2 |               |
#      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                                | ANALYSIS-0020 | CAE_Collector_for_zOS_DB2 |               |
#    And Analysis log "collector/CAEDDLoader/zOS_DB2_DDLoader_3/%" should display below info/error/warning
#      | type | logValue                                                                                                                           | logCode       | pluginName  | removableText |
#      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:165, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
#      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                     | ANALYSIS-0020 | CAEDDLoader |               |
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "DV538A" and clicks on search
#    And user performs "facet selection" in "zOS_DB2_BA" attribute under "Tags" facets in Item Search results page
#    And user connects to data base and get count of below fields and compare with platform analysis count
#      | dataBaseName | dataBaseType | queryPath     | queryPage       | queryField              | columnName | queryOperation | facet         | facetValue | count      |
#      | zOS_DB2      | STRUCTURED   | json/IDA.json | zOS_DB2_Queries | getTableCountforDV538A  | COUNT      | returnValue    | Metadata Type | Table      | fromSource |
#      | zOS_DB2      | STRUCTURED   | json/IDA.json | zOS_DB2_Queries | getColumnCountforDV538A | COUNT      | returnValue    | Metadata Type | Column     | fromSource |
#
#
#  Scenario:SC#11:Delete Cluster and all the Analysis log for db2
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                                                                     | type     | query | param |
#      | MultipleIDDelete | Default | other/CAEFeed/zOS_DB2_Feeder/%                                           | Analysis |       |       |
#      | MultipleIDDelete | Default | collector/CAEDDLoader/zOS_DB2_DDLoader_3/%                               | Analysis |       |       |
#      | MultipleIDDelete | Default | collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO/% | Analysis |       |       |
#
#
#    ##########################################Incrementals Scenario: Remove Data from zOS_DB2 Database and run the sybase collector with PROCESSS AUTO and CAEDDLoader with CLEAR(FALSE) and INCREMENTAL(FALSE) and Negative(TRUE)###########################################################################################
#
#  @jdbc
#  Scenario:SC#12: drop Table for incremental scenario
#    Given user connects to the database and performs the following operation
#      | databaseConnection | Operation    | queryPath     | queryPage       | queryField              |
#      | zOS_DB2            | EXECUTEQUERY | json/IDA.json | zOS_DB2_Queries | dropViewForIncremental  |
#      | zOS_DB2            | EXECUTEQUERY | json/IDA.json | zOS_DB2_Queries | dropTableForIncremental |
#
#
#  Scenario Outline:SC12#Run the db2 Collector, feeder and loader plugin for Incremental
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                            | bodyFile                                                         | path                                 | response code | response message                   | jsonPath                                                                |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_zOS_DB2/zOS_DB2_DataSource                                                   | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_DataSource.json        | $.zOS_DB2_DataSource                 | 204           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_zOS_DB2/zOS_DB2_DataSource                                                   |                                                                  |                                      | 200           | zOS_DB2_DataSource                 |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO                                | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_Collector.json         | $.zOS_DB2_Collector_Incremental_AUTO | 204           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO                                |                                                                  |                                      | 200           | zOS_DB2_Collector_Incremental_AUTO |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO |                                                                  |                                      | 200           | IDLE                               | $.[?(@.configurationName=='zOS_DB2_Collector_Incremental_AUTO')].status |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO  | payloads/ida/CAE_zOS_DB2_Payloads/empty.json                     | $.emptyJson                          | 200           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO |                                                                  |                                      | 200           | IDLE                               | $.[?(@.configurationName=='zOS_DB2_Collector_Incremental_AUTO')].status |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Feeder_zOS_DB2_Cred                                                             |                                                                  |                                      | 200           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/zOS_DB2_Feeder_DS                                                             | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_Feeder_DataSource.json | $.zOS_DB2_Feeder_DataSource          | 204           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/zOS_DB2_Feeder_DS                                                             |                                                                  |                                      | 200           | zOS_DB2_Feeder_DS                  |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEFeed/zOS_DB2_Feeder                                                                      | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_Feeder.json            | $.zOS_DB2_Feeder                     | 204           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEFeed/zOS_DB2_Feeder                                                                      |                                                                  |                                      | 200           | zOS_DB2_Feeder                     |                                                                         |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEFeed/zOS_DB2_Feeder                                           |                                                                  |                                      | 200           | IDLE                               | $.[?(@.configurationName=='zOS_DB2_Feeder')].status                     |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/other/CAEFeed/zOS_DB2_Feeder                                            |                                                                  |                                      | 200           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEFeed/zOS_DB2_Feeder                                           |                                                                  |                                      | 200           | IDLE                               | $.[?(@.configurationName=='zOS_DB2_Feeder')].status                     |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/zOS_DB2_DDLoader_4                                                              | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_ETL.json               | $.zOS_DB2_DDLoader_4                 | 204           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/zOS_DB2_DDLoader_4                                                              |                                                                  |                                      | 200           | zOS_DB2_DDLoader_4                 |                                                                         |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/collector/CAEDDLoader/zOS_DB2_DDLoader_4                               |                                                                  |                                      | 200           | IDLE                               | $.[?(@.configurationName=='zOS_DB2_DDLoader_4')].status                 |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/collector/CAEDDLoader/zOS_DB2_DDLoader_4                                |                                                                  |                                      | 200           |                                    |                                                                         |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/collector/CAEDDLoader/zOS_DB2_DDLoader_4                               |                                                                  |                                      | 200           | IDLE                               | $.[?(@.configurationName=='zOS_DB2_DDLoader_4')].status                 |
#
#
#  ##7198370##
#  @webtest
#  Scenario: SC#12: Validate the data type counts in db2 after running collector, Feed and CAEDDLoader for Incremental
#    Given Verify Analysis log "collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO/%" info/error/warning for below parameters
#      | assertion      | type | code           | logMessage                                                                 |
#      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =         69 |
#      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =         22 |
#      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =          2 |
#    And Analysis log "collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO/%" should display below info/error/warning
#      | type | logValue                                                                                                                                                      | logCode       | pluginName                | removableText |
#      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_zOS_DB2 Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_zOS_DB2 |               |
#      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                                | ANALYSIS-0020 | CAE_Collector_for_zOS_DB2 |               |
#    And Analysis log "collector/CAEDDLoader/zOS_DB2_DDLoader_4/%" should display below info/error/warning
#      | type | logValue                                                                                                                           | logCode       | pluginName  | removableText |
#      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:160, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
#      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                     | ANALYSIS-0020 | CAEDDLoader |               |
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "DV538A" and clicks on search
#    And user performs "facet selection" in "zOS_DB2_BA" attribute under "Tags" facets in Item Search results page
#    And user connects to data base and get count of below fields and compare with platform analysis count
#      | dataBaseName | dataBaseType | queryPath     | queryPage       | queryField              | columnName | queryOperation | facet         | facetValue | count      |
#      | zOS_DB2      | STRUCTURED   | json/IDA.json | zOS_DB2_Queries | getTableCountforDV538A  | COUNT      | returnValue    | Metadata Type | Table      | fromSource |
#      | zOS_DB2      | STRUCTURED   | json/IDA.json | zOS_DB2_Queries | getColumnCountforDV538A | COUNT      | returnValue    | Metadata Type | Column     | fromSource |
#
#
#  Scenario:SC#12:Delete Cluster and all the Analysis log for db2
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                                                                     | type     | query | param |
#      | MultipleIDDelete | Default | other/CAEFeed/zOS_DB2_Feeder/%                                           | Analysis |       |       |
#      | MultipleIDDelete | Default | collector/CAEDDLoader/zOS_DB2_DDLoader_4/%                               | Analysis |       |       |
#      | MultipleIDDelete | Default | collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO/% | Analysis |       |       |
#
#
#
#
#    #############################################################Lineage Verfication for zOS_DB2############################################################################################
#
#  ##7198368##
#  Scenario: SC#13 update the Lineage tags to the data items
#    Given user updates the tags to the data items in DD
#      | firstItemType | item hierarchy                           | tableName                                                              | LineageFor | getTagsPayloadURL              | bodyFile1                                             | assignTagsURL            | bodyFile2                                          | jsonPath1                                                | jsonPath2                                               | jsonValue |
#      | Cluster       | MVSSYSA.ASG.COM,DB2:6203,NA01DC1A,DV538A | DB2_VIEWTOSINGLETABLE,DB2_SINGLEVIEWTOVIEW,ORDERS_TABLE,PAYMENTS_TABLE | Column     | tags/Default/items/assignments | payloads/ida/CAE_zOS_DB2_Payloads/columnsPayload.json | tags/Default/assignments | payloads/ida/CAE_zOS_DB2_Payloads/tagsPayload.json | $..[?(@.name=='Backward Lineage Candidate')].cardinality | $..[?(@.name=='Forward Lineage Candidate')].cardinality | ALL       |
#
#
#  ##7198368##
#  Scenario Outline: SC#13: Configure and run the CAELineage Plugin.
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                  | bodyFile                                               | path          | response code | response message | jsonPath                                         |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAELineage/db2_Lineage                            | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_Lineage.json | $.db2_Lineage | 204           |                  |                                                  |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAELineage/db2_Lineage                            |                                                        |               | 200           | db2_Lineage      |                                                  |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAELineage/db2_Lineage |                                                        |               | 200           | IDLE             | $.[?(@.configurationName=='db2_Lineage')].status |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/other/CAELineage/db2_Lineage  | payloads/ida/CAE_zOS_DB2_Payloads/empty.json           | $.emptyJson   | 200           |                  |                                                  |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAELineage/db2_Lineage |                                                        |               | 200           | IDLE             | $.[?(@.configurationName=='db2_Lineage')].status |
#
#  ##7198368##
#  Scenario Outline: user retrieves ids for specific item name
#    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>"
#    Examples:
#      | database      | catalog | name                    | type  | targetFile                                                       |
#      | APPDBPOSTGRES | Default | DB2_VIEWTOSINGLETABLE   | Table | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/tableIDs.json |
#      | APPDBPOSTGRES | Default | DB2_SINGLEVIEWTOVIEW    | Table | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/tableIDs.json |
#      | APPDBPOSTGRES | Default | DB2_VIEWTOMULTIPLETABLE | Table | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/tableIDs.json |
#      | APPDBPOSTGRES | Default | ORDERS_TABLE            | Table | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/tableIDs.json |
#      | APPDBPOSTGRES | Default | PAYMENTS_TABLE          | Table | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/tableIDs.json |
#
#
#  ##7198368##
#  Scenario Outline: user copy the id to payload
#    Given user copy the id from "<file>" to "<payloadFile>" with "<type>" using "<jsonPath>"
#    Examples:
#      | file                                                             | payloadFile                                                              | type  | jsonPath                   |
#      | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/zOS_DB2/payloads/DB2_VIEWTOSINGLETABLE.json   | Table | $..DB2_VIEWTOSINGLETABLE   |
#      | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/zOS_DB2/payloads/DB2_SINGLEVIEWTOVIEW.json    | Table | $..DB2_SINGLEVIEWTOVIEW    |
#      | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/zOS_DB2/payloads/DB2_VIEWTOMULTIPLETABLE.json | Table | $..DB2_VIEWTOMULTIPLETABLE |
#      | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/zOS_DB2/payloads/ORDERS_TABLE.json            | Table | $..ORDERS_TABLE            |
#      | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/zOS_DB2/payloads/PAYMENTS_TABLE.json          | Table | $..PAYMENTS_TABLE          |
#
#
#  ##7198368##
#  Scenario Outline: user get the response of lineage edges and store the lineage values in file
#    Given user hits "<request>" with "<url>" "<body>" for id from "<file>" "<type>" using "<path>" and verify "<statusCode>" and store response of "<jsonPath>" in "<targetFile>" for "<name>"
#    Examples:
#      | request | url                                                                               | body                                                                     | file                                                             | type | path                       | statusCode | jsonPath   | targetFile                                                                      | name                    |
#      | Post    | lineages/Default?dir=OUT&what=id,type,name,catalog&excludeUnusedViewColumns=false | Constant.REST_DIR/response/zOS_DB2/payloads/DB2_VIEWTOSINGLETABLE.json   | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/tableIDs.json | List | $..DB2_VIEWTOSINGLETABLE   | 200        | $..edges.* | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/DB2_VIEWTOSINGLETABLE.json   | DB2_VIEWTOSINGLETABLE   |
#      | Post    | lineages/Default?dir=OUT&what=id,type,name,catalog&excludeUnusedViewColumns=false | Constant.REST_DIR/response/zOS_DB2/payloads/DB2_SINGLEVIEWTOVIEW.json    | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/tableIDs.json | List | $..DB2_SINGLEVIEWTOVIEW    | 200        | $..edges.* | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/DB2_SINGLEVIEWTOVIEW.json    | DB2_SINGLEVIEWTOVIEW    |
#      | Post    | lineages/Default?dir=OUT&what=id,type,name,catalog&excludeUnusedViewColumns=false | Constant.REST_DIR/response/zOS_DB2/payloads/DB2_VIEWTOMULTIPLETABLE.json | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/tableIDs.json | List | $..DB2_VIEWTOMULTIPLETABLE | 200        | $..edges.* | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/DB2_VIEWTOMULTIPLETABLE.json | DB2_VIEWTOMULTIPLETABLE |
#      | Post    | lineages/Default?dir=OUT&what=id,type,name,catalog&excludeUnusedViewColumns=false | Constant.REST_DIR/response/zOS_DB2/payloads/ORDERS_TABLE.json            | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/tableIDs.json | List | $..ORDERS_TABLE            | 200        | $..edges.* | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/ORDERS_TABLE.json            | ORDERS_TABLE            |
#      | Post    | lineages/Default?dir=OUT&what=id,type,name,catalog&excludeUnusedViewColumns=false | Constant.REST_DIR/response/zOS_DB2/payloads/PAYMENTS_TABLE.json          | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/tableIDs.json | List | $..PAYMENTS_TABLE          | 200        | $..edges.* | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/PAYMENTS_TABLE.json          | PAYMENTS_TABLE          |
#
#
#  ##7198368##
#  Scenario Outline: user retrieve the name of id for each value stored in lineage data file
#    Given user gets the name for each id stored in "<LineageFile>" under "<TableName>" and replace the id with name
#    Examples:
#      | LineageFile                                                                     | TableName               |
#      | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/DB2_VIEWTOSINGLETABLE.json   | DB2_VIEWTOSINGLETABLE   |
#      | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/DB2_SINGLEVIEWTOVIEW.json    | DB2_SINGLEVIEWTOVIEW    |
#      | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/DB2_VIEWTOMULTIPLETABLE.json | DB2_VIEWTOMULTIPLETABLE |
#      | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/ORDERS_TABLE.json            | ORDERS_TABLE            |
#      | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/PAYMENTS_TABLE.json          | PAYMENTS_TABLE          |
#
#
#  ##7198368##
#  Scenario Outline: user compares the expected lineage data and actual lineage data
#    Given user json assert between "<expectedJson>" data and "<actualJson>" data
#    Examples:
#      | expectedJson                                                                      | actualJson                                                                      |
#      | Constant.REST_DIR/response/zOS_DB2/expectedJsonFiles/DB2_VIEWTOSINGLETABLE.json   | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/DB2_VIEWTOSINGLETABLE.json   |
#      | Constant.REST_DIR/response/zOS_DB2/expectedJsonFiles/DB2_SINGLEVIEWTOVIEW.json    | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/DB2_SINGLEVIEWTOVIEW.json    |
#      | Constant.REST_DIR/response/zOS_DB2/expectedJsonFiles/DB2_VIEWTOMULTIPLETABLE.json | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/DB2_VIEWTOMULTIPLETABLE.json |
#      | Constant.REST_DIR/response/zOS_DB2/expectedJsonFiles/ORDERS_TABLE.json            | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/ORDERS_TABLE.json            |
#      | Constant.REST_DIR/response/zOS_DB2/expectedJsonFiles/PAYMENTS_TABLE.json          | Constant.REST_DIR/response/zOS_DB2/actualJsonFiles/PAYMENTS_TABLE.json          |
#
#
#    ############################################End of Lineage Case##########################################################################
#
#  ##Need to Test From here####################
#  ########################################Technology Restriction Verification#############################################################3
#
#  Scenario Outline:SC14#Run the sybase Collector, feeder and loader plugin for adding additional technology to entry point
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                     | bodyFile                                                               | path                           | response code | response message             | jsonPath                                                          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/Valid_sybase_Cred                                                                  | payloads/ida/CAE_zOS_DB2_Payloads/Credentials/zOS_DB2_credentials.json | $.valid_sybase                 | 200           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_sybase_Cred                                                                  |                                                                        |                                | 200           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_Sybase/sybase_DataSource_Testing_DB                                   | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_DataSource.json              | $.sybase_DataSource_Testing_DB | 204           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_Sybase/sybase_DataSource_Testing_DB                                   |                                                                        |                                | 200           | sybase_DataSource_Testing_DB |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Incremental                                | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_Collector.json               | $.sybase_Collector_Incremental | 204           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Incremental                                |                                                                        |                                | 200           | sybase_Collector_Incremental |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental |                                                                        |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Collector_Incremental')].status |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/HeadlessEDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental  | payloads/ida/CAE_zOS_DB2_Payloads/empty.json                           | $.emptyJson                    | 200           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/HeadlessEDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental |                                                                        |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Collector_Incremental')].status |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Feeder_zOS_DB2_Cred                                                      |                                                                        |                                | 200           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/zOS_DB2_Feeder_DS                                                      | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_Feeder_DataSource.json       | $.zOS_DB2_Feeder_DataSource    | 204           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/zOS_DB2_Feeder_DS                                                      |                                                                        |                                | 200           | zOS_DB2_Feeder_DS            |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEFeed/zOS_DB2_Feeder                                                               | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_Feeder.json                  | $.zOS_DB2_Feeder               | 204           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEFeed/zOS_DB2_Feeder                                                               |                                                                        |                                | 200           | zOS_DB2_Feeder               |                                                                   |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEFeed/zOS_DB2_Feeder                                    |                                                                        |                                | 200           | IDLE                         | $.[?(@.configurationName=='zOS_DB2_Feeder')].status               |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/other/CAEFeed/zOS_DB2_Feeder                                     |                                                                        |                                | 200           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEFeed/zOS_DB2_Feeder                                    |                                                                        |                                | 200           | IDLE                         | $.[?(@.configurationName=='zOS_DB2_Feeder')].status               |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/zOS_DB2_DDLoader                                                         | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_ETL.json                     | $.zOS_DB2_DDLoader             | 204           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/zOS_DB2_DDLoader                                                         |                                                                        |                                | 200           | zOS_DB2_DDLoader             |                                                                   |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/collector/CAEDDLoader/zOS_DB2_DDLoader                          |                                                                        |                                | 200           | IDLE                         | $.[?(@.configurationName=='zOS_DB2_DDLoader')].status             |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/collector/CAEDDLoader/zOS_DB2_DDLoader                           |                                                                        |                                | 200           |                              |                                                                   |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/collector/CAEDDLoader/zOS_DB2_DDLoader                          |                                                                        |                                | 200           | IDLE                         | $.[?(@.configurationName=='zOS_DB2_DDLoader')].status             |
#
#
#  ##7198369##
#  @webtest
#  Scenario: Verify if the DB2 Items and Sybase Items are Loaded from the EntryPoint
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "zOS_DB2_BA" and clicks on search
#    And user performs "facet selection" in "zOS_DB2_BA" attribute under "Tags" facets in Item Search results page
#    And user connects to data base and get count of below fields and compare with platform analysis count
#      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
#      |              |              |           |           |            |            |                | Metadata Type | Table      | 82    |
#    And user enters the search text "DB2_VIEWTOSINGLETABLE" and clicks on search
#    And user performs "facet selection" in "zOS_DB2_BA" attribute under "Tags" facets in Item Search results page
#    And user performs "item click" on "DB2_VIEWTOSINGLETABLE" item from search results
#    And user enters the search text "SYBASE_VIEWTOSINGLETABLE" and clicks on search
#    And user performs "facet selection" in "zOS_DB2_BA" attribute under "Tags" facets in Item Search results page
#    And user performs "item click" on "SYBASE_VIEWTOSINGLETABLE" item from search results
#
#
#  Scenario Outline:SC14#Run the CAEDDLoader loader plugin with Technology Restriction
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                   | bodyFile                                           | path                                      | response code | response message                        | jsonPath                                                                     |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/zOS_DB2_DDLoader_Technology_Restriction                                | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_ETL.json | $.zOS_DB2_DDLoader_Technology_Restriction | 204           |                                         |                                                                              |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/zOS_DB2_DDLoader_Technology_Restriction                                |                                                    |                                           | 200           | zOS_DB2_DDLoader_Technology_Restriction |                                                                              |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/collector/CAEDDLoader/zOS_DB2_DDLoader_Technology_Restriction |                                                    |                                           | 200           | IDLE                                    | $.[?(@.configurationName=='zOS_DB2_DDLoader_Technology_Restriction')].status |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/collector/CAEDDLoader/zOS_DB2_DDLoader_Technology_Restriction  |                                                    |                                           | 200           |                                         |                                                                              |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/collector/CAEDDLoader/zOS_DB2_DDLoader_Technology_Restriction |                                                    |                                           | 200           | IDLE                                    | $.[?(@.configurationName=='zOS_DB2_DDLoader_Technology_Restriction')].status |
#
#
#  ##7198369##
#  @webtest
#  Scenario: Verify only the DB2 Items are Loaded from the EntryPoint when Technology Restriction is set to TRUE
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "DV538A" and clicks on search
#    And user performs "facet selection" in "zOS_DB2_BA" attribute under "Tags" facets in Item Search results page
#    And user connects to data base and get count of below fields and compare with platform analysis count
#      | dataBaseName | dataBaseType | queryPath     | queryPage       | queryField             | columnName | queryOperation | facet         | facetValue | count      |
#      | zOS_DB2      | STRUCTURED   | json/IDA.json | zOS_DB2_Queries | getTableCountforDV538A | COUNT      | returnValue    | Metadata Type | Table      | fromSource |
#    And user enters the search text "DB2_VIEWTOSINGLETABLE" and clicks on search
#    And user performs "facet selection" in "zOS_DB2_BA" attribute under "Tags" facets in Item Search results page
#    And user performs "item click" on "DB2_VIEWTOSINGLETABLE" item from search results
#    And user enters the search text "SYBASE_VIEWTOSINGLETABLE" and clicks on search
#    Then user "verify non presence" of following "Values" in Search Results Page
#      | SYBASE_VIEWTOSINGLETABLE | No data found |
#
#
#  Scenario:SC#14:Delete Cluster and all the Analysis log for db2
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                                                              | type     | query | param |
#      | MultipleIDDelete | Default | other/CAEFeed/zOS_DB2_Feeder/%                                    | Analysis |       |       |
#      | MultipleIDDelete | Default | collector/CAEDDLoader/zOS_DB2_DDLoader/%                          | Analysis |       |       |
#      | MultipleIDDelete | Default | collector/CAEDDLoader/zOS_DB2_DDLoader_Technology_Restriction/%   | Analysis |       |       |
#      | MultipleIDDelete | Default | collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental/% | Analysis |       |       |
#      | MultipleIDDelete | Default | other/CAECreateEntryPoint/zOS_DB2_Creator/%                       | Analysis |       |       |
#
#    ############################################################CAEDeletor plugin for zOS_DB2 ############################################################
#  Scenario Outline:SC5# Run the CAE Deletor plugin for zOS_DB2
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                               | bodyFile                                                                  | path                         | response code | response message           | jsonPath                                             |
#      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Creator_Deletor_zOS_DB2_Cred                       |                                                                           |                              | 200           |                            |                                                      |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/zOS_DB2_Creator_Deletor_DS                       | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_Creator_Deletor_DataSource.json | $.zOS_DB2_Creator_Deletor_DS | 204           |                            |                                                      |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/zOS_DB2_Creator_Deletor_DS                       |                                                                           |                              | 200           | zOS_DB2_Creator_Deletor_DS |                                                      |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDeleteEntryPoint/zOS_DB2_Deletor                            | payloads/ida/CAE_zOS_DB2_Payloads/zOS_DB2_Creator_Deletor.json            | $.zOS_DB2_Deletor            | 204           |                            |                                                      |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDeleteEntryPoint/zOS_DB2_Deletor                            |                                                                           |                              | 200           | zOS_DB2_Deletor            |                                                      |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEDeleteEntryPoint/zOS_DB2_Deletor |                                                                           |                              | 200           | IDLE                       | $.[?(@.configurationName=='zOS_DB2_Deletor')].status |
#      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/other/CAEDeleteEntryPoint/zOS_DB2_Deletor  |                                                                           |                              | 200           |                            |                                                      |
#      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/other/CAEDeleteEntryPoint/zOS_DB2_Deletor |                                                                           |                              | 200           | IDLE                       | $.[?(@.configurationName=='zOS_DB2_Deletor')].status |
#
#
#  ####
#  Scenario:SC#15: Validate the logs of CAEDelteEntryPoint Plugin
#    Given Verify Analysis log "other/CAEDeleteEntryPoint/zOS_DB2_Deletor/%" info/error/warning for below parameters
#      | assertion      | type | code           | logMessage                                         |
#      | should contain | INFO | DBW-INF-006102 | DBW-INF-006102 (0000021544) : Entry point deleted. |
#    And Analysis log "other/CAEDeleteEntryPoint/zOS_DB2_Deletor/%" should display below info/error/warning
#      | type | logValue                                                                                                                                                | logCode       | pluginName          | removableText |
#      | INFO | ANALYSIS-0072: Plugin CAEDeleteEntryPoint Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDeleteEntryPoint |               |
#      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                          | ANALYSIS-0020 | CAEDeleteEntryPoint |               |
#    And user delete all "Analysis" log with name "other/CAEDeleteEntryPoint/zOS_DB2_Deletor%" using database
#
#
#  Scenario:SC#14:Delete Cluster and BusinessApplication Tag
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                 | type                | query | param |
#      | SingleItemDelete | Default | MVSSYSA.ASG.COM      | Cluster             |       |       |
#      | SingleItemDelete | Default | GECHCAE-COL1.ASG.COM | Cluster             |       |       |
#      | SingleItemDelete | Default | zOS_DB2_CREATOR_BA   | BusinessApplication |       |       |
#      | SingleItemDelete | Default | zOS_DB2_BA           | BusinessApplication |       |       |
#      | SingleItemDelete | Default | zOS_DB2_FEEDER_BA    | BusinessApplication |       |       |
#      | SingleItemDelete | Default | zOS_DB2_LOADER_BA    | BusinessApplication |       |       |
#      | SingleItemDelete | Default | zOS_DB2_LINEAGE_BA   | BusinessApplication |       |       |
#      | SingleItemDelete | Default | zOS_DB2_DELETOR_BA   | BusinessApplication |       |       |
#
#
#  @jdbc
#  Scenario Outline:SC#15_Delete Plugin Configuration
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                                                | body | response code | response message | jsonPath |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Valid_sybase_Cred                                                             |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Valid_zOS_DB2_Cred                                                            |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Invalid_zOS_DB2_Cred                                                          |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Valid_CAE_Creator_Deletor_zOS_DB2_Cred                                        |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Valid_CAE_Feeder_zOS_DB2_Cred                                                 |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDataSource/zOS_DB2_Feeder_DS                                                 |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDataSource/zOS_DB2_Creator_Deletor_DS                                        |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/DataSource_for_Sybase/sybase_DataSource_Testing_DB                              |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/DataSource_for_zOS_DB2/zOS_DB2_DataSource                                       |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_InvalidCredentials                  |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Include_SchemaInConfigLines         |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Exclude_SchemaInConfigLines         |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Include_Exclude_SchemaInConfigLines |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Process_DELETE                      |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_LOAD                    |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Incremental_AUTO                    |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector                                     |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Incremental                           |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDDLoader/zOS_DB2_DDLoader                                                    |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDDLoader/zOS_DB2_DDLoader_1                                                  |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDDLoader/zOS_DB2_DDLoader_2                                                  |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDDLoader/zOS_DB2_DDLoader_3                                                  |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDDLoader/zOS_DB2_DDLoader_4                                                  |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDDLoader/zOS_DB2_DDLoader_Technology_Restriction                             |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAECreateEntryPoint/zOS_DB2_Creator                                             |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDeleteEntryPoint/zOS_DB2_Deletor                                             |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEFeed/zOS_DB2_Feeder                                                          |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAELineage/db2_Lineage                                                          |      | 204           |                  |          |
#

#    ##################################DataSource Test connection for Valid and Invalid Credentials##############################
#
#  ##7154060##
#  @webtest @negative
#  Scenario:SC#1_Verify whether the background of the panel is displayed in red when connection to DataSource is unsuccessful due to invalid credential/Invalid Host/Invalid Database name in CAE Node (DataSource plugin)
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem                   |
#      | click      | Capture And Import Data Icon |
#      | click      | Manage Data Sources          |
#    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName        | attribute              |
#      | Data Source Type | DataSource_for_zOS_DB2 |
#      | Credential       | Invalid_zOS_DB2_Cred   |
#      | Node             | HeadlessEDI            |
#    And user "enter text" in Add Data Source Page
#      | fieldName     | attribute                                |
#      | Name          | Invalid_zOS_DB2_DataSourceTest           |
#      | Label         | Invalid_zOS_DB2_DataSourceTest           |
#      | url           | jdbc:db2://mvssysa.asg.com:6203/NA01DC1A |
#      | DB2 subsystem | DC1A                                     |
#    And user "click" on "Test Connection" button in "Add Data Sources Page"
#    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName  | attribute          |
#      | Credential | Valid_zOS_DB2_Cred |
#    And user "enter text" in Add Data Source Page
#      | fieldName | attribute                            |
#      | url       | jdbc:db2://mvs.asg.com:6203/NA01DC1A |
#    And user "click" on "Test Connection" button in "Add Data Sources Page"
#    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
#    And user "enter text" in Add Data Source Page
#      | fieldName | attribute                            |
#      | url       | jdbc:db2://mvssysa.asg.com:6203/NA01 |
#    And user "click" on "Test Connection" button in "Add Data Sources Page"
#    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
#
#
#  ##7154061## ##7143218##
#  @positve @regression @sanity @webtest
#  Scenario:SC#1_Verify whether the background of the panel is displayed in green when connection to DataSource is successful due to valid credential in CAE Node (DataSource Plugin)
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem                   |
#      | click      | Capture And Import Data Icon |
#      | click      | Manage Data Sources          |
#    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName        | attribute              |
#      | Data Source Type | DataSource_for_zOS_DB2 |
#      | Credential       | Valid_zOS_DB2_Cred     |
#      | Node             | HeadlessEDI            |
#    And user "enter text" in Add Data Source Page
#      | fieldName     | attribute                                |
#      | Name          | Valid_zOS_DB2_DataSourceTest             |
#      | Label         | Valid_zOS_DB2_DataSourceTest             |
#      | url           | jdbc:db2://mvssysa.asg.com:6203/NA01DC1A |
#      | DB2 subsystem | DC1A                                     |
#    And user "click" on "Test Connection" button in "Add Data Sources Page"
#    And user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
#    And user "click" on "Save" button in "Add Data Sources Page"
#
#
#    ########################################################DataSource Test connection in Plugin Config with Valid and Invalid Credentials###############################################################
#
#
#  ##7154102##
#  @webtest
#  Scenario:SC#2_Verify wheather the background in the Cataloger panel is red when connection is unsuccessful due to Invalid Credentials
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem                   |
#      | click      | Capture And Import Data Icon |
#      | click      | Manage Configurations        |
#    And user performs "click" operation in Manage Configurations panel
#      | button          | actionItem  |
#      | Open Deployment | HeadlessEDI |
#    And user "click" on "Add Configuration" button under "HeadlessEDI" in Manage Configurations
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName  | attribute                 |
#      | Type       | Collector                 |
#      | Plugin     | CAE_Collector_for_zOS_DB2 |
#      | Credential | Invalid_zOS_DB2_Cred      |
#    And user "enter text" in Add Data Source Page
#      | fieldName | attribute              |
#      | Name      | zOS_DB2_Collector_Test |
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName   | attribute                    |
#      | Data Source | Valid_zOS_DB2_DataSourceTest |
#      | Credential  | Invalid_zOS_DB2_Cred         |
#    And user "click" on "Test Connection" button in "Add Data Sources Page"
#    And user verifies "Failed datasource connection" is "displayed" in "Add Configuration Sources Page"
#
#
#  ##7154104## ##7143219##
#  @webtest
#  Scenario:SC#2_Verify whether the background in the Cataloger panel is green when connection is successful due to valid Credentials
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem                   |
#      | click      | Capture And Import Data Icon |
#      | click      | Manage Configurations        |
#    And user performs "click" operation in Manage Configurations panel
#      | button          | actionItem  |
#      | Open Deployment | HeadlessEDI |
#    And user "click" on "Add Configuration" button under "HeadlessEDI" in Manage Configurations
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName  | attribute                 |
#      | Type       | Collector                 |
#      | Plugin     | CAE_Collector_for_zOS_DB2 |
#      | Credential | Valid_zOS_DB2_Cred        |
#    And user "enter text" in Add Data Source Page
#      | fieldName | attribute              |
#      | Name      | zOS_DB2_Collector_Test |
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName   | attribute                    |
#      | Data Source | Valid_zOS_DB2_DataSourceTest |
#      | Credential  | Valid_zOS_DB2_Cred           |
#    And user "click" on "Test Connection" button in "Add Data Sources Page"
#    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"
#    And user "click" on "Save" button in "Add Configuration Sources Page"
#
#
#    ############################################################Verify Mandatory Error Message in zOS_DB2 Datasource and Collector plugin####################################################################
#
#  ##7143220##
#  @webtest @jdbc
#  Scenario:SC#3_Verify proper error message is shown if mandatory fields are not filled in zOS_DB2_DataSource plugin configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem                   |
#      | click      | Capture And Import Data Icon |
#      | click      | Manage Data Sources          |
#    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName        | attribute              |
#      | Data Source Type | DataSource_for_zOS_DB2 |
#    And user "enter text" in Add Data Source Page
#      | fieldName | attribute |
#      | Name      |           |
#      | url       | A         |
#    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
#      | fieldName | errorMessage                                                                                      |
#      | url       | UnSupported DB2 JDBC URL Format. Sample Format : jdbc:db2//@<<hostname>>:<<port>>/<<db2location>> |
#    And user press "BACK_SPACE" key using key press event
#    And user press "TAB" key using key press event
#    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
#      | fieldName | errorMessage                   |
#      | Name      | Name field should not be empty |
#      | url       | url field should not be empty  |
#    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
#
#
#   ##7143221##
#  @webtest @jdbc
#  Scenario:SC#3_Verify proper error message is shown if mandatory fields are not filled in CAE_Collector_for_zOS_DB2 plugin configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType | actionItem                   |
#      | click      | Capture And Import Data Icon |
#      | click      | Manage Configurations        |
#    And user performs "click" operation in Manage Configurations panel
#      | button          | actionItem  |
#      | Open Deployment | HeadlessEDI |
#    And user "click" on "Add Configuration" button under "HeadlessEDI" in Manage Configurations
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute                 |
#      | Type      | Collector                 |
#      | Plugin    | CAE_Collector_for_zOS_DB2 |
#    And user "enter text" in Add Data Source Page
#      | fieldName | attribute |
#      | Name      |           |
#    And user press "TAB" key using key press event
#    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
#      | fieldName | errorMessage                   |
#      | Name      | Name field should not be empty |
#    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
#
#
#  @webtest
#  Scenario:SC3#Verify presence of configuration fields for zOS_DB2 Collector
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Add Data source Configuration"
#    And user performs "click" operation in Manage Configurations panel
#      | button            | actionItem  |
#      | Open Deployment   | HeadlessEDI |
#      | Add Configuration |             |
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName | attribute                 |
#      | Type      | Collector                 |
#      | Plugin    | CAE_Collector_for_zOS_DB2 |
#    Then user "Verify the presnce of captions" in Plugin Configuration page
#      | Name*                |
#      | Label                |
#      | Business Application |
#    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
#    Then user "Verify the presnce of captions" in Plugin Configuration page
#      | Plugin version      |
#      | Event condition     |
#      | Tags                |
#      | Configuration Lines |
#      | DEBUG               |
#      | JAVA_MEMORY_HEAP_1  |
#      | JAVA_MEMORY_HEAP_2  |
#
