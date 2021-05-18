Feature:Verification of Scan UDB Analyzer using DB2 database and plugin validation

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: Add valid and invalid Credentials for ScanUDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                         | body                                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/UDB_Credentials        | ida/ScanUDBPayloads/credentials/Credentials.json        | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/UDB_Credentials        |                                                         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/UDB_InvalidCredentials | ida/ScanUDBPayloads/credentials/InvalidCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/UDB_InvalidCredentials |                                                         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/UDB_EmptyCredentials   | ida/ScanUDBPayloads/credentials/EmptyCredentials.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/UDB_EmptyCredentials   |                                                         | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/UDB_EDIBusCredentials  | idc/EdiBusPayloads/credentials/EDIBusValidCredentials.json | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/UDB_EDIBusCredentials  |                                                            | 200           |                  |          |

  @positve @regression @sanity @webtest
  Scenario:SC01#Verify whether the background of the panel is displayed in green when connection is successful in Local Node
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Settings Icon                                      |
      | click       | Settings Icon                                      |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute     |
      | Data Source Type | UDBDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                    |
      | Name      | UDBDataSource1                               |
      | Label     | UDBDataSource1                               |
      | URL       | jdbc:db2://gechcae-col1.asg.com:50000/SAMPLE |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute       |
      | Credential | UDB_Credentials |
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute |
      | Node      | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
    And user "click" on "Save" button in "Add Data Sources Page"

  @RedShift @positve @regression @sanity
  Scenario:Delete Datasource Configurations
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                              | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/UDBDataSource |      | 204           |                  |          |

  @positve @regression @sanity
  Scenario:Add valid Datasource for ScanUDB
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                              | body                                              | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/UDBDataSource | ida/ScanUDBPayloads/DataSource/UDBDataSource.json | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/UDBDataSource |                                                   | 200           | UDBDataSource    |          |

  @MLP-14629 @webtest
  Scenario: SC#1-Verify whether the background of the panel is displayed in red when test connection is not successful for UDBDataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Settings Icon                                      |
      | click       | Settings Icon                                      |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute     |
      | Data Source Type | UDBDataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                 |
      | Label                 |
      | URL*                  |
      | Credential*           |
      | Driver Bundle Name    |
      | Driver Bundle Version |
      | Driver Name           |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                    |
      | Name*     | AutoUDBDataSourceTest                        |
      | Label     | AutoUDBDataSourceTest                        |
      | URL*      | jdbc:db2://gechcae-col1.asg.com:50000/SAMPLE |
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute              |
      | Credential* | UDB_InvalidCredentials |
      | Node        | LocalNode              |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute            |
      | Credential* | UDB_EmptyCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"


  @redshift @webtest @negative
  Scenario:SC01#Verify whether the background of the panel is displayed in red when connection is unsuccessful in Manage Plugin Configuration page
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
      | fieldName | attribute    |
      | Type      | Cataloger    |
      | Plugin    | UDBCataloger |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute     |
      | Name      | UDB_Cataloger |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName    | attribute              |
      | Data Source* | UDBDataSource          |
      | Credential   | UDB_InvalidCredentials |
    And user "click" on "Test Connection" button in "Add Manage Configuration Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Manage Configuration Sources Page"
    And user verifies "Save Button" is "enabled" in "Add Configuration pop up"

  @MLP-146361 @RedShift @positive @sanity @webtest @IDA_E2E
  Scenario:SC01# Verify proper error message is shown if mandatory fields are not filled in UDB DataSource plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Settings Icon                                      |
      | click       | Settings Icon                                      |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute     |
      | Data Source Type | UDBDataSource |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Name      | A         |
    And user press "BACK_SPACE" key using key press event
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | URL       | A         |
    And user press "BACK_SPACE" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
      | URL       | URL field should not be empty  |
    And user verifies "Save Button" is "enabled" in "Add Configuration pop up"


  #6822672
  @MLP-146361 @RedShift @positive @sanity @webtest @IDA_E2E
  Scenario:SC01# Verify error message is displayed when providing incorrect UDB url in url field
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Settings Icon                                      |
      | click       | Settings Icon                                      |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute     |
      | Data Source Type | UDBDataSource |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Name      | /         |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                                     |
      | URL       | jdbc1:db2://gechcae-col1.asg.com:50000/SAMPLE |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage                                                          |
      | Name      | Invalid name. Leading/trailing blanks and special characters are forbidden |
      | URL       | Value of URL doesnt satisfy given pattern: {1}                             |
    And user verifies "Save Button" is "enabled" in "Add Configuration pop up"

  @webtest
  Scenario: SC01#Verify captions and tool tip text in UDBCataloger
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
      | fieldName | attribute    |
      | Type      | Cataloger    |
      | Plugin    | UDBCataloger |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                |
      | Label                |
      | Business Application |
      | Data Source*         |
      | Credential*          |

  @webtest @jdbc
  Scenario: Verify proper error message is shown if mandatory fields are not filled in UDBCataloger plugin configuration
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
      | fieldName | attribute    |
      | Type      | Cataloger    |
      | Plugin    | UDBCataloger |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |


  @webtest @jdbc
  Scenario: Verify proper error message is shown if mandatory fields are not filled in UDBCAnalyzer plugin configuration
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
      | fieldName | attribute    |
      | Type      | Dataanalyzer |
      | Plugin    | UDBAnalyzer  |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |


 ################################## ************************************* ##############################

  @jdbc
  Scenario: Create Table in DB2
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage  | queryField                |
      | db2                | EXECUTEQUERY | json/IDA.json | db2Queries | createConstraintTable     |
      | db2                | EXECUTEQUERY | json/IDA.json | db2Queries | createEmptyTimeStampTable |


  @jdbc
  Scenario: Create Table and insert value for data sampling
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage  | queryField    |
      | db2                | EXECUTEQUERY | json/IDA.json | db2Queries | createTable   |
      | db2                | EXECUTEQUERY | json/IDA.json | db2Queries | insertRecord1 |
      | db2                | EXECUTEQUERY | json/IDA.json | db2Queries | insertRecord2 |
      | db2                | EXECUTEQUERY | json/IDA.json | db2Queries | insertRecord3 |
      | db2                | EXECUTEQUERY | json/IDA.json | db2Queries | insertRecord4 |


  @jdbc
  Scenario: Create table for Timestamp verification
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage  | queryField            |
      | db2                | EXECUTEQUERY | json/IDA.json | db2Queries | createTimeStampTable  |
      | db2                | EXECUTEQUERY | json/IDA.json | db2Queries | insertTimeStampRecord |

############################## ******************************************************* ################################


  @jdbc
  Scenario:Create Cataloger and Analyser config
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                             | body                                     | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/UDBCataloger | ida/ScanUDBPayloads/CatalogerConfig.json | 204           |                  |          |
      |                  |       |       | Put  | settings/analyzers/UDBAnalyzer  | ida/ScanUDBPayloads/AnalyzerConfig.json  | 204           |                  |          |

  @jdbc @webtest
  Scenario:Run the UDB plugin in Dry Run mode
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                  | body | response code | response message       | jsonPath                                                    |
      | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger                                                      |      | 200           | DB2CatalogerWithDryRun |                                                             |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithDryRun |      | 200           | IDLE                   | $.[?(@.configurationName=='DB2CatalogerWithDryRun')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithDryRun  |      | 200           |                        |                                                             |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithDryRun |      | 200           | IDLE                   | $.[?(@.configurationName=='DB2CatalogerWithDryRun')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "DryUDB" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
    Then Analysis log "cataloger/UDBCataloger/DB2CatalogerWithDryRun/%" should display below info/error/warning
      | type | logValue                                                                                | logCode       | pluginName | removableText |
      | INFO | Plugin UDBCataloger running on dry run mode                                             | ANALYSIS-0069 |            |               |
      | INFO | Plugin UDBCataloger processed 0 items on dry run mode and not written to the repository | ANALYSIS-0070 |            |               |

  @MLP-4441 @sanity @positive
  Scenario:Delete Analysis Id after Dry run
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type     | query | param |
      | SingleItemDelete | Default | cataloger/UDBCataloger/DB2CatalogerWithDryRun% | Analysis |       |       |

  @sanity @positive @regression
  Scenario Outline:Create BusinessApplication tag
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                            | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/ScanUDBPayloads/UDBBusinessApplication.json | 200           |                  |          |


  @jdbc
  Scenario:SC1#Create JDBC Plugin config and start it
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                           | body | response code | response message                | jsonPath                                                             |
      | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger                                                               |      | 200           | DB2CatalogerWithSchemaFilterSC1 |                                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaFilterSC1 |      | 200           | IDLE                            | $.[?(@.configurationName=='DB2CatalogerWithSchemaFilterSC1')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaFilterSC1  |      | 200           |                                 |                                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaFilterSC1 |      | 200           | IDLE                            | $.[?(@.configurationName=='DB2CatalogerWithSchemaFilterSC1')].status |

  @webtest @jdbc
  Scenario:SC1#Verify the breadcrumb hierarchy appears correctly when ScanUDB cataloger is ran for DB2 Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1UDB" and clicks on search
    And user performs "facet selection" in "SC1UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DB2_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "POSTAL_CODE" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | gechcae-col1.asg.com |
      | DB2:50000            |
      | SAMPLE               |
      | UDBTEST1             |
      | DB2_TAG_DETAILS      |
      | POSTAL_CODE          |
    Then Analysis log "cataloger/UDBCataloger/DB2CatalogerWithSchemaFilterSC1/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | logCode       | pluginName   | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0019 |              |                |
      | INFO | Plugin Name:UDBCataloger, Plugin Type:cataloger, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:ebf4738f08e0, Plugin Configuration name:DB2CatalogerWithSchemaFilterSC1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0071 | UDBCataloger | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin UDBCataloger Configuration: name: "DB2CatalogerWithSchemaFilterSC1"  2020-08-05 11:59:11.587 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: pluginVersion: "LATEST"  2020-08-05 11:59:11.587 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: label:  20-08-05 11:59:11.587 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: : "DB2CatalogerWithSchemaFilterSC1"  2020-08-05 11:59:11.587 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: catalogName: "Default"  2020-08-05 11:59:11.587 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: eventClass: null  2020-08-05 11:59:11.587 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: eventCondition: null  2020-08-05 11:59:11.587 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: nodeCondition: "name==\"LocalNode\""  2020-08-05 11:59:11.587 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: maxWorkSize: 100  2020-08-05 11:59:11.587 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: tags:  2020-08-05 11:59:11.587 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: - "SC1UDB"  2020-08-05 11:59:11.588 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: pluginType: "cataloger"  2020-08-05 11:59:11.588 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: dataSource: "UDBDataSource"  2020-08-05 11:59:11.588 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: credential: "UDB_Credentials"  2020-08-05 11:59:11.588 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: businessApplicationName: "UDB_BA"  2020-08-05 11:59:11.588 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: dryRun: false  2020-08-05 11:59:11.588 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: schedule: null  2020-08-05 11:59:11.589 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: filter: null  2020-08-05 11:59:11.589 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: pluginName: "UDBCataloger"  2020-08-05 11:59:11.589 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: schemas:  2020-08-05 11:59:11.589 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: - schema: "UDBTEST1"  2020-08-05 11:59:11.589 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: tables: []  2020-08-05 11:59:11.589 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: arguments: []  2020-08-05 11:59:11.589 INFO  - ANALYSIS-0073: Plugin UDBCataloger Configuration: type: "Cataloger" | ANALYSIS-0073 | UDBCataloger |                |
      | INFO | Plugin UDBCataloger Start Time:2020-08-05 11:59:11.580, End Time:2020-08-05 11:59:50.244, Processed Count:0, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0072 | UDBCataloger |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0020 |              |                |


  @webtest @jdbc
  Scenario:SC1#Verify the technology tags got assigned to all DB2 database items like Cluster,Service,Database...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name           | facet | Tag               | fileName             | userTag |
      | Default     | Column         | Type  | SC1UDB,DB2,UDB_BA | FLD99_DEC            | SC1UDB  |
      | Default     | Table          | Type  | SC1UDB,DB2,UDB_BA | SWITCH4              | SC1UDB  |
      | Default     | Constraint     | Type  | SC1UDB,DB2,UDB_BA | CITY_PKEY            | SC1UDB  |
      | Default     | Tablespace     | Type  | SC1UDB,DB2,UDB_BA | STB_4                | SC1UDB  |
      | Default     | Index          | Type  | SC1UDB,DB2,UDB_BA | CKP                  | SC1UDB  |
      | Default     | Bufferpool     | Type  | SC1UDB,DB2,UDB_BA | BP4K                 | SC1UDB  |
      | Default     | User           | Type  | SC1UDB,DB2,UDB_BA | PUBLIC               | SC1UDB  |
      | Default     | PartitionGroup | Type  | SC1UDB,DB2,UDB_BA | IBMCATGROUP          | SC1UDB  |
      | Default     | Cluster        | Type  | SC1UDB,DB2,UDB_BA | gechcae-col1.asg.com | SC1UDB  |
      | Default     | Database       | Type  | SC1UDB,DB2,UDB_BA | SAMPLE               | SC1UDB  |
      | Default     | Schema         | Type  | SC1UDB,DB2,UDB_BA | UDBTEST1             | SC1UDB  |
      | Default     | Service        | Type  | SC1UDB,DB2,UDB_BA | DB2:50000            | SC1UDB  |
      | Default     | StorageGroup   | Type  | SC1UDB,DB2,UDB_BA | IBMSTOGROUP          | SC1UDB  |

       ##6549303
#  @sanity @positive @webtest @edibus
#  Scenario:SC1#_Verify the UDB Cataloger items are replicated to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "SC1UDB" and clicks on search
#    And user performs "facet selection" in "SC1UDB" attribute under "Tags" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Column         |
#      | Table          |
#      | Constraint     |
#      | Cluster        |
#      | Service        |
#      | Database       |
#      | Tablespace     |
#      | Index          |
#      | Bufferpool     |
#      | User           |
#      | PartitionGroup |
#      | Schema         |
#      | StorageGroup   |
#      | Analysis       |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | DDUDB       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/EDIBusUDBConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                            | body                                            | response code | response message | jsonPath                                       |
#      | application/json | raw   | false | Put          | settings/analyzers/EDIBusDataSource                            | idc/EdiBusPayloads/DataSource/EDIBusDS_UDB.json | 204           |                  |                                                |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/EDIBusUDBConfig.json         | 204           |                  |                                                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusUDB |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDIBusUDB')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusUDB  |                                                 | 200           |                  |                                                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusUDB |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDIBusUDB')].status |
#    And user enters the search text "EDIBusUDB" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusUDB%"
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Number of errors  | 0             | Description |
#    And user enters the search text "SC1UDB" and clicks on search
#    And user performs "facet selection" in "SC1UDB" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                     |
#      | AP-DATA      | DDUDB       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                          |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Relational Databases/DB2 |
#      | $..selections.['type_s'][*]                   | Database                                            |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                   | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=SC1UDB&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | DDUDB       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
#    And user enters the search text "SC1UDB" and clicks on search
#    And user performs "facet selection" in "SC1UDB" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Schema" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | DDUDB       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_SCHEMA) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                          |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Relational Databases/DB2 |
#      | $..selections.['type_s'][*]                   | Schema                                              |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                   | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=SC1UDB&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | DDUDB       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_SCHEMA ) |
#    And user enters the search text "SC1UDB" and clicks on search
#    And user performs "facet selection" in "SC1UDB" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                          |
#      | AP-DATA      | DDUDB       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                          |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Relational Databases/DB2 |
#      | $..selections.['type_s'][*]                   | Table                                               |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                   | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=SC1UDB&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
#      | AP-DATA      | DDUDB       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
#    And user enters the search text "SC1UDB" and clicks on search
#    And user performs "facet selection" in "SC1UDB" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | DDUDB       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                          |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Relational Databases/DB2 |
#      | $..selections.['type_s'][*]                   | Column                                              |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                   | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=SC1UDB&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | DDUDB       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
#    And user enters the search text "SC1UDB" and clicks on search
#    And user performs "facet selection" in "SC1UDB" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | DDUDB       | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM) |
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                          |
#      | AP-DATA      | DDUDB       | 1.0                | (XNAME * *  ~/ @*DB2≫DEFAULT≫DWR_RDB_SCHEMA≫@* ) ,AND,( TYPE = DWR_IDC )       |
#      | AP-DATA      | DDUDB       | 1.0                | (XNAME * *  ~/ @*DB2≫DEFAULT≫DWR_RDB_COLUMN≫@* ) ,AND,( TYPE = DWR_IDC )       |
#      | AP-DATA      | DDUDB       | 1.0                | (XNAME * *  ~/ @*DB2≫DEFAULT≫DWR_RDB_TABLE_OR_VIEW≫@* ),AND,( TYPE = DWR_IDC ) |
#      | AP-DATA      | DDUDB       | 1.0                | (XNAME * *  ~/ @*DB2≫DEFAULT≫DWR_RDB_DATABASE≫@* ),AND,( TYPE = DWR_IDC )      |
#      | AP-DATA      | DDUDB       | 1.0                | (XNAME * *  ~/ @*DB2≫DEFAULT≫DWR_RDB_DB_SYSTEM≫@* ),AND,( TYPE = DWR_IDC )     |

  @MLP-4441 @sanity @positive
  Scenario:SC#1:Delete cluster id and Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                    | type     | query | param |
      | SingleItemDelete | Default | cataloger/UDBCataloger/DB2CatalogerWithSchemaFilterSC1% | Analysis |       |       |
      | SingleItemDelete | Default | SAMPLE                                                  | Database |       |       |

  @RedShift @positve @regression @sanity
  Scenario:Delete Datasource Configurations for internal node
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                              | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/UDBDataSource |      | 204           |                  |          |

  @positve @regression @sanity
  Scenario:Add internalnode Datasource for ScanUDB
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                              | body                                                          | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/UDBDataSource | ida/ScanUDBPayloads/DataSource/UDBDataSourceInternalNode.json | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/UDBDataSource |                                                               | 200           | UDBDataSource    |          |


  @webtest @jdbc @MLP-5641
  Scenario:SC2#Verify the DB2 Table should not have constraints window if the table is not having any constraints and CatalogerWithSchemaAndTableFilter
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                   | body | response code | response message                     | jsonPath                                                                  | endpointType | itemName |
      | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger                                                                       |      | 200           | DB2CatalogerWithSchemaAndTableFilter |                                                                           |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter |      | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithSchemaAndTableFilter')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/InternalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter  |      | 200           |                                      |                                                                           |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter |      | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithSchemaAndTableFilter')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC2UDB" and clicks on search
    And user performs "facet selection" in "SC2UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DB2_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    Then user verify "catalog not contains" any "Constriant" attribute under "Metadata Type" facets
    And user enters the search text "SC2UDB" and clicks on search
    And user performs "facet selection" in "SC2UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DB2_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | DB2_TAG_DETAILS |

  @jdbc
  Scenario:SC3#Create JDBC Analyzer Plugin config and start it
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                         | body | response code | response message | jsonPath                                         |
      | application/json | raw   | false | Get          | settings/analyzers/UDBAnalyzer                                              |      | 200           | UDBAnalyzer      |                                                  |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzer |      | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzer')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzer  |      | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzer |      | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzer')].status |

  @webtest @jdbc
  Scenario:SC3#Verify the technology tags and PII tags got assigned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name   | facet | Tag              | fileName | userTag |
      | Default     | Column | Type  | SC2UDB,DB2,State | STATE    | SC2UDB  |

  @webtest @jdbc @MLP-5358
  Scenario: verify the Created Table Name in DB2DB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC2UDB" and clicks on search
    And user performs "facet selection" in "SC2UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DB2_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "definite facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DB2_TAG_DETAILS" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
      | Number of rows    | 4             | Statistics  |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Modified           | Lifecycle  |

  @webtest @jdbc @MLP-5358
  Scenario: Verify the Column with datatype varchar in DB2 DB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC2UDB" and clicks on search
    And user performs "facet selection" in "SC2UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DB2_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FULL_NAME" item from search results
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

  @webtest @jdbc @MLP-5358
  Scenario: Verify the Column with datatype decimal in DB2 DB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC2UDB" and clicks on search
    And user performs "facet selection" in "SC2UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DB2_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DB2DB_SALARY" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Average                       | 95.72         | Statistics  |
      | Length                        | 6             | Statistics  |
      | Median                        | 95.72         | Statistics  |
      | Maximum value                 | 100.90        | Statistics  |
      | Minimum value                 | 90.55         | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 50            | Statistics  |
      | Number of null values         | 2             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | Standard deviation            | 5.18          | Statistics  |
      | Variance                      | 26.78         | Statistics  |

  @webtest @jdbc @MLP-5358
  Scenario: Verify the Column with datatype timestamp in DB2 DB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC2UDB" and clicks on search
    And user performs "facet selection" in "SC2UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DB2_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DB2DB_LOCALTIME" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue         | widgetName  |
      | Data type                     | TIMESTAMP             | Description |
      | Length                        | 10                    | Statistics  |
      | Maximum value                 | 2014-09-18 10:06:47.0 | Statistics  |
      | Minimum value                 | 2007-11-17 07:45:37.0 | Statistics  |
      | Number of non null values     | 4                     | Statistics  |
      | Percentage of non null values | 100                   | Statistics  |
      | Number of null values         | 0                     | Statistics  |
      | Number of unique values       | 4                     | Statistics  |
      | Percentage of unique values   | 100                   | Statistics  |


  @webtest @jdbc @MLP-5641
  Scenario: Verify the count of Schema matched UI and DB
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC2UDB" and clicks on search
    And user performs "facet selection" in "SC2UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | UDBTEST1 |

  @webtest @jdbc @MLP-6064
  Scenario: Verify the data sampling information in DB2 DB
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "DB2_TAG_DETAILS" and clicks on search
    And user performs "facet selection" in "SC2UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SAMPLE [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DB2_TAG_DETAILS" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GENDER | FULL_NAME      | EMAIL            | STATE | PHONE_NUMBER | EMPLOYEE_ID | POSTAL_CODE |
      | m      | Alex Ferguson  | fergie@gmail.com | DC    | 515.123.4568 | 10          | 46576       |
      | f      | Jones Campbell | cambie@gmail.com | TX    | 515.123.4356 | 11          | 46581       |
      | m      | Lionel Messi   | lmessi@gmail.com | NY    | 515.123.6666 | 12          | 78576       |
      | f      | Irina Shayk    | ishayk@gmail.com | VI    | 515.123.2580 | 13          | 48276       |

  @MLP-4441 @sanity @positive
  Scenario:SC#3:Delete cluster id and Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                         | type     | query | param |
      | SingleItemDelete | Default | cataloger/UDBCataloger/DB2CatalogerWithSchemaAndTableFilter% | Analysis |       |       |
      | SingleItemDelete | Default | SAMPLE                                                       | Database |       |       |

  @RedShift @positve @regression @sanity
  Scenario:SC3# Delete Datasource Configurations
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                              | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/UDBDataSource |      | 204           |                  |          |

  @positve @regression @sanity
  Scenario:SC4# Add Datasource for ScanUDB
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                              | body                                              | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/UDBDataSource | ida/ScanUDBPayloads/DataSource/UDBDataSource.json | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/UDBDataSource |                                                   | 200           | UDBDataSource    |          |


  @webtest @jdbc @MLP-6281
  Scenario:SC4#Verify JDBC cataloger scans and collects data if schema name alone is provided in filters(DB2 DB)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                        | body | response code | response message             | jsonPath                                                          | endpointType | itemName |
      | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger                                                            |      | 200           | DB2CatalogerWithSchemaFilter |                                                                   |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaFilter |      | 200           | IDLE                         | $.[?(@.configurationName=='DB2CatalogerWithSchemaFilter')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaFilter  |      | 200           |                              |                                                                   |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithSchemaFilter |      | 200           | IDLE                         | $.[?(@.configurationName=='DB2CatalogerWithSchemaFilter')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC4UDB" and clicks on search
    And user performs "facet selection" in "SC4UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "UDBTEST1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Column     |
      | Table      |
      | Constraint |
      | Index      |
      | Schema     |


  @MLP-4441 @sanity @positive
  Scenario:SC#4:Delete cluster id and Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                 | type     | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/DB2Cataloger% | Analysis |       |       |
      | SingleItemDelete | Default | SAMPLE                               | Database |       |       |


  @webtest @jdbc @MLP-6281
  Scenario:SC6#Verify JDBC cataloger scans and collects data if multiple schema name alone is provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                   | body | response code | response message                        | jsonPath                                                                     | endpointType | itemName |
      | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger                                                                       |      | 200           | DB2CatalogerWithMultipleSchemasInFilter |                                                                              |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithMultipleSchemasInFilter |      | 200           | IDLE                                    | $.[?(@.configurationName=='DB2CatalogerWithMultipleSchemasInFilter')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithMultipleSchemasInFilter  |      | 200           |                                         |                                                                              |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithMultipleSchemasInFilter |      | 200           | IDLE                                    | $.[?(@.configurationName=='DB2CatalogerWithMultipleSchemasInFilter')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC6UDB" and clicks on search
    And user performs "facet selection" in "SC6UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SAMPLE [Database]" attribute under "Hierarchy" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Column         |
      | Table          |
      | Constraint     |
      | Database       |
      | Tablespace     |
      | Index          |
      | Bufferpool     |
      | User           |
      | PartitionGroup |
      | Schema         |
      | StorageGroup   |


  @MLP-4441 @sanity @positive
  Scenario:SC#6:Delete cluster id and Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                 | type     | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/DB2Cataloger% | Analysis |       |       |
      | SingleItemDelete | Default | SAMPLE                               | Database |       |       |

  @webtest @jdbc @MLP-6281
  Scenario:SC7#Verify JDBC cataloger scans and collects data if single schema name with multiple table names are provided in filters(DB2 DB)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                        | body | response code | response message                             | jsonPath                                                                          | endpointType | itemName |
      | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger                                                                            |      | 200           | DB2CatalogerwithSchemaAndMultipleTableFilter |                                                                                   |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerwithSchemaAndMultipleTableFilter |      | 200           | IDLE                                         | $.[?(@.configurationName=='DB2CatalogerwithSchemaAndMultipleTableFilter')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerwithSchemaAndMultipleTableFilter  |      | 200           |                                              |                                                                                   |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerwithSchemaAndMultipleTableFilter |      | 200           | IDLE                                         | $.[?(@.configurationName=='DB2CatalogerwithSchemaAndMultipleTableFilter')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC7UDB" and clicks on search
    And user performs "facet selection" in "SC7UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "UDBTEST1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | DB2_TAG_DETAILS |
      | TAG_DETAILS     |

  @MLP-4441 @sanity @positive
  Scenario:SC#7:Delete cluster id and Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                 | type     | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/DB2Cataloger% | Analysis |       |       |
      | SingleItemDelete | Default | SAMPLE                               | Database |       |       |

  @webtest @jdbc @MLP-6281
  Scenario:SC8#Verify JDBC cataloger scans and collects data if multiple schema names having tables in it are provided in filters(DB2 DB)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                          | body | response code | response message                               | jsonPath                                                                            | endpointType | itemName |
      | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger                                                                              |      | 200           | DB2CatalogerWithMultipleSchemaFilterWithTables |                                                                                     |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithMultipleSchemaFilterWithTables |      | 200           | IDLE                                           | $.[?(@.configurationName=='DB2CatalogerWithMultipleSchemaFilterWithTables')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithMultipleSchemaFilterWithTables  |      | 200           |                                                |                                                                                     |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithMultipleSchemaFilterWithTables |      | 200           | IDLE                                           | $.[?(@.configurationName=='DB2CatalogerWithMultipleSchemaFilterWithTables')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC8UDB" and clicks on search
    And user performs "facet selection" in "SC8UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "SAMPLE [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | DB2ADMIN |
      | UDBTEST1 |

  @MLP-4441 @sanity @positive
  Scenario:SC#8:Delete cluster id and Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                 | type     | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/DB2Cataloger% | Analysis |       |       |
      | SingleItemDelete | Default | SAMPLE                               | Database |       |       |

  @webtest @jdbc @MLP-6281
  Scenario:SC9#Verify JDBC cataloger scans and collects data if non existing schema name and table name are provided in filters(DB2 DB)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                           | body | response code | response message                                | jsonPath                                                                             | endpointType | itemName |
      | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger                                                                               |      | 200           | DB2CatalogerwithNonExistingSchemaAndTableFilter |                                                                                      |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerwithNonExistingSchemaAndTableFilter |      | 200           | IDLE                                            | $.[?(@.configurationName=='DB2CatalogerwithNonExistingSchemaAndTableFilter')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerwithNonExistingSchemaAndTableFilter  |      | 200           |                                                 |                                                                                      |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerwithNonExistingSchemaAndTableFilter |      | 200           | IDLE                                            | $.[?(@.configurationName=='DB2CatalogerwithNonExistingSchemaAndTableFilter')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC9UDB" and clicks on search
    And user performs "facet selection" in "SC9UDB" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Metadata Type" section in item search results page
      | Schema |

  @MLP-4441 @sanity @positive
  Scenario:SC#9:Delete cluster id and Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                 | type     | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/DB2Cataloger% | Analysis |       |       |
      | SingleItemDelete | Default | SAMPLE                               | Database |       |       |

  @webtest @jdbc @MLP-6942
  Scenario:SC11#Verify the error message when Configuration credentials are incorrect
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                | body | response code | response message                     | jsonPath                                                                  | endpointType | itemName |
      | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger                                                                    |      | 200           | DB2CatalogerWithIncorrectCredentials |                                                                           |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithIncorrectCredentials |      | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithIncorrectCredentials')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithIncorrectCredentials  |      | 200           |                                      |                                                                           |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithIncorrectCredentials |      | 200           | IDLE                                 | $.[?(@.configurationName=='DB2CatalogerWithIncorrectCredentials')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC11UDB" and clicks on search
    And user performs "facet selection" in "SC11UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/UDBCataloger/DB2CatalogerWithIncorrect%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 3             | Description |
    Then Analysis log "cataloger/UDBCataloger/DB2CatalogerWithIncorrectCredentials/%" should display below info/error/warning
      | type  | logValue                                | logCode            | pluginName | removableText |
      | ERROR | Connection failed                       | ANALYSIS-UDB-0007  |            |               |
      | ERROR | No JDBC connection could be established | ANALYSIS-JDBC-0003 |            |               |

  @MLP-4441 @sanity @positive
  Scenario:SC#11:Delete cluster id and Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                 | type     | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/DB2Cataloger% | Analysis |       |       |


  @jdbc @webtest @MLP-7325
  Scenario:SC14_1#Verify the data profiling metadata for string,numeric,date,time,timestamp datatypes metrics does not get calculated for empty table(DB2)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                     | body | response code | response message          | jsonPath                                                       | endpointType | itemName |
      | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger                                                         |      | 200           | DB2CatalogerWithTimeStamp |                                                                |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithTimeStamp |      | 200           | IDLE                      | $.[?(@.configurationName=='DB2CatalogerWithTimeStamp')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithTimeStamp  |      | 200           |                           |                                                                |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithTimeStamp |      | 200           | IDLE                      | $.[?(@.configurationName=='DB2CatalogerWithTimeStamp')].status |              |          |
      |                  |       |       | Get          | settings/analyzers/UDBAnalyzer                                                          |      | 200           | UDBAnalyzer               |                                                                |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzer             |      | 200           | IDLE                      | $.[?(@.configurationName=='UDBAnalyzer')].status               |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzer              |      | 200           |                           |                                                                |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzer             |      | 200           | IDLE                      | $.[?(@.configurationName=='UDBAnalyzer')].status               |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC14UDB" and clicks on search
    And user performs "facet selection" in "SC14UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DB2_EMPTY [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ID" item from search results
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    And user enters the search text "SC14UDB" and clicks on search
    And user performs "facet selection" in "DB2_EMPTY [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "NAME" item from search results
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    And user enters the search text "SC14UDB" and clicks on search
    And user performs "facet selection" in "DB2_EMPTY [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DATE1" item from search results
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    And user enters the search text "SC14UDB" and clicks on search
    And user performs "facet selection" in "DB2_EMPTY [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DATE2" item from search results
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    And user enters the search text "SC14UDB" and clicks on search
    And user performs "facet selection" in "DB2_EMPTY [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DATE3" item from search results
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |

  @jdbc @webtest @MLP-7325
  Scenario:SC14_2#Verify the data profiling metadata for date,time,timestamp datatypes and should have the appropriate metadata information in IDC UI and Database(DB2)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC14UDB" and clicks on search
    And user performs "facet selection" in "SC14UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DB2_TABLE [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ID" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | INTEGER       | Description |
      | Average                       | 100           | Statistics  |
      | Length                        | 4             | Statistics  |
      | Median                        | 100           | Statistics  |
      | Maximum value                 | 100           | Statistics  |
      | Minimum value                 | 100           | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 0             | Statistics  |
      | Variance                      | 0             | Statistics  |
    And user enters the search text "SC14UDB" and clicks on search
    And user performs "facet selection" in "SC14UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DB2_TABLE [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "NAME" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 20            | Statistics  |
      | Maximum value                 | Test Name     | Statistics  |
      | Minimum value                 | Test Name     | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user enters the search text "SC14UDB" and clicks on search
    And user performs "facet selection" in "SC14UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DB2_TABLE [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DATE1" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DATE          | Description |
      | Length                        | 4             | Statistics  |
      | Maximum value                 | 2000-01-01    | Statistics  |
      | Minimum value                 | 2000-01-01    | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user enters the search text "SC14UDB" and clicks on search
    And user performs "facet selection" in "SC14UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DB2_TABLE [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DATE2" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TIME          | Description |
      | Length                        | 3             | Statistics  |
      | Maximum value                 | 00:00:00      | Statistics  |
      | Minimum value                 | 00:00:00      | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user enters the search text "SC14UDB" and clicks on search
    And user performs "facet selection" in "SC14UDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DB2_TABLE [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DATE3" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue         | widgetName  |
      | Data type                     | TIMESTAMP             | Description |
      | Length                        | 10                    | Statistics  |
      | Maximum value                 | 2000-01-01 00:00:00.0 | Statistics  |
      | Minimum value                 | 2000-01-01 00:00:00.0 | Statistics  |
      | Number of non null values     | 1                     | Statistics  |
      | Percentage of non null values | 100                   | Statistics  |
      | Number of null values         | 0                     | Statistics  |
      | Number of unique values       | 1                     | Statistics  |
      | Percentage of unique values   | 100                   | Statistics  |

  @MLP-4441 @sanity @positive
  Scenario:SC#14:Delete cluster id and Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                 | type     | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/DB2Cataloger% | Analysis |       |       |
      | SingleItemDelete | Default | SAMPLE                               | Database |       |       |


  @jdbc @webtest @MLP-7325
  Scenario:SC16#Verify ScanUDBCataloger does not scans and collects and any data if username and password are not provided
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                 | body | response code | response message                      | jsonPath                                                                   | endpointType | itemName |
      | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger                                                                     |      | 200           | DB2CatalogerWithNoUsernameAndPassword |                                                                            |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithNoUsernameAndPassword |      | 200           | IDLE                                  | $.[?(@.configurationName=='DB2CatalogerWithNoUsernameAndPassword')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithNoUsernameAndPassword  |      | 200           |                                       |                                                                            |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithNoUsernameAndPassword |      | 200           | IDLE                                  | $.[?(@.configurationName=='DB2CatalogerWithNoUsernameAndPassword')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC16UDB" and clicks on search
    And user performs "facet selection" in "SC16UDB" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis |

  @MLP-4441 @sanity @positive
  Scenario:SC#16:Delete cluster id and Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                 | type     | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/DB2Cataloger% | Analysis |       |       |

  @positve @regression @sanity
  Scenario:SC12#_Add Invalid Datasource for ScanUDB
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                              | body                                                     | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/UDBDataSource | ida/ScanUDBPayloads/DataSource/UDBInvalidDataSource.json | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/UDBDataSource |                                                          | 200           | UDBDataSource    |          |


  @webtest @jdbc @MLP-6942
  Scenario:SC12#Verify the error message when Configuration url is incorrect
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                        | body | response code | response message             | jsonPath                                                          | endpointType | itemName |
      | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger                                                            |      | 200           | DB2CatalogerWithIncorrectURL |                                                                   |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithIncorrectURL |      | 200           | IDLE                         | $.[?(@.configurationName=='DB2CatalogerWithIncorrectURL')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithIncorrectURL  |      | 200           |                              |                                                                   |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithIncorrectURL |      | 200           | IDLE                         | $.[?(@.configurationName=='DB2CatalogerWithIncorrectURL')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC12UDB" and clicks on search
    And user performs "facet selection" in "SC12UDB" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Metadata Type" section in item search results page
      | Cluster  |
      | Service  |
      | Database |
      | Table    |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/UDBCataloger/DB2CatalogerWithIncorrectURL%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 3             | Description |
    Then Analysis log "cataloger/UDBCataloger/DB2CatalogerWithIncorrectURL/%" should display below info/error/warning
      | type  | logValue                                | logCode            | pluginName | removableText |
      | ERROR | Connection failed                       | ANALYSIS-UDB-0007  |            |               |
      | ERROR | No JDBC connection could be established | ANALYSIS-JDBC-0003 |            |               |

  @MLP-4441 @sanity @positive
  Scenario:SC#12:Delete cluster id and Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                 | type     | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/DB2Cataloger% | Analysis |       |       |

  @sanity @positive @regression
  Scenario Outline:SC12#Delete Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                              | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/UDBDataSource |      | 204           |                  |          |

  @positve @regression @sanity
  Scenario:SC17#_Add Oracle Datasource for ScanUDB
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                              | body                                                 | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/UDBDataSource | ida/ScanUDBPayloads/DataSource/OracleDataSource.json | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/UDBDataSource |                                                      | 200           | UDBDataSource    |          |


  @jdbc @webtest @MLP-7325
  Scenario:SC17#Verify ScanUDBCataloger does not collect any DB items and log throws error when the jdbc url is for databases oracle)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                             | body | response code | response message                  | jsonPath                                                               | endpointType | itemName |
      | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger                                                                 |      | 200           | DB2CatalogerWithOracleDatabaseURL |                                                                        |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithOracleDatabaseURL |      | 200           | IDLE                              | $.[?(@.configurationName=='DB2CatalogerWithOracleDatabaseURL')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithOracleDatabaseURL  |      | 200           |                                   |                                                                        |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithOracleDatabaseURL |      | 200           | IDLE                              | $.[?(@.configurationName=='DB2CatalogerWithOracleDatabaseURL')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC17UDB" and clicks on search
    And user performs "facet selection" in "SC17UDB" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Metadata Type" section in item search results page
      | Cluster  |
      | Service  |
      | Database |
      | Table    |
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis |

  @MLP-4441 @sanity @positive
  Scenario:SC#17:Delete cluster id and Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                 | type     | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/DB2Cataloger% | Analysis |       |       |

  @sanity @positive @regression
  Scenario Outline:SC17#Delete Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                              | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/UDBDataSource |      | 204           |                  |          |

  @positve @regression @sanity
  Scenario:SC18#_Add Postgres Datasource for ScanUDB
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                              | body                                                   | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/UDBDataSource | ida/ScanUDBPayloads/DataSource/PostgresDataSource.json | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/UDBDataSource |                                                        | 200           | UDBDataSource    |          |


  @jdbc @webtest @MLP-7325
  Scenario:SC18#Verify ScanUDBCataloger does not collect any DB items and log throws error when the jdbc url is for databases postgress
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                               | body | response code | response message                    | jsonPath                                                                 | endpointType | itemName |
      | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger                                                                   |      | 200           | DB2CatalogerWithPostgresDatabaseURL |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithPostgresDatabaseURL |      | 200           | IDLE                                | $.[?(@.configurationName=='DB2CatalogerWithPostgresDatabaseURL')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithPostgresDatabaseURL  |      | 200           |                                     |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerWithPostgresDatabaseURL |      | 200           | IDLE                                | $.[?(@.configurationName=='DB2CatalogerWithPostgresDatabaseURL')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC18UDB" and clicks on search
    And user performs "facet selection" in "SC18UDB" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Metadata Type" section in item search results page
      | Cluster  |
      | Service  |
      | Database |
      | Table    |
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis |

###############################################  Delete Config , Item ids ########################

  @MLP-4441 @sanity @positive
  Scenario:SC#18:Delete ids and Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type                | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/%   | Analysis            |       |       |
      | MultipleIDDelete | Default | dataanalyzer/UDBAnalyzer/% | Analysis            |       |       |
      | SingleItemDelete | Default | UDB_BA                     | BusinessApplication |       |       |

  @jdbc
  Scenario: Drop Table
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation | Schema   | Table           | Database |
      | db2                | DROP      | UDBTEST1 | TABLE_PRIMARY   |          |
      | db2                | DROP      | UDBTEST1 | DB2_TAG_DETAILS |          |
      | db2                | DROP      | UDBTEST1 | DB2_EMPTY       |          |
      | db2                | DROP      | UDBTEST1 | DB2_TABLE       |          |

  @MLP-4441 @sanity @positive
  Scenario:Delete cluster id and Service
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                 | type    | query | param |
      | SingleItemDelete | Default | gechcae-col1.asg.com | Cluster |       |       |
      | SingleItemDelete | Default | DB2:50000            | Service |       |       |

  @cr-data @sanity @positive
  Scenario:Delete Configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                         | body | response code | response message | jsonPath |
      | application/json | raw   | false | Delete | settings/credentials/UDB_Credentials        |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/UDB_InvalidCredentials |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/UDB_EmptyCredentials   |      | 200           |                  |          |
      |                  |       |       | Delete | settings/analyzers/UDBDataSource            |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/credentials/UDB_EDIBusCredentials  |      | 200           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/EDIBusDataSource         |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/UDBCataloger             |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/UDBAnalyzer              |      | 204           |                  |          |


##################################################################### PII Tags - Scenarios - starts ################################################################
  @sanity @positive @regression @IDA_E2E
  Scenario Outline:PII_Add valid Credentials for ScanUDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                  | body                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/UDB_Credentials | ida/ScanUDBPayloads/credentials/Credentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/UDB_Credentials |                                                  | 200           |                  |          |

  @positve @regression @sanity
  Scenario:PII_Add valid Datasource for ScanUDB
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                              | body                                              | response code | response message | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/UDBDataSource | ida/ScanUDBPayloads/DataSource/UDBDataSource.json | 204           |                  |          |
      |                  |       |       | Get  | settings/analyzers/UDBDataSource |                                                   | 200           | UDBDataSource    |          |

  @sanity @positive @regression @IDA_E2E @precondition
  Scenario Outline:SC#PII_#Add Tags for UDBCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                                                  | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | tags/Default/structures | ida/ScanUDBPayloads/policyEngine/PluginConfiguration/PIITags_UDB.json | 200           |                  |          |


  @MLP-20518 @sanity @positive @regression
  Scenario Outline:SC#PII_1:Create UDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                           | bodyFile                                                                               | path                  | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | policy/tagging/actions                                                        | payloads/ida/ScanUDBPayloads/policyEngine/1Tags.json                                   | $.typeanddatapattern1 | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBCataloger/DB2CatalogerPII                               | payloads/ida/ScanUDBPayloads/policyEngine/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig     | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger/DB2CatalogerPII                               |                                                                                        |                       | 200           | DB2CatalogerPII  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII  |                                                                                        |                       | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII   |                                                                                        |                       | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII  |                                                                                        |                       | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBAnalyzer/UDBAnalyzerPII                                 | payloads/ida/ScanUDBPayloads/policyEngine/PluginConfiguration/TagsAnalyzerConfig.json  | $.configurations      | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBAnalyzer/UDBAnalyzerPII                                 |                                                                                        |                       | 200           | UDBAnalyzerPII   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII |                                                                                        |                       | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzerPII')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII  |                                                                                        |                       | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII |                                                                                        |                       | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzerPII')].status  |

###################################################################################################################################################

    #7123294# #7123295# #7123296# #7123297# #7123298# #7123299# #7123300# #7123301# #7123302# #7123303# #7123304# #7123305# #7123306# #7123307#
  @MLP-24319 @webtest @jsons3analyzer @PIITag
  Scenario:SC#PII_1 Verify Tag is set for the column when typePattern(String) and dataPattern/minimumRatio matches with the column type/value ratio in DB2 table.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name           | facet | Tag                                                | fileName  | userTag                             |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBEmailAddress | EMAIL     | TAGDETAILS_ALLMATCH                 |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBIPAddress    | IPADDRESS | TAGDETAILS_ALLMATCH                 |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBGender       | GENDER    | TAGDETAILS_ALLMATCH                 |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBFullName     | FULL_NAME | TAGDETAILS_ALLMATCH                 |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBSSN          | SSN       | TAGDETAILS_ALLMATCH                 |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBIPAddress    | IPADDRESS | TAGDETAILS_ALLEMPTY                 |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBEmailAddress | EMAIL     | TAGDETAILS_ALLEMPTY                 |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBSSN          | SSN       | TAGDETAILS_ALLEMPTY                 |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBEmailAddress | EMAIL     | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBIPAddress    | IPADDRESS | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBGender       | GENDER    | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBFullName     | FULL_NAME | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBSSN          | SSN       | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name           | facet | Tag              | fileName  | userTag                                     |
      | Default     | UDBPIIAnalyzer | Tags  | UDBEmailAddress1 | EMAIL     | TAGDETAILS_ALLMATCH                         |
      | Default     | UDBPIIAnalyzer | Tags  | UDBIPAddress1    | IPADDRESS | TAGDETAILS_ALLEMPTY                         |
      | Default     | UDBPIIAnalyzer | Tags  | UDBGender1       | GENDER    | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         |
      | Default     | UDBPIIAnalyzer | Tags  | UDBSSN1          | SSN       | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        |
      | Default     | UDBPIIAnalyzer | Tags  | UDBFullName1     | FULL_NAME | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE |


  @sanity @positive
  Scenario:SC#PII_1:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/UDBAnalyzer/% | Analysis |       |       |
      | SingleItemDelete | Default | gechcae-col1.asg.com       | Cluster  |       |       |
      | SingleItemDelete | Default | DB2:50000                  | Service  |       |       |

    ##################################################

  @MLP-20518 @sanity @positive @regression
  Scenario Outline:SC#PII_2:Create UDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                           | bodyFile                                                                               | path                  | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | policy/tagging/actions                                                        | payloads/ida/ScanUDBPayloads/policyEngine/1Tags.json                                   | $.nameanddatapattern1 | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBCataloger/DB2CatalogerPII                               | payloads/ida/ScanUDBPayloads/policyEngine/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig     | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger/DB2CatalogerPII                               |                                                                                        |                       | 200           | DB2CatalogerPII  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII  |                                                                                        |                       | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII   |                                                                                        |                       | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII  |                                                                                        |                       | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBAnalyzer/UDBAnalyzerPII                                 | payloads/ida/ScanUDBPayloads/policyEngine/PluginConfiguration/TagsAnalyzerConfig.json  | $.configurations      | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBAnalyzer/UDBAnalyzerPII                                 |                                                                                        |                       | 200           | UDBAnalyzerPII   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII |                                                                                        |                       | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzerPII')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII  |                                                                                        |                       | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII |                                                                                        |                       | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzerPII')].status  |

  @MLP-24319 @webtest @jsons3analyzer @PIITag
  Scenario:SC#PII_2 Verify Tag is set for the column when namePattern and dataPattern/minimumRatio matches with the column name/value ratio in DB2 table.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name           | facet | Tag                                                | fileName  | userTag                                     |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBEmailAddress | EMAIL     | TAGDETAILS_ALLMATCH                         |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBIPAddress    | IPADDRESS | TAGDETAILS_ALLMATCH                         |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBGender       | GENDER    | TAGDETAILS_ALLMATCH                         |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBFullName     | FULL_NAME | TAGDETAILS_ALLMATCH                         |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBSSN          | SSN       | TAGDETAILS_ALLMATCH                         |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBIPAddress    | IPADDRESS | TAGDETAILS_ALLEMPTY                         |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBEmailAddress | EMAIL     | TAGDETAILS_ALLEMPTY                         |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBSSN          | SSN       | TAGDETAILS_ALLEMPTY                         |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBEmailAddress | EMAIL     | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBIPAddress    | IPADDRESS | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBGender       | GENDER    | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBFullName     | FULL_NAME | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBSSN          | SSN       | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBIPAddress    | IPADDRESS | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBEmailAddress | EMAIL     | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBGender       | GENDER    | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBEmailAddress | EMAIL     | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBIPAddress    | IPADDRESS | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBGender       | GENDER    | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name           | facet | Tag              | fileName  | userTag                                     |
      | Default     | UDBPIIAnalyzer | Tags  | UDBEmailAddress1 | EMAIL     | TAGDETAILS_ALLMATCH                         |
      | Default     | UDBPIIAnalyzer | Tags  | UDBIPAddress1    | IPADDRESS | TAGDETAILS_ALLEMPTY                         |
      | Default     | UDBPIIAnalyzer | Tags  | UDBGender1       | GENDER    | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         |
      | Default     | UDBPIIAnalyzer | Tags  | UDBSSN1          | SSN       | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        |
      | Default     | UDBPIIAnalyzer | Tags  | UDBFullName1     | FULL_NAME | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE |


  @sanity @positive
  Scenario:SC#PII_2:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/UDBAnalyzer/% | Analysis |       |       |
      | SingleItemDelete | Default | gechcae-col1.asg.com       | Cluster  |       |       |
      | SingleItemDelete | Default | DB2:50000                  | Service  |       |       |


        ##################################################

  @MLP-20518 @sanity @positive @regression
  Scenario Outline:SC#PII_3:Create UDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                           | bodyFile                                                                               | path                   | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | policy/tagging/actions                                                        | payloads/ida/ScanUDBPayloads/policyEngine/1Tags.json                                   | $.datapatternandratio1 | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBCataloger/DB2CatalogerPII                               | payloads/ida/ScanUDBPayloads/policyEngine/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig      | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger/DB2CatalogerPII                               |                                                                                        |                        | 200           | DB2CatalogerPII  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII  |                                                                                        |                        | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII   |                                                                                        |                        | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII  |                                                                                        |                        | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBAnalyzer/UDBAnalyzerPII                                 | payloads/ida/ScanUDBPayloads/policyEngine/PluginConfiguration/TagsAnalyzerConfig.json  | $.configurations       | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBAnalyzer/UDBAnalyzerPII                                 |                                                                                        |                        | 200           | UDBAnalyzerPII   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII |                                                                                        |                        | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzerPII')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII  |                                                                                        |                        | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII |                                                                                        |                        | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzerPII')].status  |

  @MLP-24319 @webtest @jsons3analyzer @PIITag
  Scenario:SC#PII_3 Verify Tag is set for the column when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the data in column in DB2 table.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name           | facet | Tag                                                                                  | fileName  | userTag                              |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBEmailAddress,UDBEmailAddress1,UDBEmailAddress2 | EMAIL     | TAGDETAILS_ALLMATCH                  |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBIPAddress,UDBIPAddress1,UDBIPAddress2          | IPADDRESS | TAGDETAILS_ALLMATCH                  |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBGender,UDBGender1,UDBGender2                   | GENDER    | TAGDETAILS_ALLMATCH                  |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBFullName,UDBFullName1,UDBFullName2             | FULL_NAME | TAGDETAILS_ALLMATCH                  |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBSSN,UDBSSN1,UDBSSN2                            | SSN       | TAGDETAILS_ALLMATCH                  |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBEmailAddress,UDBEmailAddress1,UDBEmailAddress2 | EMAIL     | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE  |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBIPAddress,UDBIPAddress1,UDBIPAddress2          | IPADDRESS | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE  |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBGender,UDBGender1,UDBGender2                   | GENDER    | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE  |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBFullName,UDBFullName2                          | FULL_NAME | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE  |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBSSN,UDBSSN2                                    | SSN       | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE  |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBIPAddress,UDBIPAddress1,UDBIPAddress2          | IPADDRESS | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBEmailAddress,UDBEmailAddress1,UDBEmailAddress2 | EMAIL     | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBGender,UDBGender1,UDBGender2                   | GENDER    | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBFullName                                       | FULL_NAME | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBSSN                                            | SSN       | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE |

  @sanity @positive
  Scenario:SC#PII_3:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/UDBAnalyzer/% | Analysis |       |       |
      | SingleItemDelete | Default | gechcae-col1.asg.com       | Cluster  |       |       |
      | SingleItemDelete | Default | DB2:50000                  | Service  |       |       |

           ##################################################

  @MLP-20518 @sanity @positive @regression
  Scenario Outline:SC#PII_4:Create UDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                           | bodyFile                                                                               | path                   | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | policy/tagging/actions                                                        | payloads/ida/ScanUDBPayloads/policyEngine/1Tags.json                                   | $.datapatternandratio2 | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBCataloger/DB2CatalogerPII                               | payloads/ida/ScanUDBPayloads/policyEngine/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig      | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger/DB2CatalogerPII                               |                                                                                        |                        | 200           | DB2CatalogerPII  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII  |                                                                                        |                        | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII   |                                                                                        |                        | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII  |                                                                                        |                        | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBAnalyzer/UDBAnalyzerPII                                 | payloads/ida/ScanUDBPayloads/policyEngine/PluginConfiguration/TagsAnalyzerConfig.json  | $.configurations       | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBAnalyzer/UDBAnalyzerPII                                 |                                                                                        |                        | 200           | UDBAnalyzerPII   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII |                                                                                        |                        | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzerPII')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII  |                                                                                        |                        | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII |                                                                                        |                        | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzerPII')].status  |

  @MLP-24319 @webtest @jsons3analyzer @PIITag
  Scenario:SC#PII_4 Verify Tag is set for the column when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the data in column in DB2 table.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name           | facet | Tag                                                | fileName  | userTag                                     |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBEmailAddress | EMAIL     | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBIPAddress    | IPADDRESS | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBGender       | GENDER    | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name           | facet | Tag         | fileName  | userTag                                     |
      | Default     | UDBPIIAnalyzer | Tags  | UDBFullName | FULL_NAME | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE |
      | Default     | UDBPIIAnalyzer | Tags  | UDBSSN      | SSN       | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE |


  @sanity @positive
  Scenario:SC#PII_4:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/UDBAnalyzer/% | Analysis |       |       |
      | SingleItemDelete | Default | gechcae-col1.asg.com       | Cluster  |       |       |
      | SingleItemDelete | Default | DB2:50000                  | Service  |       |       |


   ##################################################

  @MLP-20518 @sanity @positive @regression
  Scenario Outline:SC#PII_4.1:Create UDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                           | bodyFile                                                                               | path                   | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | policy/tagging/actions                                                        | payloads/ida/ScanUDBPayloads/policyEngine/1Tags.json                                   | $.datapatternandratio3 | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBCataloger/DB2CatalogerPII                               | payloads/ida/ScanUDBPayloads/policyEngine/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig      | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger/DB2CatalogerPII                               |                                                                                        |                        | 200           | DB2CatalogerPII  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII  |                                                                                        |                        | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII   |                                                                                        |                        | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII  |                                                                                        |                        | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBAnalyzer/UDBAnalyzerPII                                 | payloads/ida/ScanUDBPayloads/policyEngine/PluginConfiguration/TagsAnalyzerConfig.json  | $.configurations       | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBAnalyzer/UDBAnalyzerPII                                 |                                                                                        |                        | 200           | UDBAnalyzerPII   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII |                                                                                        |                        | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzerPII')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII  |                                                                                        |                        | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII |                                                                                        |                        | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzerPII')].status  |

  @MLP-24319 @webtest @jsons3analyzer @PIITag
  Scenario:SC#PII_4.1 Verify Tag is set for the column when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the data in column in DB2 table.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name           | facet | Tag                                                | fileName  | userTag                                     |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBEmailAddress | EMAIL     | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBIPAddress    | IPADDRESS | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBGender       | GENDER    | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name           | facet | Tag         | fileName  | userTag                                     |
      | Default     | UDBPIIAnalyzer | Tags  | UDBFullName | FULL_NAME | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE |
      | Default     | UDBPIIAnalyzer | Tags  | UDBSSN      | SSN       | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE |


  @sanity @positive
  Scenario:SC#PII_4.1:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/UDBAnalyzer/% | Analysis |       |       |
      | SingleItemDelete | Default | gechcae-col1.asg.com       | Cluster  |       |       |
      | SingleItemDelete | Default | DB2:50000                  | Service  |       |       |

  ##################################################

  @MLP-20518 @sanity @positive @regression
  Scenario Outline:SC#PII_5:Create UDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                           | bodyFile                                                                               | path                           | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | policy/tagging/actions                                                        | payloads/ida/ScanUDBPayloads/policyEngine/1Tags.json                                   | $.namedatatypepatternandratio1 | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBCataloger/DB2CatalogerPII                               | payloads/ida/ScanUDBPayloads/policyEngine/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig              | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger/DB2CatalogerPII                               |                                                                                        |                                | 200           | DB2CatalogerPII  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII  |                                                                                        |                                | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII   |                                                                                        |                                | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII  |                                                                                        |                                | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBAnalyzer/UDBAnalyzerPII                                 | payloads/ida/ScanUDBPayloads/policyEngine/PluginConfiguration/TagsAnalyzerConfig.json  | $.configurations               | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBAnalyzer/UDBAnalyzerPII                                 |                                                                                        |                                | 200           | UDBAnalyzerPII   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII |                                                                                        |                                | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzerPII')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII  |                                                                                        |                                | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII |                                                                                        |                                | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzerPII')].status  |

  @MLP-24319 @webtest @jsons3analyzer @PIITag
  Scenario:SC#PII_5 Verify Tag is set for namePattern,typePattern,dataPattern,minimumRatio cases(Match Empty False)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name           | facet | Tag                                                | fileName  | userTag                              |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBEmailAddress | EMAIL     | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBIPAddress    | IPADDRESS | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBGender       | GENDER    | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBFullName     | FULL_NAME | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBSSN          | SSN       | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name           | facet | Tag              | fileName  | userTag                                     |
      | Default     | UDBPIIAnalyzer | Tags  | UDBEmailAddress1 | EMAIL     | TAGDETAILS_ALLMATCH                         |
      | Default     | UDBPIIAnalyzer | Tags  | UDBIPAddress1    | IPADDRESS | TAGDETAILS_ALLEMPTY                         |
      | Default     | UDBPIIAnalyzer | Tags  | UDBGender1       | GENDER    | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         |
      | Default     | UDBPIIAnalyzer | Tags  | UDBSSN1          | SSN       | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        |
      | Default     | UDBPIIAnalyzer | Tags  | UDBFullName1     | FULL_NAME | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE |
      | Default     | UDBPIIAnalyzer | Tags  | UDBFullMatchTag  | NAME      | TAGDETAILS_RATIOGREATERTHAN05MATCHFULLTRUE  |
      | Default     | UDBPIIAnalyzer | Tags  | UDBFullMatchTag  | COMMENTS  | TAGDETAILS_RATIOLESSERTHAN05MATCHFULLTRUE   |

  @sanity @positive
  Scenario:SC#PII_5:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/UDBAnalyzer/% | Analysis |       |       |
      | SingleItemDelete | Default | gechcae-col1.asg.com       | Cluster  |       |       |
      | SingleItemDelete | Default | DB2:50000                  | Service  |       |       |

     ##################################################

  @MLP-20518 @sanity @positive @regression
  Scenario Outline:SC#PII_6:Create UDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                           | bodyFile                                                                               | path              | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | policy/tagging/actions                                                        | payloads/ida/ScanUDBPayloads/policyEngine/1Tags.json                                   | $.matchempty      | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBCataloger/DB2CatalogerPII                               | payloads/ida/ScanUDBPayloads/policyEngine/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger/DB2CatalogerPII                               |                                                                                        |                   | 200           | DB2CatalogerPII  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII  |                                                                                        |                   | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII   |                                                                                        |                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII  |                                                                                        |                   | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBAnalyzer/UDBAnalyzerPII                                 | payloads/ida/ScanUDBPayloads/policyEngine/PluginConfiguration/TagsAnalyzerConfig.json  | $.configurations  | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBAnalyzer/UDBAnalyzerPII                                 |                                                                                        |                   | 200           | UDBAnalyzerPII   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII |                                                                                        |                   | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzerPII')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII  |                                                                                        |                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII |                                                                                        |                   | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzerPII')].status  |

  @MLP-24319 @webtest @jsons3analyzer @PIITag
  Scenario:SC#PII_6 Verify Tag is set for MatchEmpty
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name           | facet | Tag                                                | fileName  | userTag             |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBEmailAddress | EMAIL     | TAGDETAILS_ALLEMPTY |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBIPAddress    | IPADDRESS | TAGDETAILS_ALLEMPTY |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBSSN          | SSN       | TAGDETAILS_ALLEMPTY |

  @sanity @positive
  Scenario:SC#PII_6:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/UDBAnalyzer/% | Analysis |       |       |
      | SingleItemDelete | Default | gechcae-col1.asg.com       | Cluster  |       |       |
      | SingleItemDelete | Default | DB2:50000                  | Service  |       |       |

        ##################################################

  @MLP-20518 @sanity @positive @regression
  Scenario Outline:SC#PII_7:Create UDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                           | bodyFile                                                                               | path              | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | policy/tagging/actions                                                        | payloads/ida/ScanUDBPayloads/policyEngine/1Tags.json                                   | $.matchfullcase1  | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBCataloger/DB2CatalogerPII                               | payloads/ida/ScanUDBPayloads/policyEngine/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger/DB2CatalogerPII                               |                                                                                        |                   | 200           | DB2CatalogerPII  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII  |                                                                                        |                   | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII   |                                                                                        |                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII  |                                                                                        |                   | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBAnalyzer/UDBAnalyzerPII                                 | payloads/ida/ScanUDBPayloads/policyEngine/PluginConfiguration/TagsAnalyzerConfig.json  | $.configurations  | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBAnalyzer/UDBAnalyzerPII                                 |                                                                                        |                   | 200           | UDBAnalyzerPII   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII |                                                                                        |                   | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzerPII')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII  |                                                                                        |                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII |                                                                                        |                   | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzerPII')].status  |

  @MLP-24319 @webtest @jsons3analyzer @PIITag
  Scenario:SC#PII_7 Verify Tag is set for MatchFullCase1
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name           | facet | Tag             | fileName | userTag                                    |
      | Default     | UDBPIIAnalyzer | Tags  | UDBFullMatchTag | NAME     | TAGDETAILS_RATIOGREATERTHAN05MATCHFULLTRUE |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name           | facet | Tag                                                                                                   | fileName | userTag                                    |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBFullMatchTag,UDBFullMatchTag1,UDBFullMatchTag2,UDBFullMatchTag3 | COMMENTS | TAGDETAILS_RATIOGREATERTHAN05MATCHFULLTRUE |


  @sanity @positive
  Scenario:SC#PII_7:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/UDBAnalyzer/% | Analysis |       |       |
      | SingleItemDelete | Default | gechcae-col1.asg.com       | Cluster  |       |       |
      | SingleItemDelete | Default | DB2:50000                  | Service  |       |       |

  ##################################################

  @MLP-20518 @sanity @positive @regression
  Scenario Outline:SC#PII_8:Create UDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                           | bodyFile                                                                               | path              | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | policy/tagging/actions                                                        | payloads/ida/ScanUDBPayloads/policyEngine/1Tags.json                                   | $.matchfullcase2  | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBCataloger/DB2CatalogerPII                               | payloads/ida/ScanUDBPayloads/policyEngine/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBCataloger/DB2CatalogerPII                               |                                                                                        |                   | 200           | DB2CatalogerPII  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII  |                                                                                        |                   | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII   |                                                                                        |                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/UDBCataloger/DB2CatalogerPII  |                                                                                        |                   | 200           | IDLE             | $.[?(@.configurationName=='DB2CatalogerPII')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UDBAnalyzer/UDBAnalyzerPII                                 | payloads/ida/ScanUDBPayloads/policyEngine/PluginConfiguration/TagsAnalyzerConfig.json  | $.configurations  | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UDBAnalyzer/UDBAnalyzerPII                                 |                                                                                        |                   | 200           | UDBAnalyzerPII   |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII |                                                                                        |                   | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzerPII')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII  |                                                                                        |                   | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UDBAnalyzer/UDBAnalyzerPII |                                                                                        |                   | 200           | IDLE             | $.[?(@.configurationName=='UDBAnalyzerPII')].status  |

  @MLP-24319 @webtest @jsons3analyzer @PIITag
  Scenario:SC#PII_8 Verify Tag is set for MatchFullCase2
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name           | facet | Tag             | fileName | userTag                                   |
      | Default     | UDBPIIAnalyzer | Tags  | UDBFullMatchTag | NAME     | TAGDETAILS_RATIOLESSERTHAN05MATCHFULLTRUE |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name           | facet | Tag                                                                                                   | fileName | userTag                                   |
      | Default     | UDBPIIAnalyzer | Tags  | DB2,UDBPIICataloger,UDBPIIAnalyzer,UDBFullMatchTag,UDBFullMatchTag1,UDBFullMatchTag2,UDBFullMatchTag3 | COMMENTS | TAGDETAILS_RATIOLESSERTHAN05MATCHFULLTRUE |

  @sanity @positive
  Scenario:SC#PII_8:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | MultipleIDDelete | Default | cataloger/UDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/UDBAnalyzer/% | Analysis |       |       |
      | SingleItemDelete | Default | gechcae-col1.asg.com       | Cluster  |       |       |
      | SingleItemDelete | Default | DB2:50000                  | Service  |       |       |

##################################################################### PII Tags - Scenarios - END ################################################################

  @cr-data @sanity @positive
  Scenario:PII_Delete Configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                  | body | response code | response message | jsonPath |
      | application/json | raw   | false | Delete | settings/credentials/UDB_Credentials |      | 200           |                  |          |
      |                  |       |       | Delete | settings/analyzers/UDBDataSource     |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/UDBCataloger      |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/UDBAnalyzer       |      | 204           |                  |          |

 #########################################################################################################################################################