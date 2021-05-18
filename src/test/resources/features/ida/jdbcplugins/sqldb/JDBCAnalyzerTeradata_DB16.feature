Feature:Verification of JDBC Analyzer using Teradata database Version 16 and plugin validation

  ############################################ Pre Conditions ##########################################################
  @jdbc
  Scenario: SC#1-Create User in TeradataDatabase
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField             |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createUserInTeradataDB |

  @jdbc
  Scenario: SC#1-Create Database in TeradataDatabase
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField         |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createDBinTeradata |

  @jdbc
  Scenario: SC#1-Create User permission in TeradataDatabase
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField          |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | grantUserPermission |

  @jdbc
  Scenario: SC#1-Create Table in Teradata
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField                |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createConstraintTable     |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createEmptyTimeStampTable |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createUniqueConstraint    |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createPrimaryConstraint   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createForeignConstraint   |

  @jdbc
  Scenario: SC#1-Create Table and insert value for data sampling
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField    |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createTable   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord1 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord2 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord3 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord4 |


  @jdbc
  Scenario: SC#1-Create table for Timestamp verification
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField            |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createTimeStampTable  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertTimeStampRecord |


  @jdbc
  Scenario Outline: SC#1: Set the credential and DataSource for Teradata
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | body                                                                                      | response code | response message                        | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/TeradataCredentials                                                | ida/jdbcAnalyzerPayloads/Teradata/Credentials/TeradataCredentials.json                    | 200           |                                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/TeradataCredentials                                                |                                                                                           | 200           |                                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/TeradataInvalidCredentials                                         | ida/jdbcAnalyzerPayloads/Teradata/Credentials/TeradataInvalidCredentials.json             | 200           |                                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/TeradataInvalidCredentials                                         |                                                                                           | 200           |                                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/TeradataEmptyCredentials                                           | ida/jdbcAnalyzerPayloads/Teradata/Credentials/TeradataEmptyCredentials.json               | 200           |                                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/TeradataEmptyCredentials                                           |                                                                                           | 200           |                                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/TeradataDBDataSource/TeradataDataSource                              | ida/jdbcAnalyzerPayloads/Teradata/DataSource/TeradataDataSource.json                      | 204           |                                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/TeradataDBDataSource/TeradataDataSource                              |                                                                                           | 200           | TeradataDataSource                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/TeradataDBDataSource/TeradataDataSourceInternalNode                  | ida/jdbcAnalyzerPayloads/Teradata/DataSource/TeradataDataSourceWithNodeCondition.json     | 204           |                                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/TeradataDBDataSource/TeradataDataSourceInternalNode                  |                                                                                           | 200           | TeradataDataSourceInternalNode          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/TeradataDBDataSource/TeradataDataSourceWithWrongHost                 | ida/jdbcAnalyzerPayloads/Teradata/DataSource/TeradataDataSourceWithInCorrectHost.json     | 204           |                                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/TeradataDBDataSource/TeradataDataSourceWithWrongHost                 |                                                                                           | 200           | TeradataDataSourceWithWrongHost         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/TeradataDBDataSource/TeradataDataSourceWithWrongBundleName           | ida/jdbcAnalyzerPayloads/Teradata/DataSource/TeradataDataSourceWithWrongBundleName.json   | 204           |                                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/TeradataDBDataSource/TeradataDataSourceWithWrongBundleName           |                                                                                           | 200           | TeradataDataSourceWithWrongBundleName   |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/TeradataDBDataSource/TeradataDataSourceWithWrongDriverName           | ida/jdbcAnalyzerPayloads/Teradata/DataSource/TeradataDataSourceWithWrongDriverName.json   | 204           |                                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/TeradataDBDataSource/TeradataDataSourceWithWrongDriverName           |                                                                                           | 200           | TeradataDataSourceWithWrongDriverName   |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/TeradataDBDataSource/TeradataDataSourceWithInvalidCredential         | ida/jdbcAnalyzerPayloads/Teradata/DataSource/TeradataDataSourceWithInvalidCredential.json | 204           |                                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/TeradataDBDataSource/TeradataDataSourceWithInvalidCredential         |                                                                                           | 200           | TeradataDataSourceWithInvalidCredential |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/TeradataDBDataSource/TeradataDBDataSource_TEST_DEFAULT_CONFIGURATION | ida/jdbcAnalyzerPayloads/Teradata/DataSource/TeradataDataSource_DefaultConfig.json        | 204           |                                         |          |

  @cr-data
  Scenario Outline:SC#1: Create BusinessApplication tag and run the plugin configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/jdbcAnalyzerPayloads/Teradata/Test_BA_Teradata.json | 200           |                  |          |

  #################### DataSource TestConnection - UI Validation ####################
  @webtest @jdbc @MLP-10017 @teradata
  Scenario: SC#2:Verify whether the background of the panel is displayed in green when test connection is successful for TeradataDBDataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Capture And Import Data Icon                       |
      | click       | Capture And Import Data Icon                       |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute            |
      | Data Source Type | TeradataDBDataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*      |
      | Label      |
      | URL*       |
      | Credential |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                             |
      | Name      | TeradataDBTestDataSource                                              |
      | Label     | TeradataDBTestDataSource                                              |
      | URL       | jdbc:teradata://didtde01v.did.dev.asgint.loc/TMODE=ANSI,CHARSET=ASCII |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute           |
      | Credential | TeradataCredentials |
      | Deployment | LocalNode           |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "click" on "Save" button in "Add Data Sources Page"

  @webtest @jdbc @MLP-10017 @teradata
  Scenario: SC#2:Verify whether the background of the panel is displayed in red when test connection is not successful for TeradataDBDataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Capture And Import Data Icon                       |
      | click       | Capture And Import Data Icon                       |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute            |
      | Data Source Type | TeradataDBDataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*      |
      | Label      |
      | URL*       |
      | Credential |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                             |
      | Name      | TeradataDBDataSourceTest2                                             |
      | Label     | TeradataDBDataSourceTest2                                             |
      | URL       | jdbc:teradata://didtde01v.did.dev.asgint.loc/TMODE=ANSI,CHARSET=ASCII |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                  |
      | Credential | TeradataInvalidCredentials |
      | Deployment | LocalNode                  |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                |
      | Credential | TeradataEmptyCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"


  ######################################## PluginRun - TeradataDBCataloger - DryRun True ########################################
  @jdbc
  Scenario Outline: SC#3:Run teradata cataloger with dryrun as true
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                  | body                                                                                          | response code | response message                | jsonPath                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/TeradataDBCataloger/TeraDataCatalogerWithDryRunTrue                               | ida/jdbcAnalyzerPayloads/Teradata/PluginConfiguration/sc1TeradataCatalogerWithDryRunTrue.json | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/TeradataDBCataloger                                                               |                                                                                               | 200           | TeraDataCatalogerWithDryRunTrue |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDryRunTrue |                                                                                               | 200           | IDLE                            | $.[?(@.configurationName=='TeraDataCatalogerWithDryRunTrue')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDryRunTrue  | ida/jdbcAnalyzerPayloads/empty.json                                                           | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDryRunTrue |                                                                                               | 200           | IDLE                            | $.[?(@.configurationName=='TeraDataCatalogerWithDryRunTrue')].status |

  @webtest @jdbc @MLP-10017
  Scenario: SC#3:UI_Validation: Verify TeradataDBCataloger plugin functionality with dry run as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TeraDataCatalogerWithDryRunTrue" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/TeradataDBCataloger/TeraDataCatalogerWithDryRunTrue%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    Then Analysis log "cataloger/TeradataDBCataloger/TeraDataCatalogerWithDryRunTrue%" should display below info/error/warning
      | type | logValue                                           | logCode       | pluginName          | removableText |
      | INFO | Plugin TeradataDBCataloger running on dry run mode | ANALYSIS-0069 | TeradataDBCataloger |               |


  Scenario: SC#3: Delete the items for scenario: with dry run as true
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                | type     | query | param |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera% | Analysis |       |       |


  ######################################## PluginRun - TeradataDBCataloger - DryRun False ########################################
  @jdbc
  Scenario Outline: SC#4:Run teradata cataloger with dryrun as false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                      | body                                                                                              | response code | response message                    | jsonPath                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter                               | ida/jdbcAnalyzerPayloads/Teradata/PluginConfiguration/sc1TeradataCatalogerWithDBfilterConfig.json | 204           |                                     |                                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/TeradataDBCataloger                                                                   |                                                                                                   | 200           | TeraDataCatalogerWithDatabaseFilter |                                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                                                                                   | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter  | ida/jdbcAnalyzerPayloads/empty.json                                                               | 200           |                                     |                                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                                                                                   | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |


  @jdbc
  Scenario: SC#4-Create Teradata Analyzer plugin config
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                   | body                                                 | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/TeradataDBAnalyzer | ida/jdbcAnalyzerPayloads/teradataAnalyzerConfig.json | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/TeradataDBAnalyzer |                                                      | 200           | TeradataAnalyzer |          |

#  ############################ EDIBus ############################
#  Scenario Outline:SC#5:MLP-9043_Configure EDI Bus credentials and Data Source
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                         | body                                                       | response code | response message       | jsonPath |
#      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/EDIBusValidCredentials | idc/EdiBusPayloads/Credentials/EDIBusValidCredentials.json | 200           |                        |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource         | idc/EdiBusPayloads/DataSource/EDIBUSDYDBDS.json            | 204           |                        |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource         |                                                            | 200           | EDIBusDynamoDataSource |          |
#
#     ##6549303
#  @sanity @positive @webtest @edibus
#  Scenario:SC#5:MLP-9043_Verify EDI replication for items collected using TeradataDBCataloger
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "PIITags" and clicks on search
#    And user performs "facet selection" in "PIITags" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Dynamo DB" attribute under "Tags" facets in Item Search results page
#    And user "verify displayed" for listed "Type" facet in Search results page
#      | ItemType   |
#      | Column     |
#      | Constraint |
#      | Table      |
#      | Cluster    |
#      | Database   |
#      | Host       |
#      | Service    |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/DynamoDBConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                 | body                                   | response code | response message | jsonPath                                            |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/DynamoDBConfig.json | 204           |                  |                                                     |
#      |                  |       |       | Get          | settings/analyzers/EDIBus                                           |                                        | 200           |                  | EDIBusDynamoDB                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusDynamoDB |                                        | 200           | IDLE             | $.[?(@.configurationName=='EDIBusDynamoDB')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusDynamoDB  |                                        | 200           |                  |                                                     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusDynamoDB |                                        | 200           | IDLE             | $.[?(@.configurationName=='EDIBusDynamoDB')].status |
#    And user enters the search text "EDIBusDynamoDB" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusDynamoDB%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user enters the search text "PIITags" and clicks on search
#    And user performs "facet selection" in "PIITags" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Dynamo DB" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                      |
#      | $..selections.['asg.tagPathsHierarchy_ss'][0] | PIITags                                         |
#      | $..selections.['asg.tagPathsHierarchy_ss'][1] | Technology/Cloud Data/Cloud Databases/Dynamo DB |
#      | $..selections.['type_s'][*]                   | Column                                          |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                    | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=PIITags&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
#    And user enters the search text "PIITags" and clicks on search
#    And user performs "facet selection" in "PIITags" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Dynamo DB" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                          |
#      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                      |
#      | $..selections.['asg.tagPathsHierarchy_ss'][0] | PIITags                                         |
#      | $..selections.['asg.tagPathsHierarchy_ss'][1] | Technology/Cloud Data/Cloud Databases/Dynamo DB |
#      | $..selections.['type_s'][*]                   | Table                                           |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                    | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=PIITags&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
#      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
#    And user enters the search text "PIITags" and clicks on search
#    And user performs "facet selection" in "PIITags" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Dynamo DB" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                      |
#      | $..selections.['asg.tagPathsHierarchy_ss'][0] | PIITags                                         |
#      | $..selections.['asg.tagPathsHierarchy_ss'][1] | Technology/Cloud Data/Cloud Databases/Dynamo DB |
#      | $..selections.['type_s'][*]                   | Database                                        |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                    | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=PIITags&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
#    And user enters the search text "PIITags" and clicks on search
#    And user performs "facet selection" in "PIITags" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Dynamo DB" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
#      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) |
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                                 |
#      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @*Dynamo@ DB≫DEFAULT≫DWR_RDB_COLUMN≫@* ) ,AND,( TYPE = DWR_IDC )       |
#      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @*Dynamo@ DB≫DEFAULT≫DWR_RDB_TABLE_OR_VIEW≫@* ),AND,( TYPE = DWR_IDC ) |
#      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @*Dynamo@ DB≫DEFAULT≫DWR_RDB_DATABASE≫@* ),AND,( TYPE = DWR_IDC )      |
#      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @*Dynamo@ DB≫DEFAULT≫DWR_RDB_DB_SYSTEM≫@* ),AND,( TYPE = DWR_IDC )     |
#
#
#  @positve @regression @sanity  @MLP-21662 @IDA-1.1.0
#  Scenario:SC#5:Delete EDIBusAnalysis item
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                         | type     | query | param |
#      | SingleItemDelete | Default | bulk/EDIBus/EDIBusDynamoDB/% | Analysis |       |       |

  ############################ Logging Enhancements ############################
  ##
  @webtest @jdbc @MLP-10017
  Scenario: SC#5:LoggingEnhancements: Verify TeradataDBCataloger collects Analysis item with proper log messages
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TeradataCatalogerWithDBfilterConfig" and clicks on search
    And user performs "facet selection" in "SC1TeradataCatalogerWithDBfilterConfig" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    Then Analysis log "cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | logCode       | pluginName          | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | ANALYSIS-0019 |                     |                |
      | INFO | Plugin Name:TeradataDBCataloger, Plugin Type:cataloger, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:08f802c075a0, Plugin Configuration name:TeraDataCatalogerWithDatabaseFilter                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ANALYSIS-0071 | TeradataDBCataloger | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: ---  2020-07-30 07:12:04.907 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: name: "TeraDataCatalogerWithDatabaseFilter"  2020-07-30 07:12:04.907 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: pluginVersion: "LATEST"  2020-07-30 07:12:04.907 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: label:  2020-07-30 07:12:04.907 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: : ""  2020-07-30 07:12:04.908 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: catalogName: "Default"  2020-07-30 07:12:04.908 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: eventClass: null  2020-07-30 07:12:04.908 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: eventCondition: null  2020-07-30 07:12:04.908 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: nodeCondition: null  2020-07-30 07:12:04.908 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: maxWorkSize: 100  2020-07-30 07:12:04.908 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: tags:  2020-07-30 07:12:04.909 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: - "SC1TeradataCatalogerWithDBfilterConfig"  2020-07-30 07:12:04.909 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: pluginType: "cataloger"  2020-07-30 07:12:04.909 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: dataSource: "TeradataDataSource"  2020-07-30 07:12:04.909 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: credential: "TeradataCredentials"  2020-07-30 07:12:04.909 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: businessApplicationName: "Test_BA_Teradata"  2020-07-30 07:12:04.910 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: dryRun: false  2020-07-30 07:12:04.910 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: schedule: null  2020-07-30 07:12:04.910 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: runAfter: []  2020-07-30 07:12:04.910 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: filter: null  2020-07-30 07:12:04.910 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: pluginName: "TeradataDBCataloger"  2020-07-30 07:12:04.910 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: databaseFilter:  2020-07-30 07:12:04.910 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: - database: "automation_test_db"  2020-07-30 07:12:04.911 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: casesensitive: true  2020-07-30 07:12:04.911 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: arguments: []  2020-07-30 07:12:04.911 INFO  - ANALYSIS-0073: Plugin TeradataDBCataloger Configuration: type: "Cataloger" | ANALYSIS-0073 | TeradataDBCataloger |                |
      | INFO | Plugin TeradataDBCataloger Start Time:2020-07-23 12:59:58.632, End Time:2020-07-23 13:00:00.233, Processed Count:0, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ANALYSIS-0072 | TeradataDBCataloger |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | ANALYSIS-0020 |                     |                |


  @webtest @jdbc @MLP-10017
  Scenario: SC#6: Verify facet counts appears properly for the items collected by TeradataDBCataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "SC1TeradataCatalogerWithDBfilterConfig" and clicks on search
    And user performs "facet selection" in "SC1TeradataCatalogerWithDBfilterConfig" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType  | count |
      | Column     | 32    |
      | Index      | 7     |
      | Table      | 7     |
      | DataType   | 6     |
      | Cluster    | 1     |
      | Constraint | 1     |
      | Database   | 1     |
      | Service    | 1     |


  ##6492874## ##6650671##
  @webtest @jdbc @MLP-10017
  Scenario: SC#7:Verify the Database(TeradataDB) should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TeradataCatalogerWithDBfilterConfig" and clicks on search
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "automation_test_db" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                         | widgetName  |
      | databaseType      | D                                     | Description |
      | Storage type      | TeradataTeradata Database 16.20.31.01 | Description |


  ##6650651##
  @webtest @jdbc @MLP-10017
  Scenario: SC#8:Verify the Teradata Table should not have constraints window if the table is not having any constraints.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TeradataCatalogerWithDBfilterConfig" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TERADATA_TABLE" item from search results
    And user "verify presence" of following "item view section" in Item View Page
      | has_Index |
    And user "verify non presence" of following "item view section" in Item View Page
      | Constraints |
    Then user performs click and verify in new window
      | Table     | value            | Action               | RetainPrevwindow | indexSwitch |
      | has_Index | TERADATA_TABLE.1 | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue           | widgetName  |
      | indexType         | Non-Partitioned Primary | Description |
      | unique            | NO                      | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Created           | Lifecycle  |
      | Modified          | Lifecycle  |


  ##6492869## ##662100##
  @webtest @jdbc @MLP-10017
  Scenario: SC#9:Verify the Table should have the appropriate metadata information of Table Type = TABLE in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TeradataCatalogerWithDBfilterConfig" and clicks on search
    And user performs "facet selection" in "TERADATA_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TERADATA_TAG_DETAILS" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
      | Created by        | DBC           | Description |
      | Modified by       | DBC           | Description |


  ##6492878##
  @webtest @jdbc @MLP-6248
  Scenario: SC#10:Verify the ColumnName(TeradataDB) should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TeradataCatalogerWithDBfilterConfig" and clicks on search
    And user performs "facet selection" in "TERADATA_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "EMPLOYEE_ID" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | INTEGER       | Description |
      | Created by        | DBC           | Description |
      | Modified by       | DBC           | Description |
      | nulls             | YES           | Description |
      | Length            | 4             | Statistics  |


  ##6492871## ##6650642##
  @webtest @jdbc @MLP-10017
  Scenario: SC#11:Verify the TableName(TeradataDB) should have the appropriate Constraint metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TeradataCatalogerWithDBfilterConfig" and clicks on search
    And user performs "facet selection" in "Index" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "IDAPK.1" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | indexType         | Primary Key   | Description |
      | unique            | YES           | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Created           | Lifecycle  |
      | Modified          | Lifecycle  |
    And user enters the search text "SC1TeradataCatalogerWithDBfilterConfig" and clicks on search
    And user performs "facet selection" in "Index" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "supplier_uniquetest.1" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue     | widgetName  |
      | indexType         | Unique Constraint | Description |
      | unique            | YES               | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Created           | Lifecycle  |
      | Modified          | Lifecycle  |
    And user enters the search text "SC1TeradataCatalogerWithDBfilterConfig" and clicks on search
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "empForeign" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Constraint Type   | R             | Description |
      | Short name        | empForeign    | Description |


  ##6650666##
  @webtest
  Scenario: SC#12-Verify the relationships shows properly between the table and constraint under relationship tab
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TeradataCatalogerWithDBfilterConfig" and clicks on search
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "empForeign" item from search results
    Then user performs click and verify in new window
      | Table  | value       | Action                 | RetainPrevwindow | indexSwitch |
      | parent | empid       | verify widget contains | No               |             |
      | parent | PrimaryTest | verify widget contains | No               |             |
    And user enters the search text "SC1TeradataCatalogerWithDBfilterConfig" and clicks on search
    And user performs "facet selection" in "Index" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "IDAPK.1" item from search results
    Then user performs click and verify in new window
      | Table      | value   | Action                 | RetainPrevwindow | indexSwitch |
      | usesColumn | details | verify widget contains | No               |             |
    And user enters the search text "SC1TeradataCatalogerWithDBfilterConfig" and clicks on search
    And user performs "facet selection" in "Index" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "supplier_uniquetest.1" item from search results
    Then user performs click and verify in new window
      | Table      | value       | Action                 | RetainPrevwindow | indexSwitch |
      | usesColumn | supplier_id | verify widget contains | No               |             |


  ##6492881## ##6650647##
  @webtest @jdbc
  Scenario: SC#13:Verify proper error message is shown if mandatory fields are not filled in TeradataDBCataloger plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem            |
      | mouse hover | Settings Icon         |
      | click       | Settings Icon         |
      | click       | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute           |
      | Type      | Cataloger           |
      | Plugin    | TeradataDBCataloger |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  ##6492882## ##6650616##
  @webtest @jdbc @MLP-10017
  Scenario: SC#14:Verify proper error message is shown if mandatory fields are not filled in TeradataDBAnalyzer plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem            |
      | mouse hover | Settings Icon         |
      | click       | Settings Icon         |
      | click       | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute          |
      | Type      | Dataanalyzer       |
      | Plugin    | TeradataDBAnalyzer |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  ####
  @webtest @jdbc @MLP
  Scenario: SC#15: Verify proper error message is shown if mandatory fields are not filled in TeradataDBDataSource plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Settings Icon                                      |
      | click       | Settings Icon                                      |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute            |
      | Data Source Type | TeradataDBDataSource |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
      | URL       | URL field should not be empty  |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  ##6492886## ##6492885##
  @webtest @jdbc @MLP-10017
  Scenario: SC#16: Verify TERADATA DATASOURCE throws error when the jdbc url is for databases other than Teradata
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Settings Icon                                      |
      | click       | Settings Icon                                      |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute            |
      | Data Source Type | TeradataDBDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                      |
      | Name      | TeradataDBDataSourceInvalidURLFormat           |
      | URL       | jdbc:test:thin:@gechcae-col1.asg.com:1521:col2 |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                                                                                   |
      | URL       | UnSupported Teradata JDBC URL Format. Sample Format : jdbc:teradata://<hostname:port>/<params> |


  ##6492879## ##6650646##
  @webtest @jdbc @MLP-10017
  Scenario: SC#17: Verify the breadcrumb hierarchy appears correctly when JDBC cataloger is ran for Teradata Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TeradataCatalogerWithDBfilterConfig" and clicks on search
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "POSTAL_CODE" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | didtde01v.did.dev.asgint.loc |
      | Teradata                     |
      | automation_test_db           |
      | TERADATA_TAG_DETAILS         |
      | POSTAL_CODE                  |

  Scenario: SC#17: Delete the items for scenario: SC1
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                | type     | query | param |
      | SingleItemDelete | Default | didtde01v.did.dev.asgint.loc        | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera% | Analysis |       |       |

  ############################################# Node Condition Internal Node ##########################################################
  ##6650661##
  @webtest @jdbc
  Scenario: SC#18-Verify TeradataDBCataloger collects items like Cluster, Service, Database, Table, Columns if node condition is specified in configuration.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                        | body                                                                                             | response code | response message                   | jsonPath                                                                | endpointType | itemName |
      | application/json |       |       | Put          | settings/analyzers/TeradataDBCataloger/TeradataCatalogerWithNodeCondition                                  | ida/jdbcAnalyzerPayloads/Teradata/PluginConfiguration/sc3TeradataCatalogerWithNodeCondition.json | 204           |                                    |                                                                         |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBCataloger                                                                     |                                                                                                  | 200           | TeradataCatalogerWithNodeCondition |                                                                         |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/cataloger/TeradataDBCataloger/TeradataCatalogerWithNodeCondition |                                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='TeradataCatalogerWithNodeCondition')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/InternalNode/cataloger/TeradataDBCataloger/TeradataCatalogerWithNodeCondition  | ida/jdbcAnalyzerPayloads/empty.json                                                              | 200           |                                    |                                                                         |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/cataloger/TeradataDBCataloger/TeradataCatalogerWithNodeCondition |                                                                                                  | 200           | IDLE                               | $.[?(@.configurationName=='TeradataCatalogerWithNodeCondition')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC3TeradataCatalogerWithNodeCondition" and clicks on search
    And user performs "facet selection" in "SC3TeradataCatalogerWithNodeCondition" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType  | count |
      | Column     | 32    |
      | Index      | 7     |
      | Table      | 7     |
      | DataType   | 6     |
      | Cluster    | 1     |
      | Constraint | 1     |
      | Database   | 1     |
      | Service    | 1     |


  ##6650617##
  @webtest @jdbc @MLP-10017
  Scenario: SC#19-Verify TeradataDBAnalyzer scans and collects data properly if the node condition is given
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                         | body                                | response code | response message                  | jsonPath                                                               |
      | application/json |       |       | Get          | settings/analyzers/TeradataDBAnalyzer                                                                       |                                     | 200           | TeradataAnalyzerWithNodeCondition |                                                                        |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzerWithNodeCondition |                                     | 200           | IDLE                              | $.[?(@.configurationName=='TeradataAnalyzerWithNodeCondition')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/InternalNode/dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzerWithNodeCondition  | ida/jdbcAnalyzerPayloads/empty.json | 200           |                                   |                                                                        |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzerWithNodeCondition |                                     | 200           | IDLE                              | $.[?(@.configurationName=='TeradataAnalyzerWithNodeCondition')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TERADATA_TAG_DETAILS" and clicks on search
    And user performs "facet selection" in "AnalyzeTeradataWithNodeCondition" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TERADATA_TAG_DETAILS" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
      | Created by        | DBC           | Description |
      | Modified by       | DBC           | Description |
      | Number of rows    | 4             | Statistics  |

  @webtest @jdbc @MLP-10017
  Scenario:SC#20:Verify the technology tags got assigned to all Teradata DB items like Cluster,Service,Database...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Teradata" and clicks on search
    And user performs "definite facet selection" in "Teradata" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Teradata,SC3TeradataCatalogerWithNodeCondition,Test_BA_Teradata" should get displayed for the column "cataloger/TeradataDBCataloger"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                                                                              | fileName                     | userTag                               |
      | Default     | Service    | Metadata Type | Teradata,SC3TeradataCatalogerWithNodeCondition,Test_BA_Teradata                                  | Teradata                     | SC3TeradataCatalogerWithNodeCondition |
      | Default     | Database   | Metadata Type | Teradata,SC3TeradataCatalogerWithNodeCondition,Test_BA_Teradata                                  | automation_test_db           | SC3TeradataCatalogerWithNodeCondition |
      | Default     | DataType   | Metadata Type | Teradata,SC3TeradataCatalogerWithNodeCondition,Test_BA_Teradata                                  | INTEGER                      | SC3TeradataCatalogerWithNodeCondition |
      | Default     | Column     | Metadata Type | Teradata,SC3TeradataCatalogerWithNodeCondition,Test_BA_Teradata,AnalyzeTeradataWithNodeCondition | TERADATADB_SALARY            | SC3TeradataCatalogerWithNodeCondition |
      | Default     | Table      | Metadata Type | Teradata,SC3TeradataCatalogerWithNodeCondition,Test_BA_Teradata,AnalyzeTeradataWithNodeCondition | TERADATA_TAG_DETAILS         | SC3TeradataCatalogerWithNodeCondition |
      | Default     | Index      | Metadata Type | Teradata,SC3TeradataCatalogerWithNodeCondition,Test_BA_Teradata                                  | IDAPK.1                      | SC3TeradataCatalogerWithNodeCondition |
      | Default     | Constraint | Metadata Type | Teradata,SC3TeradataCatalogerWithNodeCondition,Test_BA_Teradata,AnalyzeTeradataWithNodeCondition | empForeign                   | SC3TeradataCatalogerWithNodeCondition |
      | Default     | Cluster    | Metadata Type | Teradata,SC3TeradataCatalogerWithNodeCondition,Test_BA_Teradata                                  | didtde01v.did.dev.asgint.loc | SC3TeradataCatalogerWithNodeCondition |

  Scenario: SC#20: Delete the items for scenario: Specific Node Condition
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                  | type     | query | param |
      | SingleItemDelete | Default | didtde01v.did.dev.asgint.loc          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/TeradataDBAnalyzer/Tera% | Analysis |       |       |


  ############################################# Invalid Hostname in Datasource ##########################################################
  ###6492885##
  @webtest @jdbc
  Scenario: SC#21-Verify Teradata cataloger does not collect any DB items and log throws error when the jdbc url has incorrect host
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                     | body                                                                                          | response code | response message                   | jsonPath                                                                | endpointType | itemName |
      | application/json |       |       | Put          | settings/analyzers/TeradataDBCataloger/TeraDataCatalogerWithWrongHostInDS                               | ida/jdbcAnalyzerPayloads/Teradata/PluginConfiguration/sc5TeradataCatalogerWithWrongURLds.json | 204           |                                    |                                                                         |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBCataloger                                                                  |                                                                                               | 200           | TeraDataCatalogerWithWrongHostInDS |                                                                         |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithWrongHostInDS |                                                                                               | 200           | IDLE                               | $.[?(@.configurationName=='TeraDataCatalogerWithWrongHostInDS')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithWrongHostInDS  | ida/jdbcAnalyzerPayloads/empty.json                                                           | 200           |                                    |                                                                         |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithWrongHostInDS |                                                                                               | 200           | IDLE                               | $.[?(@.configurationName=='TeraDataCatalogerWithWrongHostInDS')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC5TeradataCatalogerWithWrongHostInDS" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/TeradataDBCataloger/TeraDataCatalogerWithWrongHostInDS%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 3             | Description |
    Then Analysis log "cataloger/TeradataDBCataloger/TeraDataCatalogerWithWrongHostInDS%" should display below info/error/warning
      | type  | logValue                                              | logCode       | pluginName | removableText |
      | ERROR | Login failure for Connection to didtde01v.did.dev.asg | ANALYSIS-0067 |            |               |

  Scenario: SC#21: Delete the items for scenario: when the jdbc url has incorrect host
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                | type     | query | param |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera% | Analysis |       |       |

  ############################################# TeradataDBCataloger - PluginRun ##########################################################
  ##6650653##
  @webtest @jdbc @MLP-10017
  Scenario: SC#22-Verify TeradataDBCataloger scans and collects data if Database name is provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                      | body                                                                                              | response code | response message                    | jsonPath                                                                 | endpointType | itemName |
      | application/json |       |       | Put          | settings/analyzers/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter                               | ida/jdbcAnalyzerPayloads/Teradata/PluginConfiguration/sc1TeradataCatalogerWithDBfilterConfig.json | 204           |                                     |                                                                          |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBCataloger                                                                   |                                                                                                   | 200           | TeraDataCatalogerWithDatabaseFilter |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                                                                                   | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter  | ida/jdbcAnalyzerPayloads/empty.json                                                               | 200           |                                     |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                                                                                   | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TeradataCatalogerWithDBfilterConfig" and clicks on search
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Database  | 1     |
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | automation_test_db |


  ############################################# TeradataDBAnalyzer - PluginRun DrynRun True ##########################################################
  @jdbc @MLP-6248
  Scenario: SC#23-Run the TeradataAnalyzer with dryrun as true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                               | body                                | response code | response message           | jsonPath                                                        | endpointType | itemName |
      | application/json |       |       | Get          | settings/analyzers/TeradataDBAnalyzer                                                             |                                     | 200           | TeradataAnalyzerDryRunTrue |                                                                 |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzerDryRunTrue |                                     | 200           | IDLE                       | $.[?(@.configurationName=='TeradataAnalyzerDryRunTrue')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzerDryRunTrue  | ida/jdbcAnalyzerPayloads/empty.json | 200           |                            |                                                                 |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzerDryRunTrue |                                     | 200           | IDLE                       | $.[?(@.configurationName=='TeradataAnalyzerDryRunTrue')].status |              |          |

  @webtest @jdbc @MLP-10017
  Scenario: SC#24:UI_Validation: Verify TeradataDBAnalyzer plugin functionality with dry run as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TeradataAnalyzerDryRunTrue" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzerDryRunTrue%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    Then Analysis log "dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzerDryRunTrue%" should display below info/error/warning
      | type | logValue                                          | logCode       | pluginName         | removableText |
      | INFO | Plugin TeradataDBAnalyzer running on dry run mode | ANALYSIS-0069 | TeradataDBAnalyzer |               |


  ############################################# TeradataDBAnalyzer - PluginRun DrynRun False ##########################################################
  ##6250376##
  @webtest @jdbc @MLP-6248
  Scenario: SC#25-Verify the Table Name in Teradata DB which should have the appropriate metadata information in IDC UI and Database after running TeradataAnalyser
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                     | body                                | response code | response message | jsonPath                                              | endpointType | itemName |
      | application/json |       |       | Get          | settings/analyzers/TeradataDBAnalyzer                                                   |                                     | 200           | TeradataAnalyzer |                                                       |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzer |                                     | 200           | IDLE             | $.[?(@.configurationName=='TeradataAnalyzer')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzer  | ida/jdbcAnalyzerPayloads/empty.json | 200           |                  |                                                       |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzer |                                     | 200           | IDLE             | $.[?(@.configurationName=='TeradataAnalyzer')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeTeradataSC1" and clicks on search
    And user performs "facet selection" in "TERADATA_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TERADATA_TAG_DETAILS" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
      | Created by        | DBC           | Description |
      | Modified by       | DBC           | Description |
      | Number of rows    | 4             | Statistics  |

  ##6650607##
  @webtest @jdbc @MLP-6248
  Scenario: SC#26-Verify the data sampling information in TeradataDB
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AnalyzeTeradataSC1" and clicks on search
    And user performs "facet selection" in "AnalyzeTeradataSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TERADATA_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "TERADATA_TAG_DETAILS" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | PHONE_NUMBER | POSTAL_CODE | EMPLOYEE_ID | EMAIL            | GENDER | SSN         | IP_ADDRESS    | TERADATADB_SALARY | JOINING_DATE        | STATE | FULL_NAME      |
      | 515.123.2580 | 48276       | 13          | ishayk@gmail.com | f      | 345-66-3222 | 255.71.255.56 | 0.00              | 2007-08-08 05:08:55 | VI    | Irina Shayk    |
      | 515.123.4356 | 46581       | 11          | cambie@gmail.com | f      | 345-53-3779 | 255.249.12.0  | 90.55             | 2000-12-12 12:50:28 | TX    | Jones Campbell |
      | 515.123.6666 | 78576       | 12          | lmessi@gmail.com | m      | 315-53-3222 | 255.83.45.0   | 0.00              | 2015-03-25 18:08:54 | NY    | Lionel Messi   |
      | 515.123.4568 | 46576       | 10          | fergie@gmail.com | m      | 345-53-3222 | 255.249.255.0 | 100.90            | 2000-06-24 15:05:26 | DC    | Alex Ferguson  |


    ##6650610##
  @webtest @jdbc @MLP-6248
  Scenario: SC#27-Verify the Column with datatype varchar in Teradata DB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "FULL_NAME" and clicks on search
    And user performs "facet selection" in "TERADATA_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "FULL_NAME" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 40            | Statistics  |
      | Maximum length                | 14            | Statistics  |
      | Maximum value                 | Lionel Messi  | Statistics  |
      | Minimum length                | 11            | Statistics  |
      | Minimum value                 | Alex Ferguson | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |


    ##6650609##
  @webtest @jdbc @MLP-6248
  Scenario: SC#28-Verify the Column with datatype decimal in Teradata DB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EMPLOYEE_ID" and clicks on search
    And user performs "facet selection" in "TERADATA_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
    And user performs "item click" on "EMPLOYEE_ID" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | INTEGER       | Description |
      | Length                        | 4             | Statistics  |
      | Average                       | 11.5          | Statistics  |
      | Maximum value                 | 13            | Statistics  |
      | Median                        | 11            | Statistics  |
      | Minimum value                 | 10            | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Standard deviation            | 1.12          | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 1.25          | Statistics  |

  Scenario: SC#28: Delete the items for scenario: Analyzer verification
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                  | type     | query | param |
      | SingleItemDelete | Default | didtde01v.did.dev.asgint.loc          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/TeradataDBAnalyzer/Tera% | Analysis |       |       |

  ############################################# TeradataDBCataloger - multiple Database names in filters ##########################################################
  ##6650654##
  @webtest @jdbc @MLP-10017
  Scenario: SC#29-Verify JDBC cataloger scans and collects data if multiple Database names are provided in filters(Teradata DB)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                              | body                                                                                                            | response code | response message                            | jsonPath                                                                         | endpointType | itemName |
      | application/json |       |       | Put          | settings/analyzers/TeradataDBCataloger/TeradataCatalogerwithMultipleDatabaseFilter                               | ida/jdbcAnalyzerPayloads/Teradata/PluginConfiguration/sc8TeradataCatalogerwithMultipleDatabaseFilterConfig.json | 204           |                                             |                                                                                  |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBCataloger                                                                           |                                                                                                                 | 200           | TeradataCatalogerwithMultipleDatabaseFilter |                                                                                  |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeradataCatalogerwithMultipleDatabaseFilter |                                                                                                                 | 200           | IDLE                                        | $.[?(@.configurationName=='TeradataCatalogerwithMultipleDatabaseFilter')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeradataCatalogerwithMultipleDatabaseFilter  | ida/jdbcAnalyzerPayloads/empty.json                                                                             | 200           |                                             |                                                                                  |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeradataCatalogerwithMultipleDatabaseFilter |                                                                                                                 | 200           | IDLE                                        | $.[?(@.configurationName=='TeradataCatalogerwithMultipleDatabaseFilter')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC8TeradataCatalogerWithMultipleDatabaseFilter" and clicks on search
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Database  | 2     |
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | automation_test_db |
      | collector          |

  Scenario: SC#29: Delete the items for scenario: multiple Database names are provided in filters
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                | type     | query | param |
      | SingleItemDelete | Default | didtde01v.did.dev.asgint.loc        | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera% | Analysis |       |       |


  ############################################# TeradataDBCataloger - Non-existing database in filters ##########################################################
  ##6650656##
  @webtest @jdbc @MLP-6248
  Scenario: SC#30-Verify Teradata cataloger scans and collects data if non existing database name are provided in filters(Teradata DB)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                           | body                                                                                                         | response code | response message                         | jsonPath                                                                      | endpointType | itemName |
      | application/json |       |       | Put          | settings/analyzers/TeradataDBCataloger/TeradataCatalogerwithNonExistingDatabase                               | ida/jdbcAnalyzerPayloads/Teradata/PluginConfiguration/sc9TeradataCatalogerwithNonExistingDatabaseConfig.json | 204           |                                          |                                                                               |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBCataloger                                                                        |                                                                                                              | 200           | TeradataCatalogerwithNonExistingDatabase |                                                                               |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeradataCatalogerwithNonExistingDatabase |                                                                                                              | 200           | IDLE                                     | $.[?(@.configurationName=='TeradataCatalogerwithNonExistingDatabase')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeradataCatalogerwithNonExistingDatabase  | ida/jdbcAnalyzerPayloads/empty.json                                                                          | 200           |                                          |                                                                               |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeradataCatalogerwithNonExistingDatabase |                                                                                                              | 200           | IDLE                                     | $.[?(@.configurationName=='TeradataCatalogerwithNonExistingDatabase')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC9TeradataCatalogerWithNonExistingDatabase" and clicks on search
    Then user verify "catalog not contains" any "Table" attribute under "Metadata Type" facets


  ############################################# TeradataDBCataloger - Bundle Name is incorrect ##########################################################
  ##6492884##
  @webtest @jdbc @MLP-6942
  Scenario: SC#31-Verify the error message when Configuration Bundle Name is incorrect
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                           | body                                                                                                          | response code | response message                         | jsonPath                                                                      | endpointType | itemName |
      | application/json |       |       | Put          | settings/analyzers/TeradataDBCataloger/TeradataCatalogerwithIncorrectBundleName                               | ida/jdbcAnalyzerPayloads/Teradata/PluginConfiguration/sc10TeradataCatalogerwithIncorrectBundleNameConfig.json | 204           |                                          |                                                                               |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBCataloger                                                                        |                                                                                                               | 200           | TeradataCatalogerwithIncorrectBundleName |                                                                               |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeradataCatalogerwithIncorrectBundleName |                                                                                                               | 200           | IDLE                                     | $.[?(@.configurationName=='TeradataCatalogerwithIncorrectBundleName')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeradataCatalogerwithIncorrectBundleName  | ida/jdbcAnalyzerPayloads/empty.json                                                                           | 200           |                                          |                                                                               |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeradataCatalogerwithIncorrectBundleName |                                                                                                               | 200           | IDLE                                     | $.[?(@.configurationName=='TeradataCatalogerwithIncorrectBundleName')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC10TeradataCatalogerWithIncorrectBundleName" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/TeradataDBCataloger/TeradataCatalogerwithIncorrectBundleName%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 2             | Description |
    Then Analysis log "cataloger/TeradataDBCataloger/TeradataCatalogerwithIncorrectBundleName%" should display below info/error/warning
      | type  | logValue                                                           | logCode            | pluginName | removableText |
      | ERROR | No Driver class returned: Bundle com.teradata.TeraDriver not found | ANALYSIS-JDBC-0002 |            |               |


  ############################################# TeradataDBCataloger - Bundle Driver is incorrect ##########################################################
  ##6492884##
  @webtest @jdbc @MLP-6942
  Scenario: SC#32-Verify the error message when Configuration Bundle Driver is incorrect
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                             | body                                                                                                            | response code | response message                           | jsonPath                                                                        | endpointType | itemName |
      | application/json |       |       | Put          | settings/analyzers/TeradataDBCataloger/TeradataCatalogerwithIncorrectBundleDriver                               | ida/jdbcAnalyzerPayloads/Teradata/PluginConfiguration/sc11TeradataCatalogerwithIncorrectBundleDriverConfig.json | 204           |                                            |                                                                                 |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBCataloger                                                                          |                                                                                                                 | 200           | TeradataCatalogerwithIncorrectBundleDriver |                                                                                 |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeradataCatalogerwithIncorrectBundleDriver |                                                                                                                 | 200           | IDLE                                       | $.[?(@.configurationName=='TeradataCatalogerwithIncorrectBundleDriver')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeradataCatalogerwithIncorrectBundleDriver  | ida/jdbcAnalyzerPayloads/empty.json                                                                             | 200           |                                            |                                                                                 |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeradataCatalogerwithIncorrectBundleDriver |                                                                                                                 | 200           | IDLE                                       | $.[?(@.configurationName=='TeradataCatalogerwithIncorrectBundleDriver')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC11TeradataCatalogerWithIncorrectBundleDriver" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/TeradataDBCataloger/TeradataCatalogerwithIncorrectBundleDriver%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 2             | Description |
    Then Analysis log "cataloger/TeradataDBCataloger/TeradataCatalogerwithIncorrectBundleDriver%" should display below info/error/warning
      | type  | logValue                                | logCode | pluginName | removableText |
      | ERROR | Class 'com.teradata.jdbc' was not found |         |            |               |

  Scenario: SC#32: Delete the items for scenario: IncorrectBundleDriver/IncorrectBundleName/NonExistingDatabase
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                | type     | query | param |
      | SingleItemDelete | Default | didtde01v.did.dev.asgint.loc        | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera% | Analysis |       |       |


  ##6423518##
  @jdbc @webtest @MLP-7325
  Scenario: SC#33-Verify the data profiling metadata for string,numeric,date,time,timestamp datatypes metrics does not get calculated for empty table(Teradata)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                      | body                                | response code | response message                    | jsonPath                                                                 | endpointType | itemName |
      | application/json |       |       | Get          | settings/analyzers/TeradataDBCataloger                                                                   |                                     | 200           | TeraDataCatalogerWithDatabaseFilter |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                     | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter  | ida/jdbcAnalyzerPayloads/empty.json | 200           |                                     |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                     | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBAnalyzer                                                                    |                                     | 200           | TeradataAnalyzer                    |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzer                  |                                     | 200           | IDLE                                | $.[?(@.configurationName=='TeradataAnalyzer')].status                    |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzer                   | ida/jdbcAnalyzerPayloads/empty.json | 200           |                                     |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzer                  |                                     | 200           | IDLE                                | $.[?(@.configurationName=='TeradataAnalyzer')].status                    |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TERADATA_EMPTY" and clicks on search
    And user performs "facet selection" in "TERADATA_EMPTY [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TERADATA_EMPTY" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName |
      | Number of rows    | 0             | Statistics |
    And user enters the search text "TERADATA_EMPTY" and clicks on search
    And user performs "facet selection" in "TERADATA_EMPTY [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TERADATA_EMPTY" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Date1 | click and switch tab | No               |             |
    And user confirm "non presence of metadata properties" for the below item types
      | metaDataAttribute             | widgetName |
      | Last analyzed at              | Lifecycle  |
      | Maximum value                 | Statistics |
      | Minimum value                 | Statistics |
      | Number of non null values     | Statistics |
      | Percentage of non null values | Statistics |
      | Number of null values         | Statistics |
    And user enters the search text "TERADATA_EMPTY" and clicks on search
    And user performs "facet selection" in "TERADATA_EMPTY [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TERADATA_EMPTY" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | id    | click and switch tab | No               |             |
    And user confirm "non presence of metadata properties" for the below item types
      | metaDataAttribute             | widgetName |
      | Last analyzed at              | Lifecycle  |
      | Average                       | Statistics |
      | Maximum value                 | Statistics |
      | Median                        | Statistics |
      | Minimum value                 | Statistics |
      | Number of non null values     | Statistics |
      | Percentage of non null values | Statistics |
      | Number of null values         | Statistics |
      | Number of unique values       | Statistics |
      | Standard deviation            | Statistics |
      | Percentage of unique values   | Statistics |
      | Variance                      | Statistics |


  ##6492877## ##6492876## ##6492875## ##66500663## ##6650615##
  @jdbc @webtest @MLP-7325 @6650615
  Scenario: SC#34-Verify the data profiling metadata for date,time,timestamp datatypes and should have the appropriate metadata information in IDC UI and Database(Teradata)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TERADATA_TABLE" and clicks on search
    And user performs "facet selection" in "TERADATA_TABLE [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TERADATA_TABLE" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Date1 | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DATE          | Description |
      | Modified by                   | DBC           | Description |
      | Created by                    | DBC           | Description |
      | Length                        | 4             | Statistics  |
      | Maximum value                 | 2000-01-01    | Statistics  |
      | Minimum value                 | 2000-01-01    | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user enters the search text "TERADATA_TABLE" and clicks on search
    And user performs "facet selection" in "TERADATA_TABLE [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TERADATA_TABLE" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Date2 | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TIME          | Description |
      | Modified by                   | DBC           | Description |
      | Created by                    | DBC           | Description |
      | scale                         | 6             | Description |
      | Length                        | 15            | Statistics  |
      | Maximum value                 | 00:00:00      | Statistics  |
      | Minimum value                 | 00:00:00      | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user enters the search text "TERADATA_TABLE" and clicks on search
    And user performs "facet selection" in "TERADATA_TABLE [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TERADATA_TABLE" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Date3 | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue         | widgetName  |
      | Data type                     | TIMESTAMP             | Description |
      | Modified by                   | DBC                   | Description |
      | Created by                    | DBC                   | Description |
      | scale                         | 6                     | Description |
      | Length                        | 26                    | Statistics  |
      | Maximum value                 | 2000-01-01 00:00:00.0 | Statistics  |
      | Minimum value                 | 2000-01-01 00:00:00.0 | Statistics  |
      | Number of non null values     | 1                     | Statistics  |
      | Percentage of non null values | 100                   | Statistics  |
      | Number of null values         | 0                     | Statistics  |
      | Number of unique values       | 1                     | Statistics  |
      | Percentage of unique values   | 100                   | Statistics  |
    And user enters the search text "TERADATA_TABLE" and clicks on search
    And user performs "facet selection" in "TERADATA_TABLE [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TERADATA_TABLE" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | name  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Modified by                   | DBC           | Description |
      | Created by                    | DBC           | Description |
      | Length                        | 20            | Statistics  |
      | Maximum length                | 9             | Statistics  |
      | Maximum value                 | Test Name     | Statistics  |
      | Minimum length                | 9             | Statistics  |
      | Minimum value                 | Test Name     | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user enters the search text "TERADATA_TABLE" and clicks on search
    And user performs "facet selection" in "TERADATA_TABLE [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TERADATA_TABLE" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | id    | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | INTEGER       | Description |
      | Modified by                   | DBC           | Description |
      | Created by                    | DBC           | Description |
      | Length                        | 4             | Statistics  |
      | Average                       | 100           | Statistics  |
      | Maximum value                 | 100           | Statistics  |
      | Median                        | 100           | Statistics  |
      | Minimum value                 | 100           | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Standard deviation            | 0             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 0             | Statistics  |

  Scenario: SC#34: Delete the items for scenario: data profiling
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                  | type     | query | param |
      | SingleItemDelete | Default | didtde01v.did.dev.asgint.loc          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/TeradataDBAnalyzer/Tera% | Analysis |       |       |

  ############################################# Tooltip validation ##########################################################
  ##6650665##
  @webtest @jdbc @MLP-10017
  Scenario: SC#35-Verify captions and tool tip text in TeradataDBCataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem            |
      | mouse hover | Settings Icon         |
      | click       | Settings Icon         |
      | click       | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute           |
      | Type      | Cataloger           |
      | Plugin    | TeradataDBCataloger |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                             |
      | Label                             |
      | Business Application              |
      | Teradata Database Or User Filters |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name*                             | Plugin configuration name                           |
      | Label                             | Plugin configuration extended label and description |
      | Business Application              | Business Application                                |
      | Teradata Database Or User Filters | Filter on Teradata Database & Users                 |


  ##6650608##
  @webtest @jdbc @MLP-10017
  Scenario: SC#36-Verify captions and tool tip text in TeradataDBAnalyzer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem            |
      | mouse hover | Settings Icon         |
      | click       | Settings Icon         |
      | click       | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute          |
      | Type      | Dataanalyzer       |
      | Plugin    | TeradataDBAnalyzer |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                |
      | Label                |
      | Business Application |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name*                | Plugin configuration name                           |
      | Label                | Plugin configuration extended label and description |
      | Business Application | Business Application                                |


     ####
  @webtest @jdbc @MLP
  Scenario: SC#37-Verify captions and tool tip text in TeradataDBPostProcessor
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem            |
      | mouse hover | Settings Icon         |
      | click       | Settings Icon         |
      | click       | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute               |
      | Type      | Lineage                 |
      | Plugin    | TeradataDBPostProcessor |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                            |
      | Label                            |
      | Business Application             |
      | Teradata Postprocessor Arguments |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name*                            | Plugin configuration name                           |
      | Label                            | Plugin configuration extended label and description |
      | Business Application             | Business Application                                |
      | Teradata Postprocessor Arguments | Teradata Postprocessor Arguments                    |


    ####
  @webtest @jdbc @MLP
  Scenario: SC#38-Verify captions and tool tip text in TeradataDBDataSource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Settings Icon                                      |
      | click       | Settings Icon                                      |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute            |
      | Data Source Type | TeradataDBDataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*      |
      | Label      |
      | URL*       |
      | Credential |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name*      | Plugin configuration name                           |
      | Label      | Plugin configuration extended label and description |
      | Credential | Credential to be used                               |
      | URL*       | TeradataDB JDBC Connection URL                      |

  ############################################# TeradataDBCataloger - without filters ##########################################################
  @jdbc
  Scenario: SC#39-Start the TeradataDBCataloger without filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                   | body                                                                                                  | response code | response message                 | jsonPath                                                              | endpointType | itemName |
      | application/json |       |       | Put          | settings/analyzers/TeradataDBCataloger/TeraDataCatalogerWithoutDBFilter                               | ida/jdbcAnalyzerPayloads/Teradata/PluginConfiguration/sc18TeradataCatalogerWithoutDBfilterConfig.json | 204           |                                  |                                                                       |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBCataloger                                                                |                                                                                                       | 200           | TeraDataCatalogerWithoutDBFilter |                                                                       |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithoutDBFilter |                                                                                                       | 200           | IDLE                             | $.[?(@.configurationName=='TeraDataCatalogerWithoutDBFilter')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithoutDBFilter  | ida/jdbcAnalyzerPayloads/empty.json                                                                   | 200           |                                  |                                                                       |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithoutDBFilter |                                                                                                       | 200           | IDLE                             | $.[?(@.configurationName=='TeraDataCatalogerWithoutDBFilter')].status |              |          |


    ##6652102## ##6650662##
  @webtest @jdbc @MLP-10017
  Scenario: SC#40-Verify all DataBases are fetched by TeraDataDBcataloger if Database name not passed in url
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user waits for the final status to be reflected after "20000" milliseconds
    And user enters the search text "SC18TeradataCatalogerWithoutDBFilter" and clicks on search
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType  | count |
      | Cluster    | 1     |
      | Service    | 1     |
      | User       | 7     |
      | Constraint | 11    |
      | Trigger    | 20    |
      | Database   | 43    |
      | DataType   | 204   |
      | Routine    | 266   |
      | Index      | 592   |
      | Table      | 1137  |
      | Column     | 20443 |

  ##6650664##
  @webtest @jdbc @MLP-10017
  Scenario:SC#41:Verify the technology tags got assigned to all Teradata DB items like Cluster,Service,Database...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                                            | fileName                     | userTag                              |
      | Default     | Cluster    | Metadata Type | Teradata,SC18TeradataCatalogerWithoutDBFilter,Test_BA_Teradata | didtde01v.did.dev.asgint.loc | SC18TeradataCatalogerWithoutDBFilter |
      | Default     | Service    | Metadata Type | Teradata,SC18TeradataCatalogerWithoutDBFilter,Test_BA_Teradata | Teradata                     | SC18TeradataCatalogerWithoutDBFilter |
      | Default     | Trigger    | Metadata Type | Teradata,SC18TeradataCatalogerWithoutDBFilter,Test_BA_Teradata | RaiseTrig                    | SC18TeradataCatalogerWithoutDBFilter |
      | Default     | User       | Metadata Type | Teradata,SC18TeradataCatalogerWithoutDBFilter,Test_BA_Teradata | DBC                          | SC18TeradataCatalogerWithoutDBFilter |
      | Default     | Constraint | Metadata Type | Teradata,SC18TeradataCatalogerWithoutDBFilter,Test_BA_Teradata | empForeign                   | SC18TeradataCatalogerWithoutDBFilter |
      | Default     | Database   | Metadata Type | Teradata,SC18TeradataCatalogerWithoutDBFilter,Test_BA_Teradata | automation_test_db           | SC18TeradataCatalogerWithoutDBFilter |


  Scenario: SC#42: Delete the items for scenario: without filters
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                | type     | query | param |
      | SingleItemDelete | Default | didtde01v.did.dev.asgint.loc        | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera% | Analysis |       |       |

  ############################################# TeradataDBCataloger - with Arguments and Database filter ##########################################################
  @jdbc
  Scenario: SC#43-Start the Plugin Configuration which has Arguments and Database filter
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                           | body                                                                                                          | response code | response message                         | jsonPath                                                                      | endpointType | itemName |
      | application/json |       |       | Put          | settings/analyzers/TeradataDBCataloger/TeradataCatalogerWithArgumentAndDBfilter                               | ida/jdbcAnalyzerPayloads/Teradata/PluginConfiguration/sc19TeradataCatalogerWithArgumentAndDBfilterConfig.json | 204           |                                          |                                                                               |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBCataloger                                                                        |                                                                                                               | 200           | TeradataCatalogerWithArgumentAndDBfilter |                                                                               |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeradataCatalogerWithArgumentAndDBfilter |                                                                                                               | 200           | IDLE                                     | $.[?(@.configurationName=='TeradataCatalogerWithArgumentAndDBfilter')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeradataCatalogerWithArgumentAndDBfilter  | ida/jdbcAnalyzerPayloads/empty.json                                                                           | 200           |                                          |                                                                               |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeradataCatalogerWithArgumentAndDBfilter |                                                                                                               | 200           | IDLE                                     | $.[?(@.configurationName=='TeradataCatalogerWithArgumentAndDBfilter')].status |              |          |


  ##6657385##
  @webtest @jdbc @MLP-10017
  Scenario: SC#44-Verify Teradata Cataloger input argument filter.applyToUsers = false should override the default TRUE value
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user waits for the final status to be reflected after "20000" milliseconds
    And user enters the search text "SC19TeradataCatalogerWithArgumentAndDBfilter" and clicks on search
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Database  | 20    |

  Scenario: SC#44: Delete the items for scenario: with Arguments and Database filter
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                | type     | query | param |
      | SingleItemDelete | Default | didtde01v.did.dev.asgint.loc        | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera% | Analysis |       |       |


  ############################################# TeradataDBCataloger - username and password are incorrect ##########################################################
  ##6650660##
  @webtest @jdbc @MLP-10017
  Scenario: SC#45-Verify TeradataDBCataloger does not scans and collects and any data if username and password are incorrectly provided
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                            | body                                                                                                           | response code | response message                          | jsonPath                                                                       | endpointType | itemName |
      | application/json |       |       | Put          | settings/analyzers/TeradataDBCataloger/TeradataCatalogerWithIncorrectCredentials                               | ida/jdbcAnalyzerPayloads/Teradata/PluginConfiguration/sc21TeradataCatalogerWithIncorrectCredentialsConfig.json | 204           |                                           |                                                                                |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBCataloger                                                                         |                                                                                                                | 200           | TeradataCatalogerWithIncorrectCredentials |                                                                                |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeradataCatalogerWithIncorrectCredentials |                                                                                                                | 200           | IDLE                                      | $.[?(@.configurationName=='TeradataCatalogerWithIncorrectCredentials')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeradataCatalogerWithIncorrectCredentials  | ida/jdbcAnalyzerPayloads/empty.json                                                                            | 200           |                                           |                                                                                |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeradataCatalogerWithIncorrectCredentials |                                                                                                                | 200           | IDLE                                      | $.[?(@.configurationName=='TeradataCatalogerWithIncorrectCredentials')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC21TeradataCatalogerWithIncorrectCredentials" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/TeradataDBCataloger/TeradataCatalogerWithIncorrectCredentials%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 3             | Description |
    Then Analysis log "cataloger/TeradataDBCataloger/TeradataCatalogerWithIncorrectCredentials%" should display below info/error/warning
      | type  | logValue                                    | logCode | pluginName | removableText |
      | ERROR | The UserId, Password or Account is invalid. |         |            |               |

  Scenario: SC#45: Delete the items for scenario: if username and password are incorrectly provided
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                | type     | query | param |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera% | Analysis |       |       |


  @jdbc
  Scenario: SC#46-Drop Constraint from Table
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField     |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | dropConstraint |

  @jdbc
  Scenario: SC#46-Drop Table
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation | Schema | Table                | Database           |
      | teradata_db16      | DROP      |        | TABLE_PRIMARY        | automation_test_db |
      | teradata_db16      | DROP      |        | TERADATA_TAG_DETAILS | automation_test_db |
      | teradata_db16      | DROP      |        | TERADATA_EMPTY       | automation_test_db |
      | teradata_db16      | DROP      |        | TERADATA_TABLE       | automation_test_db |
      | teradata_db16      | DROP      |        | ForeignTest          | automation_test_db |
      | teradata_db16      | DROP      |        | UniqueTest           | automation_test_db |
      | teradata_db16      | DROP      |        | PrimaryTest          | automation_test_db |


  @jdbc
  Scenario: SC#46-Delete and Drop Database and User
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField     |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | deleteDatabase |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | dropDatabase   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | deleteUser     |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | dropUser       |


  @jdbc
  Scenario:SC#47-Create User in TeradataDatabase for filter scenario
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField              |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createUser2InTeradataDB |
    And user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField          |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createDB2inTeradata |
    And user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField           |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | grantUser2Permission |
    And user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField                 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createConstraintTable2     |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createEmptyTimeStampTable2 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createUniqueConstraint2    |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createPrimaryConstraint2   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createForeignConstraint2   |
    And sync the test execution for "20" seconds
    And user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField      |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createTable2    |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecorddb2 |


    # 6752561 # 6752699  # 6752743
  @jdbc @10.2
  Scenario Outline: SC#48-Run teradata cataloger with database in filter configuraton
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                | body                                                                                         | response code | response message              | jsonPath                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/TeradataDBCataloger/TeraDataWithDatabaseFilterSC1                               | ida/jdbcAnalyzerPayloads/Teradata/PluginConfiguration/sc23TeraDataWithDatabaseFilterSC1.json | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/TeradataDBCataloger                                                             |                                                                                              | 200           | TeraDataWithDatabaseFilterSC1 |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataWithDatabaseFilterSC1 |                                                                                              | 200           | IDLE                          | $.[?(@.configurationName=='TeraDataWithDatabaseFilterSC1')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataWithDatabaseFilterSC1  | ida/jdbcAnalyzerPayloads/empty.json                                                          | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataWithDatabaseFilterSC1 |                                                                                              | 200           | IDLE                          | $.[?(@.configurationName=='TeraDataWithDatabaseFilterSC1')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/TeradataDBCataloger/TeraDataWithDatabaseFilterSC2                               | ida/jdbcAnalyzerPayloads/Teradata/PluginConfiguration/sc23TeraDataWithDatabaseFilterSC2.json | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/TeradataDBCataloger                                                             |                                                                                              | 200           | TeraDataWithDatabaseFilterSC2 |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataWithDatabaseFilterSC2 |                                                                                              | 200           | IDLE                          | $.[?(@.configurationName=='TeraDataWithDatabaseFilterSC2')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataWithDatabaseFilterSC2  | ida/jdbcAnalyzerPayloads/empty.json                                                          | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataWithDatabaseFilterSC2 |                                                                                              | 200           | IDLE                          | $.[?(@.configurationName=='TeraDataWithDatabaseFilterSC2')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/TeradataDBCataloger/TeraDataWithDatabaseFilterSC3                               | ida/jdbcAnalyzerPayloads/Teradata/PluginConfiguration/sc23TeraDataWithDatabaseFilterSC3.json | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/TeradataDBCataloger                                                             |                                                                                              | 200           | TeraDataWithDatabaseFilterSC3 |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataWithDatabaseFilterSC3 |                                                                                              | 200           | IDLE                          | $.[?(@.configurationName=='TeraDataWithDatabaseFilterSC3')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataWithDatabaseFilterSC3  | ida/jdbcAnalyzerPayloads/empty.json                                                          | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataWithDatabaseFilterSC3 |                                                                                              | 200           | IDLE                          | $.[?(@.configurationName=='TeraDataWithDatabaseFilterSC3')].status |

  @jdbc @10.2 @webtest
  Scenario: SC#49: Verify Scan TeraData cataloger collects items when Database name provided with regular expression
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TeradataCatalogerWithDBfilterRegex1" and clicks on search
    And user performs "facet selection" in "SC1TeradataCatalogerWithDBfilterRegex1" attribute under "Tags" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 50 items" in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Database  | 1     |
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | automation_test_db2 |
    And user enters the search text "SC1TeradataCatalogerWithDBfilterRegex2" and clicks on search
    And user performs "facet selection" in "SC1TeradataCatalogerWithDBfilterRegex2" attribute under "Tags" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 50 items" in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Database  | 1     |
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | automation_test_db2 |
    And user enters the search text "SC1TeradataCatalogerWithDBfilterRegex3" and clicks on search
    And user performs "facet selection" in "SC1TeradataCatalogerWithDBfilterRegex3" attribute under "Tags" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 50 items" in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Database  | 1     |
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | automation_test_db2 |

  Scenario: SC#49: Delete the items for scenario: Database name provided with regular expression
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                | type     | query | param |
      | SingleItemDelete | Default | didtde01v.did.dev.asgint.loc        | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera% | Analysis |       |       |

     #6752746    # 6752928  # 6752929
  Scenario Outline: SC#50-Run teradata cataloger with user in filter configuraton
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | body                                                                                     | response code | response message          | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/TeradataDBCataloger/TeraDataWithUserFilterSC4                               | ida/jdbcAnalyzerPayloads/Teradata/PluginConfiguration/sc24TeraDataWithUserFilterSC4.json | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/TeradataDBCataloger                                                         |                                                                                          | 200           | TeraDataWithUserFilterSC4 |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataWithUserFilterSC4 |                                                                                          | 200           | IDLE                      | $.[?(@.configurationName=='TeraDataWithUserFilterSC4')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataWithUserFilterSC4  | ida/jdbcAnalyzerPayloads/empty.json                                                      | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataWithUserFilterSC4 |                                                                                          | 200           | IDLE                      | $.[?(@.configurationName=='TeraDataWithUserFilterSC4')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/TeradataDBCataloger/TeraDataWithUserFilterSC5                               | ida/jdbcAnalyzerPayloads/Teradata/PluginConfiguration/sc24TeraDataWithUserFilterSC5.json | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/TeradataDBCataloger                                                         |                                                                                          | 200           | TeraDataWithUserFilterSC5 |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataWithUserFilterSC5 |                                                                                          | 200           | IDLE                      | $.[?(@.configurationName=='TeraDataWithUserFilterSC5')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataWithUserFilterSC5  | ida/jdbcAnalyzerPayloads/empty.json                                                      | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataWithUserFilterSC5 |                                                                                          | 200           | IDLE                      | $.[?(@.configurationName=='TeraDataWithUserFilterSC5')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/TeradataDBCataloger/TeraDataWithUserFilterSC6                               | ida/jdbcAnalyzerPayloads/Teradata/PluginConfiguration/sc24TeraDataWithUserFilterSC6.json | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/TeradataDBCataloger                                                         |                                                                                          | 200           | TeraDataWithUserFilterSC6 |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataWithUserFilterSC6 |                                                                                          | 200           | IDLE                      | $.[?(@.configurationName=='TeraDataWithUserFilterSC6')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataWithUserFilterSC6  | ida/jdbcAnalyzerPayloads/empty.json                                                      | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataWithUserFilterSC6 |                                                                                          | 200           | IDLE                      | $.[?(@.configurationName=='TeraDataWithUserFilterSC6')].status |


  @jdbc @10.2 @webtest
  Scenario: SC#51: Verify Scan TeraData cataloger collects items when username provided with regular expression
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TeraDataWithUserFilterSC4" and clicks on search
    And user performs "facet selection" in "TeraDataWithUserFilterSC4" attribute under "Tags" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 17972 items" in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Database  | 1     |
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | DBC |
    And user enters the search text "TeraDataWithUserFilterSC5" and clicks on search
    And user performs "facet selection" in "TeraDataWithUserFilterSC5" attribute under "Tags" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 17972 items" in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Database  | 1     |
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | DBC |
    And user enters the search text "TeraDataWithUserFilterSC6" and clicks on search
    And user performs "facet selection" in "TeraDataWithUserFilterSC6" attribute under "Tags" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 17972 items" in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Database  | 1     |
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | DBC |

  Scenario: SC#51: Delete the items for scenario: when username provided with regular expression
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                | type                | query | param |
      | SingleItemDelete | Default | didtde01v.did.dev.asgint.loc        | Cluster             |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera% | Analysis            |       |       |
      | SingleItemDelete | Default | Test_BA_Teradata                    | BusinessApplication |       |       |


  @jdbc
  Scenario:SC#51 Delete and Drop Database and User of filter scenarios
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField      |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | deleteDatabase2 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | dropDatabase2   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | deleteUser2     |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | dropUser2       |

  ############################################# Policy Patterns - PII Tagging ##########################################################
  @jdbc
  Scenario: SC#52-Create User in TeradataDatabase
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField             |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createUserInTeradataDB |

  @jdbc
  Scenario: SC#52-Create Database in TeradataDatabase
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField         |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createDBinTeradata |

  @jdbc
  Scenario: SC#52-Create User permission in TeradataDatabase
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField          |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | grantUserPermission |

  @jdbc
  Scenario: SC#52-Create Table1 and insert value for PII Tags verification
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField             |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createPIITable1        |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord1PIITable1 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord2PIITable1 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord3PIITable1 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord4PIITable1 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord5PIITable1 |

  @jdbc
  Scenario: SC#52-Create Table2 and insert value for PII Tags verification
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField             |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createPIITable2        |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord1PIITable2 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord2PIITable2 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord3PIITable2 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord4PIITable2 |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord5PIITable2 |

  @jdbc
  Scenario: SC#52-Create Table3 and insert value for PII Tags verification
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField              |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createPIITable3         |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord1PIITable3  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord2PIITable3  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord3PIITable3  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord4PIITable3  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord5PIITable3  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord6PIITable3  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord7PIITable3  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord8PIITable3  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord9PIITable3  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord10PIITable3 |

  @jdbc
  Scenario: SC#52-Create Table4 and insert value for PII Tags verification
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField              |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createPIITable4         |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord1PIITable4  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord2PIITable4  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord3PIITable4  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord4PIITable4  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord5PIITable4  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord6PIITable4  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord7PIITable4  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord8PIITable4  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord9PIITable4  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord10PIITable4 |

  @jdbc
  Scenario: SC#52-Create Table5 and insert value for PII Tags verification
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField              |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createPIITable5         |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord1PIITable5  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord2PIITable5  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord3PIITable5  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord4PIITable5  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord5PIITable5  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord6PIITable5  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord7PIITable5  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord8PIITable5  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord9PIITable5  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord10PIITable5 |

  @jdbc
  Scenario: SC#52-Create Table6 and insert value for PII Tags verification
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField              |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createPIITable6         |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord1PIITable6  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord2PIITable6  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord3PIITable6  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord4PIITable6  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord5PIITable6  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord6PIITable6  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord7PIITable6  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord8PIITable6  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord9PIITable6  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord10PIITable6 |

  @jdbc
  Scenario: SC#52-Create Table7 and insert value for PII Tags verification
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField              |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | createPIITable7         |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord1PIITable7  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord2PIITable7  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord3PIITable7  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord4PIITable7  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord5PIITable7  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord6PIITable7  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord7PIITable7  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord8PIITable7  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord9PIITable7  |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | insertRecord10PIITable7 |

  Scenario Outline:SC#52:Create root tag and sub tag for TeradataDB and Update policy tags for TeradataDBAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                                                       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | tags/Default/structures | ida/jdbcAnalyzerPayloads/Teradata/policyEngine/teradataDBTagStructure.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions  | ida/jdbcAnalyzerPayloads/Teradata/policyEngine/teradataDB_policy1.1.0.json | 204           |                  |          |


  Scenario Outline: SC#53:Run TeradataDBCataloger & TeradataDBAnalyzer to verify PII Tags
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                               | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/TeradataDBCataloger/TeraDataCatalogerPII                               | ida/jdbcAnalyzerPayloads/Teradata/PluginConfiguration/sc2TeradataCatalogerPII.json | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/TeradataDBCataloger                                                    |                                                                                    | 200           | TeraDataCatalogerPII |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerPII |                                                                                    | 200           | IDLE                 | $.[?(@.configurationName=='TeraDataCatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerPII  | ida/jdbcAnalyzerPayloads/empty.json                                                | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerPII |                                                                                    | 200           | IDLE                 | $.[?(@.configurationName=='TeraDataCatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/TeradataDBAnalyzer                                                     |                                                                                    | 200           | TeradataAnalyzer     |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzer   |                                                                                    | 200           | IDLE                 | $.[?(@.configurationName=='TeradataAnalyzer')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzer    | ida/jdbcAnalyzerPayloads/empty.json                                                | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzer   |                                                                                    | 200           | IDLE                 | $.[?(@.configurationName=='TeradataAnalyzer')].status     |

  @jdbc @PIITag
  Scenario: SC#54: Verify PII Tags gets assigned to the below columns in table: TAGDETAILS_ALLMATCH
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                  | ServiceName | DatabaseName       | TableName/Filename  | Column    | Tags                                                                                      | Query                    | Action      |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_ALLMATCH | EMAIL     | TeradataDBEmailPII_SC1Tag,TeradataDBEmailPII_SC3Tag,TeradataDBEmailPII_SC8Tag             | ColumnQuerywithoutSchema | TagAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_ALLMATCH | GENDER    | TeradataDBGenderPII_SC1Tag,TeradataDBGenderPII_SC3Tag,TeradataDBGenderPII_SC8Tag          | ColumnQuerywithoutSchema | TagAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_ALLMATCH | IPADDRESS | TeradataDBIPAddressPII_SC1Tag,TeradataDBIPAddressPII_SC3Tag,TeradataDBIPAddressPII_SC8Tag | ColumnQuerywithoutSchema | TagAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_ALLMATCH | SSN       | TeradataDBSSNPII_SC1Tag,TeradataDBSSNPII_SC3Tag,TeradataDBSSNPII_SC8Tag                   | ColumnQuerywithoutSchema | TagAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_ALLMATCH | FULL_NAME | TeradataDBFullNamePII_SC1Tag,TeradataDBFullNamePII_SC3Tag,TeradataDBFullNamePII_SC8Tag    | ColumnQuerywithoutSchema | TagAssigned |

  @jdbc @PIITag
  Scenario: SC#54: Verify PII Tags doesn't gets assigned to the below columns in table: TAGDETAILS_ALLMATCH
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                  | ServiceName | DatabaseName       | TableName/Filename  | Column    | Tags                                                                                                                                                     | Query                    | Action         |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_ALLMATCH | EMAIL     | TeradataDBEmailPII_SC2Tag,TeradataDBEmailPII_SC4Tag,TeradataDBEmailPII_SC11Tag,TeradataDBEmailPII_SC12Tag,TeradataDBEmailPII_SC13Tag                     | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_ALLMATCH | GENDER    | TeradataDBGenderPII_SC2Tag,TeradataDBGenderPII_SC4Tag,TeradataDBGenderPII_SC11Tag,TeradataDBGenderPII_SC12Tag,TeradataDBGenderPII_SC13Tag                | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_ALLMATCH | IPADDRESS | TeradataDBIPAddressPII_SC2Tag,TeradataDBIPAddressPII_SC4Tag,TeradataDBIPAddressPII_SC11Tag,TeradataDBIPAddressPII_SC12Tag,TeradataDBIPAddressPII_SC13Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_ALLMATCH | SSN       | TeradataDBSSNPII_SC2Tag,TeradataDBSSNPII_SC4Tag,TeradataDBSSNPII_SC11Tag,TeradataDBSSNPII_SC12Tag,TeradataDBSSNPII_SC13Tag                               | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_ALLMATCH | FULL_NAME | TeradataDBFullNamePII_SC2Tag,TeradataDBFullNamePII_SC4Tag,TeradataDBFullNamePII_SC11Tag,TeradataDBFullNamePII_SC12Tag,TeradataDBFullNamePII_SC13Tag      | ColumnQuerywithoutSchema | TagNotAssigned |

  @jdbc @PIITag
  Scenario: SC#55: Verify PII Tags gets assigned to the below columns in table: TAGDETAILS_ALLEMPTY
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                  | ServiceName | DatabaseName       | TableName/Filename  | Column    | Tags                                                                                                                     | Query                    | Action      |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_ALLEMPTY | EMAIL     | TeradataDBEmailPII_SC1Tag,TeradataDBEmailPII_SC3Tag,TeradataDBEmailPII_SC8Tag,TeradataDBEmailPII_SC14Tag                 | ColumnQuerywithoutSchema | TagAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_ALLEMPTY | IPADDRESS | TeradataDBIPAddressPII_SC1Tag,TeradataDBIPAddressPII_SC3Tag,TeradataDBIPAddressPII_SC8Tag,TeradataDBIPAddressPII_SC14Tag | ColumnQuerywithoutSchema | TagAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_ALLEMPTY | SSN       | TeradataDBSSNPII_SC1Tag,TeradataDBSSNPII_SC3Tag,TeradataDBSSNPII_SC8Tag,TeradataDBSSNPII_SC14Tag                         | ColumnQuerywithoutSchema | TagAssigned |

  @jdbc @PIITag
  Scenario: SC#55: Verify PII Tags doesn't gets assigned to the below columns in table: TAGDETAILS_ALLEMPTY
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                  | ServiceName | DatabaseName       | TableName/Filename  | Column    | Tags                                                                                                                                                     | Query                    | Action         |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_ALLEMPTY | EMAIL     | TeradataDBEmailPII_SC2Tag,TeradataDBEmailPII_SC4Tag,TeradataDBEmailPII_SC11Tag,TeradataDBEmailPII_SC12Tag,TeradataDBEmailPII_SC13Tag                     | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_ALLEMPTY | GENDER    | TeradataDBGenderPII_SC2Tag,TeradataDBGenderPII_SC4Tag,TeradataDBGenderPII_SC11Tag,TeradataDBGenderPII_SC12Tag,TeradataDBGenderPII_SC13Tag                | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_ALLEMPTY | IPADDRESS | TeradataDBIPAddressPII_SC2Tag,TeradataDBIPAddressPII_SC4Tag,TeradataDBIPAddressPII_SC11Tag,TeradataDBIPAddressPII_SC12Tag,TeradataDBIPAddressPII_SC13Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_ALLEMPTY | SSN       | TeradataDBSSNPII_SC2Tag,TeradataDBSSNPII_SC4Tag,TeradataDBSSNPII_SC11Tag,TeradataDBSSNPII_SC12Tag,TeradataDBSSNPII_SC13Tag                               | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_ALLEMPTY | FULL_NAME | TeradataDBFullNamePII_SC2Tag,TeradataDBFullNamePII_SC4Tag,TeradataDBFullNamePII_SC11Tag,TeradataDBFullNamePII_SC12Tag,TeradataDBFullNamePII_SC13Tag      | ColumnQuerywithoutSchema | TagNotAssigned |

  @jdbc @PIITag
  Scenario: SC#56: Verify PII Tags gets assigned to the below columns in table: TAGDETAILS_Ratiolessthan05EmptyFalse
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                  | ServiceName | DatabaseName       | TableName/Filename                   | Column    | Tags                                                                                                                     | Query                    | Action      |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiolessthan05EmptyFalse | EMAIL     | TeradataDBEmailPII_SC1Tag,TeradataDBEmailPII_SC3Tag,TeradataDBEmailPII_SC5Tag,TeradataDBEmailPII_SC10Tag                 | ColumnQuerywithoutSchema | TagAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiolessthan05EmptyFalse | GENDER    | TeradataDBGenderPII_SC1Tag,TeradataDBGenderPII_SC3Tag,TeradataDBGenderPII_SC5Tag,TeradataDBGenderPII_SC10Tag             | ColumnQuerywithoutSchema | TagAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiolessthan05EmptyFalse | IPADDRESS | TeradataDBIPAddressPII_SC1Tag,TeradataDBIPAddressPII_SC3Tag,TeradataDBIPAddressPII_SC5Tag,TeradataDBIPAddressPII_SC10Tag | ColumnQuerywithoutSchema | TagAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiolessthan05EmptyFalse | SSN       | TeradataDBSSNPII_SC5Tag,TeradataDBSSNPII_SC10Tag                                                                         | ColumnQuerywithoutSchema | TagAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiolessthan05EmptyFalse | FULL_NAME | TeradataDBFullNamePII_SC5Tag,TeradataDBFullNamePII_SC10Tag                                                               | ColumnQuerywithoutSchema | TagAssigned |

  @jdbc @PIITag
  Scenario: SC#56: Verify PII Tags doesn't gets assigned to the below columns in table: TAGDETAILS_Ratiolessthan05EmptyFalse
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                  | ServiceName | DatabaseName       | TableName/Filename                   | Column    | Tags                                                                                                                                                                                                          | Query                    | Action         |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiolessthan05EmptyFalse | EMAIL     | TeradataDBEmailPII_SC2Tag,TeradataDBEmailPII_SC4Tag,TeradataDBEmailPII_SC11Tag,TeradataDBEmailPII_SC12Tag,TeradataDBEmailPII_SC13Tag                                                                          | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiolessthan05EmptyFalse | GENDER    | TeradataDBGenderPII_SC2Tag,TeradataDBGenderPII_SC4Tag,TeradataDBGenderPII_SC11Tag,TeradataDBGenderPII_SC12Tag,TeradataDBGenderPII_SC13Tag                                                                     | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiolessthan05EmptyFalse | IPADDRESS | TeradataDBIPAddressPII_SC2Tag,TeradataDBIPAddressPII_SC4Tag,TeradataDBIPAddressPII_SC11Tag,TeradataDBIPAddressPII_SC12Tag,TeradataDBIPAddressPII_SC13Tag                                                      | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiolessthan05EmptyFalse | SSN       | TeradataDBSSNPII_SC1Tag,TeradataDBSSNPII_SC3Tag,TeradataDBSSNPII_SC2Tag,TeradataDBSSNPII_SC4Tag,TeradataDBSSNPII_SC11Tag,TeradataDBSSNPII_SC12Tag,TeradataDBSSNPII_SC13Tag                                    | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiolessthan05EmptyFalse | FULL_NAME | TeradataDBFullNamePII_SC1Tag,TeradataDBFullNamePII_SC3Tag,TeradataDBFullNamePII_SC2Tag,TeradataDBFullNamePII_SC4Tag,TeradataDBFullNamePII_SC11Tag,TeradataDBFullNamePII_SC12Tag,TeradataDBFullNamePII_SC13Tag | ColumnQuerywithoutSchema | TagNotAssigned |

  @jdbc @PIITag
  Scenario: SC#57: Verify PII Tags gets assigned to the below columns in table: TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                  | ServiceName | DatabaseName       | TableName/Filename                          | Column    | Tags                                                                                                                                                                                 | Query                    | Action      |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | TeradataDBEmailPII_SC1Tag,TeradataDBEmailPII_SC3Tag,TeradataDBEmailPII_SC5Tag,TeradataDBEmailPII_SC6Tag,TeradataDBEmailPII_SC7Tag,TeradataDBEmailPII_SC10Tag                         | ColumnQuerywithoutSchema | TagAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | TeradataDBGenderPII_SC1Tag,TeradataDBGenderPII_SC3Tag,TeradataDBGenderPII_SC5Tag,TeradataDBGenderPII_SC10Tag                                                                         | ColumnQuerywithoutSchema | TagAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | TeradataDBIPAddressPII_SC1Tag,TeradataDBIPAddressPII_SC3Tag,TeradataDBIPAddressPII_SC5Tag,TeradataDBIPAddressPII_SC6Tag,TeradataDBIPAddressPII_SC7Tag,TeradataDBIPAddressPII_SC10Tag | ColumnQuerywithoutSchema | TagAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | TeradataDBSSNPII_SC5Tag,TeradataDBSSNPII_SC10Tag                                                                                                                                     | ColumnQuerywithoutSchema | TagAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | TeradataDBFullNamePII_SC5Tag,TeradataDBFullNamePII_SC10Tag                                                                                                                           | ColumnQuerywithoutSchema | TagAssigned |

  @jdbc @PIITag
  Scenario: SC#57: Verify PII Tags doesn't gets assigned to the below columns in table: TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                  | ServiceName | DatabaseName       | TableName/Filename                          | Column    | Tags                                                                                                                                                                                                          | Query                    | Action         |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | TeradataDBEmailPII_SC2Tag,TeradataDBEmailPII_SC4Tag,TeradataDBEmailPII_SC11Tag,TeradataDBEmailPII_SC12Tag,TeradataDBEmailPII_SC13Tag                                                                          | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | TeradataDBGenderPII_SC2Tag,TeradataDBGenderPII_SC4Tag,TeradataDBGenderPII_SC11Tag,TeradataDBGenderPII_SC12Tag,TeradataDBGenderPII_SC13Tag                                                                     | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | TeradataDBIPAddressPII_SC2Tag,TeradataDBIPAddressPII_SC4Tag,TeradataDBIPAddressPII_SC11Tag,TeradataDBIPAddressPII_SC12Tag,TeradataDBIPAddressPII_SC13Tag                                                      | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | TeradataDBSSNPII_SC1Tag,TeradataDBSSNPII_SC3Tag,TeradataDBSSNPII_SC2Tag,TeradataDBSSNPII_SC4Tag,TeradataDBSSNPII_SC11Tag,TeradataDBSSNPII_SC12Tag,TeradataDBSSNPII_SC13Tag                                    | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | TeradataDBFullNamePII_SC1Tag,TeradataDBFullNamePII_SC3Tag,TeradataDBFullNamePII_SC2Tag,TeradataDBFullNamePII_SC4Tag,TeradataDBFullNamePII_SC11Tag,TeradataDBFullNamePII_SC12Tag,TeradataDBFullNamePII_SC13Tag | ColumnQuerywithoutSchema | TagNotAssigned |

  @jdbc @PIITag
  Scenario: SC#58: Verify PII Tags gets assigned to the below columns in table: TAGDETAILS_RatioEqualTo05EmptyFalse
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                  | ServiceName | DatabaseName       | TableName/Filename                  | Column    | Tags                                                                                      | Query                    | Action      |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_RatioEqualTo05EmptyFalse | EMAIL     | TeradataDBEmailPII_SC1Tag,TeradataDBEmailPII_SC3Tag,TeradataDBEmailPII_SC9Tag             | ColumnQuerywithoutSchema | TagAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_RatioEqualTo05EmptyFalse | GENDER    | TeradataDBGenderPII_SC1Tag,TeradataDBGenderPII_SC3Tag,TeradataDBGenderPII_SC9Tag          | ColumnQuerywithoutSchema | TagAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_RatioEqualTo05EmptyFalse | IPADDRESS | TeradataDBIPAddressPII_SC1Tag,TeradataDBIPAddressPII_SC3Tag,TeradataDBIPAddressPII_SC9Tag | ColumnQuerywithoutSchema | TagAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_RatioEqualTo05EmptyFalse | SSN       | TeradataDBSSNPII_SC1Tag,TeradataDBSSNPII_SC3Tag,TeradataDBSSNPII_SC9Tag                   | ColumnQuerywithoutSchema | TagAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_RatioEqualTo05EmptyFalse | FULL_NAME | TeradataDBFullNamePII_SC1Tag,TeradataDBFullNamePII_SC3Tag,TeradataDBFullNamePII_SC9Tag    | ColumnQuerywithoutSchema | TagAssigned |

  @jdbc @PIITag
  Scenario: SC#58: Verify PII Tags doesn't gets assigned to the below columns in table: TAGDETAILS_RatioEqualTo05EmptyFalse
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                  | ServiceName | DatabaseName       | TableName/Filename                  | Column    | Tags                                                                                                                                                     | Query                    | Action         |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_RatioEqualTo05EmptyFalse | EMAIL     | TeradataDBEmailPII_SC2Tag,TeradataDBEmailPII_SC4Tag,TeradataDBEmailPII_SC11Tag,TeradataDBEmailPII_SC12Tag,TeradataDBEmailPII_SC13Tag                     | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_RatioEqualTo05EmptyFalse | GENDER    | TeradataDBGenderPII_SC2Tag,TeradataDBGenderPII_SC4Tag,TeradataDBGenderPII_SC11Tag,TeradataDBGenderPII_SC12Tag,TeradataDBGenderPII_SC13Tag                | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_RatioEqualTo05EmptyFalse | IPADDRESS | TeradataDBIPAddressPII_SC2Tag,TeradataDBIPAddressPII_SC4Tag,TeradataDBIPAddressPII_SC11Tag,TeradataDBIPAddressPII_SC12Tag,TeradataDBIPAddressPII_SC13Tag | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_RatioEqualTo05EmptyFalse | SSN       | TeradataDBSSNPII_SC2Tag,TeradataDBSSNPII_SC4Tag,TeradataDBSSNPII_SC11Tag,TeradataDBSSNPII_SC12Tag,TeradataDBSSNPII_SC13Tag                               | ColumnQuerywithoutSchema | TagNotAssigned |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_RatioEqualTo05EmptyFalse | FULL_NAME | TeradataDBFullNamePII_SC2Tag,TeradataDBFullNamePII_SC4Tag,TeradataDBFullNamePII_SC11Tag,TeradataDBFullNamePII_SC12Tag,TeradataDBFullNamePII_SC13Tag      | ColumnQuerywithoutSchema | TagNotAssigned |

  @jdbc @PIITag
  Scenario: SC#59: Verify PII Tags gets assigned to the below columns in table: TAGDETAILS_Ratiogreaterthan05MatchFullTrue
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                  | ServiceName | DatabaseName       | TableName/Filename                         | Column   | Tags                          | Query                    | Action      |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | Comments | TeradataDBFullMatchPII_SC2Tag | ColumnQuerywithoutSchema | TagAssigned |

  @jdbc @PIITag
  Scenario: SC#59: Verify PII Tags doesn't gets assigned to the below columns in table: TAGDETAILS_Ratiogreaterthan05MatchFullTrue
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                  | ServiceName | DatabaseName       | TableName/Filename                         | Column   | Tags                          | Query                    | Action         |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | Comments | TeradataDBFullMatchPII_SC1Tag | ColumnQuerywithoutSchema | TagNotAssigned |

  @jdbc @PIITag
  Scenario: SC#60: Verify PII Tags gets assigned to the below columns in table: TAGDETAILS_Ratiolesserthan05MatchFullTrue
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                  | ServiceName | DatabaseName       | TableName/Filename                        | Column   | Tags                          | Query                    | Action      |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiolesserthan05MatchFullTrue | Comments | TeradataDBFullMatchPII_SC4Tag | ColumnQuerywithoutSchema | TagAssigned |

  @jdbc @PIITag
  Scenario: SC#60: Verify PII Tags doesn't gets assigned to the below columns in table: TAGDETAILS_Ratiolesserthan05MatchFullTrue
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                  | ServiceName | DatabaseName       | TableName/Filename                        | Column   | Tags                          | Query                    | Action         |
      | didtde01v.did.dev.asgint.loc | Teradata    | automation_test_db | TAGDETAILS_Ratiolesserthan05MatchFullTrue | Comments | TeradataDBFullMatchPII_SC3Tag | ColumnQuerywithoutSchema | TagNotAssigned |

  @jdbc
  Scenario: SC#60-Delete and Drop Database and User for PII Tags
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage             | queryField     |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | deleteDatabase |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | dropDatabase   |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | deleteUser     |
      | teradata_db16      | EXECUTEQUERY | json/IDA.json | teradata_db16_Queries | dropUser       |

  Scenario: SC#60: Delete the items for scenario: PII TAGS
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                  | type     | query | param |
      | SingleItemDelete | Default | didtde01v.did.dev.asgint.loc          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/TeradataDBAnalyzer/Tera% | Analysis |       |       |

  @jdbc
  Scenario Outline: SC#61: Delete the Teradata Credential, DataSource and Plugin Configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                                     | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | policy/tagging/analysis?dataType=STRUCTURED&pluginName=TeradataDBAnalyzer&technologies= |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/TeradataCredentials                                                |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/TeradataInvalidCredentials                                         |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/TeradataEmptyCredentials                                           |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/TeradataDBDataSource                                                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/TeradataDBCataloger                                                  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/TeradataDBAnalyzer                                                   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | /tags/Default/tags/TeradataDBPII                                                        |      | 204           |                  |          |
