Feature:Verification of SQL Server Data Source Implementation
  Description: MLP-23487 - SQL Server Data Source Implementation
  MLP-26080 - SQLServer Cataloger validation against RDS

   ###################################################Delete existing Anlaysis and CLuster if any#############################

  @positve @regression @sanity
  Scenario:Pre-Condition:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/SQLServerDBAnalyzer/%                 | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/%                   | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |

    ################################################### Credentials,Data Source,Plugin  Configuration and Business Application Creation #################################

  @precondition
  Scenario: MLP-26080:SC#1_1_Update RDS credential payload json for SqlServerDB
    Given User update the below "RDS SqlServer Credentials readOnly" in following files using json path
      | filePath                                                         | username    | password    |
      | ida/sqlServerPayloads/credentials/sqlServerValidCredentials.json | $..userName | $..password |

  @precondition
  Scenario: MLP-23487:SC#1_2_Update RDS Admin credential payload json for SqlServerDB
    Given User update the below "RDS SqlServer Credentials" in following files using json path
      | filePath                                                                 | username    | password    |
      | ida/sqlServerPayloads/credentials/sqlServerValidAdminCredentialsRDS.json | $..userName | $..password |

  @sanity @positive
  Scenario Outline:SC#1_3_Configure the Credentials for SqlServer DBDatasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                 | body                                                                     | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidSqlServerCredentials      | ida/SqlServerPayloads/Credentials/sqlServerValidCredentials.json         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidSqlServerRDSCredentials   | ida/SqlServerPayloads/Credentials/sqlServerValidRDSCredentials.json      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidSqlServerAdminCredentials | ida/SqlServerPayloads/Credentials/sqlServerValidAdminCredentialsRDS.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/IncorrectSqlServerCredentials  | ida/SqlServerPayloads/Credentials/sqlServerInvalidCredentials.json       | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/EmptySqlServerCredentials      | ida/SqlServerPayloads/Credentials/sqlServerEmptyCredentials.json         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidSqlServerCredentials      |                                                                          | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidSqlServerRDSCredentials   |                                                                          | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/IncorrectSqlServerCredentials  |                                                                          | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/EmptySqlServerCredentials      |                                                                          | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidSqlServerAdminCredentials |                                                                          | 200           |                  |          |

  @sanity @positive @regression
  Scenario Outline:SC#1_4_Create BusinessApplication tag and run the plugin configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                            | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/SqlServerPayloads/BussinessApplication.json | 200           |                  |          |

    #6822675
  Scenario Outline:MLP-26080:SC#2_1_Run the Plugin configurations for DataSource and SqlServerDBCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                        | response code | response message         | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBDataSource                                                | ida/SqlServerPayloads/DataSource/SqlServer2019AWSValidDataSourceConfig.json | 204           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBDataSource                                                |                                                                             | 200           | SqlServerValidDataSource |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                 | ida/SqlServerPayloads/PluginConfiguration/SqlServerConfigWithNoFilter.json  | 204           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                 |                                                                             | 200           | SqlServerCataloger       |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                             | 200           | IDLE                     | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  | ida/SqlServerPayloads/empty.json                                            | 200           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                             | 200           | RUNNING                  | $.[?(@.configurationName=='SqlServerCataloger')].status |

  Scenario Outline:MLP-26080:SC#2_2_Sync the test execution.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body | response code | response message | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |      | 200           | IDLE             | $.[?(@.configurationName=='SqlServerCataloger')].status |

  ##7177793##
  @webtest @MLP-26080 @sanity @positive @regression
  Scenario:MLP-26080:SC#3_Verify the Cluster,Service,Database,Schema should have the appropriate metadata information in IDC UI.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                | widgetName  |
      | caseConvert       | L                            | Description |
      | collation         | SQL_Latin1_General_CP1_CI_AS | Description |
      | version           | 15.00.4043                   | Description |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "sqlserver:1521" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                   | widgetName  |
      | Definition        | SQL Server service on port 1521 | Description |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testdatabase" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                   | widgetName  |
      | Storage type      | Microsoft SQL Server 15.00.4043 | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testschema" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Created by        | admin         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |

    ##7177794##
  @webtest @MLP-26080 @sanity @positive @regression
  Scenario:MLP-26080:SC#4_Verify the Table,Column,Index,Constraint should have the appropriate metadata information in IDC UI.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "products" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "product_id" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | INT           | Description |
      | nulls             | NO            | Description |
      | columnId          | 1             | Description |
      | scale             | 0             | Description |
      | dataPrecision     | 10            | Description |
      | Length            | 4             | Statistics  |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Index" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "pk__products__47027df5cc95f19a" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | unique            | YES           | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |

    ##7177795##
  @webtest @MLP-26080 @sanity @positive @regression
  Scenario:MLP-26080:SC#5_Verify the User,Data Type,File should have the appropriate metadata information in IDC UI.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "User" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "admin" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DataType" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "clientcode" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | varchar 8     | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testdatabase_log" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | File size         | 8.00 MB       | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |

    ##7177796##
  @webtest @MLP-26080 @sanity @positive @regression
  Scenario:MLP-26080:SC#6_Verify the Trigger metadata and SqlSource should appear properly.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Trigger" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "trigger_product_audit" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    Then user performs click and verify in new window
      | Table     | value     | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | SQLSource | click and switch tab | No               |             |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Trigger" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "trigger_vw_brands" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    Then user performs click and verify in new window
      | Table     | value     | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | SQLSource | click and switch tab | No               |             |

    ##7177797##
  @webtest @MLP-26080 @sanity @positive @regression
  Scenario:MLP-26080:SC#7_Verify the metadata for different routines should appear properly.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "procedurewithparameters" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue        | widgetName  |
      | routineType       | SQL_STORED_PROCEDURE | Description |
      | paramSignature    | NNC                  | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName  |
      | Last catalogued at | Lifecycle   |
      | Created            | Lifecycle   |
      | Modified           | Lifecycle   |
      | Parameters         | Description |
    Then user performs click and verify in new window
      | Table     | value     | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | SQLSource | click and switch tab | No               |             |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "inlinetablevaluedfunction" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                    | widgetName  |
      | routineType       | SQL_INLINE_TABLE_VALUED_FUNCTION | Description |
      | paramSignature    | N                                | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName  |
      | Last catalogued at | Lifecycle   |
      | Created            | Lifecycle   |
      | Modified           | Lifecycle   |
      | Parameters         | Description |
    Then user performs click and verify in new window
      | Table     | value     | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | SQLSource | click and switch tab | No               |             |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "productlistprocedure" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue        | widgetName  |
      | routineType       | SQL_STORED_PROCEDURE | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    Then user performs click and verify in new window
      | Table     | value     | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | SQLSource | click and switch tab | No               |             |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testfunction1" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue       | widgetName  |
      | routineType       | SQL_SCALAR_FUNCTION | Description |
      | paramSignature    | NNNN                | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName  |
      | Last catalogued at | Lifecycle   |
      | Created            | Lifecycle   |
      | Modified           | Lifecycle   |
      | Parameters         | Description |
    Then user performs click and verify in new window
      | Table     | value     | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | SQLSource | click and switch tab | No               |             |

##7177798##
  @webtest @MLP-26080 @sanity @positive @regression
  Scenario:MLP-26080:SC#8_Verify User defined data type are collected with data type UDT under Schema by SqlServerCataloger.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "clientcode" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | UDT           | Description |
      | nulls             | NO            | Description |
      | columnId          | 1             | Description |
      | scale             | 0             | Description |
      | dataPrecision     | 0             | Description |
      | Length            | 8             | Statistics  |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |

    ##7177799##
  @webtest @MLP-26080 @sanity @positive @regression
  Scenario:MLP-26080:SC#9_Verify normal views and materialized views are collected by SqlServerCataloger.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "view_employee_personal_info" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "view_employee_personal_info" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    Then user performs click and verify in new window
      | Table     | value     | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | SQLSource | click and switch tab | No               |             |
    And user enters the search text "productmaterialview" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "productmaterialview" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | MATERIALIZED  | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    Then user performs click and verify in new window
      | Table     | value     | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | SQLSource | click and switch tab | No               |             |

    #7177800#
  @sanity @positive @MLP-23777 @webtest @IDA-1.1.0
  Scenario:MLP-26080:SC#10_Verify log entries/log enhancements(processed Items widget and Processed count) check for SqlServerDBCataloger plugin logs.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/SQLServerDBCataloger/SqlServerCataloger%"
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com |
      | sqlserver:1521                                     |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/SQLServerDBCataloger/SqlServerCataloger%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | logCode       | pluginName           | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0019 |                      |                |
      | INFO | Plugin Name:SQLServerDBCataloger, Plugin Type:cataloger, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:2e21b2063ab6, Plugin Configuration name:SqlServerCataloger                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | ANALYSIS-0071 | SQLServerDBCataloger | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: ---  2020-09-16 19:35:18.643 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: name: "SqlServerCataloger"  2020-09-16 19:35:18.643 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: pluginVersion: "LATEST"  2020-09-16 19:35:18.643 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: label:  2020-09-16 19:35:18.643 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: : ""  2020-09-16 19:35:18.643 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: catalogName: "Default"  2020-09-16 19:35:18.643 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: eventClass: null  2020-09-16 19:35:18.644 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: eventCondition: null  2020-09-16 19:35:18.644 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: nodeCondition: "name==\"LocalNode\""  2020-09-16 19:35:18.644 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: maxWorkSize: 100  2020-09-16 19:35:18.644 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: tags:  2020-09-16 19:35:18.644 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: - "SqlServerTag1"  2020-09-16 19:35:18.644 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: pluginType: "cataloger"  2020-09-16 19:35:18.644 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: dataSource: "SqlServerValidDataSource"  2020-09-16 19:35:18.644 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: credential: "ValidSqlServerCredentials"  2020-09-16 19:35:18.644 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: businessApplicationName: "SqlServer_BA"  2020-09-16 19:35:18.644 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: dryRun: false  2020-09-16 19:35:18.645 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: schedule: null  2020-09-16 19:35:18.645 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: filter: null  2020-09-16 19:35:18.645 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: pluginName: "SQLServerDBCataloger"  2020-09-16 19:35:18.645 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: schemas: []  2020-09-16 19:35:18.645 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: arguments: []  2020-09-16 19:35:18.645 INFO  - ANALYSIS-0073: Plugin SQLServerDBCataloger Configuration: type: "Cataloger" | ANALYSIS-0073 | SQLServerDBCataloger |                |
      | INFO | Plugin SQLServerDBCataloger Start Time:2020-08-22 18:26:03.168, End Time:2020-08-22 18:29:55.041, Processed Count:2, Errors:0, Warnings:22                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0072 | SQLServerDBCataloger |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:35.865)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0020 |                      |                |

  #7177801#
  @positve @regression @sanity @webtest
  Scenario:MLP-26080:SC#11_Verify the breadcrumb hierarchy appears correctly when SqlServerCataloger is ran.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "personal_info [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "state" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com |
      | sqlserver:1521                                     |
      | testdatabase                                       |
      | testschema                                         |
      | personal_info                                      |
      | state                                              |

#7177802
  @sanity @positive @webtest
  Scenario:MLP-26080:SC#12_Verify the technology tags got assigned to all SqlServerDB items like Cluster,Service,Database...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "SQL Server,SqlServerTag1,SqlServer_BA" should get displayed for the column "cataloger/SQLServerDBCataloger"
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                   | fileName                                           | userTag      |
      | Default     | Cluster    | Metadata Type | SQL Server,SqlServerTag1,SqlServer_BA | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | SqlServer_BA |
      | Default     | Column     | Metadata Type | SQL Server,SqlServerTag1,SqlServer_BA | product_id                                         | SqlServer_BA |
      | Default     | Constraint | Metadata Type | SQL Server,SqlServerTag1,SqlServer_BA | ck__checkcons__unit___3e52440b::1045578763         | SqlServer_BA |
      | Default     | Database   | Metadata Type | SQL Server,SqlServerTag1,SqlServer_BA | testdatabase                                       | SqlServer_BA |
      | Default     | Schema     | Metadata Type | SQL Server,SqlServerTag1,SqlServer_BA | testschema                                         | SqlServer_BA |
      | Default     | Service    | Metadata Type | SQL Server,SqlServerTag1,SqlServer_BA | sqlserver:1521                                     | SqlServer_BA |
      | Default     | Table      | Metadata Type | SQL Server,SqlServerTag1,SqlServer_BA | products                                           | SqlServer_BA |
      | Default     | File       | Metadata Type | SQL Server,SqlServerTag1,SqlServer_BA | testdatabase_log                                   | SqlServer_BA |
      | Default     | Routine    | Metadata Type | SQL Server,SqlServerTag1,SqlServer_BA | testfunction1                                      | SqlServer_BA |
      | Default     | DataType   | Metadata Type | SQL Server,SqlServerTag1,SqlServer_BA | clientcode                                         | SqlServer_BA |
      | Default     | Trigger    | Metadata Type | SQL Server,SqlServerTag1,SqlServer_BA | trigger_vw_brands                                  | SqlServer_BA |
      | Default     | Index      | Metadata Type | SQL Server,SqlServerTag1,SqlServer_BA | customerdetails_multipleindex                      | SqlServer_BA |
      | Default     | User       | Metadata Type | SQL Server,SqlServerTag1,SqlServer_BA | admin                                              | SqlServer_BA |

    #7177804
  @MLP-26080 @webtest @positive @regression @sanity
  Scenario:MLP-26080:SC#13_Verify proper error message is shown if mandatory fields are not filled in SqlServerDBCataloger configuration page
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
      | fieldName | attribute            |
      | Type      | Cataloger            |
      | Plugin    | SQLServerDBCataloger |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |

  #7177805
  @MLP-26080 @webtest @positive @regression @sanity
  Scenario:MLP-26080:SC#14_Verify captions and tool tip text in SqlServerDBCataloger
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
      | fieldName | attribute            |
      | Type      | Cataloger            |
      | Plugin    | SQLServerDBCataloger |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                |
      | Label                |
      | Business Application |
      | Data Source*         |
      | Credential*          |

    #7132255
  @positve @regression @sanity  @MLP-24873 @IDA-1.1.0
  Scenario Outline:MLP-26080:SC#15_1_Get the SqlServerCataloger Configuration response
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                               | body                                           | response code | response message | filePath                                         | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | /schemes/analyzers/configurations | response/sqlserver/body/ToolTip_Cataloger.json | 200           |                  | response/sqlserver/actual/ToolTip_Cataloger.json |          |

    #7177806
  @positve @regression @sanity  @MLP-7660 @IDA-1.1.0
  Scenario Outline:MLP-26080:SC#15_2_Validate ToolTip for all the fields in SqlServerDbCataloger plugin.
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                           | actualValues                                     | valueType     | expectedJsonPath                               | actualJsonPath                                         |
      | response/sqlserver/expected/ToolTip.json | response/sqlserver/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields..[?(@.label=='Type')].tooltip   | $..[?(@.label=='Type')].tooltip                        |
      | response/sqlserver/expected/ToolTip.json | response/sqlserver/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields..[?(@.label=='Plugin')].tooltip | $..[?(@.label=='Plugin')].tooltip                      |
      | response/sqlserver/expected/ToolTip.json | response/sqlserver/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.Name.tooltip                    | $.properties[0].value.prototype.properties[2].tooltip  |
      | response/sqlserver/expected/ToolTip.json | response/sqlserver/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.pluginVersion.tooltip           | $.properties[0].value.prototype.properties[3].tooltip  |
      | response/sqlserver/expected/ToolTip.json | response/sqlserver/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.label.tooltip                   | $.properties[0].value.prototype.properties[4].tooltip  |
      | response/sqlserver/expected/ToolTip.json | response/sqlserver/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.businessApplicationName.tooltip | $.properties[0].value.prototype.properties[17].tooltip |
      | response/sqlserver/expected/ToolTip.json | response/sqlserver/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.dataSource.tooltip              | $.properties[0].value.prototype.properties[14].tooltip |
      | response/sqlserver/expected/ToolTip.json | response/sqlserver/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.credential.tooltip              | $.properties[0].value.prototype.properties[16].tooltip |
      | response/sqlserver/expected/ToolTip.json | response/sqlserver/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.eventCondition.tooltip          | $.properties[0].value.prototype.properties[5].tooltip  |
      | response/sqlserver/expected/ToolTip.json | response/sqlserver/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.dryRun.tooltip                  | $.properties[0].value.prototype.properties[6].tooltip  |
      | response/sqlserver/expected/ToolTip.json | response/sqlserver/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.eventClass.tooltip              | $.properties[0].value.prototype.properties[7].tooltip  |
      | response/sqlserver/expected/ToolTip.json | response/sqlserver/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.maxWorkSize.tooltip             | $.properties[0].value.prototype.properties[8].tooltip  |
      | response/sqlserver/expected/ToolTip.json | response/sqlserver/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.nodeCondition.tooltip           | $.properties[0].value.prototype.properties[10].tooltip |
      | response/sqlserver/expected/ToolTip.json | response/sqlserver/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.autoStart.tooltip               | $.properties[0].value.prototype.properties[11].tooltip |
      | response/sqlserver/expected/ToolTip.json | response/sqlserver/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.tags.tooltip                    | $.properties[0].value.prototype.properties[12].tooltip |
      | response/sqlserver/expected/ToolTip.json | response/sqlserver/actual/ToolTip_Cataloger.json | stringCompare | $.Commonfields.schematablefilters.tooltip      | $.properties[0].value.prototype.properties[18].tooltip |

   #7177807
  @webtest @MLP-26080 @sanity @positive @regression
  Scenario:MLP-26080:SC#16_Verify the primary key,foreign key,Unique key,index constraint are getting collected properly.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "stores" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Index" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "pk__stores__a2f2a30c53c041ab" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | unique            | YES           | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user enters the search text "visits" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "fk__visits__store_id__38996ab5::949578421" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Constraint Type   | FOREIGN_KEY   | Description |
      | deleteRule        | NO_ACTION     | Description |
      | updateRule        | NO_ACTION     | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    And user enters the search text "UniqueTable" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Index" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "uq__uniqueta__ab6e61649c8e5ec0" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | unique            | YES           | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user enters the search text "unitprice" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ck__multiplecheckcon__4316f928::1125579048" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                     | widgetName  |
      | checkCondition    | ([discounted_price]<[unit_price]) | Description |
      | Constraint Type   | CHECK                             | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |

  ##7177808
  @webtest @MLP-26080 @sanity @positive @regression
  Scenario:MLP-26080:SC#17_1_Verify SqlServerDBCataloger scans and collects data if filters are not provided.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | testdatabase |
      | model        |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testdatabase" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName      | dataBaseType | queryPath     | queryPage        | queryField          | columnName  | queryOperation   | storeResults  |
      | SQLSERVER2019_RDS | STRUCTURED   | json/IDA.json | SqlServerQueries | getSqlServerSchemas | schema_name | returnstringlist | resultsInList |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testschema" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName      | dataBaseType | queryPath     | queryPage        | queryField         | columnName | queryOperation   | storeResults  |
      | SQLSERVER2019_RDS | STRUCTURED   | json/IDA.json | SqlServerQueries | getSqlServerTables | table_name | returnstringlist | resultsInList |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testdatabase" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName      | dataBaseType | queryPath     | queryPage        | queryField        | columnName | queryOperation   | storeResults  |
      | SQLSERVER2019_RDS | STRUCTURED   | json/IDA.json | SqlServerQueries | getSqlServerFiles | file_name  | returnstringlist | resultsInList |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testschema" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName      | dataBaseType | queryPath     | queryPage        | queryField           | columnName   | queryOperation   | storeResults  |
      | SQLSERVER2019_RDS | STRUCTURED   | json/IDA.json | SqlServerQueries | getSqlServerRoutines | routine_name | returnstringlist | resultsInList |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testdatabase" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName      | dataBaseType | queryPath     | queryPage        | queryField        | columnName | queryOperation   | storeResults  |
      | SQLSERVER2019_RDS | STRUCTURED   | json/IDA.json | SqlServerQueries | getSqlServerUsers | user_name  | returnstringlist | resultsInList |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testschema" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName      | dataBaseType | queryPath     | queryPage        | queryField           | columnName   | queryOperation   | storeResults  |
      | SQLSERVER2019_RDS | STRUCTURED   | json/IDA.json | SqlServerQueries | getSqlServerTriggers | trigger_name | returnstringlist | resultsInList |

  Scenario:MLP-26080:SC#17_2_Delete cluster and analysis items
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/SqlServerCataloger/% | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com  | Cluster  |       |       |

  Scenario Outline:MLP-26080:SC#18_1_Run the Plugin configurations for SqlServerDBCataloger in dry run mode
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                             | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                 | ida/SqlServerPayloads/PluginConfiguration/SqlServerConfigWithNoFilterDryRun.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                 |                                                                                  | 200           | SqlServerCataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                                  | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  | ida/SqlServerPayloads/empty.json                                                 | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                                  | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |

    #7177810
  @MLP-26080 @webtest @regression @sanity
  Scenario:MLP-26080:SC#18_2_Verify SqlServerDBCataloger doesn't collects Cluster,Service,Database,Table,Column,Constraint when dryrun as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerTag1" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service    |
      | Cluster    |
      | Database   |
      | Table      |
      | Column     |
      | Constraint |
      | Schema     |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/SQLServerDBCataloger/SqlServerCataloger%"
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName |
      | Number of processed items | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/SQLServerDBCataloger/SqlServerCataloger%" should display below info/error/warning
      | type | logValue                                                                                                                                   | logCode       | pluginName           | removableText |
      | INFO | Plugin SQLServerDBCataloger running on dry run mode                                                                                        | ANALYSIS-0069 | SQLServerDBCataloger |               |
      | INFO | Plugin SQLServerDBCataloger processed 2 items on dry run mode and not written to the repository                                            | ANALYSIS-0070 | SQLServerDBCataloger |               |
      | INFO | Plugin SQLServerDBCataloger Start Time:2020-06-15 23:31:07.702, End Time:2020-06-15 23:31:09.040, Processed Count:2, Errors:0, Warnings:88 | ANALYSIS-0072 | SQLServerDBCataloger |               |
    And user clicks on logout button

  @sanity @positive
  Scenario:MLP-26080:SC#18_3_Delete cluster and analysis items
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/SqlServerCataloger/% | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com  | Cluster  |       |       |

  @sanity @positive
  Scenario Outline:MLP-26621:SC#18_4_Delete the Credentials and plugin configurations for SqlServerCataloger and SqlServerAnalyzer.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                      | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerDBCataloger  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerDBDataSource |      | 204           |                  |          |

  Scenario Outline:MLP-26080:SC#19_1_Run the Plugin configurations for DataSource and SqlServerDBCataloger in Internal node.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                                                    | response code | response message         | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBDataSource                                                   | ida/SqlServerPayloads/DataSource/SqlServer2019AWSValidDataSourceConfigInternalNode.json | 204           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBDataSource                                                   |                                                                                         | 200           | SqlServerValidDataSource |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                    | ida/SqlServerPayloads/PluginConfiguration/SqlServerConfigWithNoFilterInternalNode.json  | 204           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                    |                                                                                         | 200           | SqlServerCataloger       |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                                         | 200           | IDLE                     | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  | ida/SqlServerPayloads/empty.json                                                        | 200           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                                         | 200           | RUNNING                  | $.[?(@.configurationName=='SqlServerCataloger')].status |

  Scenario Outline:MLP-26080:SC#19_2_Sync the test execution.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body | response code | response message | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |      | 200           | IDLE             | $.[?(@.configurationName=='SqlServerCataloger')].status |

    ##7177811 MLP-28209 has been created for the trigger issue.To make this case pass,tried deleting trigger but shows no permission to do it.#
  @webtest @MLP-26080 @sanity @positive @regression
  Scenario:MLP-26080:SC#19_3_Verify SqlServerDBCataloger scans and collects data if filters are not provided.(run in internal node)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | testdatabase |
      | model        |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testdatabase" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName      | dataBaseType | queryPath     | queryPage        | queryField          | columnName  | queryOperation   | storeResults  |
      | SQLSERVER2019_RDS | STRUCTURED   | json/IDA.json | SqlServerQueries | getSqlServerSchemas | schema_name | returnstringlist | resultsInList |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testschema" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName      | dataBaseType | queryPath     | queryPage        | queryField         | columnName | queryOperation   | storeResults  |
      | SQLSERVER2019_RDS | STRUCTURED   | json/IDA.json | SqlServerQueries | getSqlServerTables | table_name | returnstringlist | resultsInList |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testdatabase" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName      | dataBaseType | queryPath     | queryPage        | queryField        | columnName | queryOperation   | storeResults  |
      | SQLSERVER2019_RDS | STRUCTURED   | json/IDA.json | SqlServerQueries | getSqlServerFiles | file_name  | returnstringlist | resultsInList |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testschema" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName      | dataBaseType | queryPath     | queryPage        | queryField           | columnName   | queryOperation   | storeResults  |
      | SQLSERVER2019_RDS | STRUCTURED   | json/IDA.json | SqlServerQueries | getSqlServerRoutines | routine_name | returnstringlist | resultsInList |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testdatabase" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName      | dataBaseType | queryPath     | queryPage        | queryField        | columnName | queryOperation   | storeResults  |
      | SQLSERVER2019_RDS | STRUCTURED   | json/IDA.json | SqlServerQueries | getSqlServerUsers | user_name  | returnstringlist | resultsInList |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testschema" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName      | dataBaseType | queryPath     | queryPage        | queryField           | columnName   | queryOperation   | storeResults  |
      | SQLSERVER2019_RDS | STRUCTURED   | json/IDA.json | SqlServerQueries | getSqlServerTriggers | trigger_name | returnstringlist | resultsInList |

  Scenario:MLP-26080:SC#19_4_Delete cluster and analysis items
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/SqlServerCataloger/% | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com  | Cluster  |       |       |

    ##########################Cataloger Cases with filters ###############################################################

  #6822675
  Scenario Outline:MLP-26655:SC#20_1_Run the Plugin configurations for DataSource and SqlServerDBCataloger with schema only filter
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                               | response code | response message         | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBDataSource                                                | ida/SqlServerPayloads/DataSource/SqlServer2019AWSValidDataSourceConfig.json        | 204           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBDataSource                                                |                                                                                    | 200           | SqlServerValidDataSource |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                 | ida/SqlServerPayloads/PluginConfiguration/SqlServerConfigWithOnlySchemaFilter.json | 204           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                 |                                                                                    | 200           | SqlServerCataloger       |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                                    | 200           | IDLE                     | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  | ida/SqlServerPayloads/empty.json                                                   | 200           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                                    | 200           | RUNNING                  | $.[?(@.configurationName=='SqlServerCataloger')].status |

  Scenario Outline:MLP-26080:SC#20_2_Sync the test execution.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body | response code | response message | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |      | 200           | IDLE             | $.[?(@.configurationName=='SqlServerCataloger')].status |

    #7177790
  @webtest @MLP-26655 @sanity @positive @regression
  Scenario:MLP-26655:SC#20_3_Verify SqlServerDBCataloger scans and collects data if schema alone given in filters.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | testdatabase |
      | model        |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | testschema |
      | sys        |
      | guest      |
      | dbo        |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testschema" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName      | dataBaseType | queryPath     | queryPage        | queryField         | columnName | queryOperation   | storeResults  |
      | SQLSERVER2019_RDS | STRUCTURED   | json/IDA.json | SqlServerQueries | getSqlServerTables | table_name | returnstringlist | resultsInList |

  Scenario:MLP-26655:SC#20_4_Delete cluster and analysis items
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/SqlServerCataloger/% | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com  | Cluster  |       |       |

#6822675
  Scenario Outline:MLP-26655:SC#21_1_Run the Plugin configurations for DataSource and SqlServerDBCataloger with schema/table/view filter
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                                        | response code | response message         | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBDataSource                                                | ida/SqlServerPayloads/DataSource/SqlServer2019AWSValidDataSourceConfig.json                 | 204           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBDataSource                                                |                                                                                             | 200           | SqlServerValidDataSource |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                 | ida/SqlServerPayloads/PluginConfiguration/SqlServerConfigWithOnlySchemaTableViewFilter.json | 204           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                 |                                                                                             | 200           | SqlServerCataloger       |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                                             | 200           | IDLE                     | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  | ida/SqlServerPayloads/empty.json                                                            | 200           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                                             | 200           | RUNNING                  | $.[?(@.configurationName=='SqlServerCataloger')].status |

  Scenario Outline:MLP-26655:SC#21_2_Sync the test execution.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body | response code | response message | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |      | 200           | IDLE             | $.[?(@.configurationName=='SqlServerCataloger')].status |

    #7177790
  @webtest @MLP-26655 @sanity @positive @regression
  Scenario:MLP-26655:SC#21_3_Verify SqlServerDBCataloger scans and collects data if schema/table/view given in filters.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | testdatabase |
      | model        |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | testschema |
      | sys        |
      | guest      |
      | dbo        |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testschema" item from search results
    And user "verifies tab section values" has the following values in "Tables" Tab in Item View page
      | diffdatatypesanalyzer     |
      | diffdatatypesanalyzerview |
      | products                  |
      | product_audits            |
      | brands                    |
      | brand_approvals           |
      | staffs                    |

  Scenario:MLP-26655:SC#21_4_Delete cluster and analysis items
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/SqlServerCataloger/% | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com  | Cluster  |       |       |

 #6822675
  Scenario Outline:MLP-26655:SC#22_1_Run the Plugin configurations for DataSource and SqlServerDBCataloger with multiple schema/table/view filter
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                                            | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                 | ida/SqlServerPayloads/PluginConfiguration/SqlServerConfigWithMultipleSchemaTableViewFilter.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                 |                                                                                                 | 200           | SqlServerCataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                                                 | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  | ida/SqlServerPayloads/empty.json                                                                | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                                                 | 200           | RUNNING            | $.[?(@.configurationName=='SqlServerCataloger')].status |

  Scenario Outline:MLP-26655:SC#21_2_Sync the test execution.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body | response code | response message | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |      | 200           | IDLE             | $.[?(@.configurationName=='SqlServerCataloger')].status |

        #7177790
  @webtest @MLP-26655 @sanity @positive @regression
  Scenario:MLP-26655:SC#21_3_Verify SqlServerDBCataloger scans and collects data if multiple schema/table/view given in filters.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testdatabase" item from search results
    And user "verifies tab section values" has the following values in "Schemas" Tab in Item View page
      | testschema       |
      | sqlserverlineage |
      | sys              |
      | dbo              |
      | guest            |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testschema" item from search results
    And user "verifies tab section values" has the following values in "Tables" Tab in Item View page
      | diffdatatypesanalyzer     |
      | diffdatatypesanalyzerview |
      | products                  |
      | product_audits            |
      | brands                    |
      | brand_approvals           |
      | staffs                    |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "sqlserverlineage" item from search results
    And user "verifies tab section values" has the following values in "Tables" Tab in Item View page
      | diffdatatypesanalyzerview                |
      | diffdatatypesanalyzer                    |
      | school                                   |
      | lineagetable1                            |
      | category                                 |
      | lineagetable2                            |
      | lineagetable3                            |
      | lineagetable4                            |
      | lineagetable5                            |
      | lineagetable6                            |
      | userdefinedtypetable1                    |
      | userdefinedtypetable2                    |
      | category_staging                         |
      | addresses1                               |
      | addresses2                               |
      | addresses3                               |
      | lineagetableviewtoviewviewtomulttables56 |
      | addresses                                |
      | lineagetable56                           |
      | lineageviewtomultipletables56            |
      | lineagetableview56                       |
      | books                                    |
      | authors                                  |
      | lineageupdatetable1                      |
      | lineageupdatetable2                      |

  Scenario:MLP-26655:SC#21_4_Delete cluster and analysis items
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/SqlServerCataloger/% | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com  | Cluster  |       |       |

#6822675
  Scenario Outline:MLP-26655:SC#22_1_Run the Plugin configurations for DataSource and SqlServerDBCataloger with multiple duplicate schema/table/view filter
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                                                     | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                 | ida/SqlServerPayloads/PluginConfiguration/SqlServerConfigWithMultipleDuplicateSchemaTableViewFilter.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                 |                                                                                                          | 200           | SqlServerCataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                                                          | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  | ida/SqlServerPayloads/empty.json                                                                         | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                                                          | 200           | RUNNING            | $.[?(@.configurationName=='SqlServerCataloger')].status |

  Scenario Outline:MLP-26655:SC#22_2_Sync the test execution.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body | response code | response message | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |      | 200           | IDLE             | $.[?(@.configurationName=='SqlServerCataloger')].status |

    #7177790
  @webtest @MLP-26655 @sanity @positive @regression
  Scenario:MLP-26655:SC#22_3_Verify SqlServerDBCataloger scans and collects data if multiple duplicate schema/table/view given in filters.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | testschema       |
      | sqlserverlineage |
      | sys              |
      | dbo              |
      | guest            |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testschema" item from search results
    And user "verifies tab section values" has the following values in "Tables" Tab in Item View page
      | diffdatatypesanalyzer     |
      | diffdatatypesanalyzerview |
      | products                  |
      | product_audits            |
      | brands                    |
      | brand_approvals           |
      | staffs                    |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "sqlserverlineage" item from search results
    And user "verifies tab section values" has the following values in "Tables" Tab in Item View page
      | diffdatatypesanalyzerview                |
      | diffdatatypesanalyzer                    |
      | school                                   |
      | lineagetable1                            |
      | category                                 |
      | lineagetable2                            |
      | lineagetable3                            |
      | lineagetable4                            |
      | lineagetable5                            |
      | lineagetable6                            |
      | userdefinedtypetable1                    |
      | userdefinedtypetable2                    |
      | category_staging                         |
      | addresses1                               |
      | addresses2                               |
      | addresses3                               |
      | lineagetableviewtoviewviewtomulttables56 |
      | addresses                                |
      | lineagetable56                           |
      | lineageviewtomultipletables56            |
      | lineagetableview56                       |
      | books                                    |
      | authors                                  |
      | lineageupdatetable1                      |
      | lineageupdatetable2                      |

  Scenario:MLP-26655:SC#22_4_Delete cluster and analysis items
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/SqlServerCataloger/% | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com  | Cluster  |       |       |

#6822675
  Scenario Outline:MLP-26655:SC#23_1_Run the Plugin configurations for DataSource and SqlServerDBCataloger with only table/view filter
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                                  | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                 | ida/SqlServerPayloads/PluginConfiguration/SqlServerConfigWithOnlyTableViewFilter.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                 |                                                                                       | 200           | SqlServerCataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                                       | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  | ida/SqlServerPayloads/empty.json                                                      | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                                       | 200           | RUNNING            | $.[?(@.configurationName=='SqlServerCataloger')].status |

  Scenario Outline:MLP-26655:SC#23_2_Sync the test execution.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body | response code | response message | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |      | 200           | IDLE             | $.[?(@.configurationName=='SqlServerCataloger')].status |

  #7177790
  @webtest @MLP-26655 @sanity @positive @regression
  Scenario:MLP-26655:SC#23_3_Verify SqlServerDBCataloger scans and collects data if only table/view given in filters.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | testschema       |
      | sqlserverlineage |
      | sys              |
      | dbo              |
      | guest            |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "testschema" item from search results
    And user "verifies tab section values" has the following values in "Tables" Tab in Item View page
      | diffdatatypesanalyzer     |
      | diffdatatypesanalyzerview |
      | products                  |
      | product_audits            |
      | brands                    |
      | brand_approvals           |
      | staffs                    |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "sqlserverlineage" item from search results
    And user "verifies tab section values" has the following values in "Tables" Tab in Item View page
      | diffdatatypesanalyzerview                |
      | diffdatatypesanalyzer                    |
      | lineagetable1                            |
      | category                                 |
      | lineagetable2                            |
      | lineagetable3                            |
      | lineagetable4                            |
      | lineagetable5                            |
      | lineagetable6                            |
      | userdefinedtypetable1                    |
      | userdefinedtypetable2                    |
      | category_staging                         |
      | addresses1                               |
      | addresses2                               |
      | addresses3                               |
      | lineagetableviewtoviewviewtomulttables56 |
      | addresses                                |
      | lineagetable56                           |
      | lineageviewtomultipletables56            |
      | lineagetableview56                       |
      | books                                    |
      | authors                                  |
      | lineageupdatetable1                      |
      | lineageupdatetable2                      |

  Scenario:MLP-26655:SC#23_4_Delete cluster and analysis items
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/SqlServerCataloger/% | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com  | Cluster  |       |       |

  #6822675
  Scenario Outline:MLP-26655:SC#24_1_Run the Plugin configurations for DataSource and SqlServerDBCataloger with non existing schema/table filters
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                                               | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                 | ida/SqlServerPayloads/PluginConfiguration/SqlServerConfigWithNonExistingSchemaTableViewFilter.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                 |                                                                                                    | 200           | SqlServerCataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                                                    | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  | ida/SqlServerPayloads/empty.json                                                                   | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                                                    | 200           | RUNNING            | $.[?(@.configurationName=='SqlServerCataloger')].status |

  Scenario Outline:MLP-26655:SC#24_2_Sync the test execution.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body | response code | response message | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |      | 200           | IDLE             | $.[?(@.configurationName=='SqlServerCataloger')].status |

  @webtest @MLP-26655 @sanity @positive @regression
  Scenario:MLP-26655:SC#24_3_Verify SqlServerDBCataloger scans and does not collects data if non existing schema name and table/view name are provided in filters.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerTag1" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Table      |
      | Column     |
      | Constraint |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/SQLServerDBCataloger/SqlServerCataloger%"
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com |
      | sqlserver:1521                                     |
    And user clicks on logout button

  Scenario:MLP-26655:SC#24_4_Delete cluster and analysis items
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/SqlServerCataloger/% | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com  | Cluster  |       |       |

#6822675
  Scenario Outline:MLP-26655:SC#25_1_Run the Plugin configurations for DataSource and SqlServerDBCataloger with schema/table/view filter for diffdatatypes metadata.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                                                 | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                 | ida/SqlServerPayloads/PluginConfiguration/SqlServerConfigWithOnlySchemaTableDiffdataTypesFilter.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                 |                                                                                                      | 200           | SqlServerCataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                                                      | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  | ida/SqlServerPayloads/empty.json                                                                     | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                                                      | 200           | RUNNING            | $.[?(@.configurationName=='SqlServerCataloger')].status |

  Scenario Outline:MLP-26655:SC#25_2_Sync the test execution.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body | response code | response message | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |      | 200           | IDLE             | $.[?(@.configurationName=='SqlServerCataloger')].status |

  Scenario Outline:MLP-26655:SC#25_3_user retrieves the item ids of Column items of Table: DiffDataTypes and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                 | type | targetFile                                    | jsonpath      |
      | APPDBPOSTGRES | Default | biginttype           |      | response/sqlserver/actual/columnItemIds1.json | $..Field1.id  |
      | APPDBPOSTGRES | Default | inttype              |      | response/sqlserver/actual/columnItemIds1.json | $..Field2.id  |
      | APPDBPOSTGRES | Default | smallinttype         |      | response/sqlserver/actual/columnItemIds1.json | $..Field3.id  |
      | APPDBPOSTGRES | Default | tinyinttype          |      | response/sqlserver/actual/columnItemIds1.json | $..Field4.id  |
      | APPDBPOSTGRES | Default | bittype              |      | response/sqlserver/actual/columnItemIds1.json | $..Field5.id  |
      | APPDBPOSTGRES | Default | decimaltype          |      | response/sqlserver/actual/columnItemIds1.json | $..Field6.id  |
      | APPDBPOSTGRES | Default | numerictype          |      | response/sqlserver/actual/columnItemIds1.json | $..Field7.id  |
      | APPDBPOSTGRES | Default | moneytype            |      | response/sqlserver/actual/columnItemIds1.json | $..Field8.id  |
      | APPDBPOSTGRES | Default | smallmoneytype       |      | response/sqlserver/actual/columnItemIds1.json | $..Field9.id  |
      | APPDBPOSTGRES | Default | floattype            |      | response/sqlserver/actual/columnItemIds1.json | $..Field10.id |
      | APPDBPOSTGRES | Default | realtype             |      | response/sqlserver/actual/columnItemIds1.json | $..Field11.id |
      | APPDBPOSTGRES | Default | datetimetype         |      | response/sqlserver/actual/columnItemIds1.json | $..Field12.id |
      | APPDBPOSTGRES | Default | smalldatetimetype    |      | response/sqlserver/actual/columnItemIds1.json | $..Field13.id |
      | APPDBPOSTGRES | Default | datetype             |      | response/sqlserver/actual/columnItemIds1.json | $..Field14.id |
      | APPDBPOSTGRES | Default | timetype             |      | response/sqlserver/actual/columnItemIds1.json | $..Field15.id |
      | APPDBPOSTGRES | Default | datetimeoffsettype   |      | response/sqlserver/actual/columnItemIds1.json | $..Field16.id |
      | APPDBPOSTGRES | Default | datetime2type        |      | response/sqlserver/actual/columnItemIds1.json | $..Field17.id |
      | APPDBPOSTGRES | Default | chartype             |      | response/sqlserver/actual/columnItemIds1.json | $..Field18.id |
      | APPDBPOSTGRES | Default | varchartype          |      | response/sqlserver/actual/columnItemIds1.json | $..Field19.id |
      | APPDBPOSTGRES | Default | varcharofmax         |      | response/sqlserver/actual/columnItemIds1.json | $..Field20.id |
      | APPDBPOSTGRES | Default | testtype             |      | response/sqlserver/actual/columnItemIds1.json | $..Field21.id |
      | APPDBPOSTGRES | Default | nchartype            |      | response/sqlserver/actual/columnItemIds1.json | $..Field22.id |
      | APPDBPOSTGRES | Default | nvarchartype         |      | response/sqlserver/actual/columnItemIds1.json | $..Field23.id |
      | APPDBPOSTGRES | Default | ntexttype            |      | response/sqlserver/actual/columnItemIds1.json | $..Field24.id |
      | APPDBPOSTGRES | Default | binarytype           |      | response/sqlserver/actual/columnItemIds1.json | $..Field25.id |
      | APPDBPOSTGRES | Default | varbinarytype        |      | response/sqlserver/actual/columnItemIds1.json | $..Field26.id |
      | APPDBPOSTGRES | Default | imagetype            |      | response/sqlserver/actual/columnItemIds1.json | $..Field27.id |
      | APPDBPOSTGRES | Default | rowversiontype       |      | response/sqlserver/actual/columnItemIds1.json | $..Field28.id |
      | APPDBPOSTGRES | Default | hierarchyidtype      |      | response/sqlserver/actual/columnItemIds1.json | $..Field29.id |
      | APPDBPOSTGRES | Default | uniqueidentifiertype |      | response/sqlserver/actual/columnItemIds1.json | $..Field30.id |
      | APPDBPOSTGRES | Default | sql_varianttype      |      | response/sqlserver/actual/columnItemIds1.json | $..Field31.id |
      | APPDBPOSTGRES | Default | xmltype              |      | response/sqlserver/actual/columnItemIds1.json | $..Field32.id |
      | APPDBPOSTGRES | Default | geometrytype         |      | response/sqlserver/actual/columnItemIds1.json | $..Field33.id |

  Scenario Outline:MLP-26655:SC#25_4_user retrieves the metadata of Column type for a Table: DiffDataTypes
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>" of "<responsePath>"
    Examples:
      | url                                             | responseCode | inputJson    | inputFile                                     | outPutFile                                     | outPutJson                                                 | responsePath                          |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field1.id  | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field1.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field1.id  | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field1.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field2.id  | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field2.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field2.id  | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field2.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field3.id  | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field3.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field3.id  | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field3.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field4.id  | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field4.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field4.id  | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field4.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field5.id  | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field5.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field5.id  | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field5.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field6.id  | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field6.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field6.id  | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field6.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field7.id  | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field7.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field7.id  | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field7.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field8.id  | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field8.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field8.id  | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field8.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field9.id  | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field9.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field9.id  | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field9.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field10.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field10.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field10.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field10.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field11.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field11.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field11.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field11.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field12.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field12.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field12.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field12.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field13.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field13.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field13.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field13.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field14.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field14.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field14.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field14.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field15.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field15.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field15.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field15.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field16.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field16.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field16.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field16.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field17.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field17.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field17.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field17.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field18.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field18.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field18.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field18.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field19.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field19.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field19.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field19.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field20.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field20.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field20.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field20.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field21.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field21.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field21.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field21.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field22.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field22.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field22.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field22.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field23.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field23.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field23.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field23.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field24.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field24.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field24.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field24.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field25.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field25.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field25.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field25.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field26.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field26.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field26.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field26.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field27.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field27.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field27.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field27.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field28.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field28.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field28.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field28.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field29.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field29.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field29.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field29.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field30.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field30.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field30.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field30.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field31.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field31.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field31.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field31.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field32.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field32.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field32.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field32.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field33.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field33.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field33.id | response/sqlserver/actual/columnItemIds1.json | response/sqlserver/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field33.fieldActualDataType | $..[?(@.caption=='Data type')]..value |

    #7177809
  Scenario Outline:MLP-26655:SC#25_5_Validate the column level metadata results for a Table: DiffDataTypes in IDC platform
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                | actualValues                                   | valueType     | expectedJsonPath                               | actualJsonPath                                             |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field1.fieldName      | $..columnActualMetaData.Table1.field1.fieldActualName      |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field1.fieldDataType  | $..columnActualMetaData.Table1.field1.fieldActualDataType  |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field2.fieldName      | $..columnActualMetaData.Table1.field2.fieldActualName      |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field2.fieldDataType  | $..columnActualMetaData.Table1.field2.fieldActualDataType  |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field3.fieldName      | $..columnActualMetaData.Table1.field3.fieldActualName      |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field3.fieldDataType  | $..columnActualMetaData.Table1.field3.fieldActualDataType  |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field4.fieldName      | $..columnActualMetaData.Table1.field4.fieldActualName      |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field4.fieldDataType  | $..columnActualMetaData.Table1.field4.fieldActualDataType  |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field5.fieldName      | $..columnActualMetaData.Table1.field5.fieldActualName      |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field5.fieldDataType  | $..columnActualMetaData.Table1.field5.fieldActualDataType  |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field6.fieldName      | $..columnActualMetaData.Table1.field6.fieldActualName      |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field6.fieldDataType  | $..columnActualMetaData.Table1.field6.fieldActualDataType  |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field7.fieldName      | $..columnActualMetaData.Table1.field7.fieldActualName      |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field7.fieldDataType  | $..columnActualMetaData.Table1.field7.fieldActualDataType  |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field8.fieldName      | $..columnActualMetaData.Table1.field8.fieldActualName      |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field8.fieldDataType  | $..columnActualMetaData.Table1.field8.fieldActualDataType  |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field9.fieldName      | $..columnActualMetaData.Table1.field9.fieldActualName      |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field9.fieldDataType  | $..columnActualMetaData.Table1.field9.fieldActualDataType  |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field10.fieldName     | $..columnActualMetaData.Table1.field10.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field10.fieldDataType | $..columnActualMetaData.Table1.field10.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field11.fieldName     | $..columnActualMetaData.Table1.field11.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field11.fieldDataType | $..columnActualMetaData.Table1.field11.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field12.fieldName     | $..columnActualMetaData.Table1.field12.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field12.fieldDataType | $..columnActualMetaData.Table1.field12.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field13.fieldName     | $..columnActualMetaData.Table1.field13.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field13.fieldDataType | $..columnActualMetaData.Table1.field13.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field14.fieldName     | $..columnActualMetaData.Table1.field14.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field14.fieldDataType | $..columnActualMetaData.Table1.field14.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field15.fieldName     | $..columnActualMetaData.Table1.field15.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field15.fieldDataType | $..columnActualMetaData.Table1.field15.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field16.fieldName     | $..columnActualMetaData.Table1.field16.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field16.fieldDataType | $..columnActualMetaData.Table1.field16.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field17.fieldName     | $..columnActualMetaData.Table1.field17.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field17.fieldDataType | $..columnActualMetaData.Table1.field17.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field18.fieldName     | $..columnActualMetaData.Table1.field18.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field18.fieldDataType | $..columnActualMetaData.Table1.field18.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field19.fieldName     | $..columnActualMetaData.Table1.field19.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field19.fieldDataType | $..columnActualMetaData.Table1.field19.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field20.fieldName     | $..columnActualMetaData.Table1.field20.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field20.fieldDataType | $..columnActualMetaData.Table1.field20.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field21.fieldName     | $..columnActualMetaData.Table1.field21.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field21.fieldDataType | $..columnActualMetaData.Table1.field21.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field22.fieldName     | $..columnActualMetaData.Table1.field22.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field22.fieldDataType | $..columnActualMetaData.Table1.field22.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field23.fieldName     | $..columnActualMetaData.Table1.field23.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field23.fieldDataType | $..columnActualMetaData.Table1.field23.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field24.fieldName     | $..columnActualMetaData.Table1.field24.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field24.fieldDataType | $..columnActualMetaData.Table1.field24.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field25.fieldName     | $..columnActualMetaData.Table1.field25.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field25.fieldDataType | $..columnActualMetaData.Table1.field25.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field26.fieldName     | $..columnActualMetaData.Table1.field26.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field26.fieldDataType | $..columnActualMetaData.Table1.field26.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field27.fieldName     | $..columnActualMetaData.Table1.field27.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field27.fieldDataType | $..columnActualMetaData.Table1.field27.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field28.fieldName     | $..columnActualMetaData.Table1.field28.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field28.fieldDataType | $..columnActualMetaData.Table1.field28.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field29.fieldName     | $..columnActualMetaData.Table1.field29.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field29.fieldDataType | $..columnActualMetaData.Table1.field29.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field30.fieldName     | $..columnActualMetaData.Table1.field30.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field30.fieldDataType | $..columnActualMetaData.Table1.field30.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field31.fieldName     | $..columnActualMetaData.Table1.field31.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field31.fieldDataType | $..columnActualMetaData.Table1.field31.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field32.fieldName     | $..columnActualMetaData.Table1.field32.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field32.fieldDataType | $..columnActualMetaData.Table1.field32.fieldActualDataType |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field33.fieldName     | $..columnActualMetaData.Table1.field33.fieldActualName     |
      | response/sqlserver/expected/sqlserverDBExpectedJsonData1.json | response/sqlserver/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field33.fieldDataType | $..columnActualMetaData.Table1.field33.fieldActualDataType |

  Scenario:MLP-26655:SC#25_6_Delete cluster and analysis items
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/SqlServerCataloger/% | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com  | Cluster  |       |       |

  @sanity @positive @regression
  Scenario Outline:SC#26_Delete Credentials,DataSource for SqlServerDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                 | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerDBCataloger             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerDBDataSource            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidSqlServerCredentials      |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidSqlServerRDSCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidSqlServerAdminCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/IncorrectSqlServerCredentials  |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EmptySqlServerCredentials      |      | 200           |                  |          |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario:SC#27_Delete Bussiness Application
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name         | type                | query | param |
      | SingleItemDelete | Default | SqlServer_BA | BusinessApplication |       |       |

  ############################## SqlServerAnalyzer Test cases ########################################################################

  @precondition
  Scenario:MLP-20943:SC#28_1_Update credential payload json for SqlServerDB
    Given User update the below "RDS SqlServer Credentials readOnly" in following files using json path
      | filePath                                                         | username    | password    |
      | ida/sqlServerPayloads/credentials/sqlServerValidCredentials.json | $..userName | $..password |

  @sanity @positive
  Scenario Outline:MLP-20943:SC#28_2_Configure the Credentials for SqlServerDBDatasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                | body                                                               | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidSqlServerCredentials     | ida/SqlServerPayloads/Credentials/sqlServerValidCredentials.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/IncorrectSqlServerCredentials | ida/SqlServerPayloads/Credentials/sqlServerInvalidCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/EmptySqlServerCredentials     | ida/SqlServerPayloads/Credentials/sqlServerEmptyCredentials.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidSqlServerCredentials     |                                                                    | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/IncorrectSqlServerCredentials |                                                                    | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/EmptySqlServerCredentials     |                                                                    | 200           |                  |          |

  @sanity @positive @regression
  Scenario Outline:MLP-20943:SC#28_3_Create BusinessApplication tag and run the plugin configuration for analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                            | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/SqlServerPayloads/BussinessApplication.json | 200           |                  |          |

    #6822675
  Scenario Outline:MLP-20943:SC#28_4_Run the Plugin configurations for DataSource and SqlServerDBCataloger/SqlServerAnalyzer with no filters.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | body                                                                               | response code | response message         | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBDataSource                                                 | ida/SqlServerPayloads/DataSource/SqlServer2019AWSValidDataSourceConfig.json        | 204           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBDataSource                                                 |                                                                                    | 200           | SqlServerValidDataSource |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                  | ida/SqlServerPayloads/PluginConfiguration/SqlServerConfigWithNoFilter.json         | 204           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                  |                                                                                    | 200           | SqlServerCataloger       |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                    | 200           | IDLE                     | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger   | ida/SqlServerPayloads/empty.json                                                   | 200           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                    | 200           | RUNNING                  | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                    | 200           | IDLE                     | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBAnalyzer                                                   | ida/SqlServerPayloads/PluginConfiguration/SqlServerAnalyzerConfigWithNoFilter.json | 204           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBAnalyzer                                                   |                                                                                    | 200           | SqlServerAnalyzer        |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                    | 200           | IDLE                     | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer  | ida/SqlServerPayloads/empty.json                                                   | 200           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                    | 200           | RUNNING                  | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                    | 200           | IDLE                     | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |

  #7195075##
  @webtest @MLP-20943
  Scenario:MLP-20943:SC#28_5_Verify the data sampling works fine for string,numeric,date,time,timestamp,complex types(table/view/materialized) if SqlServerDBAnalyzer is run successfully with no filters.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerAnalyzerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "diffdatatypesanalyzer" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | Bittype | Tinyinttype | Smallinttype | Inttype    | Biginttype          | Decimaltype | Numerictype | Smallmoneytype | Moneytype       | Realtype | Floattype         | Datetype   | Datetimetype            | Datetime2type               | Datetimeoffsettype          | Smalldatetimetype     | Timetype | Chartype  | Varchartype            | Texttype    | Nchartype          | Nvarchartype                   | Ntexttype   | Binarytype  | Varbinarytype | Imagetype   | Rowversiontype | Hierarchyidtype | Uniqueidentifiertype                 | Xmltype                             | Sql_varianttype | Geographtype | Geometrytype |
      | true    | 255         | 32767        | 2147483647 | 9223372036854775807 | 123.00      | 12345.12000 | 3148.2900      | 922337203.0000  | 5.6      | 1.2321412234324E7 | 2007-05-08 | 2007-05-08 12:35:29.123 | 2007-05-08 12:35:29.1234567 | 2007-05-08 00:20:29.1234567 | 2007-05-08 12:35:00.0 | 12:35:29 | TestChar  | Testing Variable Char  | UNSUPPORTED | Test Unicode char  | Testing Unicode Variable Char  | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED   | UNSUPPORTED | UNSUPPORTED    | UNSUPPORTED     | 61DF6F46-27AC-4787-A7C1-852B7CBCF362 | <ProductDescription ProductID="1"/> | UNSUPPORTED     | UNSUPPORTED  | UNSUPPORTED  |
      | true    | 115         | 2367         | 1137483647 | 8213372036854775807 | 303.00      | 20345.12000 | 3148.2900      | 6232337203.0000 | 51.6     | 2.2321412134324E7 | 2006-05-08 | 2006-05-08 12:35:29.123 | 2006-05-08 12:35:29.1234567 | 2006-05-08 00:20:29.1234567 | 2006-05-08 12:35:00.0 | 12:35:29 | TestChar2 | Testing Variable Char2 | UNSUPPORTED | Test Unicode char2 | Testing Unicode Variable Char2 | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED   | UNSUPPORTED | UNSUPPORTED    | UNSUPPORTED     | 734BBDBA-A376-4D9A-A123-ADEA09D417E3 | <ProductDescription ProductID="3"/> | UNSUPPORTED     | UNSUPPORTED  | UNSUPPORTED  |
      | true    | 124         | 2365         | 1137483697 | 8213372036854775897 | 503.00      | 25345.12000 | 4148.2900      | 7232337203.0000 | 55.6     | 2.4321412134324E7 | 2000-05-08 | 2000-05-08 12:35:29.123 | 2000-05-08 12:35:29.1234567 | 2000-05-08 00:20:29.1234567 | 2000-05-08 12:35:00.0 | 12:35:29 | TestChar3 | Testing Variable Char3 | UNSUPPORTED | Test Unicode char3 | Testing Unicode Variable Char3 | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED   | UNSUPPORTED | UNSUPPORTED    | UNSUPPORTED     | 08BDC137-E14D-4BCA-BBCF-823241E2654A | <ProductDescription ProductID="4"/> | UNSUPPORTED     | UNSUPPORTED  | UNSUPPORTED  |
      | true    | 20          | 2395         | 137483697  | 213372036854775897  | 465.57      | 23345.62000 | 4248.2900      | 8232337203.0000 | 54.6     | 5.4321412134324E7 | 1900-05-08 | 1900-05-08 12:35:29.123 | 1900-05-08 12:35:29.1234567 | 1900-05-08 00:20:29.1234567 | 1900-05-08 12:35:00.0 | 12:35:29 | TestChar4 | Testing Variable Char4 | UNSUPPORTED | Test Unicode char4 | Testing Unicode Variable Char4 | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED   | UNSUPPORTED | UNSUPPORTED    | UNSUPPORTED     | C513987D-9F5F-4DB6-989E-4859306F2C90 | <ProductDescription ProductID="5"/> | UNSUPPORTED     | UNSUPPORTED  | UNSUPPORTED  |
      | true    | 60          | 6395         | 637483697  | 613372036854775897  | 665.57      | 63345.62000 | 6248.2900      | 6232337203.0000 | 6754.6   | 6.4321412134324E7 | 1988-05-08 | 1988-05-08 12:35:29.123 | 1988-05-08 12:35:29.1234567 | 1988-05-08 00:20:29.1234567 | 1988-05-08 12:35:00.0 | 12:35:29 | TestChar6 | Testing Variable Char6 | UNSUPPORTED | Test Unicode char6 | Testing Unicode Variable Char6 | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED   | UNSUPPORTED | UNSUPPORTED    | UNSUPPORTED     | E288CC59-AD4A-4D93-8326-AC6153418D47 | <ProductDescription ProductID="5"/> | UNSUPPORTED     | UNSUPPORTED  | UNSUPPORTED  |
    And user enters the search text "SqlServerAnalyzerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "diffdatatypesanalyzerview" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | Bittype | Tinyinttype | Smallinttype | Inttype    | Biginttype          | Decimaltype | Numerictype | Smallmoneytype | Moneytype       | Realtype | Floattype         | Datetype   | Datetimetype            | Datetime2type               | Datetimeoffsettype          | Smalldatetimetype     | Timetype | Chartype  | Varchartype            | Texttype    | Nchartype          | Nvarchartype                   | Ntexttype   | Binarytype  | Varbinarytype | Imagetype   | Rowversiontype | Hierarchyidtype | Uniqueidentifiertype                 | Xmltype                             | Sql_varianttype | Geographtype | Geometrytype |
      | true    | 255         | 32767        | 2147483647 | 9223372036854775807 | 123.00      | 12345.12000 | 3148.2900      | 922337203.0000  | 5.6      | 1.2321412234324E7 | 2007-05-08 | 2007-05-08 12:35:29.123 | 2007-05-08 12:35:29.1234567 | 2007-05-08 00:20:29.1234567 | 2007-05-08 12:35:00.0 | 12:35:29 | TestChar  | Testing Variable Char  | UNSUPPORTED | Test Unicode char  | Testing Unicode Variable Char  | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED   | UNSUPPORTED | UNSUPPORTED    | UNSUPPORTED     | 61DF6F46-27AC-4787-A7C1-852B7CBCF362 | <ProductDescription ProductID="1"/> | UNSUPPORTED     | UNSUPPORTED  | UNSUPPORTED  |
      | true    | 115         | 2367         | 1137483647 | 8213372036854775807 | 303.00      | 20345.12000 | 3148.2900      | 6232337203.0000 | 51.6     | 2.2321412134324E7 | 2006-05-08 | 2006-05-08 12:35:29.123 | 2006-05-08 12:35:29.1234567 | 2006-05-08 00:20:29.1234567 | 2006-05-08 12:35:00.0 | 12:35:29 | TestChar2 | Testing Variable Char2 | UNSUPPORTED | Test Unicode char2 | Testing Unicode Variable Char2 | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED   | UNSUPPORTED | UNSUPPORTED    | UNSUPPORTED     | 734BBDBA-A376-4D9A-A123-ADEA09D417E3 | <ProductDescription ProductID="3"/> | UNSUPPORTED     | UNSUPPORTED  | UNSUPPORTED  |
      | true    | 124         | 2365         | 1137483697 | 8213372036854775897 | 503.00      | 25345.12000 | 4148.2900      | 7232337203.0000 | 55.6     | 2.4321412134324E7 | 2000-05-08 | 2000-05-08 12:35:29.123 | 2000-05-08 12:35:29.1234567 | 2000-05-08 00:20:29.1234567 | 2000-05-08 12:35:00.0 | 12:35:29 | TestChar3 | Testing Variable Char3 | UNSUPPORTED | Test Unicode char3 | Testing Unicode Variable Char3 | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED   | UNSUPPORTED | UNSUPPORTED    | UNSUPPORTED     | 08BDC137-E14D-4BCA-BBCF-823241E2654A | <ProductDescription ProductID="4"/> | UNSUPPORTED     | UNSUPPORTED  | UNSUPPORTED  |
      | true    | 20          | 2395         | 137483697  | 213372036854775897  | 465.57      | 23345.62000 | 4248.2900      | 8232337203.0000 | 54.6     | 5.4321412134324E7 | 1900-05-08 | 1900-05-08 12:35:29.123 | 1900-05-08 12:35:29.1234567 | 1900-05-08 00:20:29.1234567 | 1900-05-08 12:35:00.0 | 12:35:29 | TestChar4 | Testing Variable Char4 | UNSUPPORTED | Test Unicode char4 | Testing Unicode Variable Char4 | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED   | UNSUPPORTED | UNSUPPORTED    | UNSUPPORTED     | C513987D-9F5F-4DB6-989E-4859306F2C90 | <ProductDescription ProductID="5"/> | UNSUPPORTED     | UNSUPPORTED  | UNSUPPORTED  |
      | true    | 60          | 6395         | 637483697  | 613372036854775897  | 665.57      | 63345.62000 | 6248.2900      | 6232337203.0000 | 6754.6   | 6.4321412134324E7 | 1988-05-08 | 1988-05-08 12:35:29.123 | 1988-05-08 12:35:29.1234567 | 1988-05-08 00:20:29.1234567 | 1988-05-08 12:35:00.0 | 12:35:29 | TestChar6 | Testing Variable Char6 | UNSUPPORTED | Test Unicode char6 | Testing Unicode Variable Char6 | UNSUPPORTED | UNSUPPORTED | UNSUPPORTED   | UNSUPPORTED | UNSUPPORTED    | UNSUPPORTED     | E288CC59-AD4A-4D93-8326-AC6153418D47 | <ProductDescription ProductID="5"/> | UNSUPPORTED     | UNSUPPORTED  | UNSUPPORTED  |
    And user enters the search text "SqlServerAnalyzerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "productmaterialview" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | Product_id | Product_name | List_price | Brand_name  | Category_name |
      | 10         | name1        | 350.5      | brand name1 | cat name1     |
      | 20         | name2        | 450.5      | brand name2 | cat name2     |
      | 30         | name3        | 550.5      | brand name3 | cat name3     |

  @positve @regression @sanity @webtest
  Scenario:MLP-20943:SC#28_6_Verify data profiling works fine for different Numeric types without schema/table filters.(table/View)
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "smallinttype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | SMALLINT      | Description |
      | Length                        | 2             | Statistics  |
      | Average                       | 9257.80       | Statistics  |
      | Maximum value                 | 32767         | Statistics  |
      | Minimum value                 | 2365          | Statistics  |
      | Median                        | 2395          | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 13256.79      | Statistics  |
      | Variance                      | 175742487.20  | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "tinyinttype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TINYINT       | Description |
      | Length                        | 1             | Statistics  |
      | Average                       | 114.80        | Statistics  |
      | Maximum value                 | 255           | Statistics  |
      | Minimum value                 | 20            | Statistics  |
      | Median                        | 115           | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 89.07         | Statistics  |
      | Variance                      | 7932.70       | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "inttype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue      | widgetName  |
      | Data type                     | INT                | Description |
      | Length                        | 4                  | Statistics  |
      | Average                       | 1039483677         | Statistics  |
      | Maximum value                 | 2147483647         | Statistics  |
      | Minimum value                 | 137483697          | Statistics  |
      | Median                        | 1137483647         | Statistics  |
      | Number of non null values     | 5                  | Statistics  |
      | Percentage of non null values | 100                | Statistics  |
      | Number of null values         | 0                  | Statistics  |
      | Number of unique values       | 5                  | Statistics  |
      | Percentage of unique values   | 100                | Statistics  |
      | Standard deviation            | 745332120.50       | Statistics  |
      | Variance                      | 555519969850000640 | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "biginttype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue          | widgetName  |
      | Data type                     | BIGINT                 | Description |
      | Length                        | 8                      | Statistics  |
      | Average                       | 5295372036854776000    | Statistics  |
      | Maximum value                 | 9223372036854775807    | Statistics  |
      | Minimum value                 | 213372036854775897     | Statistics  |
      | Median                        | 8213372036854776000    | Statistics  |
      | Number of non null values     | 5                      | Statistics  |
      | Percentage of non null values | 100                    | Statistics  |
      | Number of null values         | 0                      | Statistics  |
      | Number of unique values       | 5                      | Statistics  |
      | Percentage of unique values   | 100                    | Statistics  |
      | Standard deviation            | 4477903527321686000    | Statistics  |
      | Variance                      | 2.0051619999999998e+37 | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "decimaltype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Length                        | 5             | Statistics  |
      | Average                       | 412.03        | Statistics  |
      | Maximum value                 | 665.57        | Statistics  |
      | Minimum value                 | 123.00        | Statistics  |
      | Median                        | 465.57        | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 206.67        | Statistics  |
      | Variance                      | 42712.62      | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "floattype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue      | widgetName  |
      | Data type                     | FLOAT              | Description |
      | Length                        | 8                  | Statistics  |
      | Average                       | 35521412.15        | Statistics  |
      | Maximum value                 | 6.4321412134324E7  | Statistics  |
      | Minimum value                 | 1.2321412234324E7  | Statistics  |
      | Median                        | 24321412.13        | Statistics  |
      | Number of non null values     | 5                  | Statistics  |
      | Percentage of non null values | 100                | Statistics  |
      | Number of null values         | 0                  | Statistics  |
      | Number of unique values       | 5                  | Statistics  |
      | Percentage of unique values   | 100                | Statistics  |
      | Standard deviation            | 22476654.53        | Statistics  |
      | Variance                      | 505199998840000.50 | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "realtype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | REAL          | Description |
      | Length                        | 4             | Statistics  |
      | Average                       | 1384.40       | Statistics  |
      | Maximum value                 | 6754.6        | Statistics  |
      | Minimum value                 | 5.6           | Statistics  |
      | Median                        | 54.60         | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 3002.11       | Statistics  |
      | Variance                      | 9012642.97    | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "smallinttype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | SMALLINT      | Description |
      | Length                        | 2             | Statistics  |
      | Average                       | 9257.80       | Statistics  |
      | Maximum value                 | 32767         | Statistics  |
      | Minimum value                 | 2365          | Statistics  |
      | Median                        | 2395          | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 13256.79      | Statistics  |
      | Variance                      | 175742487.20  | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "tinyinttype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TINYINT       | Description |
      | Length                        | 1             | Statistics  |
      | Average                       | 114.80        | Statistics  |
      | Maximum value                 | 255           | Statistics  |
      | Minimum value                 | 20            | Statistics  |
      | Median                        | 115           | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 89.07         | Statistics  |
      | Variance                      | 7932.70       | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "inttype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue      | widgetName  |
      | Data type                     | INT                | Description |
      | Length                        | 4                  | Statistics  |
      | Average                       | 1039483677         | Statistics  |
      | Maximum value                 | 2147483647         | Statistics  |
      | Minimum value                 | 137483697          | Statistics  |
      | Median                        | 1137483647         | Statistics  |
      | Number of non null values     | 5                  | Statistics  |
      | Percentage of non null values | 100                | Statistics  |
      | Number of null values         | 0                  | Statistics  |
      | Number of unique values       | 5                  | Statistics  |
      | Percentage of unique values   | 100                | Statistics  |
      | Standard deviation            | 745332120.50       | Statistics  |
      | Variance                      | 555519969850000640 | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "biginttype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue          | widgetName  |
      | Data type                     | BIGINT                 | Description |
      | Length                        | 8                      | Statistics  |
      | Average                       | 5295372036854776000    | Statistics  |
      | Maximum value                 | 9223372036854775807    | Statistics  |
      | Minimum value                 | 213372036854775897     | Statistics  |
      | Median                        | 8213372036854776000    | Statistics  |
      | Number of non null values     | 5                      | Statistics  |
      | Percentage of non null values | 100                    | Statistics  |
      | Number of null values         | 0                      | Statistics  |
      | Number of unique values       | 5                      | Statistics  |
      | Percentage of unique values   | 100                    | Statistics  |
      | Standard deviation            | 4477903527321686000    | Statistics  |
      | Variance                      | 2.0051619999999998e+37 | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "decimaltype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Length                        | 5             | Statistics  |
      | Average                       | 412.03        | Statistics  |
      | Maximum value                 | 665.57        | Statistics  |
      | Minimum value                 | 123.00        | Statistics  |
      | Median                        | 465.57        | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 206.67        | Statistics  |
      | Variance                      | 42712.62      | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "floattype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue      | widgetName  |
      | Data type                     | FLOAT              | Description |
      | Length                        | 8                  | Statistics  |
      | Average                       | 35521412.15        | Statistics  |
      | Maximum value                 | 6.4321412134324E7  | Statistics  |
      | Minimum value                 | 1.2321412234324E7  | Statistics  |
      | Median                        | 24321412.13        | Statistics  |
      | Number of non null values     | 5                  | Statistics  |
      | Percentage of non null values | 100                | Statistics  |
      | Number of null values         | 0                  | Statistics  |
      | Number of unique values       | 5                  | Statistics  |
      | Percentage of unique values   | 100                | Statistics  |
      | Standard deviation            | 22476654.53        | Statistics  |
      | Variance                      | 505199998840000.50 | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "realtype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | REAL          | Description |
      | Length                        | 4             | Statistics  |
      | Average                       | 1384.40       | Statistics  |
      | Maximum value                 | 6754.6        | Statistics  |
      | Minimum value                 | 5.6           | Statistics  |
      | Median                        | 54.60         | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 3002.11       | Statistics  |
      | Variance                      | 9012642.97    | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page

  @positve @regression @sanity @webtest
  Scenario:MLP-20943:SC#28_7_Verify data profiling works fine for different string types without schema/table filters.(table/View)
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "chartype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | CHAR          | Description |
      | Length                        | 20            | Statistics  |
      | Maximum length                | 9             | Statistics  |
      | Minimum length                | 8             | Statistics  |
      | Maximum value                 | TestChar6     | Statistics  |
      | Minimum value                 | TestChar      | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "varchartype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue          | widgetName  |
      | Data type                     | VARCHAR                | Description |
      | Length                        | 1200                   | Statistics  |
      | Maximum length                | 22                     | Statistics  |
      | Minimum length                | 21                     | Statistics  |
      | Maximum value                 | Testing Variable Char6 | Statistics  |
      | Minimum value                 | Testing Variable Char  | Statistics  |
      | Number of non null values     | 5                      | Statistics  |
      | Percentage of non null values | 100                    | Statistics  |
      | Number of null values         | 0                      | Statistics  |
      | Number of unique values       | 5                      | Statistics  |
      | Percentage of unique values   | 100                    | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "nchartype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue      | widgetName  |
      | Data type                     | NCHAR              | Description |
      | Length                        | 100                | Statistics  |
      | Maximum length                | 18                 | Statistics  |
      | Minimum length                | 17                 | Statistics  |
      | Maximum value                 | Test Unicode char6 | Statistics  |
      | Minimum value                 | Test Unicode char  | Statistics  |
      | Number of non null values     | 5                  | Statistics  |
      | Percentage of non null values | 100                | Statistics  |
      | Number of null values         | 0                  | Statistics  |
      | Number of unique values       | 5                  | Statistics  |
      | Percentage of unique values   | 100                | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "nvarchartype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                  | widgetName  |
      | Data type                     | NVARCHAR                       | Description |
      | Length                        | 1200                           | Statistics  |
      | Maximum length                | 30                             | Statistics  |
      | Minimum length                | 29                             | Statistics  |
      | Maximum value                 | Testing Unicode Variable Char6 | Statistics  |
      | Minimum value                 | Testing Unicode Variable Char  | Statistics  |
      | Number of non null values     | 5                              | Statistics  |
      | Percentage of non null values | 100                            | Statistics  |
      | Number of null values         | 0                              | Statistics  |
      | Number of unique values       | 5                              | Statistics  |
      | Percentage of unique values   | 100                            | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "chartype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | CHAR          | Description |
      | Length                        | 20            | Statistics  |
      | Maximum length                | 9             | Statistics  |
      | Minimum length                | 8             | Statistics  |
      | Maximum value                 | TestChar6     | Statistics  |
      | Minimum value                 | TestChar      | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "varchartype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue          | widgetName  |
      | Data type                     | VARCHAR                | Description |
      | Length                        | 1200                   | Statistics  |
      | Maximum length                | 22                     | Statistics  |
      | Minimum length                | 21                     | Statistics  |
      | Maximum value                 | Testing Variable Char6 | Statistics  |
      | Minimum value                 | Testing Variable Char  | Statistics  |
      | Number of non null values     | 5                      | Statistics  |
      | Percentage of non null values | 100                    | Statistics  |
      | Number of null values         | 0                      | Statistics  |
      | Number of unique values       | 5                      | Statistics  |
      | Percentage of unique values   | 100                    | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "nchartype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue      | widgetName  |
      | Data type                     | NCHAR              | Description |
      | Length                        | 100                | Statistics  |
      | Maximum length                | 18                 | Statistics  |
      | Minimum length                | 17                 | Statistics  |
      | Maximum value                 | Test Unicode char6 | Statistics  |
      | Minimum value                 | Test Unicode char  | Statistics  |
      | Number of non null values     | 5                  | Statistics  |
      | Percentage of non null values | 100                | Statistics  |
      | Number of null values         | 0                  | Statistics  |
      | Number of unique values       | 5                  | Statistics  |
      | Percentage of unique values   | 100                | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "nvarchartype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                  | widgetName  |
      | Data type                     | NVARCHAR                       | Description |
      | Length                        | 1200                           | Statistics  |
      | Maximum length                | 30                             | Statistics  |
      | Minimum length                | 29                             | Statistics  |
      | Maximum value                 | Testing Unicode Variable Char6 | Statistics  |
      | Minimum value                 | Testing Unicode Variable Char  | Statistics  |
      | Number of non null values     | 5                              | Statistics  |
      | Percentage of non null values | 100                            | Statistics  |
      | Number of null values         | 0                              | Statistics  |
      | Number of unique values       | 5                              | Statistics  |
      | Percentage of unique values   | 100                            | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page

  @positve @regression @sanity @webtest
  Scenario:MLP-20943:SC#28_8_Verify data profiling works fine for different date/time/timestamp types without schema/table filters.(table/View)
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "datetype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DATE          | Description |
      | Length                        | 3             | Statistics  |
      | Maximum value                 | 2007-05-08    | Statistics  |
      | Minimum value                 | 1900-05-08    | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "timetype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue    | widgetName  |
      | Data type                     | TIME             | Description |
      | Length                        | 5                | Statistics  |
      | Maximum value                 | 12:35:29.1234567 | Statistics  |
      | Minimum value                 | 12:35:29.1234567 | Statistics  |
      | Number of non null values     | 5                | Statistics  |
      | Percentage of non null values | 100              | Statistics  |
      | Number of null values         | 0                | Statistics  |
      | Number of unique values       | 1                | Statistics  |
      | Percentage of unique values   | 20               | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "datetimetype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP               | Description |
      | Length                        | 8                       | Statistics  |
      | Maximum value                 | 2007-05-08 12:35:29.123 | Statistics  |
      | Minimum value                 | 1900-05-08 12:35:29.123 | Statistics  |
      | Number of non null values     | 5                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 5                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "datetime2type" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue               | widgetName  |
      | Data type                     | TIMESTAMP                   | Description |
      | Length                        | 8                           | Statistics  |
      | Maximum value                 | 2007-05-08 12:35:29.1234567 | Statistics  |
      | Minimum value                 | 1900-05-08 12:35:29.1234567 | Statistics  |
      | Number of non null values     | 5                           | Statistics  |
      | Percentage of non null values | 100                         | Statistics  |
      | Number of null values         | 0                           | Statistics  |
      | Number of unique values       | 5                           | Statistics  |
      | Percentage of unique values   | 100                         | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "datetime2type" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue               | widgetName  |
      | Data type                     | TIMESTAMP                   | Description |
      | Length                        | 8                           | Statistics  |
      | Maximum value                 | 2007-05-08 12:35:29.1234567 | Statistics  |
      | Minimum value                 | 1900-05-08 12:35:29.1234567 | Statistics  |
      | Number of non null values     | 5                           | Statistics  |
      | Percentage of non null values | 100                         | Statistics  |
      | Number of null values         | 0                           | Statistics  |
      | Number of unique values       | 5                           | Statistics  |
      | Percentage of unique values   | 100                         | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "datetimeoffsettype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                      | widgetName  |
      | Data type                     | TIMESTAMP                          | Description |
      | Length                        | 10                                 | Statistics  |
      | Maximum value                 | 2007-05-08 12:35:29.1234567 +12:15 | Statistics  |
      | Minimum value                 | 1900-05-08 12:35:29.1234567 +12:15 | Statistics  |
      | Number of non null values     | 5                                  | Statistics  |
      | Percentage of non null values | 100                                | Statistics  |
      | Number of null values         | 0                                  | Statistics  |
      | Number of unique values       | 5                                  | Statistics  |
      | Percentage of unique values   | 100                                | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "datetimeoffsettype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                      | widgetName  |
      | Data type                     | TIMESTAMP                          | Description |
      | Length                        | 10                                 | Statistics  |
      | Maximum value                 | 2007-05-08 12:35:29.1234567 +12:15 | Statistics  |
      | Minimum value                 | 1900-05-08 12:35:29.1234567 +12:15 | Statistics  |
      | Number of non null values     | 5                                  | Statistics  |
      | Percentage of non null values | 100                                | Statistics  |
      | Number of null values         | 0                                  | Statistics  |
      | Number of unique values       | 5                                  | Statistics  |
      | Percentage of unique values   | 100                                | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "smalldatetimetype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue         | widgetName  |
      | Data type                     | TIMESTAMP             | Description |
      | Length                        | 4                     | Statistics  |
      | Maximum value                 | 2007-05-08 12:35:00.0 | Statistics  |
      | Minimum value                 | 1900-05-08 12:35:00.0 | Statistics  |
      | Number of non null values     | 5                     | Statistics  |
      | Percentage of non null values | 100                   | Statistics  |
      | Number of null values         | 0                     | Statistics  |
      | Number of unique values       | 5                     | Statistics  |
      | Percentage of unique values   | 100                   | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "datetype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DATE          | Description |
      | Length                        | 3             | Statistics  |
      | Maximum value                 | 2007-05-08    | Statistics  |
      | Minimum value                 | 1900-05-08    | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "timetype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue    | widgetName  |
      | Data type                     | TIME             | Description |
      | Length                        | 5                | Statistics  |
      | Maximum value                 | 12:35:29.1234567 | Statistics  |
      | Minimum value                 | 12:35:29.1234567 | Statistics  |
      | Number of non null values     | 5                | Statistics  |
      | Percentage of non null values | 100              | Statistics  |
      | Number of null values         | 0                | Statistics  |
      | Number of unique values       | 1                | Statistics  |
      | Percentage of unique values   | 20               | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "datetimetype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP               | Description |
      | Length                        | 8                       | Statistics  |
      | Maximum value                 | 2007-05-08 12:35:29.123 | Statistics  |
      | Minimum value                 | 1900-05-08 12:35:29.123 | Statistics  |
      | Number of non null values     | 5                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 5                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "datetime2type" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue               | widgetName  |
      | Data type                     | TIMESTAMP                   | Description |
      | Length                        | 8                           | Statistics  |
      | Maximum value                 | 2007-05-08 12:35:29.1234567 | Statistics  |
      | Minimum value                 | 1900-05-08 12:35:29.1234567 | Statistics  |
      | Number of non null values     | 5                           | Statistics  |
      | Percentage of non null values | 100                         | Statistics  |
      | Number of null values         | 0                           | Statistics  |
      | Number of unique values       | 5                           | Statistics  |
      | Percentage of unique values   | 100                         | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "datetime2type" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue               | widgetName  |
      | Data type                     | TIMESTAMP                   | Description |
      | Length                        | 8                           | Statistics  |
      | Maximum value                 | 2007-05-08 12:35:29.1234567 | Statistics  |
      | Minimum value                 | 1900-05-08 12:35:29.1234567 | Statistics  |
      | Number of non null values     | 5                           | Statistics  |
      | Percentage of non null values | 100                         | Statistics  |
      | Number of null values         | 0                           | Statistics  |
      | Number of unique values       | 5                           | Statistics  |
      | Percentage of unique values   | 100                         | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "datetimeoffsettype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                      | widgetName  |
      | Data type                     | TIMESTAMP                          | Description |
      | Length                        | 10                                 | Statistics  |
      | Maximum value                 | 2007-05-08 12:35:29.1234567 +12:15 | Statistics  |
      | Minimum value                 | 1900-05-08 12:35:29.1234567 +12:15 | Statistics  |
      | Number of non null values     | 5                                  | Statistics  |
      | Percentage of non null values | 100                                | Statistics  |
      | Number of null values         | 0                                  | Statistics  |
      | Number of unique values       | 5                                  | Statistics  |
      | Percentage of unique values   | 100                                | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "datetimeoffsettype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                      | widgetName  |
      | Data type                     | TIMESTAMP                          | Description |
      | Length                        | 10                                 | Statistics  |
      | Maximum value                 | 2007-05-08 12:35:29.1234567 +12:15 | Statistics  |
      | Minimum value                 | 1900-05-08 12:35:29.1234567 +12:15 | Statistics  |
      | Number of non null values     | 5                                  | Statistics  |
      | Percentage of non null values | 100                                | Statistics  |
      | Number of null values         | 0                                  | Statistics  |
      | Number of unique values       | 5                                  | Statistics  |
      | Percentage of unique values   | 100                                | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "smalldatetimetype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue         | widgetName  |
      | Data type                     | TIMESTAMP             | Description |
      | Length                        | 4                     | Statistics  |
      | Maximum value                 | 2007-05-08 12:35:00.0 | Statistics  |
      | Minimum value                 | 1900-05-08 12:35:00.0 | Statistics  |
      | Number of non null values     | 5                     | Statistics  |
      | Percentage of non null values | 100                   | Statistics  |
      | Number of null values         | 0                     | Statistics  |
      | Number of unique values       | 5                     | Statistics  |
      | Percentage of unique values   | 100                   | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget non presence" on "Data Distribution" in Item view page

  @positve @regression @sanity
  Scenario:MLP-20943:SC#28_9_Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/%                   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SQLServerDBAnalyzer/%                 | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |

    #6822675
  Scenario Outline:MLP-20943:SC#29_1_Run the Plugin configurations for DataSource and SqlServerDBCataloger/SqlServerDBAnalyzer with Schema/table/View filter.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | body                                                                                            | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                  |                                                                                                 | 200           | SqlServerCataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                                 | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger   | ida/SqlServerPayloads/empty.json                                                                | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                                 | 200           | RUNNING            | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                                 | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBAnalyzer                                                   | ida/SqlServerPayloads/PluginConfiguration/SqlServerAnalyzerConfigWithSchemaTableViewFilter.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBAnalyzer                                                   |                                                                                                 | 200           | SqlServerAnalyzer  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                                 | 200           | IDLE               | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer  | ida/SqlServerPayloads/empty.json                                                                | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                                 | 200           | RUNNING            | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                                 | 200           | IDLE               | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |

  @MLP-20943 @positve @regression @sanity
  Scenario Outline:MLP-20943:SC#29_2_User get the Dynamic ID's (Table ID) for the Table name "DiffDataTypesAnalyzer"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                              | asg_scopeid | targetFile                                    | jsonpath                                      |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | testdatabase,testschema,diffdatatypesanalyzer     |             | payloads/ida/sqlServerPayloads/API/items.json | $.Tables.testschema.diffdatatypesanalyzer     |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | testdatabase,testschema,diffdatatypesanalyzerview |             | payloads/ida/sqlServerPayloads/API/items.json | $.Tables.testschema.diffdatatypesanalyzerview |

  @MLP-20943 @positve @regression @sanity
  Scenario Outline:MLP-20943:SC#29_3_User hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                                     | inputFile                                     | outPutFile                                                                          | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.testschema.diffdatatypesanalyzer     | payloads/ida/sqlServerPayloads/API/items.json | payloads\ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZER.json     |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.testschema.diffdatatypesanalyzerview | payloads/ida/sqlServerPayloads/API/items.json | payloads\ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZERVIEW.json |            |

    #7195075##
  @MLP-20943 @positve @regression @sanity
  Scenario:MLP-20943:SC#29_4_Verify data sampling works fine for String, Numeric, Date, Time, and Timestamp, Complex Types without schema/table filters - Table and View
    Then file content in "ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZER.json" should be same as the content in "ida\sqlServerPayloads\API\Expected\TESTSCHEMA_DIFFDATATYPESANALYZER.json"
    Then file content in "ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZERVIEW.json" should be same as the content in "ida\sqlServerPayloads\API\Expected\TESTSCHEMA_DIFFDATATYPESANALYZERVIEW.json"

  @positve @regression @sanity
  Scenario:MLP-20943:SC#29_5_Verify data profiling works fine for different data types with schema/table/view filters.(SqlServerAnalyzer filter)
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                        | jsonPath                                                             | Action                    | query                 | ClusterName                                        | ServiceName    | DatabaseName | SchemaName | TableName/Filename        | columnName/FieldName |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.bittype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | bittype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.tinyinttype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.tinyinttype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.tinyinttype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallinttype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallinttype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallinttype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.inttype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.inttype.Statistics                   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.inttype.Lifecycle                    | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.biginttype.Description               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.biginttype.Statistics                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.biginttype.Lifecycle                 | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.decimaltype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.decimaltype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.decimaltype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.numerictype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.numerictype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.numerictype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallmoneytype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallmoneytype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.moneytype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | moneytype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.realtype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.realtype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.realtype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.floattype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.floattype.Statistics                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.floattype.Lifecycle                  | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimetype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimetype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimetype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetime2type.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetime2type.Statistics             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetime2type.Lifecycle              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimeoffsettype.Description       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimeoffsettype.Statistics        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimeoffsettype.Lifecycle         | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smalldatetimetype.Description        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smalldatetimetype.Statistics         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smalldatetimetype.Lifecycle          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.timetype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.timetype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.timetype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varchartype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varchartype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varchartype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nchartype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nchartype.Statistics                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nchartype.Lifecycle                  | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nvarchartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nvarchartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nvarchartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.ntexttype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | ntexttype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.binarytype.Description               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | binarytype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varbinarytype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varbinarytype        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.imagetype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | imagetype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.rowversiontype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | rowversiontype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.hierarchyidtype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | hierarchyidtype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.uniqueidentifiertype.Description     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | uniqueidentifiertype |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.xmltype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | xmltype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.sql_varianttype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | sql_varianttype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.geographtype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | geographtype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.geometrytype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | geometrytype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.bittype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | bittype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.tinyinttype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.tinyinttype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.tinyinttype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallinttype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallinttype.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallinttype.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.inttype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.inttype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.inttype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.biginttype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.biginttype.Statistics            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.biginttype.Lifecycle             | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.decimaltype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.decimaltype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.decimaltype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.numerictype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.numerictype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.numerictype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallmoneytype.Description       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallmoneytype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.moneytype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | moneytype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.realtype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.realtype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.realtype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.floattype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.floattype.Statistics             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.floattype.Lifecycle              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimetype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimetype.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimetype.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetime2type.Description        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetime2type.Statistics         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetime2type.Lifecycle          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimeoffsettype.Description   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimeoffsettype.Statistics    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimeoffsettype.Lifecycle     | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smalldatetimetype.Description    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smalldatetimetype.Statistics     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smalldatetimetype.Lifecycle      | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.timetype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.timetype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.timetype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varchartype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varchartype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varchartype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nchartype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nchartype.Statistics             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nchartype.Lifecycle              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nvarchartype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nvarchartype.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nvarchartype.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.ntexttype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | ntexttype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.binarytype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | binarytype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varbinarytype.Description        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varbinarytype        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.imagetype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | imagetype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.rowversiontype.Description       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | rowversiontype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.hierarchyidtype.Description      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | hierarchyidtype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.uniqueidentifiertype.Description | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | uniqueidentifiertype |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.xmltype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | xmltype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.sql_varianttype.Description      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | sql_varianttype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.geographtype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | geographtype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.geometrytype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | geometrytype         |

  @positve @regression @sanity
  Scenario:MLP-20943:SC#29_6_Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/%                   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SQLServerDBAnalyzer/%                 | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |

      #6822675
  Scenario Outline:MLP-20943:SC#30_1_Run the Plugin configurations for DataSource and SqlServerDBCataloger/SqlServerAnalyzer with multiple schema/table/view filters.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | body                                                                                                    | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                  | ida/SqlServerPayloads/PluginConfiguration/SqlServerConfigWithOnlySchemaFilterForAnalyzer.json           | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                  |                                                                                                         | 200           | SqlServerCataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                                         | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger   | ida/SqlServerPayloads/empty.json                                                                        | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                                         | 200           | RUNNING            | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                                         | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBAnalyzer                                                   | ida/SqlServerPayloads/PluginConfiguration/SqlServerAnalyzerConfigWithMultipleSchemaTableViewFilter.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBAnalyzer                                                   |                                                                                                         | 200           | SqlServerAnalyzer  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                                         | 200           | IDLE               | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer  | ida/SqlServerPayloads/empty.json                                                                        | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                                         | 200           | RUNNING            | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                                         | 200           | IDLE               | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |

  @MLP-20943 @positve @regression @sanity
  Scenario Outline:MLP-20943:SC#30_2_User get the Dynamic ID's (Table ID) for the Table name "DiffDataTypesAnalyzer"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                    | asg_scopeid | targetFile                                    | jsonpath                                            |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | testdatabase,testschema,diffdatatypesanalyzer           |             | payloads/ida/sqlServerPayloads/API/items.json | $.Tables.testschema.diffdatatypesanalyzer           |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | testdatabase,testschema,diffdatatypesanalyzerview       |             | payloads/ida/sqlServerPayloads/API/items.json | $.Tables.testschema.diffdatatypesanalyzerview       |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | testdatabase,sqlserverlineage,diffdatatypesanalyzer     |             | payloads/ida/sqlServerPayloads/API/items.json | $.Tables.sqlserverlineage.diffdatatypesanalyzer     |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | testdatabase,sqlserverlineage,diffdatatypesanalyzerview |             | payloads/ida/sqlServerPayloads/API/items.json | $.Tables.sqlserverlineage.diffdatatypesanalyzerview |

  @MLP-20943 @positve @regression @sanity
  Scenario Outline:MLP-20943:SC#30_3_User hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                                           | inputFile                                     | outPutFile                                                                                | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.testschema.diffdatatypesanalyzer           | payloads/ida/sqlServerPayloads/API/items.json | payloads\ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZER.json           |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.testschema.diffdatatypesanalyzerview       | payloads/ida/sqlServerPayloads/API/items.json | payloads\ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZERVIEW.json       |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.sqlserverlineage.diffdatatypesanalyzer     | payloads/ida/sqlServerPayloads/API/items.json | payloads\ida\sqlServerPayloads\API\Actual\SQLSERVERLINEAGE_DIFFDATATYPESANALYZER.json     |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.sqlserverlineage.diffdatatypesanalyzerview | payloads/ida/sqlServerPayloads/API/items.json | payloads\ida\sqlServerPayloads\API\Actual\SQLSERVERLINEAGE_DIFFDATATYPESANALYZERVIEW.json |            |

    #7195075##
  @MLP-20943 @positve @regression @sanity
  Scenario:MLP-20943:SC#30_4_Verify the data sampling works fine for string,numeric,date,time,timestamp,complex types(table/view/materialized) if SqlServerDBAnalyzer is run successfully with multiple schema/table/view filters.
    Then file content in "ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZER.json" should be same as the content in "ida\sqlServerPayloads\API\Expected\TESTSCHEMA_DIFFDATATYPESANALYZER.json"
    Then file content in "ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZERVIEW.json" should be same as the content in "ida\sqlServerPayloads\API\Expected\TESTSCHEMA_DIFFDATATYPESANALYZERVIEW.json"
    Then file content in "ida\sqlServerPayloads\API\Actual\SQLSERVERLINEAGE_DIFFDATATYPESANALYZER.json" should be same as the content in "ida\sqlServerPayloads\API\Expected\SQLSERVERLINEAGE_DIFFDATATYPESANALYZER.json"
    Then file content in "ida\sqlServerPayloads\API\Actual\SQLSERVERLINEAGE_DIFFDATATYPESANALYZERVIEW.json" should be same as the content in "ida\sqlServerPayloads\API\Expected\SQLSERVERLINEAGE_DIFFDATATYPESANALYZERVIEW.json"

  @positve @regression @sanity
  Scenario:MLP-20943:SC#30_5_Verify data profiling works fine with multiple schema/table/view filters.(table/View)
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                        | jsonPath                                                                        | Action                    | query                 | ClusterName                                        | ServiceName    | DatabaseName | SchemaName | TableName/Filename        | columnName/FieldName |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.bittype.Description                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | bittype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.tinyinttype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.tinyinttype.Statistics                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.tinyinttype.Lifecycle                           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallinttype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallinttype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallinttype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.inttype.Description                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.inttype.Statistics                              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.inttype.Lifecycle                               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.biginttype.Description                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.biginttype.Statistics                           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.biginttype.Lifecycle                            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.decimaltype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.decimaltype.Statistics                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.decimaltype.Lifecycle                           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.numerictype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.numerictype.Statistics                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.numerictype.Lifecycle                           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallmoneytype.Description                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallmoneytype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.moneytype.Description                           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | moneytype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.realtype.Description                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.realtype.Statistics                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.realtype.Lifecycle                              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.floattype.Description                           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.floattype.Statistics                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.floattype.Lifecycle                             | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetype.Description                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetype.Statistics                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetype.Lifecycle                              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimetype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimetype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimetype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetime2type.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetime2type.Statistics                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetime2type.Lifecycle                         | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimeoffsettype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimeoffsettype.Statistics                   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimeoffsettype.Lifecycle                    | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smalldatetimetype.Description                   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smalldatetimetype.Statistics                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smalldatetimetype.Lifecycle                     | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.timetype.Description                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.timetype.Statistics                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.timetype.Lifecycle                              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Description                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Statistics                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Lifecycle                              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varchartype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varchartype.Statistics                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varchartype.Lifecycle                           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Description                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Statistics                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Lifecycle                              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nchartype.Description                           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nchartype.Statistics                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nchartype.Lifecycle                             | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Description                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Statistics                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Lifecycle                              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nvarchartype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nvarchartype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nvarchartype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.ntexttype.Description                           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | ntexttype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.binarytype.Description                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | binarytype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varbinarytype.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varbinarytype        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.imagetype.Description                           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | imagetype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.rowversiontype.Description                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | rowversiontype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.hierarchyidtype.Description                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | hierarchyidtype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.uniqueidentifiertype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | uniqueidentifiertype |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.xmltype.Description                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | xmltype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.sql_varianttype.Description                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | sql_varianttype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.geographtype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | geographtype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.geometrytype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | geometrytype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.bittype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | bittype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.tinyinttype.Description                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.tinyinttype.Statistics                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.tinyinttype.Lifecycle                       | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallinttype.Description                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallinttype.Statistics                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallinttype.Lifecycle                      | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.inttype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.inttype.Statistics                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.inttype.Lifecycle                           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.biginttype.Description                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.biginttype.Statistics                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.biginttype.Lifecycle                        | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.decimaltype.Description                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.decimaltype.Statistics                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.decimaltype.Lifecycle                       | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.numerictype.Description                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.numerictype.Statistics                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.numerictype.Lifecycle                       | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallmoneytype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallmoneytype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.moneytype.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | moneytype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.realtype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.realtype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.realtype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.floattype.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.floattype.Statistics                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.floattype.Lifecycle                         | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimetype.Description                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimetype.Statistics                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimetype.Lifecycle                      | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetime2type.Description                   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetime2type.Statistics                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetime2type.Lifecycle                     | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimeoffsettype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimeoffsettype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimeoffsettype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smalldatetimetype.Description               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smalldatetimetype.Statistics                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smalldatetimetype.Lifecycle                 | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.timetype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.timetype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.timetype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varchartype.Description                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varchartype.Statistics                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varchartype.Lifecycle                       | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nchartype.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nchartype.Statistics                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nchartype.Lifecycle                         | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nvarchartype.Description                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nvarchartype.Statistics                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nvarchartype.Lifecycle                      | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.ntexttype.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | ntexttype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.binarytype.Description                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | binarytype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varbinarytype.Description                   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varbinarytype        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.imagetype.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | imagetype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.rowversiontype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | rowversiontype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.hierarchyidtype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | hierarchyidtype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.uniqueidentifiertype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | uniqueidentifiertype |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.xmltype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | xmltype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.sql_varianttype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | sql_varianttype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.geographtype.Description                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | geographtype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.geometrytype.Description                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | geometrytype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.bittype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | bittype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.tinyinttype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.tinyinttype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.tinyinttype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smallinttype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smallinttype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smallinttype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.inttype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.inttype.Statistics                   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.inttype.Lifecycle                    | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.biginttype.Description               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.biginttype.Statistics                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.biginttype.Lifecycle                 | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.decimaltype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.decimaltype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.decimaltype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.numerictype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.numerictype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.numerictype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smallmoneytype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallmoneytype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.moneytype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | moneytype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.realtype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.realtype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.realtype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.floattype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.floattype.Statistics                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.floattype.Lifecycle                  | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetimetype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetimetype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetimetype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetime2type.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetime2type.Statistics             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetime2type.Lifecycle              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetimeoffsettype.Description       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetimeoffsettype.Statistics        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetimeoffsettype.Lifecycle         | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smalldatetimetype.Description        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smalldatetimetype.Statistics         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smalldatetimetype.Lifecycle          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.timetype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.timetype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.timetype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.varchartype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.varchartype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.varchartype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.nchartype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.nchartype.Statistics                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.nchartype.Lifecycle                  | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.nvarchartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.nvarchartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.nvarchartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.ntexttype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | ntexttype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.binarytype.Description               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | binarytype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.varbinarytype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varbinarytype        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.imagetype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | imagetype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.rowversiontype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | rowversiontype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.hierarchyidtype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | hierarchyidtype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.uniqueidentifiertype.Description     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | uniqueidentifiertype |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.xmltype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | xmltype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.sql_varianttype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | sql_varianttype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.geographtype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | geographtype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.geometrytype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | geometrytype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.bittype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | bittype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.tinyinttype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.tinyinttype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.tinyinttype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smallinttype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smallinttype.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smallinttype.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.inttype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.inttype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.inttype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.biginttype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.biginttype.Statistics            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.biginttype.Lifecycle             | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.decimaltype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.decimaltype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.decimaltype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.numerictype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.numerictype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.numerictype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smallmoneytype.Description       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallmoneytype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.moneytype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | moneytype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.realtype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.realtype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.realtype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.floattype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.floattype.Statistics             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.floattype.Lifecycle              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetimetype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetimetype.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetimetype.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetime2type.Description        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetime2type.Statistics         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetime2type.Lifecycle          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetimeoffsettype.Description   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetimeoffsettype.Statistics    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetimeoffsettype.Lifecycle     | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smalldatetimetype.Description    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smalldatetimetype.Statistics     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smalldatetimetype.Lifecycle      | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.timetype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.timetype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.timetype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.varchartype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.varchartype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.varchartype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.nchartype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.nchartype.Statistics             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.nchartype.Lifecycle              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.nvarchartype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.nvarchartype.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.nvarchartype.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.ntexttype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | ntexttype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.binarytype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | binarytype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.varbinarytype.Description        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varbinarytype        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.imagetype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | imagetype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.rowversiontype.Description       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | rowversiontype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.hierarchyidtype.Description      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | hierarchyidtype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.uniqueidentifiertype.Description | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | uniqueidentifiertype |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.xmltype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | xmltype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.sql_varianttype.Description      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | sql_varianttype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.geographtype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | geographtype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.geometrytype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | geometrytype         |

  @positve @regression @sanity
  Scenario:MLP-20943:SC#30_6_Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/%                   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SQLServerDBAnalyzer/%                 | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |

    #6822675
  Scenario Outline::MLP-20943:SC#31_1_Run the Plugin configurations for DataSource and SqlServerDBCataloger/SqlServerAnalyzer with multiple duplicate schem/table/view filters.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | body                                                                                                             | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                  | ida/SqlServerPayloads/PluginConfiguration/SqlServerConfigWithOnlySchemaFilterForAnalyzer.json                    | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                  |                                                                                                                  | 200           | SqlServerCataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                                                  | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger   | ida/SqlServerPayloads/empty.json                                                                                 | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                                                  | 200           | RUNNING            | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                                                  | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBAnalyzer                                                   | ida/SqlServerPayloads/PluginConfiguration/SqlServerAnalyzerConfigWithMultipleDuplicateSchemaTableViewFilter.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBAnalyzer                                                   |                                                                                                                  | 200           | SqlServerAnalyzer  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                                                  | 200           | IDLE               | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer  | ida/SqlServerPayloads/empty.json                                                                                 | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                                                  | 200           | RUNNING            | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                                                  | 200           | IDLE               | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |

  @MLP-20943 @positve @regression @sanity
  Scenario Outline:MLP-20943:SC#31_2_User get the Dynamic ID's (Table ID) for the Table name "DiffDataTypesAnalyzer"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                    | asg_scopeid | targetFile                                    | jsonpath                                            |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | testdatabase,testschema,diffdatatypesanalyzer           |             | payloads/ida/sqlServerPayloads/API/items.json | $.Tables.testschema.diffdatatypesanalyzer           |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | testdatabase,testschema,diffdatatypesanalyzerview       |             | payloads/ida/sqlServerPayloads/API/items.json | $.Tables.testschema.diffdatatypesanalyzerview       |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | testdatabase,sqlserverlineage,diffdatatypesanalyzer     |             | payloads/ida/sqlServerPayloads/API/items.json | $.Tables.sqlserverlineage.diffdatatypesanalyzer     |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | testdatabase,sqlserverlineage,diffdatatypesanalyzerview |             | payloads/ida/sqlServerPayloads/API/items.json | $.Tables.sqlserverlineage.diffdatatypesanalyzerview |

  @MLP-20943 @positve @regression @sanity
  Scenario Outline:MLP-20943:SC#31_3_User hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                                           | inputFile                                     | outPutFile                                                                                | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.testschema.diffdatatypesanalyzer           | payloads/ida/sqlServerPayloads/API/items.json | payloads\ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZER.json           |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.testschema.diffdatatypesanalyzerview       | payloads/ida/sqlServerPayloads/API/items.json | payloads\ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZERVIEW.json       |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.sqlserverlineage.diffdatatypesanalyzer     | payloads/ida/sqlServerPayloads/API/items.json | payloads\ida\sqlServerPayloads\API\Actual\SQLSERVERLINEAGE_DIFFDATATYPESANALYZER.json     |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.sqlserverlineage.diffdatatypesanalyzerview | payloads/ida/sqlServerPayloads/API/items.json | payloads\ida\sqlServerPayloads\API\Actual\SQLSERVERLINEAGE_DIFFDATATYPESANALYZERVIEW.json |            |

    #7195075##
  @MLP-20943 @positve @regression @sanity
  Scenario:MLP-20943:SC#31_4_Verify the data sampling works fine for string,numeric,date,time,timestamp,complex types(table/view/materialized) if SqlServerDBAnalyzer is run successfully with multiple duplicate schema/table/view filters.
    Then file content in "ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZER.json" should be same as the content in "ida\sqlServerPayloads\API\Expected\TESTSCHEMA_DIFFDATATYPESANALYZER.json"
    Then file content in "ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZERVIEW.json" should be same as the content in "ida\sqlServerPayloads\API\Expected\TESTSCHEMA_DIFFDATATYPESANALYZERVIEW.json"
    Then file content in "ida\sqlServerPayloads\API\Actual\SQLSERVERLINEAGE_DIFFDATATYPESANALYZER.json" should be same as the content in "ida\sqlServerPayloads\API\Expected\SQLSERVERLINEAGE_DIFFDATATYPESANALYZER.json"
    Then file content in "ida\sqlServerPayloads\API\Actual\SQLSERVERLINEAGE_DIFFDATATYPESANALYZERVIEW.json" should be same as the content in "ida\sqlServerPayloads\API\Expected\SQLSERVERLINEAGE_DIFFDATATYPESANALYZERVIEW.json"

  @MLP-20943 @positve @regression @sanity
  Scenario:MLP-20943:SC#31_5_Verify data profiling works fine for different data types with multiple duplicate schema/table/view filters.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                        | jsonPath                                                                        | Action                    | query                 | ClusterName                                        | ServiceName    | DatabaseName | SchemaName | TableName/Filename        | columnName/FieldName |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.bittype.Description                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | bittype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.tinyinttype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.tinyinttype.Statistics                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.tinyinttype.Lifecycle                           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallinttype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallinttype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallinttype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.inttype.Description                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.inttype.Statistics                              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.inttype.Lifecycle                               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.biginttype.Description                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.biginttype.Statistics                           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.biginttype.Lifecycle                            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.decimaltype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.decimaltype.Statistics                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.decimaltype.Lifecycle                           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.numerictype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.numerictype.Statistics                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.numerictype.Lifecycle                           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallmoneytype.Description                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallmoneytype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.moneytype.Description                           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | moneytype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.realtype.Description                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.realtype.Statistics                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.realtype.Lifecycle                              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.floattype.Description                           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.floattype.Statistics                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.floattype.Lifecycle                             | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetype.Description                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetype.Statistics                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetype.Lifecycle                              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimetype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimetype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimetype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetime2type.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetime2type.Statistics                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetime2type.Lifecycle                         | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimeoffsettype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimeoffsettype.Statistics                   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimeoffsettype.Lifecycle                    | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smalldatetimetype.Description                   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smalldatetimetype.Statistics                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smalldatetimetype.Lifecycle                     | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.timetype.Description                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.timetype.Statistics                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.timetype.Lifecycle                              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Description                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Statistics                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Lifecycle                              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varchartype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varchartype.Statistics                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varchartype.Lifecycle                           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Description                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Statistics                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Lifecycle                              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nchartype.Description                           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nchartype.Statistics                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nchartype.Lifecycle                             | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Description                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Statistics                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Lifecycle                              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nvarchartype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nvarchartype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nvarchartype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.ntexttype.Description                           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | ntexttype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.binarytype.Description                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | binarytype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varbinarytype.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varbinarytype        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.imagetype.Description                           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | imagetype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.rowversiontype.Description                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | rowversiontype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.hierarchyidtype.Description                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | hierarchyidtype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.uniqueidentifiertype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | uniqueidentifiertype |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.xmltype.Description                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | xmltype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.sql_varianttype.Description                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | sql_varianttype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.geographtype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | geographtype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.geometrytype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | geometrytype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.bittype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | bittype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.tinyinttype.Description                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.tinyinttype.Statistics                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.tinyinttype.Lifecycle                       | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallinttype.Description                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallinttype.Statistics                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallinttype.Lifecycle                      | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.inttype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.inttype.Statistics                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.inttype.Lifecycle                           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.biginttype.Description                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.biginttype.Statistics                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.biginttype.Lifecycle                        | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.decimaltype.Description                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.decimaltype.Statistics                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.decimaltype.Lifecycle                       | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.numerictype.Description                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.numerictype.Statistics                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.numerictype.Lifecycle                       | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallmoneytype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallmoneytype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.moneytype.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | moneytype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.realtype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.realtype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.realtype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.floattype.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.floattype.Statistics                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.floattype.Lifecycle                         | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimetype.Description                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimetype.Statistics                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimetype.Lifecycle                      | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetime2type.Description                   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetime2type.Statistics                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetime2type.Lifecycle                     | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimeoffsettype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimeoffsettype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimeoffsettype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smalldatetimetype.Description               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smalldatetimetype.Statistics                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smalldatetimetype.Lifecycle                 | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.timetype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.timetype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.timetype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varchartype.Description                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varchartype.Statistics                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varchartype.Lifecycle                       | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nchartype.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nchartype.Statistics                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nchartype.Lifecycle                         | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nvarchartype.Description                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nvarchartype.Statistics                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nvarchartype.Lifecycle                      | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.ntexttype.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | ntexttype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.binarytype.Description                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | binarytype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varbinarytype.Description                   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varbinarytype        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.imagetype.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | imagetype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.rowversiontype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | rowversiontype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.hierarchyidtype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | hierarchyidtype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.uniqueidentifiertype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | uniqueidentifiertype |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.xmltype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | xmltype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.sql_varianttype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | sql_varianttype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.geographtype.Description                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | geographtype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.geometrytype.Description                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | geometrytype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.bittype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | bittype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.tinyinttype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.tinyinttype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.tinyinttype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smallinttype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smallinttype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smallinttype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.inttype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.inttype.Statistics                   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.inttype.Lifecycle                    | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.biginttype.Description               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.biginttype.Statistics                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.biginttype.Lifecycle                 | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.decimaltype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.decimaltype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.decimaltype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.numerictype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.numerictype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.numerictype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smallmoneytype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallmoneytype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.moneytype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | moneytype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.realtype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.realtype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.realtype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.floattype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.floattype.Statistics                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.floattype.Lifecycle                  | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetimetype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetimetype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetimetype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetime2type.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetime2type.Statistics             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetime2type.Lifecycle              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetimeoffsettype.Description       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetimeoffsettype.Statistics        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetimeoffsettype.Lifecycle         | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smalldatetimetype.Description        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smalldatetimetype.Statistics         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smalldatetimetype.Lifecycle          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.timetype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.timetype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.timetype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.varchartype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.varchartype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.varchartype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.nchartype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.nchartype.Statistics                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.nchartype.Lifecycle                  | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.nvarchartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.nvarchartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.nvarchartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.ntexttype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | ntexttype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.binarytype.Description               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | binarytype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.varbinarytype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varbinarytype        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.imagetype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | imagetype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.rowversiontype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | rowversiontype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.hierarchyidtype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | hierarchyidtype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.uniqueidentifiertype.Description     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | uniqueidentifiertype |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.xmltype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | xmltype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.sql_varianttype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | sql_varianttype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.geographtype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | geographtype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.geometrytype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | geometrytype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.bittype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | bittype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.tinyinttype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.tinyinttype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.tinyinttype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smallinttype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smallinttype.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smallinttype.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.inttype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.inttype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.inttype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.biginttype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.biginttype.Statistics            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.biginttype.Lifecycle             | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.decimaltype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.decimaltype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.decimaltype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.numerictype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.numerictype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.numerictype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smallmoneytype.Description       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallmoneytype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.moneytype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | moneytype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.realtype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.realtype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.realtype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.floattype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.floattype.Statistics             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.floattype.Lifecycle              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetimetype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetimetype.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetimetype.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetime2type.Description        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetime2type.Statistics         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetime2type.Lifecycle          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetimeoffsettype.Description   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetimeoffsettype.Statistics    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetimeoffsettype.Lifecycle     | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smalldatetimetype.Description    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smalldatetimetype.Statistics     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smalldatetimetype.Lifecycle      | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.timetype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.timetype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.timetype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.varchartype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.varchartype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.varchartype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.nchartype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.nchartype.Statistics             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.nchartype.Lifecycle              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.nvarchartype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.nvarchartype.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.nvarchartype.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.ntexttype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | ntexttype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.binarytype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | binarytype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.varbinarytype.Description        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varbinarytype        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.imagetype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | imagetype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.rowversiontype.Description       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | rowversiontype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.hierarchyidtype.Description      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | hierarchyidtype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.uniqueidentifiertype.Description | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | uniqueidentifiertype |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.xmltype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | xmltype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.sql_varianttype.Description      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | sql_varianttype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.geographtype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | geographtype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.geometrytype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | geometrytype         |

  @positve @regression @sanity
  Scenario:MLP-20943:SC#31_6_Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/%                   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SQLServerDBAnalyzer/%                 | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |

  Scenario Outline:MLP-20943:SC#32_1_Run the Plugin configurations for DataSource and SqlServerDBCataloger/SqlServerAnalyzer with only Table/View filter.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | body                                                                                          | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                  | ida/SqlServerPayloads/PluginConfiguration/SqlServerConfigWithOnlySchemaFilterForAnalyzer.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                  |                                                                                               | 200           | SqlServerCataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                               | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger   | ida/SqlServerPayloads/empty.json                                                              | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                               | 200           | RUNNING            | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                               | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBAnalyzer                                                   | ida/SqlServerPayloads/PluginConfiguration/SqlServerAnalyzerConfigWithOnlyTableViewFilter.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBAnalyzer                                                   |                                                                                               | 200           | SqlServerAnalyzer  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                               | 200           | IDLE               | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer  | ida/SqlServerPayloads/empty.json                                                              | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                               | 200           | RUNNING            | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                               | 200           | IDLE               | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |

  @MLP-20943 @positve @regression @sanity
  Scenario Outline:MLP-20943:SC#32_2_User get the Dynamic ID's (Table ID) for the Table name "DiffDataTypesAnalyzer"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                    | asg_scopeid | targetFile                                    | jsonpath                                            |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | testdatabase,testschema,diffdatatypesanalyzer           |             | payloads/ida/sqlServerPayloads/API/items.json | $.Tables.testschema.diffdatatypesanalyzer           |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | testdatabase,testschema,diffdatatypesanalyzerview       |             | payloads/ida/sqlServerPayloads/API/items.json | $.Tables.testschema.diffdatatypesanalyzerview       |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | testdatabase,sqlserverlineage,diffdatatypesanalyzer     |             | payloads/ida/sqlServerPayloads/API/items.json | $.Tables.sqlserverlineage.diffdatatypesanalyzer     |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | testdatabase,sqlserverlineage,diffdatatypesanalyzerview |             | payloads/ida/sqlServerPayloads/API/items.json | $.Tables.sqlserverlineage.diffdatatypesanalyzerview |

  @MLP-20943 @positve @regression @sanity
  Scenario Outline:MLP-20943:SC#32_3_User hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                                           | inputFile                                     | outPutFile                                                                                | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.testschema.diffdatatypesanalyzer           | payloads/ida/sqlServerPayloads/API/items.json | payloads\ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZER.json           |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.testschema.diffdatatypesanalyzerview       | payloads/ida/sqlServerPayloads/API/items.json | payloads\ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZERVIEW.json       |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.sqlserverlineage.diffdatatypesanalyzer     | payloads/ida/sqlServerPayloads/API/items.json | payloads\ida\sqlServerPayloads\API\Actual\SQLSERVERLINEAGE_DIFFDATATYPESANALYZER.json     |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.sqlserverlineage.diffdatatypesanalyzerview | payloads/ida/sqlServerPayloads/API/items.json | payloads\ida\sqlServerPayloads\API\Actual\SQLSERVERLINEAGE_DIFFDATATYPESANALYZERVIEW.json |            |

    #7195075##
  @MLP-20943 @positve @regression @sanity
  Scenario:MLP-20943:SC#32_4_Verify the data sampling works fine for string,numeric,date,time,timestamp,complex types(table/view/materialized) if SqlServerDBAnalyzer is run successfully with only Table/View filter.
    Then file content in "ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZER.json" should be same as the content in "ida\sqlServerPayloads\API\Expected\TESTSCHEMA_DIFFDATATYPESANALYZER.json"
    Then file content in "ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZERVIEW.json" should be same as the content in "ida\sqlServerPayloads\API\Expected\TESTSCHEMA_DIFFDATATYPESANALYZERVIEW.json"
    Then file content in "ida\sqlServerPayloads\API\Actual\SQLSERVERLINEAGE_DIFFDATATYPESANALYZER.json" should be same as the content in "ida\sqlServerPayloads\API\Expected\SQLSERVERLINEAGE_DIFFDATATYPESANALYZER.json"
    Then file content in "ida\sqlServerPayloads\API\Actual\SQLSERVERLINEAGE_DIFFDATATYPESANALYZERVIEW.json" should be same as the content in "ida\sqlServerPayloads\API\Expected\SQLSERVERLINEAGE_DIFFDATATYPESANALYZERVIEW.json"

  @positve @regression @sanity @webtest
  Scenario:MLP-20943:SC#32_5_Verify data profiling works fine for different data types with only table/view filters.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                        | jsonPath                                                                        | Action                    | query                 | ClusterName                                        | ServiceName    | DatabaseName | SchemaName | TableName/Filename        | columnName/FieldName |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.bittype.Description                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | bittype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.tinyinttype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.tinyinttype.Statistics                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.tinyinttype.Lifecycle                           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallinttype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallinttype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallinttype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.inttype.Description                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.inttype.Statistics                              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.inttype.Lifecycle                               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.biginttype.Description                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.biginttype.Statistics                           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.biginttype.Lifecycle                            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.decimaltype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.decimaltype.Statistics                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.decimaltype.Lifecycle                           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.numerictype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.numerictype.Statistics                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.numerictype.Lifecycle                           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallmoneytype.Description                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallmoneytype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.moneytype.Description                           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | moneytype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.realtype.Description                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.realtype.Statistics                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.realtype.Lifecycle                              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.floattype.Description                           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.floattype.Statistics                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.floattype.Lifecycle                             | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetype.Description                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetype.Statistics                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetype.Lifecycle                              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimetype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimetype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimetype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetime2type.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetime2type.Statistics                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetime2type.Lifecycle                         | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimeoffsettype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimeoffsettype.Statistics                   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimeoffsettype.Lifecycle                    | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smalldatetimetype.Description                   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smalldatetimetype.Statistics                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smalldatetimetype.Lifecycle                     | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.timetype.Description                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.timetype.Statistics                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.timetype.Lifecycle                              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Description                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Statistics                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Lifecycle                              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varchartype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varchartype.Statistics                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varchartype.Lifecycle                           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Description                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Statistics                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Lifecycle                              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nchartype.Description                           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nchartype.Statistics                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nchartype.Lifecycle                             | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Description                            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Statistics                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Lifecycle                              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nvarchartype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nvarchartype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nvarchartype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.ntexttype.Description                           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | ntexttype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.binarytype.Description                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | binarytype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varbinarytype.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varbinarytype        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.imagetype.Description                           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | imagetype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.rowversiontype.Description                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | rowversiontype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.hierarchyidtype.Description                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | hierarchyidtype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.uniqueidentifiertype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | uniqueidentifiertype |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.xmltype.Description                             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | xmltype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.sql_varianttype.Description                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | sql_varianttype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.geographtype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | geographtype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.geometrytype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | geometrytype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.bittype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | bittype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.tinyinttype.Description                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.tinyinttype.Statistics                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.tinyinttype.Lifecycle                       | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallinttype.Description                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallinttype.Statistics                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallinttype.Lifecycle                      | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.inttype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.inttype.Statistics                          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.inttype.Lifecycle                           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.biginttype.Description                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.biginttype.Statistics                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.biginttype.Lifecycle                        | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.decimaltype.Description                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.decimaltype.Statistics                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.decimaltype.Lifecycle                       | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.numerictype.Description                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.numerictype.Statistics                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.numerictype.Lifecycle                       | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallmoneytype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallmoneytype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.moneytype.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | moneytype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.realtype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.realtype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.realtype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.floattype.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.floattype.Statistics                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.floattype.Lifecycle                         | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimetype.Description                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimetype.Statistics                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimetype.Lifecycle                      | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetime2type.Description                   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetime2type.Statistics                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetime2type.Lifecycle                     | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimeoffsettype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimeoffsettype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimeoffsettype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smalldatetimetype.Description               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smalldatetimetype.Statistics                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smalldatetimetype.Lifecycle                 | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.timetype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.timetype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.timetype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varchartype.Description                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varchartype.Statistics                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varchartype.Lifecycle                       | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nchartype.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nchartype.Statistics                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nchartype.Lifecycle                         | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Description                        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Statistics                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Lifecycle                          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nvarchartype.Description                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nvarchartype.Statistics                     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nvarchartype.Lifecycle                      | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.ntexttype.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | ntexttype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.binarytype.Description                      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | binarytype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varbinarytype.Description                   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varbinarytype        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.imagetype.Description                       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | imagetype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.rowversiontype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | rowversiontype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.hierarchyidtype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | hierarchyidtype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.uniqueidentifiertype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | uniqueidentifiertype |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.xmltype.Description                         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | xmltype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.sql_varianttype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | sql_varianttype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.geographtype.Description                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | geographtype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.geometrytype.Description                    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | geometrytype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.bittype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | bittype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.tinyinttype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.tinyinttype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.tinyinttype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smallinttype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smallinttype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smallinttype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.inttype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.inttype.Statistics                   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.inttype.Lifecycle                    | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.biginttype.Description               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.biginttype.Statistics                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.biginttype.Lifecycle                 | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.decimaltype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.decimaltype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.decimaltype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.numerictype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.numerictype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.numerictype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smallmoneytype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallmoneytype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.moneytype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | moneytype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.realtype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.realtype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.realtype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.floattype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.floattype.Statistics                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.floattype.Lifecycle                  | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetimetype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetimetype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetimetype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetime2type.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetime2type.Statistics             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetime2type.Lifecycle              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetimeoffsettype.Description       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetimeoffsettype.Statistics        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.datetimeoffsettype.Lifecycle         | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smalldatetimetype.Description        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smalldatetimetype.Statistics         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.smalldatetimetype.Lifecycle          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.timetype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.timetype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.timetype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.varchartype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.varchartype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.varchartype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.nchartype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.nchartype.Statistics                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.nchartype.Lifecycle                  | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.chartype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.nvarchartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.nvarchartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.nvarchartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.ntexttype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | ntexttype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.binarytype.Description               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | binarytype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.varbinarytype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varbinarytype        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.imagetype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | imagetype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.rowversiontype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | rowversiontype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.hierarchyidtype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | hierarchyidtype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.uniqueidentifiertype.Description     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | uniqueidentifiertype |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.xmltype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | xmltype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.sql_varianttype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | sql_varianttype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.geographtype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | geographtype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzer.Columns.geometrytype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | geometrytype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.bittype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | bittype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.tinyinttype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.tinyinttype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.tinyinttype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smallinttype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smallinttype.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smallinttype.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.inttype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.inttype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.inttype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.biginttype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.biginttype.Statistics            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.biginttype.Lifecycle             | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.decimaltype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.decimaltype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.decimaltype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.numerictype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.numerictype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.numerictype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smallmoneytype.Description       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallmoneytype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.moneytype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | moneytype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.realtype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.realtype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.realtype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.floattype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.floattype.Statistics             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.floattype.Lifecycle              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetimetype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetimetype.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetimetype.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetime2type.Description        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetime2type.Statistics         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetime2type.Lifecycle          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetimeoffsettype.Description   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetimeoffsettype.Statistics    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.datetimeoffsettype.Lifecycle     | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smalldatetimetype.Description    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smalldatetimetype.Statistics     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.smalldatetimetype.Lifecycle      | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.timetype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.timetype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.timetype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.varchartype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.varchartype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.varchartype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.nchartype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.nchartype.Statistics             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.nchartype.Lifecycle              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.chartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.nvarchartype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.nvarchartype.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.nvarchartype.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.ntexttype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | ntexttype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.binarytype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | binarytype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.varbinarytype.Description        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varbinarytype        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.imagetype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | imagetype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.rowversiontype.Description       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | rowversiontype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.hierarchyidtype.Description      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | hierarchyidtype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.uniqueidentifiertype.Description | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | uniqueidentifiertype |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.xmltype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | xmltype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.sql_varianttype.Description      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | sql_varianttype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.geographtype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | geographtype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.Sqllineage_diffdatatypesanalyzerview.Columns.geometrytype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | geometrytype         |

  @positve @regression @sanity
  Scenario:MLP-20943:SC#32_6_Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/%                   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SQLServerDBAnalyzer/%                 | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |

  #6822675
  Scenario Outline:MLP-20943:SC#33_1_Run the Plugin configurations for DataSource and SqlServerDBCataloger with Database/Schema/Table/View filter.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | body                                                                                                       | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                  | ida/SqlServerPayloads/PluginConfiguration/SqlServerConfigWithOnlySchemaFilterForAnalyzer.json              | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                  |                                                                                                            | 200           | SqlServerCataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                                            | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger   | ida/SqlServerPayloads/empty.json                                                                           | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                                            | 200           | RUNNING            | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                                            | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBAnalyzer                                                   | ida/SqlServerPayloads/PluginConfiguration/SqlServerAnalyzerConfigWithDatabaseSchemaTableViewFilterRDS.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBAnalyzer                                                   |                                                                                                            | 200           | SqlServerAnalyzer  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                                            | 200           | IDLE               | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer  | ida/SqlServerPayloads/empty.json                                                                           | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                                            | 200           | RUNNING            | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                                            | 200           | IDLE               | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |

  @MLP-20943 @positve @regression @sanity
  Scenario Outline:MLP-20943:SC#33_2_User get the Dynamic ID's (Table ID) for the Table name "DiffDataTypesAnalyzer"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                              | asg_scopeid | targetFile                                    | jsonpath                                      |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | testdatabase,testschema,diffdatatypesanalyzer     |             | payloads/ida/sqlServerPayloads/API/items.json | $.Tables.testschema.diffdatatypesanalyzer     |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | testdatabase,testschema,diffdatatypesanalyzerview |             | payloads/ida/sqlServerPayloads/API/items.json | $.Tables.testschema.diffdatatypesanalyzerview |

  @MLP-20943 @positve @regression @sanity
  Scenario Outline:MLP-20943:SC#33_3_User hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                                     | inputFile                                     | outPutFile                                                                          | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.testschema.diffdatatypesanalyzer     | payloads/ida/sqlServerPayloads/API/items.json | payloads\ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZER.json     |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.testschema.diffdatatypesanalyzerview | payloads/ida/sqlServerPayloads/API/items.json | payloads\ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZERVIEW.json |            |

    #7195075##
  @MLP-20943 @positve @regression @sanity
  Scenario:MLP-20943:SC#33_4_Verify the data sampling works fine for string,numeric,date,time,timestamp,complex types(table/view/materialized) if SqlServerDBAnalyzer is run successfully with Database/Schema/Table/View filters.
    Then file content in "ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZER.json" should be same as the content in "ida\sqlServerPayloads\API\Expected\TESTSCHEMA_DIFFDATATYPESANALYZER.json"
    Then file content in "ida\sqlServerPayloads\API\Actual\TESTSCHEMA_DIFFDATATYPESANALYZERVIEW.json" should be same as the content in "ida\sqlServerPayloads\API\Expected\TESTSCHEMA_DIFFDATATYPESANALYZERVIEW.json"

  @MLP-20943 @positve @regression @sanity
  Scenario:MLP-20943:SC#33_5_Verify data profiling works fine for different different types with Database/schema/table/view filters.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                        | jsonPath                                                             | Action                    | query                 | ClusterName                                        | ServiceName    | DatabaseName | SchemaName | TableName/Filename        | columnName/FieldName |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.bittype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | bittype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.tinyinttype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.tinyinttype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.tinyinttype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | tinyinttype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallinttype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallinttype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallinttype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallinttype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.inttype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.inttype.Statistics                   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.inttype.Lifecycle                    | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | inttype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.biginttype.Description               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.biginttype.Statistics                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.biginttype.Lifecycle                 | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | biginttype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.decimaltype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.decimaltype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.decimaltype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | decimaltype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.numerictype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.numerictype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.numerictype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | numerictype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smallmoneytype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smallmoneytype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.moneytype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | moneytype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.realtype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.realtype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.realtype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | realtype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.floattype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.floattype.Statistics                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.floattype.Lifecycle                  | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | floattype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimetype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimetype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimetype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimetype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetime2type.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetime2type.Statistics             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetime2type.Lifecycle              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetime2type        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimeoffsettype.Description       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimeoffsettype.Statistics        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.datetimeoffsettype.Lifecycle         | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | datetimeoffsettype   |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smalldatetimetype.Description        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smalldatetimetype.Statistics         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.smalldatetimetype.Lifecycle          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | smalldatetimetype    |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.timetype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.timetype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.timetype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | timetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varchartype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varchartype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varchartype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varchartype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nchartype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nchartype.Statistics                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nchartype.Lifecycle                  | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nchartype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Description                 | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Statistics                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.chartype.Lifecycle                   | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nvarchartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nvarchartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.nvarchartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | nvarchartype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.ntexttype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | ntexttype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.binarytype.Description               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | binarytype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.varbinarytype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | varbinarytype        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.imagetype.Description                | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | imagetype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.rowversiontype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | rowversiontype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.hierarchyidtype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | hierarchyidtype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.uniqueidentifiertype.Description     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | uniqueidentifiertype |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.xmltype.Description                  | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | xmltype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.sql_varianttype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | sql_varianttype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.geographtype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | geographtype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzer.Columns.geometrytype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzer     | geometrytype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.bittype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | bittype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.tinyinttype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.tinyinttype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.tinyinttype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | tinyinttype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallinttype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallinttype.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallinttype.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallinttype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.inttype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.inttype.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.inttype.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | inttype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.biginttype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.biginttype.Statistics            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.biginttype.Lifecycle             | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | biginttype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.decimaltype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.decimaltype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.decimaltype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | decimaltype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.numerictype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.numerictype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.numerictype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | numerictype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smallmoneytype.Description       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smallmoneytype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.moneytype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | moneytype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.realtype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.realtype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.realtype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | realtype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.floattype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.floattype.Statistics             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.floattype.Lifecycle              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | floattype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimetype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimetype.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimetype.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimetype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetime2type.Description        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetime2type.Statistics         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetime2type.Lifecycle          | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetime2type        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimeoffsettype.Description   | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimeoffsettype.Statistics    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.datetimeoffsettype.Lifecycle     | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | datetimeoffsettype   |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smalldatetimetype.Description    | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smalldatetimetype.Statistics     | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.smalldatetimetype.Lifecycle      | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | smalldatetimetype    |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.timetype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.timetype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.timetype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | timetype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varchartype.Description          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varchartype.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varchartype.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varchartype          |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nchartype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nchartype.Statistics             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nchartype.Lifecycle              | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nchartype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Description             | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.chartype.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | chartype             |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nvarchartype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Statistics  | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nvarchartype.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Lifecycle   | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.nvarchartype.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | nvarchartype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.ntexttype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | ntexttype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.binarytype.Description           | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | binarytype           |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.varbinarytype.Description        | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | varbinarytype        |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.imagetype.Description            | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | imagetype            |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.rowversiontype.Description       | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | rowversiontype       |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.hierarchyidtype.Description      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | hierarchyidtype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.uniqueidentifiertype.Description | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | uniqueidentifiertype |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.xmltype.Description              | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | xmltype              |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.sql_varianttype.Description      | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | sql_varianttype      |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.geographtype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | geographtype         |
      | Description | ida/sqlServerPayloads/API/ExpectedMetadata.json | $.diffdatatypesanalyzerview.Columns.geometrytype.Description         | metadataValuePresence     | ColumnQuerywithSchema | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | sqlserver:1521 | testdatabase | testschema | diffdatatypesanalyzerview | geometrytype         |

    #6754453#
  @sanity @positive @MLP-20518 @webtest @IDA-1.1.0
  Scenario:MLP-20943:SC#33_6_Verify log entries/log enhancements(processed Items widget and Processed count) check for SqlServerDBAnalyzer plugin logs.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerAnalyzerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer%"
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com |
      | sqlserver:1521                                     |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | logCode       | pluginName          | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | ANALYSIS-0019 |                     |                |
      | INFO | Plugin Name:SQLServerDBAnalyzer, Plugin Type:dataanalyzer, Plugin Version:1.1.0.RC1-SNAPSHOT, Node Name:LocalNode, Host Name:13fac4e8ed49, Plugin Configuration name:SqlServerAnalyzer                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0071 | SQLServerDBAnalyzer | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: ---  2020-10-08 18:11:33.681 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: name: "SqlServerAnalyzer"  2020-10-08 18:11:33.681 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: pluginVersion: "LATEST"  2020-10-08 18:11:33.681 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: label:  2020-10-08 18:11:33.681 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: : ""  2020-10-08 18:11:33.681 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: catalogName: "Default"  2020-10-08 18:11:33.681 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: eventClass: null  2020-10-08 18:11:33.681 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: eventCondition: null  2020-10-08 18:11:33.681 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: nodeCondition: "name==\"LocalNode\""  2020-10-08 18:11:33.681 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: maxWorkSize: 100  2020-10-08 18:11:33.681 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: tags:  2020-10-08 18:11:33.681 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: - "SqlServerAnalyzerTag1"  2020-10-08 18:11:33.681 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: pluginType: "dataanalyzer"  2020-10-08 18:11:33.681 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: dataSource: null  2020-10-08 18:11:33.682 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: credential: null  2020-10-08 18:11:33.682 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: businessApplicationName: null  2020-10-08 18:11:33.682 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: dryRun: false  2020-10-08 18:11:33.682 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: schedule: null  2020-10-08 18:11:33.682 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: filter: null  2020-10-08 18:11:33.682 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: histogramBuckets: 10  2020-10-08 18:11:33.682 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: database: "testdatabase"  2020-10-08 18:11:33.682 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: pluginName: "SQLServerDBAnalyzer"  2020-10-08 18:11:33.682 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: queryBatchSize: 100  2020-10-08 18:11:33.682 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: sampleDataCount: 25  2020-10-08 18:11:33.682 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: schemas:  2020-10-08 18:11:33.682 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: - schema: "testschema"  2020-10-08 18:11:33.682 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: tables:  2020-10-08 18:11:33.682 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: - table: "diffdatatypesanalyzer"  2020-10-08 18:11:33.682 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: - table: "diffdatatypesanalyzerview"  2020-10-08 18:11:33.682 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: type: "Dataanalyzer"  2020-10-08 18:11:33.682 INFO  - ANALYSIS-0073: Plugin SQLServerDBAnalyzer Configuration: topValues: 10 | ANALYSIS-0073 | SQLServerDBAnalyzer |                |
      | INFO | Plugin SQLServerDBAnalyzer Start Time:2020-10-08 18:11:33.678, End Time:2020-10-08 18:12:18.446, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | ANALYSIS-0072 | SQLServerDBAnalyzer |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:35.865)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | ANALYSIS-0020 |                      |                |

  @positve @regression @sanity
  Scenario:MLP-20943:SC#33_7_Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/SQLServerDBAnalyzer/%                 | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/%                   | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |

    #6822675
  Scenario Outline:MLP-20943:SC#34_1_Run the Plugin configurations for DataSource and SqlServerDBCataloger/SqlServerDBAnalyzer with non existing Schema/Table Names in filter.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | body                                                                                                         | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                  | ida/SqlServerPayloads/PluginConfiguration/SqlServerConfigWithOnlySchemaFilterForAnalyzer.json                | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                  |                                                                                                              | 200           | SqlServerCataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                                              | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger   | ida/SqlServerPayloads/empty.json                                                                             | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                                              | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBAnalyzer                                                   | ida/SqlServerPayloads/PluginConfiguration/SqlServerAnalyzerConfigWithNonexistingDBSchemaTableViewFilter.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBAnalyzer                                                   |                                                                                                              | 200           | SqlServerAnalyzer  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                                              | 200           | IDLE               | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer  | ida/SqlServerPayloads/empty.json                                                                             | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                                              | 200           | IDLE               | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |

  #6936990
  @MLP-20518 @webtest @aws @regression @sanity
  Scenario:MLP-20943:SC#34_2_Validate analyzer does not do any analysis and log throws proper message when non existing schema/Table are passed in SqlServerDBanalyzer configuration.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerAnalyzerTag1" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis |
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer%" should display below info/error/warning
      | type | logValue                                                           | logCode            | pluginName          | removableText |
      | INFO | ANALYSIS-JDBC-0053: Database [idatestdb] not found in the Catalog. | ANALYSIS-JDBC-0053 | SqlServerDBAnalyzer |               |
    And user clicks on logout button

  @positve @regression @sanity
  Scenario:MLP-20943:SC#34_3_Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/SQLServerDBAnalyzer/%                 | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/%                   | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |

    #6822675
  Scenario Outline:MLP-23777:SC#35_1_Run the Plugin configurations for DataSource and SqlServerDBCataloger/SqlServerAnalyzer in DryRun mode.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | body                                                                                      | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                  | ida/SqlServerPayloads/PluginConfiguration/SqlServerCatalogerConfigWithDryRunNoFilter.json | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                  |                                                                                           | 200           | SqlServerCataloger |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                           | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger   | ida/SqlServerPayloads/empty.json                                                          | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                           | 200           | IDLE               | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBAnalyzer                                                   | ida/SqlServerPayloads/PluginConfiguration/SqlServerAnalyzerConfigWithDryRunNoFilter.json  | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBAnalyzer                                                   |                                                                                           | 200           | SqlServerAnalyzer  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                           | 200           | IDLE               | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer  | ida/SqlServerPayloads/empty.json                                                          | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                           | 200           | IDLE               | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |

    #6936990 Bug MLP-24578 raised for this scenario.
  @MLP-23777 @webtest @regression @sanity
  Scenario:MLP-23777:SC#35_2_Verify SqlServerDBAnalyzer doesn't collects Cluster,Service,Database,Table,Column,Constraint when SqlServerDBAanlyzer is run with dryrun as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerAnalyzerTag1" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service    |
      | Cluster    |
      | Database   |
      | Table      |
      | Column     |
      | Constraint |
      | Schema     |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 2             | Description |
      | Number of errors          | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer%" should display below info/error/warning
      | type | logValue                                                                                                                                 | logCode       | pluginName          | removableText |
      | INFO | Plugin SQLServerDBAnalyzer running on dry run mode                                                                                       | ANALYSIS-0069 | SQLServerDBAnalyzer |               |
      | INFO | Plugin SQLServerDBAnalyzer processed 0 items on dry run mode and not written to the repository                                           | ANALYSIS-0070 | SQLServerDBAnalyzer |               |
      | INFO | Plugin SQLServerDBAnalyzer Start Time:2020-06-15 23:31:07.702, End Time:2020-06-15 23:31:09.040, Processed Count:2, Errors:0, Warnings:0 | ANALYSIS-0072 | SQLServerDBAnalyzer |               |
    And user clicks on logout button

  @positve @regression @sanity
  Scenario:MLP-23777:SC#35_3_Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/SQLServerDBAnalyzer/%                 | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/%                   | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |

  @sanity @positive
  Scenario Outline:MLP-26621:SC#35_4_Delete the Credentials and plugin configurations for SqlServerCataloger and SqlServerAnalyzer.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                      | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerDBCataloger  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerDBDataSource |      | 204           |                  |          |

    #6822675
  Scenario Outline:MLP-26621:SC#36_1_Run the Plugin configurations for DataSource and SqlServerDBCataloger/SqlServerAnalyzer with Multiple DB filter.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                                                                             | response code | response message         | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBDataSource                                                    | ida/SqlServerPayloads/DataSource/SqlServer2019AWSValidDataSourceConfigInternalNode.json                          | 204           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBDataSource                                                    |                                                                                                                  | 200           | SqlServerValidDataSource |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                     | ida/SqlServerPayloads/PluginConfiguration/SqlServerConfigWithOnlySchemaFilterRDSInternal.json                    | 204           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                     |                                                                                                                  | 200           | SqlServerCataloger       |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                                                  | 200           | IDLE                     | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger   | ida/SqlServerPayloads/empty.json                                                                                 | 200           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                                                  | 200           | IDLE                     | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBDataSource                                                    | ida/SqlServerPayloads/DataSource/SqlServerValidDataSourceConfigMultipleDBRDS2019Internal.json                    | 204           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBDataSource                                                    |                                                                                                                  | 200           | SqlServerValidDataSource |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                     | ida/SqlServerPayloads/PluginConfiguration/SqlServerConfigWithMultipleDBFilterRDS2019.json                        | 204           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                     |                                                                                                                  | 200           | SqlServerCataloger       |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                                                  | 200           | IDLE                     | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger   | ida/SqlServerPayloads/empty.json                                                                                 | 200           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  |                                                                                                                  | 200           | IDLE                     | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBAnalyzer                                                      | ida/SqlServerPayloads/PluginConfiguration/SqlServerAnalyzerConfigWithMultipleDBSchemaTableViewFilterRDS2019.json | 204           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBAnalyzer                                                      |                                                                                                                  | 200           | SqlServerAnalyzer        |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                                                  | 200           | IDLE                     | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer  | ida/SqlServerPayloads/empty.json                                                                                 | 200           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/SQLServerDBAnalyzer/SqlServerAnalyzer |                                                                                                                  | 200           | IDLE                     | $.[?(@.configurationName=='SqlServerAnalyzer')].status  |

  @positve @regression @sanity @webtest
  Scenario:MLP-26621:SC#36_2_Verify analyzer does analysis for multiple db cataloged in catalog.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "testdatabase [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "diffdatatypesanalyzer" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "testdatabase [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "diffdatatypesanalyzerview" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "sqldbcollationci [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "diffdatatypesanalyzer" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "SqlServerAnalyzerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "sqldbcollationci [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "diffdatatypesanalyzerview" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |

  @positve @regression @sanity
  Scenario:MLP-26621:SC#36_3_Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/SQLServerDBAnalyzer/%                 | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/%                   | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |

  @sanity @positive
  Scenario Outline:MLP-26621:SC#36_4_Delete the Credentials and plugin configurations for SqlServerCataloger and SqlServerAnalyzer.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                      | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerDBCataloger  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerDBDataSource |      | 204           |                  |          |

 ####################################### MLP-29217 Collation Enhancements #####################################################################

  Scenario Outline:SC#37_1_Run the Plugin configurations for DataSource and SqlServerDBCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                        | response code | response message         | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBDataSource                                                | ida/SqlServerPayloads/DataSource/SqlServer2019AWSValidDataSourceConfig.json | 204           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBDataSource                                                |                                                                             | 200           | SqlServerValidDataSource |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                 | ida/SqlServerPayloads/PluginConfiguration/SqlServerConfigWithNoFilter.json  | 204           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                 |                                                                             | 200           | SqlServerCataloger       |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                             | 200           | IDLE                     | $.[?(@.configurationName=='SqlServerCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger  | ida/SqlServerPayloads/empty.json                                            | 200           |                          |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |                                                                             | 200           | RUNNING                  | $.[?(@.configurationName=='SqlServerCataloger')].status |

  Scenario Outline:SC#37_2_Sync the test execution.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body | response code | response message | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SqlServerCataloger |      | 200           | IDLE             | $.[?(@.configurationName=='SqlServerCataloger')].status |

  #7240673,#7240674,#7240675
  @webtest @MLP-29217 @sanity @positive @regression
  Scenario:SC#37_3_Verify all the DB items items like Table, column etc gets collected in DD based on the Database Collation set with _CI option(Capture all the items with lower case letter) and cataloger,analyzer,postprocessor sanity flow works fine with it.
  Verify all the DB items items like Table, column etc gets collected in DD based on the Database Collation set with _CS option(Capture all the items as it is in DB) and cataloger,analyzer,postprocessor sanity flow works fine with it.
  Verify all the DB items items like Table, column etc gets collected in DD based on the Database Collation set with _BIN option(Capture all the items as it is in DB) and cataloger,analyzer,postprocessor sanity flow works fine with it.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | sqldbcollationcs  |
      | sqldbcollationci  |
      | sqldbcollationbin |
      | model             |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "sqldbcollationci [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | diffdatatypesanalyzer     |
      | diffdatatypesanalyzerview |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "sqldbcollationcs [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | DIFFDATATYPESANALYZER     |
      | DIFFDATATYPESANALYZERVIEW |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "sqldbcollationbin [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | DiffDATATypesANALYZER     |
      | DiffDATATypesANALYZERVIEW |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "sqldbcollationci [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "diffdatatypesanalyzer" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "sqldbcollationci [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzerview [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "diffdatatypesanalyzerview" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "sqldbcollationcs [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "diffdatatypesanalyzer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "diffdatatypesanalyzer" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "sqldbcollationci [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DIFFDATATYPESANALYZER [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "DIFFDATATYPESANALYZER" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "sqldbcollationci [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DIFFDATATYPESANALYZERVIEW [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "DIFFDATATYPESANALYZERVIEW" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "sqldbcollationbin [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDATATypesANALYZER [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "DiffDATATypesANALYZER" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "SqlServerTag1" and clicks on search
    And user performs "facet selection" in "SqlServerTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "sqldbcollationbin [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDATATypesANALYZERVIEW [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "DiffDATATypesANALYZERVIEW" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |

  @positve @regression @sanity
  Scenario:SC#37_4_Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/SQLServerDBAnalyzer/%                 | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/%                   | Analysis |       |       |
      | SingleItemDelete | Default | sqlserver.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |

  @sanity @positive
  Scenario Outline:SC#38_1_Delete the Credentials and plugin configurations for SqlServerCataloger and SqlServerAnalyzer.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                 | body                                                                   | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerDBCataloger             |                                                                        | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerDBDataSource            |                                                                        | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidSqlServerCredentials      | ida/SqlServerPayloads/Credentials/sqlServerValidCredentialsOnPrem.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/IncorrectSqlServerCredentials  | ida/SqlServerPayloads/Credentials/sqlServerInvalidCredentials.json     | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EmptySqlServerCredentials      | ida/SqlServerPayloads/Credentials/sqlServerEmptyCredentials.json       | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerDBAnalyzer              |                                                                        | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get    | settings/credentials/ValidSqlServerCredentials      |                                                                        | 404           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get    | settings/credentials/IncorrectSqlServerCredentials  |                                                                        | 404           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get    | settings/credentials/EmptySqlServerCredentials      |                                                                        | 404           |                  |          |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario:SC#38_2_Delete Bussiness Application
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name         | type                | query | param |
      | SingleItemDelete | Default | SqlServer_BA | BusinessApplication |       |       |

