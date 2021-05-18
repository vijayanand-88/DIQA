Feature: MLP-9056 and MLP-7720 Verification of Snowflake Cataloger(with packing Changes included)
  MLP-20518 Snowflake Data Analyzer Implementation and DBReboot Changes.
  MLP-21007 Snwoflake Analyzer Implementation.
  MLP-20938 Snowflake External Table Support.

  @precondition
  Scenario: MLP-20518:SC1#Update credential payload json for Snowflake Database
    Given User update the below "snowflake credentials" in following files using json path
      | filePath                                                         | username    | password    |
      | ida/snowflakePayloads/Credentials/snowflakeValidCredentials.json | $..userName | $..password |

  @sanity @positive
  Scenario Outline: SC1#Configure the Credentials for Snowflake Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                              | body                                                               | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidSnowflakeCredentials   | ida/snowflakePayloads/Credentials/snowflakeValidCredentials.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/InvalidSnowflakeCredentials | ida/snowflakePayloads/Credentials/snowflakeInValidCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/EmptySnowflakeCredentials   | ida/snowflakePayloads/Credentials/snowflakeEmptyCredentials.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidSnowflakeCredentials   |                                                                    | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/InvalidSnowflakeCredentials |                                                                    | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/EmptySnowflakeCredentials   |                                                                    | 200           |                  |          |


  @sanity @positive @regression
  Scenario Outline: SC1#Create BusinessApplication tag and run the plugin configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/snowflakePayloads/snowflakeBusinessApplication.json | 200           |                  |          |

  @sanity @positive @regression
  Scenario Outline: MLP-20518:SC1#Update Snowflake PII Tags in Tagging Policy
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                                  | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | tags/Default/structures | ida/snowflakePayloads/policyEngine/SnowflakeTags.json | 200           |                  |          |

  @MLP-20518 @positive @regression
  Scenario Outline:SC1#MLP-20518 Verification of Uploading snowflake jars
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | extensions/bundles | osgibundle/snowflake-jdbc-3.9.2.jar | 200           |                  |          |


 # 7085450 #
  @webtest @regression
  Scenario: SC#1-Verify whether the background of the panel is displayed in green when test connection is successful for SnowflakeDBDataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Data Sources" in "Add Data source Configuration"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data source Configuration"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute             |
      | Data Source Type | SnowflakeDBDataSource |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                 |
      | Label                 |
      | URL*                  |
      | Driver Bundle Name*   |
      | Driver Bundle Version |
      | Driver Name           |
      | Credential*           |
      | Node                  |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                                                   |
      | Name      | SnowflakeDataSourceTest                                                                     |
      | Label     | SnowflakeDataSourceTest                                                                     |
      | URL       | jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                 |
      | Credential | ValidSnowflakeCredentials |
      | Node       | LocalNode                 |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "click" on "Save" button in "Add Data Sources Page"

    # 7085450 #
  @MLP-20518 @webtest @regression
  Scenario: SC#2-Verify whether the background of the panel is displayed in red when test connection is not successful for SnowflakeDataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Data Sources" in "Add Data source Configuration"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data source Configuration"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute             |
      | Data Source Type | SnowflakeDBDataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                 |
      | Label                 |
      | URL*                  |
      | Driver Bundle Name*   |
      | Driver Bundle Version |
      | Driver Name           |
      | Credential*           |
      | Node                  |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                                                   |
      | Name      | SnowflakeDataSourceTest2                                                                    |
      | Label     | SnowflakeDataSourceTest2                                                                    |
      | URL       | jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                   |
      | Credential | InvalidSnowflakeCredentials |
      | Node       | LocalNode                   |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Incorrect username or password was specified." is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                 |
      | Credential | EmptySnowflakeCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Missing user name" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"


#  @MLP-20518 @sanity @positive @regression @snowflake
#  Scenario:SC#3: Create Table and insert value for snowflake
#    Given user connects to the database and performs the following operation
#      | databaseConnection | Operation    | queryPath     | queryPage        | queryField                |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createSchema1             |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createTable1              |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord1             |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord2             |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord3             |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord4             |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createTable2              |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord1Table2       |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createTable3              |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord1Table3       |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createTable4              |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord1Table4       |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createTable5              |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord1Table5       |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createTable6              |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord1Table6       |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createTable7              |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord1Table7       |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createTable8              |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord1Table8       |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createTable9              |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord1Table9       |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createTable10             |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord1Table10      |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createViewReplace         |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createViewClass           |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createViewScholarSpecific |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createSecureView          |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createForceView           |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createJoinView            |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createTable11             |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord1Table11      |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord2Table11      |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord3Table11      |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord4Table11      |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createTable12             |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord1Table12      |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createTable13             |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord1Table13      |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord2Table13      |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord3Table13      |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | insertRecord4Table13      |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createTagDetailsView      |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createReplaceExtTable1    |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createReplaceExtTable1    |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createReplaceExtTable2    |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createReplaceExtTable3    |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createReplaceExtTable4    |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createReplaceExtTable5    |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createReplaceExtTable6    |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createReplaceExtTable7    |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createReplaceExtTable8    |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createReplaceExtTable9    |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createReplaceExtTable10   |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createReplaceExtTable11   |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createReplaceExtTable12   |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createReplaceExtTable13   |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createReplaceExtTable14   |
#      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | snowFlakeQueries | createReplaceExtTable15   |

  @positive
  Scenario: SC#3-Configure the Snowflake Datasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                      | body                                                                 | response code | response message | jsonPath                 |
      | application/json | raw   | false | Put  | settings/analyzers/SnowflakeDBDataSource | ida/snowflakePayloads/DataSource/SnowflakeValidDataSourceConfig.json | 204           |                  |                          |
      |                  |       |       | Get  | settings/analyzers/SnowflakeDBDataSource |                                                                      | 200           |                  | SnowflakeValidDataSource |

  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#3: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                                                | path                                      | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerNoFilterConfiguration | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              |                                                                         |                                           | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                           | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                           | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                           | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |

   # 7043461 # 7082870 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#3:  1. Verify JDBC cataloger scans and collects data if schema name and table names are not provided in filters
  2. Verify the Database Name should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TEST_DB" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TEST_DB" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue   | widgetName  |
      | Storage type      | Snowflake4.31.3 | Description |
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage        | queryField          | columnName  | queryOperation   | storeResults  |
      | SNOWFLAKE    | STRUCTURED   | json/IDA.json | snowFlakeQueries | getSnowflakeSchemas | SCHEMA_NAME | returnstringlist | resultsInList |
    And user "verifies" the "Schemas" Item view page result "list" value with Postgres DB
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TEST_SNOWSchemaAuto" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage        | queryField                | columnName | queryOperation   | storeResults  |
      | SNOWFLAKE    | STRUCTURED   | json/IDA.json | snowFlakeQueries | getAllSnowflakeTablesInDB | TABLE_NAME | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB



    # 7043454 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#4: Verify the Schema/Table/External Table Name should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TEST_SNOWSchemaAuto" item from search results
    And user "widget not present" on "Metadata" in Item view page
    And user "widget not present" on "Description" in Item view page
    And user enters the search text "SCHOOL" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "SCHOOL" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user enters the search text "snowflakecsvexttable1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "snowflakecsvexttable1" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                           | widgetName  |
      | Table Type        | EXTERNAL                                                | Description |
      | Created by        | PUBLIC                                                  | Description |
      | Location          | s3://asgredshiftworlddata/QA/SnowflakeCSVWithoutHeader/ | Description |
      | Input type        | csv                                                     | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    And user enters the search text "exttable_part" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "exttable_part" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                          | widgetName  |
      | Table Type        | EXTERNAL                               | Description |
      | Created by        | PUBLIC                                 | Description |
      | Location          | s3://asgredshiftworlddata/QA/Snowflake | Description |
      | Input type        | csv                                    | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |



    # 7053942 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#5: Verify the column Name for Table/External Table should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CLASSID" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CLASSID" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | NUMBER        | Description |
      | Length            | 38            | Statistics  |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user enters the search text "COL2" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "exttable_part [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "COL2" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | VARCHAR       | Description |
      | Length            | 16777216      | Statistics  |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |


    # 7053943 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#6: Verify the Constraint item type should have the appropriate metadata information in IDC UI and Database(Table/External Table)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PKEY1" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Constraint Type   | PRIMARY_KEY   | Description |
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "EXTTABLE_PK" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Constraint Type   | PRIMARY_KEY   | Description |




    # 7085437 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#7: Verify the different types of Views should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CreateReplaceView" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CreateReplaceView" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
      | Created by        | PUBLIC        | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    And user enters the search text "CreateViewClass" and clicks on search
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "CreateViewClass" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
      | Created by        | PUBLIC        | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    And user enters the search text "CreateViewScholarSpecific" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CreateViewScholarSpecific" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
      | Created by        | PUBLIC        | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    And user enters the search text "JoinViews" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "JoinViews" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
      | Created by        | PUBLIC        | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    And user enters the search text "SecureView" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "SecureView" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue    | widgetName  |
      | Table Type        | VIEW             | Description |
      | Created by        | PUBLIC           | Description |
      | Comments          | Test secure view | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    And user enters the search text "ForceView" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ForceView" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
      | Created by        | PUBLIC        | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    And user enters the search text "snowflakecsvexttable1view" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "snowflakecsvexttable1view" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
      | Created by        | PUBLIC        | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    And user enters the search text "EMPLOYEE_HIERARCHY_02" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TESTSCHEMA [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "EMPLOYEE_HIERARCHY_02" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
      | Created by        | PUBLIC        | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    And user enters the search text "exttablepartview" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "exttablepartview" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                  | widgetName  |
      | Table Type        | VIEW                           | Description |
      | Created by        | PUBLIC                         | Description |
      | Comments          | Test externaltable secure view | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |


    # 7054046 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#8: Verify Sql Source content should appear under Data widget under different Views collected by SnowflakeCataloger.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CreateReplaceView" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CreateReplaceView" item from search results
    Then user performs click and verify in new window
      | Table     | value             | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | CreateReplaceView | click and switch tab | No               |             |
    Then the "Data" metadata of item "CreateReplaceView" should be as expected
    And user enters the search text "CreateViewClass" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CreateViewClass" item from search results
    Then user performs click and verify in new window
      | Table     | value           | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | CreateViewClass | click and switch tab | No               |             |
    Then the "Data" metadata of item "CreateViewClass" should be as expected
    And user enters the search text "CreateViewScholarSpecific" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CreateViewScholarSpecific" item from search results
    Then user performs click and verify in new window
      | Table     | value                     | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | CreateViewScholarSpecific | click and switch tab | No               |             |
    Then the "Data" metadata of item "CreateViewScholarSpecific" should be as expected
    And user enters the search text "JoinViews" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "JoinViews" item from search results
    Then user performs click and verify in new window
      | Table     | value     | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | JoinViews | click and switch tab | No               |             |
    Then the "Data" metadata of item "JoinViews" should be as expected
    And user enters the search text "SecureView" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "SecureView" item from search results
    Then user performs click and verify in new window
      | Table     | value      | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | SecureView | click and switch tab | No               |             |
    Then the "Data" metadata of item "SecureView" should be as expected
    And user enters the search text "ForceView" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ForceView" item from search results
    Then user performs click and verify in new window
      | Table     | value     | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | ForceView | click and switch tab | No               |             |
    Then the "Data" metadata of item "ForceView" should be as expected
    And user enters the search text "EMPLOYEE_HIERARCHY_02" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TESTSCHEMA [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "EMPLOYEE_HIERARCHY_02" item from search results
    Then user performs click and verify in new window
      | Table     | value                 | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | EMPLOYEE_HIERARCHY_02 | click and switch tab | No               |             |
    Then the "Data" metadata of item "EMPLOYEE_HIERARCHY_02" should be as expected
    And user enters the search text "snowflakecsvexttable1view" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "snowflakecsvexttable1view" item from search results
    Then user performs click and verify in new window
      | Table     | value                     | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | snowflakecsvexttable1view | click and switch tab | No               |             |
    Then the "Data" metadata of item "snowflakecsvexttable1view" should be as expected


  # 7054047 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#9: Verify Table/External Table should not have constraints window if the table is not having any constraints.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user enters the search text "SCHOOL" and clicks on search
    And user performs "item click" on "SCHOOL" item from search results
    And user "widget not present" on "CONSTRAINTS" in Item view page
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user enters the search text "exttable_part" and clicks on search
    And user performs "item click" on "exttable_part" item from search results
    And user "widget not present" on "CONSTRAINTS" in Item view page



    # 7043456 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#10: Verify Table/external table should have constraints window with the Primary Key, Foreign key constraints available.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Scholar" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Scholar" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage        | queryField             | columnName      | queryOperation   | storeResults  |
      | SNOWFLAKE    | STRUCTURED   | json/IDA.json | snowFlakeQueries | getConstraintForTable1 | CONSTRAINT_NAME | returnstringlist | resultsInList |
    And user "verifies" the "Constraints" Item view page result "list" value with Postgres DB
    And user enters the search text "SCHOOL" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "SCHOOL" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage        | queryField             | columnName      | queryOperation   | storeResults  |
      | SNOWFLAKE    | STRUCTURED   | json/IDA.json | snowFlakeQueries | getConstraintForTable2 | CONSTRAINT_NAME | returnstringlist | resultsInList |
    And user "verifies" the "Constraints" Item view page result "list" value with Postgres DB
    And user enters the search text "TestTable" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TestTable" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage        | queryField             | columnName      | queryOperation   | storeResults  |
      | SNOWFLAKE    | STRUCTURED   | json/IDA.json | snowFlakeQueries | getConstraintForTable3 | CONSTRAINT_NAME | returnstringlist | resultsInList |
    And user "verifies" the "Constraints" Item view page result "list" value with Postgres DB
    And user enters the search text "CLASS" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CLASS" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage        | queryField             | columnName      | queryOperation   | storeResults  |
      | SNOWFLAKE    | STRUCTURED   | json/IDA.json | snowFlakeQueries | getConstraintForTable4 | CONSTRAINT_NAME | returnstringlist | resultsInList |
    And user "verifies" the "Constraints" Item view page result "list" value with Postgres DB
    And user enters the search text "snowflakecsvexttable1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "snowflakecsvexttable1" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage        | queryField             | columnName      | queryOperation   | storeResults  |
      | SNOWFLAKE    | STRUCTURED   | json/IDA.json | snowFlakeQueries | getConstraintForTable5 | CONSTRAINT_NAME | returnstringlist | resultsInList |
    And user "verifies" the "Constraints" Item view page result "list" value with Postgres DB

# 7085450 #
  @sanity @positive @MLP-20518 @webtest @IDA-1.1.0
  Scenario: SC#11-Verify the technology tags/explicit tags/business application got assigned to all SnowflakeDBCataloger catalogued items like Cluster,Service,Database,Tables,External table,View...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name     | facet         | Tag                                    | fileName  | userTag         |
      | Default     | Service  | Metadata Type | Snowflake,Snowflake_BA,snowflakeTagSC1 | Snowflake | Snowflake       |
      | Default     | Database | Metadata Type | Snowflake,Snowflake_BA,snowflakeTagSC1 | TEST_DB   | snowflakeTagSC1 |
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "MPKEY" item from search results
    Then user "verify presence" of following "Tag List" in Item View Page
      | Snowflake       |
      | Snowflake_BA    |
      | snowflakeTagSC1 |
    And user enters the search text "CLASSID" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CLASSID" item from search results
    Then user "verify presence" of following "Tag List" in Item View Page
      | Snowflake       |
      | Snowflake_BA    |
      | snowflakeTagSC1 |
    And user enters the search text "CLASS" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CLASS" item from search results
    Then user "verify presence" of following "Tag List" in Item View Page
      | Snowflake       |
      | Snowflake_BA    |
      | snowflakeTagSC1 |
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TEST_SNOWSchemaAuto" item from search results
    Then user "verify presence" of following "Tag List" in Item View Page
      | Snowflake       |
      | Snowflake_BA    |
      | snowflakeTagSC1 |
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "asg_partner.us-east-1.snowflakecomputing.com" item from search results
    Then user "verify presence" of following "Tag List" in Item View Page
      | Snowflake       |
      | Snowflake_BA    |
      | snowflakeTagSC1 |
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Host" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "asg_partner.us-east-1.snowflakecomputing.com" item from search results
    Then user "verify presence" of following "Tag List" in Item View Page
      | Snowflake       |
      | Snowflake_BA    |
      | snowflakeTagSC1 |
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%"
    Then user "verify presence" of following "Tag List" in Item View Page
      | Snowflake       |
      | Snowflake_BA    |
      | snowflakeTagSC1 |
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user enters the search text "snowflakecsvexttable1" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "snowflakecsvexttable1" item from search results
    Then user "verify presence" of following "Tag List" in Item View Page
      | Snowflake       |
      | Snowflake_BA    |
      | snowflakeTagSC1 |
    And user enters the search text "CreateReplaceView" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CreateReplaceView" item from search results
    Then user "verify presence" of following "Tag List" in Item View Page
      | Snowflake       |
      | Snowflake_BA    |
      | snowflakeTagSC1 |


    # 7082884 #
  @webtest @MLP-20518 @sanity @positive @regression
  Scenario:SC#12: Verify SnowflakeDataSource does not scans and collects and any data if warehouse and database are not passed in URL
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Data Sources" in "Add Data source Configuration"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data source Configuration"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute             |
      | Data Source Type | SnowflakeDBDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                       |
      | Name      | SnowflakeDataSourceTest3                                        |
      | Label     | SnowflakeDataSourceTest3                                        |
      | URL       | jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/? |
    And user "Validate the field Error Message" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                                                                                                                                                      | pageName        |
      | URL       | UnSupported Snowflake JDBC URL Format. Sample Format : jdbc:snowflake://<<account.region.snowflakecomputing.com>>/?db=<<database>>&warehouse=<<warehousename>> | Add Data Source |

# 7085450 #
  @sanity @positive @MLP-20518 @webtest @IDA-1.1.0
  Scenario:SC13#Verify log entries/log enhancements(processed Items widget and Processed count) check for SnowflakeDBCataloger plugin logs.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%"
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | asg_partner.us-east-1.snowflakecomputing.com |
      | Snowflake                                    |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | logCode       | pluginName           | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0019 |                      |                |
      | INFO | Plugin Name:SnowflakeDBCataloger, Plugin Type:cataloger, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:76e0225b7b06, Plugin Configuration name:SnowflakeDBCataloger                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0071 | SnowflakeDBCataloger | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: ---  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: name: "SnowflakeDBCataloger"  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: pluginVersion: "LATEST"  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: label:  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: : ""  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: catalogName: "Default"  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: eventClass: null  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: eventCondition: null  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: nodeCondition: "name==\"LocalNode\""  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: maxWorkSize: 100  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: tags:  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: - "snowflakeTagSC1"  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: pluginType: "cataloger"  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: dataSource: "SnowflakeValidDataSource"  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: credential: "ValidSnowflakeCredentials"  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: businessApplicationName: "Snowflake_BA"  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: dryRun: false  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: schedule: null  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: filter: null  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: pluginName: "SnowflakeDBCataloger"  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: schemas: []  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: type: "Cataloger"  2020-09-29 14:01:39.167 INFO  - ANALYSIS-0073: Plugin SnowflakeDBCataloger Configuration: properties: [] | ANALYSIS-0073 | SnowflakeDBCataloger |                |
      | INFO | Plugin SnowflakeDBCataloger Start Time:2020-07-25 14:04:24.944, End Time:2020-07-25 14:12:46.566, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ANALYSIS-0072 | SnowflakeDBCataloger |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:08:21.622)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0020 |                      |                |

  Scenario Outline: SC#14-user retrieves the item ids of Column items of Table: DiffDataTypes and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                | type | targetFile                                   | jsonpath      |
      | APPDBPOSTGRES | Default | NUMBERTYPE          |      | response/snowflake/actual/columnItemIds.json | $..Field1.id  |
      | APPDBPOSTGRES | Default | DECIMALTYPE         |      | response/snowflake/actual/columnItemIds.json | $..Field2.id  |
      | APPDBPOSTGRES | Default | NUMERICTYPE         |      | response/snowflake/actual/columnItemIds.json | $..Field3.id  |
      | APPDBPOSTGRES | Default | INTTYPE             |      | response/snowflake/actual/columnItemIds.json | $..Field4.id  |
      | APPDBPOSTGRES | Default | INTEGERTYPE         |      | response/snowflake/actual/columnItemIds.json | $..Field5.id  |
      | APPDBPOSTGRES | Default | BIGINTTYPE          |      | response/snowflake/actual/columnItemIds.json | $..Field6.id  |
      | APPDBPOSTGRES | Default | SMALLINTTYPE        |      | response/snowflake/actual/columnItemIds.json | $..Field7.id  |
      | APPDBPOSTGRES | Default | FLOATTYPE           |      | response/snowflake/actual/columnItemIds.json | $..Field8.id  |
      | APPDBPOSTGRES | Default | FLOAT4TYPE          |      | response/snowflake/actual/columnItemIds.json | $..Field9.id  |
      | APPDBPOSTGRES | Default | FLOAT8TYPE          |      | response/snowflake/actual/columnItemIds.json | $..Field10.id |
      | APPDBPOSTGRES | Default | DOUBLETYPE          |      | response/snowflake/actual/columnItemIds.json | $..Field11.id |
      | APPDBPOSTGRES | Default | DOUBLEPRECISIONTYPE |      | response/snowflake/actual/columnItemIds.json | $..Field12.id |
      | APPDBPOSTGRES | Default | REALTYPE            |      | response/snowflake/actual/columnItemIds.json | $..Field13.id |
      | APPDBPOSTGRES | Default | VARCHARTYPE         |      | response/snowflake/actual/columnItemIds.json | $..Field14.id |
      | APPDBPOSTGRES | Default | CHARTYPE            |      | response/snowflake/actual/columnItemIds.json | $..Field15.id |
      | APPDBPOSTGRES | Default | CHARACTERTYPE       |      | response/snowflake/actual/columnItemIds.json | $..Field16.id |
      | APPDBPOSTGRES | Default | STRINGTYPE          |      | response/snowflake/actual/columnItemIds.json | $..Field17.id |
      | APPDBPOSTGRES | Default | TEXTTYPE            |      | response/snowflake/actual/columnItemIds.json | $..Field18.id |
      | APPDBPOSTGRES | Default | BINARYTYPE          |      | response/snowflake/actual/columnItemIds.json | $..Field19.id |
      | APPDBPOSTGRES | Default | VARBINARYTYPE       |      | response/snowflake/actual/columnItemIds.json | $..Field20.id |
      | APPDBPOSTGRES | Default | BOOLEANTYPE         |      | response/snowflake/actual/columnItemIds.json | $..Field21.id |
      | APPDBPOSTGRES | Default | DATETYPE            |      | response/snowflake/actual/columnItemIds.json | $..Field22.id |
      | APPDBPOSTGRES | Default | DATETIMETYPE        |      | response/snowflake/actual/columnItemIds.json | $..Field23.id |
      | APPDBPOSTGRES | Default | TIMETYPE            |      | response/snowflake/actual/columnItemIds.json | $..Field24.id |
      | APPDBPOSTGRES | Default | TIMESTAMPTYPE       |      | response/snowflake/actual/columnItemIds.json | $..Field25.id |
      | APPDBPOSTGRES | Default | TIMESTAMPLTZTYPE    |      | response/snowflake/actual/columnItemIds.json | $..Field26.id |
      | APPDBPOSTGRES | Default | TIMESTAMPNTZTYPE    |      | response/snowflake/actual/columnItemIds.json | $..Field27.id |
      | APPDBPOSTGRES | Default | TIMESTAMPTZTYPE     |      | response/snowflake/actual/columnItemIds.json | $..Field28.id |


  Scenario Outline: SC#14-user retrieves the metadata of Column type for a Table: DiffDataTypes
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>" of "<responsePath>"
    Examples:
      | url                                             | responseCode | inputJson    | inputFile                                    | outPutFile                                    | outPutJson                                                 | responsePath                          |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field1.id  | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field1.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field1.id  | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field1.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field2.id  | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field2.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field2.id  | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field2.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field3.id  | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field3.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field3.id  | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field3.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field4.id  | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field4.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field4.id  | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field4.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field5.id  | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field5.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field5.id  | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field5.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field6.id  | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field6.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field6.id  | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field6.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field7.id  | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field7.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field7.id  | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field7.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field8.id  | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field8.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field8.id  | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field8.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field9.id  | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field9.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field9.id  | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field9.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field10.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field10.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field10.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field10.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field11.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field11.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field11.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field11.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field12.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field12.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field12.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field12.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field13.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field13.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field13.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field13.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field14.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field14.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field14.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field14.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field15.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field15.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field15.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field15.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field16.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field16.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field16.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field16.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field17.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field17.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field17.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field17.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field18.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field18.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field18.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field18.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field19.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field19.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field19.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field19.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field20.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field20.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field20.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field20.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field21.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field21.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field21.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field21.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field22.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field22.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field22.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field22.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field23.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field23.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field23.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field23.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field24.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field24.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field24.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field24.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field25.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field25.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field25.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field25.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field26.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field26.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field26.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field26.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field27.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field27.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field27.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field27.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field28.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field28.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field28.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table1.field28.fieldActualDataType | $..[?(@.caption=='Data type')]..value |


  #7082872 #
  Scenario Outline: SC#14-Validate the column level metadata results for a Table: DiffDataTypes in IDC platform
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                             | actualValues                                  | valueType     | expectedJsonPath                               | actualJsonPath                                             |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field1.fieldName      | $..columnActualMetaData.Table1.field1.fieldActualName      |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field1.fieldDataType  | $..columnActualMetaData.Table1.field1.fieldActualDataType  |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field2.fieldName      | $..columnActualMetaData.Table1.field2.fieldActualName      |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field2.fieldDataType  | $..columnActualMetaData.Table1.field2.fieldActualDataType  |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field3.fieldName      | $..columnActualMetaData.Table1.field3.fieldActualName      |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field3.fieldDataType  | $..columnActualMetaData.Table1.field3.fieldActualDataType  |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field4.fieldName      | $..columnActualMetaData.Table1.field4.fieldActualName      |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field4.fieldDataType  | $..columnActualMetaData.Table1.field4.fieldActualDataType  |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field5.fieldName      | $..columnActualMetaData.Table1.field5.fieldActualName      |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field5.fieldDataType  | $..columnActualMetaData.Table1.field5.fieldActualDataType  |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field6.fieldName      | $..columnActualMetaData.Table1.field6.fieldActualName      |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field6.fieldDataType  | $..columnActualMetaData.Table1.field6.fieldActualDataType  |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field7.fieldName      | $..columnActualMetaData.Table1.field7.fieldActualName      |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field7.fieldDataType  | $..columnActualMetaData.Table1.field7.fieldActualDataType  |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field8.fieldName      | $..columnActualMetaData.Table1.field8.fieldActualName      |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field8.fieldDataType  | $..columnActualMetaData.Table1.field8.fieldActualDataType  |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field9.fieldName      | $..columnActualMetaData.Table1.field9.fieldActualName      |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field9.fieldDataType  | $..columnActualMetaData.Table1.field9.fieldActualDataType  |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field10.fieldName     | $..columnActualMetaData.Table1.field10.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field10.fieldDataType | $..columnActualMetaData.Table1.field10.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field11.fieldName     | $..columnActualMetaData.Table1.field11.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field11.fieldDataType | $..columnActualMetaData.Table1.field11.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field12.fieldName     | $..columnActualMetaData.Table1.field12.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field12.fieldDataType | $..columnActualMetaData.Table1.field12.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field13.fieldName     | $..columnActualMetaData.Table1.field13.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field13.fieldDataType | $..columnActualMetaData.Table1.field13.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field14.fieldName     | $..columnActualMetaData.Table1.field14.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field14.fieldDataType | $..columnActualMetaData.Table1.field14.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field15.fieldName     | $..columnActualMetaData.Table1.field15.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field15.fieldDataType | $..columnActualMetaData.Table1.field15.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field16.fieldName     | $..columnActualMetaData.Table1.field16.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field16.fieldDataType | $..columnActualMetaData.Table1.field16.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field17.fieldName     | $..columnActualMetaData.Table1.field17.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field17.fieldDataType | $..columnActualMetaData.Table1.field17.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field18.fieldName     | $..columnActualMetaData.Table1.field18.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field18.fieldDataType | $..columnActualMetaData.Table1.field18.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field19.fieldName     | $..columnActualMetaData.Table1.field19.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field19.fieldDataType | $..columnActualMetaData.Table1.field19.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field20.fieldName     | $..columnActualMetaData.Table1.field20.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field20.fieldDataType | $..columnActualMetaData.Table1.field20.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field21.fieldName     | $..columnActualMetaData.Table1.field21.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field21.fieldDataType | $..columnActualMetaData.Table1.field21.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field22.fieldName     | $..columnActualMetaData.Table1.field22.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field22.fieldDataType | $..columnActualMetaData.Table1.field22.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field23.fieldName     | $..columnActualMetaData.Table1.field23.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field23.fieldDataType | $..columnActualMetaData.Table1.field23.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field24.fieldName     | $..columnActualMetaData.Table1.field24.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field24.fieldDataType | $..columnActualMetaData.Table1.field24.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field25.fieldName     | $..columnActualMetaData.Table1.field25.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field25.fieldDataType | $..columnActualMetaData.Table1.field25.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field26.fieldName     | $..columnActualMetaData.Table1.field26.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field26.fieldDataType | $..columnActualMetaData.Table1.field26.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field27.fieldName     | $..columnActualMetaData.Table1.field27.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field27.fieldDataType | $..columnActualMetaData.Table1.field27.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field28.fieldName     | $..columnActualMetaData.Table1.field28.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field28.fieldDataType | $..columnActualMetaData.Table1.field28.fieldActualDataType |


  Scenario Outline: SC#15-user retrieves the item ids of Column items of Table: DiffDataTypesSemistructured and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name     | type | targetFile                                   | jsonpath     |
      | APPDBPOSTGRES | Default | ARRAY1   |      | response/snowflake/actual/columnItemIds.json | $..Field1.id |
      | APPDBPOSTGRES | Default | VARIANT1 |      | response/snowflake/actual/columnItemIds.json | $..Field2.id |
      | APPDBPOSTGRES | Default | OBJECT1  |      | response/snowflake/actual/columnItemIds.json | $..Field3.id |

  Scenario Outline: SC#15-user retrieves the metadata of Column type for a Table: DiffDataTypesSemiStructured
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>" of "<responsePath>"
    Examples:
      | url                                             | responseCode | inputJson   | inputFile                                    | outPutFile                                    | outPutJson                                                | responsePath                          |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field1.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table2.field1.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field1.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table2.field1.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field2.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table2.field2.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field2.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table2.field2.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field3.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table2.field3.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field3.id | response/snowflake/actual/columnItemIds.json | response/snowflake/actual/columnMetadata.json | $..columnActualMetaData.Table2.field3.fieldActualDataType | $..[?(@.caption=='Data type')]..value |


    #7082872 #
  Scenario Outline: SC#15-Validate the column level metadata results for a Table: DiffDataTypesSemistructured in IDC platform
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                             | actualValues                                  | valueType     | expectedJsonPath                              | actualJsonPath                                            |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table2.field1.fieldName     | $..columnActualMetaData.Table2.field1.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table2.field1.fieldDataType | $..columnActualMetaData.Table2.field1.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table2.field2.fieldName     | $..columnActualMetaData.Table2.field2.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table2.field2.fieldDataType | $..columnActualMetaData.Table2.field2.fieldActualDataType |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table2.field3.fieldName     | $..columnActualMetaData.Table2.field3.fieldActualName     |
      | response/snowflake/expected/snowflakeExpectedJsonData.json | response/snowflake/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table2.field3.fieldDataType | $..columnActualMetaData.Table2.field3.fieldActualDataType |


  @sanity @positive @regression
  Scenario:SC#1-15_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com         | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger% | Analysis |       |       |

#################################################################################################################################################


  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#16: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                                                | path                                               | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerSchemaTableFilterConfiguration | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              |                                                                         |                                                    | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                    | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                                    | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                    | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |

    # 7043464 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#16: Verify JDBC cataloger scans and collects data if schema name and table/external table  name are provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagSC2" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC2" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Schema    | 1     |
      | Table     | 2     |
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | TEST_SNOWSchemaAuto |
    And user enters the search text "snowflakeTagSC2" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC2" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | SCHOOL                |
      | snowflakecsvexttable1 |


  @sanity @positive @regression
  Scenario:SC#16_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com         | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger% | Analysis |       |       |


######################################################################################################################################################
  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#17: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                                                | path                                              | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerSchemaViewFilterConfiguration | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              |                                                                         |                                                   | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |


    # 7082864 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#17: Verify JDBC cataloger scans and collects data if schema name and view name are provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagSchemaView" and clicks on search
    And user performs "facet selection" in "snowflakeTagSchemaView" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Schema    | 1     |
      | Table     | 2     |
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | TEST_SNOWSchemaAuto |
    And user enters the search text "snowflakeTagSchemaView" and clicks on search
    And user performs "facet selection" in "snowflakeTagSchemaView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | CreateReplaceView         |
      | snowflakecsvexttable1view |


  @sanity @positive @regression
  Scenario:SC#17_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com         | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger% | Analysis |       |       |

######################################################################################################################################################
  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#18: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                                                | path                                                  | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerSchemaExtTableFilterConfiguration | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              |                                                                         |                                                       | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                       | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                                       | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                       | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |


    # 7043464 # 7125621 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#18: Verify JDBC cataloger scans and collects data if schema name and external table name are provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagSchemaExtTable1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSchemaExtTable1" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Schema    | 1     |
      | Table     | 1     |
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | TEST_SNOWSchemaAuto |
    And user enters the search text "snowflakecsvexttable1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSchemaExtTable1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | snowflakecsvexttable1 |
    And user performs "item click" on "snowflakecsvexttable1" item from search results
    And user "verifies tab non presence section values" has the following values in "Columns" Tab in Item View page
      | VALUE |

  @sanity @positive @regression
  Scenario:SC#18_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com         | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger% | Analysis |       |       |



######################################################################################################################################################


  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#19: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                                                | path                                          | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerSchemaFilterConfiguration | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              |                                                                         |                                               | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                               | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                               | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                               | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |


  # 7043463 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#19: Verify JDBC cataloger scans and collects data if schema name alone is provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagSC3" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | TEST_SNOWSchemaAuto |
    And user enters the search text "snowflakeTagSC3" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TEST_SNOWSchemaAuto" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage        | queryField                 | columnName | queryOperation   | storeResults  |
      | SNOWFLAKE    | STRUCTURED   | json/IDA.json | snowFlakeQueries | getSnowflakeTablesInSchema | TABLE_NAME | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB


  @sanity @positive @regression
  Scenario:SC#19_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com         | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger% | Analysis |       |       |



    ######################################################################################################################################################

  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#20: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                                                | path                                                  | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerMultipleSchemaFilterConfiguration | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              |                                                                         |                                                       | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                       | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                                       | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                       | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |


    # 7082866 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#20:Verify JDBC cataloger scans and collects data if multiple schema name alone is provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagSC4" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | TEST_SNOWSchemaAuto |
      | TESTSCHEMA          |
    And user enters the search text "snowflakeTagSC4" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TEST_SNOWSchemaAuto" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage        | queryField                 | columnName | queryOperation   | storeResults  |
      | SNOWFLAKE    | STRUCTURED   | json/IDA.json | snowFlakeQueries | getSnowflakeTablesInSchema | TABLE_NAME | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user enters the search text "snowflakeTagSC4" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TESTSCHEMA" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage        | queryField                  | columnName | queryOperation   | storeResults  |
      | SNOWFLAKE    | STRUCTURED   | json/IDA.json | snowFlakeQueries | getSnowflakeTablesInSchema1 | TABLE_NAME | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB


  @sanity @positive @regression
  Scenario:SC#20_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com         | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger% | Analysis |       |       |



######################################################################################################################################################


  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#21: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                                                | path                                                           | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerMultipleSchemawithTableFilterConfiguration | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              |                                                                         |                                                                | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                                | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                                                | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                                | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |


    # 7043465 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#21:  Verify JDBC cataloger scans and collects data if multiple schemas with table/external table in it are provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagSC5" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC5" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | TEST_SNOWSchemaAuto |
      | TESTSCHEMA          |
    And user enters the search text "snowflakeTagSC5" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC5" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | ADULTPEOPLE           |
      | SCHOOL                |
      | snowflakecsvexttable1 |


  @sanity @positive @regression
  Scenario:SC#21_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com         | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger% | Analysis |       |       |



######################################################################################################################################################


  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#22: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                                                | path                                                          | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerMultipleSchemawithViewFilterConfiguration | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              |                                                                         |                                                               | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                               | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                                               | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                               | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |


    # 7082928 # 7053434 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#22:  Verify JDBC cataloger scans and collects data if multiple schemas with views in it are provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagMultipleSchemaView" and clicks on search
    And user performs "facet selection" in "snowflakeTagMultipleSchemaView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | TEST_SNOWSchemaAuto |
      | TESTSCHEMA          |
    And user enters the search text "snowflakeTagMultipleSchemaView" and clicks on search
    And user performs "facet selection" in "snowflakeTagMultipleSchemaView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | CreateViewClass       |
      | SecureView            |
      | EMPLOYEE_HIERARCHY_02 |
      | exttablepartview      |


  @sanity @positive @regression
  Scenario:SC#22_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com         | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger% | Analysis |       |       |



######################################################################################################################################################

  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#23: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                                                | path                                             | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerTableOnlyFilterConfiguration | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              |                                                                         |                                                  | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                  | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                                  | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                  | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |

   # 7043466 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#23:  Verify SnowflakeDBCataloger scans and collects data if table/externaltable name alone is provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagSC6" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC6" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | TEST_SNOWSchemaAuto |
      | TESTSCHEMA          |
    And user enters the search text "snowflakeTagSC6" and clicks on search
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | employee              |
      | snowflakecsvexttable2 |
    And user enters the search text "snowflakeTagSC6" and clicks on search
    And user performs "facet selection" in "TESTSCHEMA [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | employee              |
      | snowflakecsvexttable2 |

  @sanity @positive @regression
  Scenario:SC#23_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com         | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger% | Analysis |       |       |


######################################################################################################################################################


  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#24: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                                                | path                                            | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerViewOnlyFilterConfiguration | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              |                                                                         |                                                 | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                 | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                                 | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                 | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |


  # 7054312 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#24:  Verify JDBC cataloger scans and collects data if view name alone is provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagViewOnlyFilter" and clicks on search
    And user performs "facet selection" in "snowflakeTagViewOnlyFilter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | TEST_SNOWSchemaAuto |
      | TESTSCHEMA          |
    And user enters the search text "snowflakeTagViewOnlyFilter" and clicks on search
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | JoinViews                 |
      | snowflakecsvexttable1view |
    And user enters the search text "snowflakeTagViewOnlyFilter" and clicks on search
    And user performs "facet selection" in "TESTSCHEMA [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | JoinViews                 |
      | snowflakecsvexttable1view |

  @sanity @positive @regression
  Scenario:SC#24_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com         | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger% | Analysis |       |       |


    ######################################################################################################################################################

  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#25: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                                                | path                                                          | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerSchemaWithMultipeTableFilterConfiguration | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              |                                                                         |                                                               | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                               | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                                               | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                               | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |


  # 7054308 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#25: Verify JDBC cataloger scans and collects data if single schema name with multiple table/external table names are provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagSC7" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC7" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | TEST_SNOWSchemaAuto |
    And user enters the search text "snowflakeTagSC7" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC7" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | SCHOOL                |
      | CLASS                 |
      | snowflakecsvexttable1 |

  @sanity @positive @regression
  Scenario:SC#25_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com         | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger% | Analysis |       |       |

######################################################################################################################################################

  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#26: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                                                | path                                                         | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerSchemaWithMultipeViewFilterConfiguration | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              |                                                                         |                                                              | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                              | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                                              | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                              | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |


  # 7054307 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#26: Verify JDBC cataloger scans and collects data if single schema name with multiple view names are provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagSchemaMultipleViewFilter" and clicks on search
    And user performs "facet selection" in "snowflakeTagSchemaMultipleViewFilter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | TEST_SNOWSchemaAuto |
    And user enters the search text "snowflakeTagSchemaMultipleViewFilter" and clicks on search
    And user performs "facet selection" in "snowflakeTagSchemaMultipleViewFilter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | SecureView                |
      | ForceView                 |
      | CreateViewScholarSpecific |
      | snowflakecsvexttable1view |

  @sanity @positive @regression
  Scenario:SC#26_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com         | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger% | Analysis |       |       |


######################################################################################################################################################

# 7085450 #
  @MLP-20518 @webtest @positive @regression @sanity @IDA-10.3 @pluginManager
  Scenario: SC#27- Verify proper error message is shown if mandatory fields are not filled in SnowflakeDBCataloger configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute            |
      | Type      | Cataloger            |
      | Plugin    | SnowflakeDBCataloger |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


      # 7085450 #
  @MLP-20518 @webtest @positive @regression
  Scenario: SC#28- Verify if all the mandatory fields (Name) are throwing with proper error message if they are left blank in SnowflakeDatasource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Data Sources" in "Add Data source Configuration"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data source Configuration"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute             |
      | Data Source Type | SnowflakeDBDataSource |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage             |
      | URL       | URL field should not be empty |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                                          |
      | Name      | Test Data source                                                                   |
      | URL       | jdbc:teradata://didtde01v.did.dev.asgint.loc/TMODE=ANSI,CHARSET=ASCII,database=DBC |
    And user "Validate the field Error Message" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                                                                                                                                                      | pageName        |
      | URL       | UnSupported Snowflake JDBC URL Format. Sample Format : jdbc:snowflake://<<account.region.snowflakecomputing.com>>/?db=<<database>>&warehouse=<<warehousename>> | Add Data Source |
    And user "enter text" in Add Data Source Page
      | fieldName          | attribute                                                                                   |
      | URL                | jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB |
      | Driver Bundle Name | com.teradata.jdbc.TeraDriver                                                                |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                 |
      | Credential | ValidSnowflakeCredentials |
      | Node       | LocalNode                 |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Error while loading JDBC Driver com.teradata.jdbc.TeraDriver. com.teradata.jdbc.TeraDriver not found by net.snowflake.client.jdbc.SnowflakeDriver [366]" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Add Configuration pop up"

#####################################################################################################################################################

  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#29: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                                                | path                                            | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerNoFilterDryRunConfiguration | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              |                                                                         |                                                 | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                 | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                                 | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                 | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |


     # 7085450 #
  @MLP-20518 @webtest @aws @regression @sanity @IDA-1.1.0
  Scenario: SC#29- Verify SnowflakeDBCataloger doesn't collects Cluster,Service,Database,Table,Column,Constraint when SnowflakeDBCataloger is run with dryrun as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagDryRun" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service    |
      | Cluster    |
      | Database   |
      | Table      |
      | Column     |
      | Constraint |
      | Schema     |
    And user enters the search text "snowflake" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%" should display below info/error/warning
      | type | logValue                                                                                        | logCode       | pluginName           | removableText |
      | INFO | Plugin SnowflakeDBCataloger running on dry run mode                                             | ANALYSIS-0069 | SnowflakeDBCataloger |               |
      | INFO | Plugin SnowflakeDBCataloger processed 2 items on dry run mode and not written to the repository | ANALYSIS-0070 | SnowflakeDBCataloger |               |

  @sanity @positive @regression
  Scenario:SC#29_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com         | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger% | Analysis |       |       |


    ######################################################################################################################################################

    # 7085450 #
  @MLP-20518 @webtest @regression
  Scenario: SC30#-Verify the SnowflakeDbCataloger does not collect any items when an Invalid Datasource(with wrong Credentials) and Invalid Credentials are used in the Plugin Configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                                                            | response code | response message | jsonPath                                                  |
      | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                  | ida/snowflakePayloads/DataSource/SnowflakeInValidDataSourceConfig.json                          | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/SnowflakeDBDataSource                                                  |                                                                                                 | 200           |                  | SnowflakeInValidDataSource                                |
      |                  |       |       | Put          | settings/analyzers/SnowflakeDBCataloger                                                   | ida/snowflakePayloads/PluginConfiguration/SnowflakeCatalogerInvalidDataSourceConfiguration.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/SnowflakeDBCataloger                                                   |                                                                                                 | 200           |                  | SnowflakeDBCataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  | ida/snowflakePayloads/empty.json                                                                | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 2             |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%" should display below info/error/warning
      | type | logValue                                                                                                                                  | logCode       | pluginName           | removableText |
      | INFO | Plugin SnowflakeDBCataloger Start Time:2020-03-05 18:44:12.750, End Time:2020-03-05 18:44:18.209, Processed Count:0, Errors:2, Warnings:0 | ANALYSIS-0072 | SnowflakeDBCataloger |               |
    And user clicks on logout button

##################################################################################################################################################

  @sanity @positive
  Scenario: SC#31-Configure the Snowflake Datasource in internal node
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                      | body                                                                             | response code | response message | jsonPath                         |
      | application/json | raw   | false | Put  | settings/analyzers/SnowflakeDBDataSource | ida/snowflakePayloads/DataSource/SnowflakeValidDataSourceInternalNodeConfig.json | 204           |                  |                                  |
      |                  |       |       | Get  | settings/analyzers/SnowflakeDBDataSource |                                                                                  | 200           |                  | SnowflakeValidDataSourceInternal |

 # 7085450 #
  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#31: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                          | bodyFile                                                                | path                                                  | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                                 | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerNoFilterInternalNodeConfiguration | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger    |                                                                         |                                                       | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                                 |                                                                         |                                                       | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                       | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                                       | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                       | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |



# 7082864 #
  @webtest @MLP-20518 @sanity @positive @regression @snowflake
  Scenario:SC#31: Verify SnowflakeDBCataloger scans and collects data if schema name and table name are provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagInternal" and clicks on search
    And user performs "facet selection" in "snowflakeTagInternal" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Schema    | 1     |
      | Table     | 1     |
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | TEST_SNOWSchemaAuto |
    And user enters the search text "snowflakeTagInternal" and clicks on search
    And user performs "facet selection" in "snowflakeTagInternal" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | SCHOOL |


  @sanity @positive @regression
  Scenario:SC#31_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com         | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger% | Analysis |       |       |


##################################################################################################################################################

  @sanity @positive
  Scenario: SC#32-Configure the Snowflake Datasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                      | body                                                                 | response code | response message | jsonPath                 |
      | application/json | raw   | false | Put  | settings/analyzers/SnowflakeDBDataSource | ida/snowflakePayloads/DataSource/SnowflakeValidDataSourceConfig.json | 204           |                  |                          |
      |                  |       |       | Get  | settings/analyzers/SnowflakeDBDataSource |                                                                      | 200           |                  | SnowflakeValidDataSource |

  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#32: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                                                | path                                                     | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerNonExistingSchemaFilterConfiguration | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                              |                                                                         |                                                          | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                          | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                                          | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger |                                                                         |                                                          | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |


    #7085450 #
  @MLP-20518 @webtest @aws @regression @sanity @IDA-1.1.0
  Scenario:SC32#Validate the processed count and processed widget item presence in platform for invalid schema in configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeValidation" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service    |
      | Cluster    |
      | Database   |
      | Table      |
      | Column     |
      | Constraint |
      | Schema     |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis |
    And user clicks on first item on the item list page
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%" should display below info/error/warning
      | type | logValue                                                                                                                                                 | logCode       | pluginName           | removableText |
      | INFO | ANALYSIS-0072: Plugin SnowflakeDBCataloger Start Time:2020-04-17 13:27:47.492, End Time:2020-04-17 13:27:51.204, Processed Count:0, Errors:0, Warnings:1 | ANALYSIS-0072 | SnowflakeDBCataloger |               |


  Scenario Outline: SC32#user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                | type | targetFile                             | jsonpath                    |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/%DYN |      | response/snowflake/actual/itemIds.json | $..has_CatalogerAnalysis.id |

  Scenario Outline: SC32#user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                              |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/snowflake/actual/itemIds.json |

################################################################################################################################################
#Snowflake Analyzer cases

  @sanity @positive
  Scenario: SC#33-Configure the Snowflake Datasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                      | body                                                                 | response code | response message | jsonPath                 |
      | application/json | raw   | false | Put  | settings/license                         | ida/snowflakePayloads/license.json                                   | 204           |                  |                          |
      |                  |       |       | Put  | settings/analyzers/SnowflakeDBDataSource | ida/snowflakePayloads/DataSource/SnowflakeValidDataSourceConfig.json | 204           |                  |                          |
      |                  |       |       | Get  | settings/analyzers/SnowflakeDBDataSource |                                                                      | 200           |                  | SnowflakeValidDataSource |


  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#33: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                | path                                      | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerNoFilterConfiguration | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               |                                                                         |                                           | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                           | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger   |                                                                         |                                           | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                           | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 | payloads/ida/snowflakePayloads/PluginConfiguration/AnalyzerConfig.json  | $.SnowflakeAnalyzerSingleSchemaFilter     | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 |                                                                         |                                           | 200           | SnowflakeDBAnalyzer  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                         |                                           | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                         |                                           | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                         |                                           | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |

  # 7043469 # 7043470  #
  Scenario Outline:SC#33:user get the Dynamic ID's (Database ID) for the Keyspaces "Snowflake DB" and table "DiffDataTypes"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type   | name                | asg_scopeid               | targetFile                                                 | jsonpath                                               |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | TEST_SNOWSchemaAuto | DiffDataTypes             | payloads/ida/snowflakePayloads/DataSample/SC33_ItemID.json | $.Schema.TEST_SNOWSchemaAuto.DiffDataTypes             |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | TEST_SNOWSchemaAuto | DiffDataTypesView         | payloads/ida/snowflakePayloads/DataSample/SC33_ItemID.json | $.Schema.TEST_SNOWSchemaAuto.DiffDataTypesView         |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | TEST_SNOWSchemaAuto | snowflakecsvexttable1     | payloads/ida/snowflakePayloads/DataSample/SC33_ItemID.json | $.Schema.TEST_SNOWSchemaAuto.snowflakecsvexttable1     |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | TEST_SNOWSchemaAuto | snowflakecsvexttable1view | payloads/ida/snowflakePayloads/DataSample/SC33_ItemID.json | $.Schema.TEST_SNOWSchemaAuto.snowflakecsvexttable1view |


  Scenario Outline: SC#33:user hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                                              | inputFile                                                  | outPutFile                                                                           | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Schema.TEST_SNOWSchemaAuto.DiffDataTypes             | payloads/ida/snowflakePayloads/DataSample/SC33_ItemID.json | payloads/ida/snowflakePayloads/DataSample/SC33_DiffDataTypes_Actual.json             |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Schema.TEST_SNOWSchemaAuto.DiffDataTypesView         | payloads/ida/snowflakePayloads/DataSample/SC33_ItemID.json | payloads/ida/snowflakePayloads/DataSample/SC33_DiffDataTypesView_Actual.json         |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Schema.TEST_SNOWSchemaAuto.snowflakecsvexttable1     | payloads/ida/snowflakePayloads/DataSample/SC33_ItemID.json | payloads/ida/snowflakePayloads/DataSample/SC33_snowflakecsvexttable1_Actual.json     |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Schema.TEST_SNOWSchemaAuto.snowflakecsvexttable1view | payloads/ida/snowflakePayloads/DataSample/SC33_ItemID.json | payloads/ida/snowflakePayloads/DataSample/SC33_snowflakecsvexttable1view_Actual.json |            |

  Scenario: SC#34 Verify the DataSamples values are as expected
    Then file content in "ida/snowflakePayloads/DataSample/SC33_DiffDataTypes_Actual.json" should be same as the content in "ida/snowflakePayloads/DataSample/SC33_DiffDataTypes_Expected.json"
    Then file content in "ida/snowflakePayloads/DataSample/SC33_DiffDataTypesView_Actual.json " should be same as the content in "ida/snowflakePayloads/DataSample/SC33_DiffDataTypesView_Expected.json"
    Then file content in "ida/snowflakePayloads/DataSample/SC33_snowflakecsvexttable1_Actual.json" should be same as the content in "ida/snowflakePayloads/DataSample/SC33_snowflakecsvexttable1_Expected.json"
    Then file content in "ida/snowflakePayloads/DataSample/SC33_snowflakecsvexttable1view_Actual.json" should be same as the content in "ida/snowflakePayloads/DataSample/SC33_snowflakecsvexttable1view_Expected.json"



##   # 7043471 #
  @positve @regression @sanity @webtest
  Scenario:SC35#Verify the data profiling metadata information for string datatype in snowflakeDB table
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "STRINGTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 16777216      | Statistics  |
      | Maximum length                | 12            | Statistics  |
      | Maximum value                 | zxample word  | Statistics  |
      | Minimum length                | 12            | Statistics  |
      | Minimum value                 | axample word  | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user enters the search text "STRINGTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "STRINGTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 16777216      | Statistics  |
      | Maximum length                | 3             | Statistics  |
      | Maximum value                 | mno           | Statistics  |
      | Minimum length                | 3             | Statistics  |
      | Minimum value                 | abc           | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget not present" on "Most frequent values" in Item view page

 # 7043472 #
  @positve @regression @sanity @webtest
  Scenario:SC36#Verify the data profiling metadata information for string datatype in snowflakeDB view
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "CHARTYPE" and clicks on search
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CHARTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 20            | Statistics  |
      | Maximum length                | 3             | Statistics  |
      | Maximum value                 | hjk           | Statistics  |
      | Minimum length                | 3             | Statistics  |
      | Minimum value                 | abc           | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user enters the search text "STRINGTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1view [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "STRINGTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 16777216      | Statistics  |
      | Maximum length                | 3             | Statistics  |
      | Maximum value                 | mno           | Statistics  |
      | Minimum length                | 3             | Statistics  |
      | Minimum value                 | abc           | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
#    And user "widget not present" on "Most frequent values" in Item view page

  # 7043371 #
  @positve @regression @sanity @webtest
  Scenario:SC37#Verify the data profiling metadata information for numeric datatypes in snowflake table.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BIGINTTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMBER        | Description |
      | Average                       | 6125          | Statistics  |
      | Length                        | 38            | Statistics  |
      | Maximum value                 | 7500          | Statistics  |
      | Median                        | 6000          | Statistics  |
      | Minimum value                 | 5000          | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Standard deviation            | 1108.68       | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 1229166.67    | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DECIMALTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DECIMALTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMBER        | Description |
      | Average                       | 38            | Statistics  |
      | Length                        | 6             | Statistics  |
      | Maximum value                 | 60.50         | Statistics  |
      | Median                        | 35.5          | Statistics  |
      | Minimum value                 | 20.50         | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Standard deviation            | 17.08         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 291.67        | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "FLOAT4TYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "FLOAT4TYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | FLOAT         | Description |
      | Average                       | 450.5         | Statistics  |
      | Length                        | 0             | Statistics  |
      | Maximum value                 | 650.5         | Statistics  |
      | Median                        | 425.5         | Statistics  |
      | Minimum value                 | 300.5         | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Standard deviation            | 147.2         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 21666.67      | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "BIGINTTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "BIGINTTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMBER        | Description |
      | Average                       | 735353        | Statistics  |
      | Length                        | 38            | Statistics  |
      | Maximum value                 | 935353        | Statistics  |
      | Median                        | 735353        | Statistics  |
      | Minimum value                 | 535353        | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 158113.88     | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 25000000000   | Statistics  |
    And user "widget not present" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DOUBLETYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "DOUBLETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | FLOAT         | Description |
      | Average                       | 300.5         | Statistics  |
      | Length                        | 0             | Statistics  |
      | Maximum value                 | 500.5         | Statistics  |
      | Median                        | 300.5         | Statistics  |
      | Minimum value                 | 100.5         | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 158.11        | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 25000         | Statistics  |
    And user "widget not present" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page

 # 7043472 #
  @positve @regression @sanity @webtest
  Scenario:SC38#Verify the data profiling metadata information for numeric datatypes in snowflake view.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user enters the search text "BIGINTTYPE" and clicks on search
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "BIGINTTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMBER        | Description |
      | Average                       | 6125          | Statistics  |
      | Length                        | 38            | Statistics  |
      | Maximum value                 | 7500          | Statistics  |
      | Median                        | 6000          | Statistics  |
      | Minimum value                 | 5000          | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Standard deviation            | 1108.68       | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 1229166.67    | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user enters the search text "DECIMALTYPE" and clicks on search
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "DECIMALTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMBER        | Description |
      | Average                       | 38            | Statistics  |
      | Length                        | 6             | Statistics  |
      | Maximum value                 | 60.50         | Statistics  |
      | Median                        | 35.5          | Statistics  |
      | Minimum value                 | 20.50         | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Standard deviation            | 17.08         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 291.67        | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user enters the search text "FLOAT4TYPE" and clicks on search
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "FLOAT4TYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | FLOAT         | Description |
      | Average                       | 450.5         | Statistics  |
      | Length                        | 0             | Statistics  |
      | Maximum value                 | 650.5         | Statistics  |
      | Median                        | 425.5         | Statistics  |
      | Minimum value                 | 300.5         | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Standard deviation            | 147.2         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 21666.67      | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "BIGINTTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "BIGINTTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMBER        | Description |
      | Average                       | 735353        | Statistics  |
      | Length                        | 38            | Statistics  |
      | Maximum value                 | 935353        | Statistics  |
      | Median                        | 735353        | Statistics  |
      | Minimum value                 | 535353        | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 158113.88     | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 25000000000   | Statistics  |
    And user "widget not present" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DOUBLETYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "DOUBLETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | FLOAT         | Description |
      | Average                       | 300.5         | Statistics  |
      | Length                        | 0             | Statistics  |
      | Maximum value                 | 500.5         | Statistics  |
      | Median                        | 300.5         | Statistics  |
      | Minimum value                 | 100.5         | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 158.11        | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 25000         | Statistics  |
    And user "widget not present" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page

 # 7043371 #
  @positve @regression @sanity @webtest
  Scenario:SC39#Verify the data profiling metadata information for Data,time and timestamp datatypes in snowflake table.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "DATETYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "DATETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DATE          | Description |
      | Length                        | 0             | Statistics  |
      | Maximum value                 | 2020-01-01    | Statistics  |
      | Minimum value                 | 1998-01-01    | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMETYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TIME          | Description |
      | Length                        | 9             | Statistics  |
      | Maximum value                 | 13:00:00      | Statistics  |
      | Minimum value                 | 12:00:00      | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_NTZ           | Description |
      | Length                        | 9                       | Statistics  |
      | Maximum value                 | 2018-01-01 12:00:00.000 | Statistics  |
      | Minimum value                 | 2011-01-01 12:00:00.000 | Statistics  |
      | Number of non null values     | 4                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 4                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPLTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPLTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                 | widgetName  |
      | Data type                     | TIMESTAMP_LTZ                 | Description |
      | Length                        | 9                             | Statistics  |
      | Maximum value                 | 2015-01-02 08:00:00.000 -0800 | Statistics  |
      | Minimum value                 | 2011-12-02 08:00:00.000 -0800 | Statistics  |
      | Number of non null values     | 4                             | Statistics  |
      | Percentage of non null values | 100                           | Statistics  |
      | Number of null values         | 0                             | Statistics  |
      | Number of unique values       | 4                             | Statistics  |
      | Percentage of unique values   | 100                           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPNTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPNTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_NTZ           | Description |
      | Length                        | 9                       | Statistics  |
      | Maximum value                 | 2020-02-03 12:00:00.000 | Statistics  |
      | Minimum value                 | 2000-02-03 12:00:00.000 | Statistics  |
      | Number of non null values     | 4                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 4                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                 | widgetName  |
      | Data type                     | TIMESTAMP_TZ                  | Description |
      | Length                        | 9                             | Statistics  |
      | Maximum value                 | 2016-02-03 12:00:00.000 +1305 | Statistics  |
      | Minimum value                 | 2012-08-23 12:30:00.000 +1305 | Statistics  |
      | Number of non null values     | 4                             | Statistics  |
      | Percentage of non null values | 100                           | Statistics  |
      | Number of null values         | 0                             | Statistics  |
      | Number of unique values       | 4                             | Statistics  |
      | Percentage of unique values   | 100                           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "DATETYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "DATETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DATE          | Description |
      | Length                        | 0             | Statistics  |
      | Maximum value                 | 2017-07-07    | Statistics  |
      | Minimum value                 | 2013-03-03    | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget not present" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page

  # 7043472 #
  @positive @regression @sanity @webtest
  Scenario:SC40#Verify the data profiling metadata information for Date,time and timestamp datatypes in snowflake view.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "DATETYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "DATETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DATE          | Description |
      | Length                        | 0             | Statistics  |
      | Maximum value                 | 2020-01-01    | Statistics  |
      | Minimum value                 | 1998-01-01    | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMETYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TIME          | Description |
      | Length                        | 9             | Statistics  |
      | Maximum value                 | 13:00:00      | Statistics  |
      | Minimum value                 | 12:00:00      | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_NTZ           | Description |
      | Length                        | 9                       | Statistics  |
      | Maximum value                 | 2018-01-01 12:00:00.000 | Statistics  |
      | Minimum value                 | 2011-01-01 12:00:00.000 | Statistics  |
      | Number of non null values     | 4                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 4                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPLTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPLTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                 | widgetName  |
      | Data type                     | TIMESTAMP_LTZ                 | Description |
      | Length                        | 9                             | Statistics  |
      | Maximum value                 | 2015-01-02 08:00:00.000 -0800 | Statistics  |
      | Minimum value                 | 2011-12-02 08:00:00.000 -0800 | Statistics  |
      | Number of non null values     | 4                             | Statistics  |
      | Percentage of non null values | 100                           | Statistics  |
      | Number of null values         | 0                             | Statistics  |
      | Number of unique values       | 4                             | Statistics  |
      | Percentage of unique values   | 100                           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPNTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPNTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_NTZ           | Description |
      | Length                        | 9                       | Statistics  |
      | Maximum value                 | 2020-02-03 12:00:00.000 | Statistics  |
      | Minimum value                 | 2000-02-03 12:00:00.000 | Statistics  |
      | Number of non null values     | 4                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 4                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                 | widgetName  |
      | Data type                     | TIMESTAMP_TZ                  | Description |
      | Length                        | 9                             | Statistics  |
      | Maximum value                 | 2016-02-03 12:00:00.000 +1305 | Statistics  |
      | Minimum value                 | 2012-08-23 12:30:00.000 +1305 | Statistics  |
      | Number of non null values     | 4                             | Statistics  |
      | Percentage of non null values | 100                           | Statistics  |
      | Number of null values         | 0                             | Statistics  |
      | Number of unique values       | 4                             | Statistics  |
      | Percentage of unique values   | 100                           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "DATETYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1view [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "DATETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DATE          | Description |
      | Length                        | 0             | Statistics  |
      | Maximum value                 | 2017-07-07    | Statistics  |
      | Minimum value                 | 2013-03-03    | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMETYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1view [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TIME          | Description |
      | Length                        | 9             | Statistics  |
      | Maximum value                 | 00:45:00      | Statistics  |
      | Minimum value                 | 00:25:00      | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 40            | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMETYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1view [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TIME          | Description |
      | Length                        | 9             | Statistics  |
      | Maximum value                 | 00:45:00      | Statistics  |
      | Minimum value                 | 00:25:00      | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 40            | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPLTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1view [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPLTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                 | widgetName  |
      | Data type                     | TIMESTAMP_LTZ                 | Description |
      | Length                        | 9                             | Statistics  |
      | Maximum value                 | 2017-07-07 00:00:00.000 -0700 | Statistics  |
      | Minimum value                 | 2013-03-03 00:00:00.000 -0800 | Statistics  |
      | Number of non null values     | 5                             | Statistics  |
      | Percentage of non null values | 100                           | Statistics  |
      | Number of null values         | 0                             | Statistics  |
      | Number of unique values       | 5                             | Statistics  |
      | Percentage of unique values   | 100                           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPNTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1view [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPNTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_NTZ           | Description |
      | Length                        | 9                       | Statistics  |
      | Maximum value                 | 2017-07-07 00:00:00.000 | Statistics  |
      | Minimum value                 | 2013-03-03 00:00:00.000 | Statistics  |
      | Number of non null values     | 5                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 5                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1view [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                 | widgetName  |
      | Data type                     | TIMESTAMP_TZ                  | Description |
      | Length                        | 9                             | Statistics  |
      | Maximum value                 | 2017-07-07 00:00:00.000 -0700 | Statistics  |
      | Minimum value                 | 2013-03-03 00:00:00.000 -0800 | Statistics  |
      | Number of non null values     | 5                             | Statistics  |
      | Percentage of non null values | 100                           | Statistics  |
      | Number of null values         | 0                             | Statistics  |
      | Number of unique values       | 5                             | Statistics  |
      | Percentage of unique values   | 100                           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page


  @sanity @positive @regression
  Scenario:SC#33-40_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer% | Analysis |       |       |


##################################################################################################################################################

  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#41: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                | path                                       | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerNoFilterConfiguration  | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               |                                                                         |                                            | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                            | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger   |                                                                         |                                            | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                            | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 | payloads/ida/snowflakePayloads/PluginConfiguration/AnalyzerConfig.json  | $.SnowflakeAnalyzerSingleSchemaTableFilter | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 |                                                                         |                                            | 200           | SnowflakeDBAnalyzer  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                         |                                            | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                         |                                            | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                         |                                            | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |

  # 7082938 #
  Scenario Outline:SC#41:user get the Dynamic ID's (Database ID) for the Keyspaces "Snowflake DB" and table "DiffDataTypes"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type   | name                | asg_scopeid   | targetFile                                                 | jsonpath                                   |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | TEST_SNOWSchemaAuto | DiffDataTypes | payloads/ida/snowflakePayloads/DataSample/SC41_ItemID.json | $.Schema.TEST_SNOWSchemaAuto.DiffDataTypes |


  Scenario Outline: SC#41:user hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                                  | inputFile                                                  | outPutFile                                                               | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Schema.TEST_SNOWSchemaAuto.DiffDataTypes | payloads/ida/snowflakePayloads/DataSample/SC41_ItemID.json | payloads/ida/snowflakePayloads/DataSample/SC41_DiffDataTypes_Actual.json |            |

  Scenario: SC#41 Verify the DataSamples values are as expected
    Then file content in "ida/snowflakePayloads/DataSample/SC41_DiffDataTypes_Actual.json" should be same as the content in "ida/snowflakePayloads/DataSample/SC41_DiffDataTypes_Expected.json"


  # 7038738 #
  @positve @regression @sanity @webtest
  Scenario:SC42#Verify the data profiling metadata information for string datatype if SnowflakeDBAnalyzer is run successfully with single schema and table filter
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "STRINGTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 16777216      | Statistics  |
      | Maximum length                | 12            | Statistics  |
      | Maximum value                 | zxample word  | Statistics  |
      | Minimum length                | 12            | Statistics  |
      | Minimum value                 | axample word  | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page

# 7038738 #
  @positve @regression @sanity @webtest
  Scenario:SC43#Verify the data profiling metadata information for numeric datatypes in snowflake table if snowflakeAnalyzer is ran with single schema/table filters.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BIGINTTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BIGINTTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMBER        | Description |
      | Average                       | 6125          | Statistics  |
      | Length                        | 38            | Statistics  |
      | Maximum value                 | 7500          | Statistics  |
      | Median                        | 6000          | Statistics  |
      | Minimum value                 | 5000          | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Standard deviation            | 1108.68       | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 1229166.67    | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DECIMALTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DECIMALTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMBER        | Description |
      | Average                       | 38            | Statistics  |
      | Length                        | 6             | Statistics  |
      | Maximum value                 | 60.50         | Statistics  |
      | Median                        | 35.5          | Statistics  |
      | Minimum value                 | 20.50         | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Standard deviation            | 17.08         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 291.67        | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "FLOAT4TYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "FLOAT4TYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | FLOAT         | Description |
      | Average                       | 450.5         | Statistics  |
      | Length                        | 0             | Statistics  |
      | Maximum value                 | 650.5         | Statistics  |
      | Median                        | 425.5         | Statistics  |
      | Minimum value                 | 300.5         | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Standard deviation            | 147.2         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 21666.67      | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page

# 7038738 #
  @positve @regression @sanity @webtest
  Scenario:SC44#Verify the data profiling metadata information for Data,time and timestamp datatypes in snowflake table if snowflakeAnalyzer is ran with single schema/table filter.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "DATETYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DATETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DATE          | Description |
      | Length                        | 0             | Statistics  |
      | Maximum value                 | 2020-01-01    | Statistics  |
      | Minimum value                 | 1998-01-01    | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMETYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TIMETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TIME          | Description |
      | Length                        | 9             | Statistics  |
      | Maximum value                 | 13:00:00      | Statistics  |
      | Minimum value                 | 12:00:00      | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_NTZ           | Description |
      | Length                        | 9                       | Statistics  |
      | Maximum value                 | 2018-01-01 12:00:00.000 | Statistics  |
      | Minimum value                 | 2011-01-01 12:00:00.000 | Statistics  |
      | Number of non null values     | 4                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 4                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPLTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPLTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                 | widgetName  |
      | Data type                     | TIMESTAMP_LTZ                 | Description |
      | Length                        | 9                             | Statistics  |
      | Maximum value                 | 2015-01-02 08:00:00.000 -0800 | Statistics  |
      | Minimum value                 | 2011-12-02 08:00:00.000 -0800 | Statistics  |
      | Number of non null values     | 4                             | Statistics  |
      | Percentage of non null values | 100                           | Statistics  |
      | Number of null values         | 0                             | Statistics  |
      | Number of unique values       | 4                             | Statistics  |
      | Percentage of unique values   | 100                           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPNTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPNTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_NTZ           | Description |
      | Length                        | 9                       | Statistics  |
      | Maximum value                 | 2020-02-03 12:00:00.000 | Statistics  |
      | Minimum value                 | 2000-02-03 12:00:00.000 | Statistics  |
      | Number of non null values     | 4                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 4                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                 | widgetName  |
      | Data type                     | TIMESTAMP_TZ                  | Description |
      | Length                        | 9                             | Statistics  |
      | Maximum value                 | 2016-02-03 12:00:00.000 +1305 | Statistics  |
      | Minimum value                 | 2012-08-23 12:30:00.000 +1305 | Statistics  |
      | Number of non null values     | 4                             | Statistics  |
      | Percentage of non null values | 100                           | Statistics  |
      | Number of null values         | 0                             | Statistics  |
      | Number of unique values       | 4                             | Statistics  |
      | Percentage of unique values   | 100                           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page


  @sanity @positive @regression
  Scenario:SC#41-44_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer% | Analysis |       |       |


###################################################################################################################################################


  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#45: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                | path                                      | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerNoFilterConfiguration | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               |                                                                         |                                           | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                           | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger   |                                                                         |                                           | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                           | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 | payloads/ida/snowflakePayloads/PluginConfiguration/AnalyzerConfig.json  | $.SnowflakeAnalyzerSingleSchemaViewFilter | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 |                                                                         |                                           | 200           | SnowflakeDBAnalyzer  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                         |                                           | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                         |                                           | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                         |                                           | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |


  # 7082940 #
  Scenario Outline:SC#45:user get the Dynamic ID's (Database ID) for the Keyspaces "Snowflake DB" and table "DiffDataTypes"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type   | name                | asg_scopeid       | targetFile                                                 | jsonpath                                       |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | TEST_SNOWSchemaAuto | DiffDataTypesView | payloads/ida/snowflakePayloads/DataSample/SC45_ItemID.json | $.Schema.TEST_SNOWSchemaAuto.DiffDataTypesView |


  Scenario Outline: SC#45:user hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                                      | inputFile                                                  | outPutFile                                                                   | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Schema.TEST_SNOWSchemaAuto.DiffDataTypesView | payloads/ida/snowflakePayloads/DataSample/SC45_ItemID.json | payloads/ida/snowflakePayloads/DataSample/SC45_DiffDataTypesView_Actual.json |            |

  Scenario: SC#45 Verify the DataSamples values are as expected
    Then file content in "ida/snowflakePayloads/DataSample/SC45_DiffDataTypesView_Actual.json" should be same as the content in "ida/snowflakePayloads/DataSample/SC45_DiffDataTypesView_Expected.json"


#7038740 #
  @positve @regression @sanity @webtest
  Scenario:SC46#Verify the data profiling metadata information for string datatype if SnowflakeDBAnalyzer is run successfully with single schema and view filter
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "STRINGTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 16777216      | Statistics  |
      | Maximum length                | 12            | Statistics  |
      | Maximum value                 | zxample word  | Statistics  |
      | Minimum length                | 12            | Statistics  |
      | Minimum value                 | axample word  | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page

# 7038740 #
  @positve @regression @sanity @webtest
  Scenario:SC47#Verify the data profiling metadata information for numeric datatypes in snowflake table if snowflakeAnalyzer is ran with single schema/view filters.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagSC1" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BIGINTTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMBER        | Description |
      | Average                       | 6125          | Statistics  |
      | Length                        | 38            | Statistics  |
      | Maximum value                 | 7500          | Statistics  |
      | Median                        | 6000          | Statistics  |
      | Minimum value                 | 5000          | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Standard deviation            | 1108.68       | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 1229166.67    | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DECIMALTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DECIMALTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMBER        | Description |
      | Average                       | 38            | Statistics  |
      | Length                        | 6             | Statistics  |
      | Maximum value                 | 60.50         | Statistics  |
      | Median                        | 35.5          | Statistics  |
      | Minimum value                 | 20.50         | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Standard deviation            | 17.08         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 291.67        | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "FLOAT4TYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "FLOAT4TYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | FLOAT         | Description |
      | Average                       | 450.5         | Statistics  |
      | Length                        | 0             | Statistics  |
      | Maximum value                 | 650.5         | Statistics  |
      | Median                        | 425.5         | Statistics  |
      | Minimum value                 | 300.5         | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Standard deviation            | 147.2         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 21666.67      | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page

# 7038740 #
  @positve @regression @sanity @webtest
  Scenario:SC48#Verify the data profiling metadata information for Data,time and timestamp datatypes in snowflake table if snowflakeAnalyzer is ran with single schema/view filter.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "DATETYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DATETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DATE          | Description |
      | Length                        | 0             | Statistics  |
      | Maximum value                 | 2020-01-01    | Statistics  |
      | Minimum value                 | 1998-01-01    | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMETYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TIMETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TIME          | Description |
      | Length                        | 9             | Statistics  |
      | Maximum value                 | 13:00:00      | Statistics  |
      | Minimum value                 | 12:00:00      | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_NTZ           | Description |
      | Length                        | 9                       | Statistics  |
      | Maximum value                 | 2018-01-01 12:00:00.000 | Statistics  |
      | Minimum value                 | 2011-01-01 12:00:00.000 | Statistics  |
      | Number of non null values     | 4                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 4                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPLTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPLTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                 | widgetName  |
      | Data type                     | TIMESTAMP_LTZ                 | Description |
      | Length                        | 9                             | Statistics  |
      | Maximum value                 | 2015-01-02 08:00:00.000 -0800 | Statistics  |
      | Minimum value                 | 2011-12-02 08:00:00.000 -0800 | Statistics  |
      | Number of non null values     | 4                             | Statistics  |
      | Percentage of non null values | 100                           | Statistics  |
      | Number of null values         | 0                             | Statistics  |
      | Number of unique values       | 4                             | Statistics  |
      | Percentage of unique values   | 100                           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPNTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPNTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_NTZ           | Description |
      | Length                        | 9                       | Statistics  |
      | Maximum value                 | 2020-02-03 12:00:00.000 | Statistics  |
      | Minimum value                 | 2000-02-03 12:00:00.000 | Statistics  |
      | Number of non null values     | 4                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 4                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                 | widgetName  |
      | Data type                     | TIMESTAMP_TZ                  | Description |
      | Length                        | 9                             | Statistics  |
      | Maximum value                 | 2016-02-03 12:00:00.000 +1305 | Statistics  |
      | Minimum value                 | 2012-08-23 12:30:00.000 +1305 | Statistics  |
      | Number of non null values     | 4                             | Statistics  |
      | Percentage of non null values | 100                           | Statistics  |
      | Number of null values         | 0                             | Statistics  |
      | Number of unique values       | 4                             | Statistics  |
      | Percentage of unique values   | 100                           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page


  @sanity @positive @regression @PIITag
  Scenario:SC#45-48_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger%              | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SnowflakeDBAnalyzer%            | Analysis |       |       |


   ##################################################################################################################################################

  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#49: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                | path                                         | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerNoFilterConfiguration    | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               |                                                                         |                                              | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                              | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger   |                                                                         |                                              | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                              | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 | payloads/ida/snowflakePayloads/PluginConfiguration/AnalyzerConfig.json  | $.SnowflakeAnalyzerMultipleSchemaTableFilter | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 |                                                                         |                                              | 200           | SnowflakeDBAnalyzer  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                         |                                              | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                         |                                              | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                         |                                              | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |

  # 7038739 #
  Scenario Outline:SC#49:user get the Dynamic ID's (Database ID) for the Keyspaces "Snowflake DB" and table "DiffDataTypes"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type   | name                | asg_scopeid   | targetFile                                                 | jsonpath                                   |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | TEST_SNOWSchemaAuto | DiffDataTypes | payloads/ida/snowflakePayloads/DataSample/SC49_ItemID.json | $.Schema.TEST_SNOWSchemaAuto.DiffDataTypes |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | TESTSCHEMA          | CONSUMERS     | payloads/ida/snowflakePayloads/DataSample/SC49_ItemID.json | $.Schema.TESTSCHEMA.CONSUMERS              |


  Scenario Outline: SC#49:user hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                                  | inputFile                                                  | outPutFile                                                               | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Schema.TEST_SNOWSchemaAuto.DiffDataTypes | payloads/ida/snowflakePayloads/DataSample/SC49_ItemID.json | payloads/ida/snowflakePayloads/DataSample/SC49_DiffDataTypes_Actual.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Schema.TESTSCHEMA.CONSUMERS              | payloads/ida/snowflakePayloads/DataSample/SC49_ItemID.json | payloads/ida/snowflakePayloads/DataSample/SC49_Consumers_Actual.json     |            |

  Scenario: SC#49 Verify the DataSamples values are as expected
    Then file content in "ida/snowflakePayloads/DataSample/SC49_DiffDataTypes_Actual.json" should be same as the content in "ida/snowflakePayloads/DataSample/SC49_DiffDataTypes_Expected.json"
    Then file content in "ida/snowflakePayloads/DataSample/SC49_Consumers_Actual.json " should be same as the content in "ida/snowflakePayloads/DataSample/SC49_Consumers_Expected.json"




# 7038739 #
  @positve @regression @sanity @webtest
  Scenario:SC50#Verify the data profiling metadata information for string datatype if SnowflakeDBAnalyzer is run successfully with multiple schema and table filter
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "STRINGTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "STRINGTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 16777216      | Statistics  |
      | Maximum length                | 12            | Statistics  |
      | Maximum value                 | zxample word  | Statistics  |
      | Minimum length                | 12            | Statistics  |
      | Minimum value                 | axample word  | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user enters the search text "CONSUMERS" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "CONSUMERS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ADDRESS" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | VARCHAR             | Description |
      | Length                        | 16777216            | Statistics  |
      | Maximum length                | 21                  | Statistics  |
      | Maximum value                 | Tamuning Washington | Statistics  |
      | Minimum length                | 16                  | Statistics  |
      | Minimum value                 | Gardena Colorado    | Statistics  |
      | Number of non null values     | 3                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 3                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
#
## 7038739 #
  @positve @regression @sanity @webtest
  Scenario:SC51#Verify the data profiling metadata information for numeric datatypes in snowflake table if snowflakeAnalyzer is ran with multiple schema/table filters.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BIGINTTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BIGINTTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMBER        | Description |
      | Average                       | 6125          | Statistics  |
      | Length                        | 38            | Statistics  |
      | Maximum value                 | 7500          | Statistics  |
      | Median                        | 6000          | Statistics  |
      | Minimum value                 | 5000          | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Standard deviation            | 1108.68       | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 1229166.67    | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DECIMALTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DECIMALTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMBER        | Description |
      | Average                       | 38            | Statistics  |
      | Length                        | 6             | Statistics  |
      | Maximum value                 | 60.50         | Statistics  |
      | Median                        | 35.5          | Statistics  |
      | Minimum value                 | 20.50         | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Standard deviation            | 17.08         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 291.67        | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "FLOAT4TYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "FLOAT4TYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | FLOAT         | Description |
      | Average                       | 450.5         | Statistics  |
      | Length                        | 0             | Statistics  |
      | Maximum value                 | 650.5         | Statistics  |
      | Median                        | 425.5         | Statistics  |
      | Minimum value                 | 300.5         | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Standard deviation            | 147.2         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 21666.67      | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "CONSUMERS" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "CONSUMERS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "AGE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMBER        | Description |
      | Average                       | 53.33         | Statistics  |
      | Length                        | 38            | Statistics  |
      | Maximum value                 | 63            | Statistics  |
      | Median                        | 53            | Statistics  |
      | Minimum value                 | 44            | Statistics  |
      | Number of non null values     | 3             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 3             | Statistics  |
      | Standard deviation            | 9.5           | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 90.33         | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page

  @sanity @positive @regression
  Scenario:SC#49-51_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer% | Analysis |       |       |

####################################################################################################################################################
#
  Scenario Outline: SC#52 - Update policy tags
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                 | path   | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions | payloads/ida/snowflakePayloads/policyEngine/PIITags.json | $.SC52 | 204           |                  |          |


  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#52: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                | path                                        | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerNoFilterConfiguration   | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               |                                                                         |                                             | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                             | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger   |                                                                         |                                             | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                             | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 | payloads/ida/snowflakePayloads/PluginConfiguration/AnalyzerConfig.json  | $.SnowflakeAnalyzerMultipleSchemaViewFilter | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 |                                                                         |                                             | 200           | SnowflakeDBAnalyzer  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                         |                                             | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                         |                                             | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                         |                                             | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |


  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#52:Verify Tag is set for the column when dataPattern/minimumRatio matches with the column type/value ratio in snowflake external table view.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name            | facet | Tag                                                  | fileName  | userTag          |
      | Default     | snowflakeTagSC1 | Tags  | snowflakeTagSC1,Snowflake,Snowflake_BA,EMAIL ADDRESS | EMAIL     | SnowflakeTagview |
      | Default     | snowflakeTagSC1 | Tags  | snowflakeTagSC1,Snowflake,Snowflake_BA,GENDER        | GENDER    | SnowflakeTagview |
      | Default     | snowflakeTagSC1 | Tags  | snowflakeTagSC1,Snowflake,Snowflake_BA,IP ADDRESS    | IPADDRESS | SnowflakeTagview |
      | Default     | snowflakeTagSC1 | Tags  | snowflakeTagSC1,Snowflake,Snowflake_BA,FULL NAME     | FULLNAME  | SnowflakeTagview |


    # 7038741 #
  Scenario Outline:SC#52:user get the Dynamic ID's (Database ID) for the Keyspaces "Snowflake DB" and table "DiffDataTypes"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type   | name                | asg_scopeid       | targetFile                                                 | jsonpath                                       |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | TEST_SNOWSchemaAuto | DiffDataTypesView | payloads/ida/snowflakePayloads/DataSample/SC52_ItemID.json | $.Schema.TEST_SNOWSchemaAuto.DiffDataTypesView |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | TESTSCHEMA          | ViewConsumer      | payloads/ida/snowflakePayloads/DataSample/SC52_ItemID.json | $.Schema.TESTSCHEMA.ViewConsumer               |


  Scenario Outline: SC#52:user hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                                      | inputFile                                                  | outPutFile                                                                   | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Schema.TEST_SNOWSchemaAuto.DiffDataTypesView | payloads/ida/snowflakePayloads/DataSample/SC52_ItemID.json | payloads/ida/snowflakePayloads/DataSample/SC52_DiffDataTypesView_Actual.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Schema.TESTSCHEMA.ViewConsumer               | payloads/ida/snowflakePayloads/DataSample/SC52_ItemID.json | payloads/ida/snowflakePayloads/DataSample/SC52_ViewConsumer_Actual.json      |            |

  Scenario: SC#52 Verify the DataSamples values are as expected
    Then file content in "ida/snowflakePayloads/DataSample/SC52_DiffDataTypesView_Actual.json" should be same as the content in "ida/snowflakePayloads/DataSample/SC52_DiffDataTypesView_Expected.json"
    Then file content in "ida/snowflakePayloads/DataSample/SC52_ViewConsumer_Actual.json" should be same as the content in "ida/snowflakePayloads/DataSample/SC52_ViewConsumer_Expected.json"



# 7038741 #
  @positve @regression @sanity @webtest
  Scenario:SC53#Verify the data profiling metadata information for string datatype if SnowflakeDBAnalyzer is run successfully with multiple schema and view filter
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "STRINGTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "STRINGTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 16777216      | Statistics  |
      | Maximum length                | 12            | Statistics  |
      | Maximum value                 | zxample word  | Statistics  |
      | Minimum length                | 12            | Statistics  |
      | Minimum value                 | axample word  | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user enters the search text "ViewConsumer" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ViewConsumer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ADDRESS" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | VARCHAR             | Description |
      | Length                        | 16777216            | Statistics  |
      | Maximum length                | 21                  | Statistics  |
      | Maximum value                 | Tamuning Washington | Statistics  |
      | Minimum length                | 16                  | Statistics  |
      | Minimum value                 | Gardena Colorado    | Statistics  |
      | Number of non null values     | 3                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 3                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page

# 7038741 #
  @positve @regression @sanity @webtest
  Scenario:SC54#Verify the data profiling metadata information for numeric datatypes in snowflake view if snowflakeAnalyzer is ran with multiple schema/view filters.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BIGINTTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BIGINTTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMBER        | Description |
      | Average                       | 6125          | Statistics  |
      | Length                        | 38            | Statistics  |
      | Maximum value                 | 7500          | Statistics  |
      | Median                        | 6000          | Statistics  |
      | Minimum value                 | 5000          | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Standard deviation            | 1108.68       | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 1229166.67    | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DECIMALTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DECIMALTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMBER        | Description |
      | Average                       | 38            | Statistics  |
      | Length                        | 6             | Statistics  |
      | Maximum value                 | 60.50         | Statistics  |
      | Median                        | 35.5          | Statistics  |
      | Minimum value                 | 20.50         | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Standard deviation            | 17.08         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 291.67        | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "FLOAT4TYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "FLOAT4TYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | FLOAT         | Description |
      | Average                       | 450.5         | Statistics  |
      | Length                        | 0             | Statistics  |
      | Maximum value                 | 650.5         | Statistics  |
      | Median                        | 425.5         | Statistics  |
      | Minimum value                 | 300.5         | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Standard deviation            | 147.2         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 21666.67      | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "ViewConsumer" and clicks on search
    And user performs "facet selection" in "snowflakeTagSC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ViewConsumer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "AGE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMBER        | Description |
      | Average                       | 53.33         | Statistics  |
      | Length                        | 38            | Statistics  |
      | Maximum value                 | 63            | Statistics  |
      | Median                        | 53            | Statistics  |
      | Minimum value                 | 44            | Statistics  |
      | Number of non null values     | 3             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 3             | Statistics  |
      | Standard deviation            | 9.5           | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 90.33         | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page

  @sanity @positive @regression @PIITag
  Scenario:SC#52-54_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer% | Analysis |       |       |


#    ##################################################################################################################################################
#
  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#55: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                | path                                      | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerNoFilterConfiguration | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               |                                                                         |                                           | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                           | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger   |                                                                         |                                           | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                           | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 | payloads/ida/snowflakePayloads/PluginConfiguration/AnalyzerConfig.json  | $.SnowflakeAnalyzerNonExistingDBFilter    | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 |                                                                         |                                           | 200           | SnowflakeDBAnalyzer  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                         |                                           | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                         |                                           | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                         |                                           | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |




    # 7038742 #
  @MLP-20518 @webtest @aws @regression @sanity @IDA-1.1.0
  Scenario:SC55#Validate analyzer does not do any analysis and log throws proper message when non existing DB is passed in snowflakeanalyzer configuration.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagInvalidschema" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service    |
      | Cluster    |
      | Database   |
      | Table      |
      | Column     |
      | Constraint |
      | Schema     |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis |
    And user clicks on first item on the item list page
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer%" should display below info/error/warning
      | type | logValue                                                                                                                                                | logCode       | pluginName           | removableText |
      | INFO | ANALYSIS-0072: Plugin SnowflakeDBAnalyzer Start Time:2020-05-28 12:46:30.532, End Time:2020-05-28 12:46:31.376, Processed Count:0, Errors:0, Warnings:1 | ANALYSIS-0072 | SnowflakeDBCataloger |               |
    And user clicks on logout button

  @sanity @positive @regression @PIITag
  Scenario:SC#55_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger% | Analysis |       |       |


###################################################################################################################################################

    # 7085450 #
  @MLP-21007 @webtest @positive @regression @sanity @IDA-1.1.0
  Scenario: SC#56- Verify proper error message is shown if mandatory fields are not filled in SnowflakeDBAnalyzer configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Add Data source Configuration"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute           |
      | Type      | Dataanalyzer        |
      | Plugin    | SnowflakeDBAnalyzer |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


# 7038744 #
  @webtest @jdbc @MLP-14019
  Scenario:SC#57_Verify proper error message is thrown in UI if Sample Data count/Top Values/Histogram Buckets values are not provided within valid range in SnowflakeDBAnalyzer
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Add Data source Configuration"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute           |
      | Type      | Dataanalyzer        |
      | Plugin    | SnowflakeDBAnalyzer |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Sample data count     | 1001                   |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                               |
      | Sample data count | Value of Sample data count should not be greater than 1000 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Sample data count     | 9                      |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                            |
      | Sample data count | Value of Sample data count should not be lesser than 10 |
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
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

#################################################################################################################################################
  Scenario Outline: SC#58 - Update policy tags
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                 | path   | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions | payloads/ida/snowflakePayloads/policyEngine/PIITags.json | $.SC58 | 204           |                  |          |

  @MLP-20518 @sanity @positive @regression @snowflake
  Scenario Outline:SC#58: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                | path                                                                          | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               | payloads/ida/snowflakePayloads/PluginConfiguration/CatalogerConfig.json | $.SnowflakeCatalogerMultipleSchemawithMultipleExtTableViewFilterConfiguration | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               |                                                                         |                                                                               | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                                                               | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger   |                                                                         |                                                                               | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                         |                                                                               | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 | payloads/ida/snowflakePayloads/PluginConfiguration/AnalyzerConfig.json  | $.SnowflakeAnalyzerMultipleSchemaExtTableViewFilter                           | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 |                                                                         |                                                                               | 200           | SnowflakeDBAnalyzer  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                         |                                                                               | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                         |                                                                               | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                         |                                                                               | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |


  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#58:Verify Tag is set for the column when dataPattern/minimumRatio matches with the column type/value ratio in snowflake external table.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name                             | facet | Tag                                                                                   | fileName  | userTag              |
      | Default     | snowflakeTagExtMultipleTableView | Tags  | snowflakeTagExtMultipleTableView,snowflakeTagSC1,Snowflake,Snowflake_BA,EMAIL ADDRESS | EMAIL     | snowflaketagexttable |
      | Default     | snowflakeTagExtMultipleTableView | Tags  | snowflakeTagSC1,snowflakeTagExtMultipleTableView,Snowflake,Snowflake_BA,GENDER        | GENDER    | snowflaketagexttable |
      | Default     | snowflakeTagExtMultipleTableView | Tags  | snowflakeTagSC1,snowflakeTagExtMultipleTableView,Snowflake,Snowflake_BA,IP ADDRESS    | IPADDRESS | snowflaketagexttable |
      | Default     | snowflakeTagExtMultipleTableView | Tags  | snowflakeTagSC1,snowflakeTagExtMultipleTableView,Snowflake,Snowflake_BA,FULL NAME     | FULLNAME  | snowflaketagexttable |

  # 7054343 #
  @webtest @MLP-15785
  Scenario:SC#58_Verify the data sampling works fine for tables if SnowflakeDBAnalyzer is run successfully when SnowflakeDBAnalyzer is ran with mutiple schemas/tables/views.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagExtMultipleTableView" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "snowflakecsvexttable1" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | BIGINTTYPE | BOOLEANTYPE | CHARACTERTYPE | CHARTYPE | DATETIMETYPE          | DATETYPE   | DECIMALTYPE | DOUBLEPRECISIONTYPE | DOUBLETYPE | FLOAT4TYPE | FLOAT8TYPE | FLOATTYPE | INTEGERTYPE | INTTYPE | NUMBERTYPE | NUMERICTYPE | REALTYPE | SMALLINTTYPE | STRINGTYPE | TEXTTYPE | TIMESTAMPLTZTYPE      | TIMESTAMPNTZTYPE      | TIMESTAMPTYPE         | TIMESTAMPTZTYPE       | TIMETYPE | VARCHARTYPE |
      | 535353     | true        | abc           | C        | 2015-10-05 00:00:00.0 | 2015-10-05 | 30.35       | 100.5               | 100.5      | 33.45      | 256.75     | 20.5      | 535353      | 1000    | 10         | 66.77       | 100.5    | 656          | abc        | abc      | 2015-10-05 07:00:00.0 | 2015-10-05 00:00:00.0 | 2015-10-05 00:00:00.0 | 2015-10-05 07:00:00.0 | 00:45:00 | abc         |
      | 635353     | false       | def           | H        | 2016-06-06 00:00:00.0 | 2016-06-06 | 30.35       | 200.5               | 200.5      | 43.45      | 356.75     | 30.5      | 635353      | 2000    | 20         | 66.77       | 200.5    | 789          | def        | def      | 2016-06-06 07:00:00.0 | 2016-06-06 00:00:00.0 | 2016-06-06 00:00:00.0 | 2016-06-06 07:00:00.0 | 00:45:00 | def         |
      | 735353     | true        | ghi           | B        | 2017-07-07 00:00:00.0 | 2017-07-07 | 30.35       | 300.5               | 300.5      | 53.45      | 456.75     | 40.5      | 735353      | 3000    | 30         | 66.77       | 300.5    | 767          | ghi        | ghi      | 2017-07-07 07:00:00.0 | 2017-07-07 00:00:00.0 | 2017-07-07 00:00:00.0 | 2017-07-07 07:00:00.0 | 00:25:00 | ghi         |
      | 835353     | true        | jkl           | E        | 2013-10-10 00:00:00.0 | 2013-10-10 | 30.35       | 400.5               | 400.5      | 63.45      | 556.75     | 50.5      | 835353      | 4000    | 40         | 66.77       | 400.5    | 870          | jkl        | jkl      | 2013-10-10 07:00:00.0 | 2013-10-10 00:00:00.0 | 2013-10-10 00:00:00.0 | 2013-10-10 07:00:00.0 | 00:25:00 | jkl         |
      | 935353     | true        | mno           | F        | 2013-03-03 00:00:00.0 | 2013-03-03 | 30.35       | 500.5               | 500.5      | 73.45      | 656.75     | 60.5      | 935353      | 5000    | 50         | 66.77       | 500.5    | 700          | mno        | mno      | 2013-03-03 08:00:00.0 | 2013-03-03 00:00:00.0 | 2013-03-03 00:00:00.0 | 2013-03-03 08:00:00.0 | 00:45:00 | mno         |
    And user enters the search text "snowflakeTagExtMultipleTableView" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TEST_SNOWSchemaAuto [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "snowflakecsvexttable1view" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | BIGINTTYPE | BOOLEANTYPE | CHARACTERTYPE | CHARTYPE | DATETIMETYPE          | DATETYPE   | DECIMALTYPE | DOUBLEPRECISIONTYPE | DOUBLETYPE | FLOAT4TYPE | FLOAT8TYPE | FLOATTYPE | INTEGERTYPE | INTTYPE | NUMBERTYPE | NUMERICTYPE | REALTYPE | SMALLINTTYPE | STRINGTYPE | TEXTTYPE | TIMESTAMPLTZTYPE      | TIMESTAMPNTZTYPE      | TIMESTAMPTYPE         | TIMESTAMPTZTYPE       | TIMETYPE | VARCHARTYPE |
      | 535353     | true        | abc           | C        | 2015-10-05 00:00:00.0 | 2015-10-05 | 30.35       | 100.5               | 100.5      | 33.45      | 256.75     | 20.5      | 535353      | 1000    | 10         | 66.77       | 100.5    | 656          | abc        | abc      | 2015-10-05 07:00:00.0 | 2015-10-05 00:00:00.0 | 2015-10-05 00:00:00.0 | 2015-10-05 07:00:00.0 | 00:45:00 | abc         |
      | 635353     | false       | def           | H        | 2016-06-06 00:00:00.0 | 2016-06-06 | 30.35       | 200.5               | 200.5      | 43.45      | 356.75     | 30.5      | 635353      | 2000    | 20         | 66.77       | 200.5    | 789          | def        | def      | 2016-06-06 07:00:00.0 | 2016-06-06 00:00:00.0 | 2016-06-06 00:00:00.0 | 2016-06-06 07:00:00.0 | 00:45:00 | def         |
      | 735353     | true        | ghi           | B        | 2017-07-07 00:00:00.0 | 2017-07-07 | 30.35       | 300.5               | 300.5      | 53.45      | 456.75     | 40.5      | 735353      | 3000    | 30         | 66.77       | 300.5    | 767          | ghi        | ghi      | 2017-07-07 07:00:00.0 | 2017-07-07 00:00:00.0 | 2017-07-07 00:00:00.0 | 2017-07-07 07:00:00.0 | 00:25:00 | ghi         |
      | 835353     | true        | jkl           | E        | 2013-10-10 00:00:00.0 | 2013-10-10 | 30.35       | 400.5               | 400.5      | 63.45      | 556.75     | 50.5      | 835353      | 4000    | 40         | 66.77       | 400.5    | 870          | jkl        | jkl      | 2013-10-10 07:00:00.0 | 2013-10-10 00:00:00.0 | 2013-10-10 00:00:00.0 | 2013-10-10 07:00:00.0 | 00:25:00 | jkl         |
      | 935353     | true        | mno           | F        | 2013-03-03 00:00:00.0 | 2013-03-03 | 30.35       | 500.5               | 500.5      | 73.45      | 656.75     | 60.5      | 935353      | 5000    | 50         | 66.77       | 500.5    | 700          | mno        | mno      | 2013-03-03 08:00:00.0 | 2013-03-03 00:00:00.0 | 2013-03-03 00:00:00.0 | 2013-03-03 08:00:00.0 | 00:45:00 | mno         |
    And user enters the search text "snowflakeTagExtMultipleTableView" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TESTSCHEMA [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "snowflakecsvexttable1view" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | BIGINTTYPE | BOOLEANTYPE | CHARACTERTYPE | CHARTYPE | DATETIMETYPE          | DATETYPE   | DECIMALTYPE | DOUBLEPRECISIONTYPE | DOUBLETYPE | FLOAT4TYPE | FLOAT8TYPE | FLOATTYPE | INTEGERTYPE | INTTYPE | NUMBERTYPE | NUMERICTYPE | REALTYPE | SMALLINTTYPE | STRINGTYPE | TEXTTYPE | TIMESTAMPLTZTYPE      | TIMESTAMPNTZTYPE      | TIMESTAMPTYPE         | TIMESTAMPTZTYPE       | TIMETYPE | VARCHARTYPE |
      | 535353     | true        | abc           | C        | 2015-10-05 00:00:00.0 | 2015-10-05 | 30.35       | 100.5               | 100.5      | 33.45      | 256.75     | 20.5      | 535353      | 1000    | 10         | 66.77       | 100.5    | 656          | abc        | abc      | 2015-10-05 07:00:00.0 | 2015-10-05 00:00:00.0 | 2015-10-05 00:00:00.0 | 2015-10-05 07:00:00.0 | 00:45:00 | abc         |
      | 635353     | false       | def           | H        | 2016-06-06 00:00:00.0 | 2016-06-06 | 30.35       | 200.5               | 200.5      | 43.45      | 356.75     | 30.5      | 635353      | 2000    | 20         | 66.77       | 200.5    | 789          | def        | def      | 2016-06-06 07:00:00.0 | 2016-06-06 00:00:00.0 | 2016-06-06 00:00:00.0 | 2016-06-06 07:00:00.0 | 00:45:00 | def         |
      | 735353     | true        | ghi           | B        | 2017-07-07 00:00:00.0 | 2017-07-07 | 30.35       | 300.5               | 300.5      | 53.45      | 456.75     | 40.5      | 735353      | 3000    | 30         | 66.77       | 300.5    | 767          | ghi        | ghi      | 2017-07-07 07:00:00.0 | 2017-07-07 00:00:00.0 | 2017-07-07 00:00:00.0 | 2017-07-07 07:00:00.0 | 00:25:00 | ghi         |
      | 835353     | true        | jkl           | E        | 2013-10-10 00:00:00.0 | 2013-10-10 | 30.35       | 400.5               | 400.5      | 63.45      | 556.75     | 50.5      | 835353      | 4000    | 40         | 66.77       | 400.5    | 870          | jkl        | jkl      | 2013-10-10 07:00:00.0 | 2013-10-10 00:00:00.0 | 2013-10-10 00:00:00.0 | 2013-10-10 07:00:00.0 | 00:25:00 | jkl         |
      | 935353     | true        | mno           | F        | 2013-03-03 00:00:00.0 | 2013-03-03 | 30.35       | 500.5               | 500.5      | 73.45      | 656.75     | 60.5      | 935353      | 5000    | 50         | 66.77       | 500.5    | 700          | mno        | mno      | 2013-03-03 08:00:00.0 | 2013-03-03 00:00:00.0 | 2013-03-03 00:00:00.0 | 2013-03-03 08:00:00.0 | 00:45:00 | mno         |

# 7054355 #
  @positve @regression @sanity @webtest
  Scenario:SC59#Verify the data profiling metadata information for string datatype in snowflakeDB external table/view.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "STRINGTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "STRINGTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 16777216      | Statistics  |
      | Maximum length                | 3             | Statistics  |
      | Maximum value                 | mno           | Statistics  |
      | Minimum length                | 3             | Statistics  |
      | Minimum value                 | abc           | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget not present" on "Most frequent values" in Item view page
    And user enters the search text "STRINGTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1view [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "STRINGTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 16777216      | Statistics  |
      | Maximum length                | 3             | Statistics  |
      | Maximum value                 | mno           | Statistics  |
      | Minimum length                | 3             | Statistics  |
      | Minimum value                 | abc           | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user enters the search text "STRINGTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1view [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "STRINGTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 16777216      | Statistics  |
      | Maximum length                | 3             | Statistics  |
      | Maximum value                 | mno           | Statistics  |
      | Minimum length                | 3             | Statistics  |
      | Minimum value                 | abc           | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user enters the search text "FILENAME_PART" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "exttable_part [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FILENAME_PART" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 16777216      | Statistics  |
      | Maximum length                | 13            | Statistics  |
      | Maximum value                 | CSVWithoutHea | Statistics  |
      | Minimum length                | 13            | Statistics  |
      | Minimum value                 | CSVWithoutHea | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 20            | Statistics  |
    And user "widget not present" on "Most frequent values" in Item view page

#    # 7054355 #
  @positve @regression @sanity @webtest
  Scenario:SC60#Verify the data profiling metadata information for numeric datatypes in snowflake extrenal table/view.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BIGINTTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "BIGINTTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMBER        | Description |
      | Average                       | 735353        | Statistics  |
      | Length                        | 38            | Statistics  |
      | Maximum value                 | 935353        | Statistics  |
      | Median                        | 735353        | Statistics  |
      | Minimum value                 | 535353        | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 158113.88     | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 25000000000   | Statistics  |
    And user "widget not present" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DOUBLETYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "DOUBLETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | FLOAT         | Description |
      | Average                       | 300.5         | Statistics  |
      | Length                        | 0             | Statistics  |
      | Maximum value                 | 500.5         | Statistics  |
      | Median                        | 300.5         | Statistics  |
      | Minimum value                 | 100.5         | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 158.11        | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 25000         | Statistics  |
    And user "widget not present" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "BIGINTTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1view [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "BIGINTTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMBER        | Description |
      | Average                       | 735353        | Statistics  |
      | Length                        | 38            | Statistics  |
      | Maximum value                 | 935353        | Statistics  |
      | Median                        | 735353        | Statistics  |
      | Minimum value                 | 535353        | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 158113.88     | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 25000000000   | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DOUBLETYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1view [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "DOUBLETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | FLOAT         | Description |
      | Average                       | 300.5         | Statistics  |
      | Length                        | 0             | Statistics  |
      | Maximum value                 | 500.5         | Statistics  |
      | Median                        | 300.5         | Statistics  |
      | Minimum value                 | 100.5         | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 158.11        | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 25000         | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "chart widget presence" on "Data Distribution" in Item view page
#
#    # 7054355 #
  @positve @regression @sanity @webtest
  Scenario:SC60#Verify the data profiling metadata information for Data,time and timestamp datatypes in snowflake external table/view.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTagExtMultipleTableView" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user enters the search text "DATETYPE" and clicks on search
    And user performs "facet selection" in "snowflakecsvexttable1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "DATETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DATE          | Description |
      | Length                        | 0             | Statistics  |
      | Maximum value                 | 2017-07-07    | Statistics  |
      | Minimum value                 | 2013-03-03    | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMETYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TIME          | Description |
      | Length                        | 9             | Statistics  |
      | Maximum value                 | 00:45:00      | Statistics  |
      | Minimum value                 | 00:25:00      | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 40            | Statistics  |
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPLTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPLTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                 | widgetName  |
      | Data type                     | TIMESTAMP_LTZ                 | Description |
      | Length                        | 9                             | Statistics  |
      | Maximum value                 | 2017-07-07 00:00:00.000 -0700 | Statistics  |
      | Minimum value                 | 2013-03-03 00:00:00.000 -0800 | Statistics  |
      | Number of non null values     | 5                             | Statistics  |
      | Percentage of non null values | 100                           | Statistics  |
      | Number of null values         | 0                             | Statistics  |
      | Number of unique values       | 5                             | Statistics  |
      | Percentage of unique values   | 100                           | Statistics  |
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPNTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPNTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_NTZ           | Description |
      | Length                        | 9                       | Statistics  |
      | Maximum value                 | 2017-07-07 00:00:00.000 | Statistics  |
      | Minimum value                 | 2013-03-03 00:00:00.000 | Statistics  |
      | Number of non null values     | 5                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 5                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                 | widgetName  |
      | Data type                     | TIMESTAMP_TZ                  | Description |
      | Length                        | 9                             | Statistics  |
      | Maximum value                 | 2017-07-07 00:00:00.000 -0700 | Statistics  |
      | Minimum value                 | 2013-03-03 00:00:00.000 -0800 | Statistics  |
      | Number of non null values     | 5                             | Statistics  |
      | Percentage of non null values | 100                           | Statistics  |
      | Number of null values         | 0                             | Statistics  |
      | Number of unique values       | 5                             | Statistics  |
      | Percentage of unique values   | 100                           | Statistics  |
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "DATETYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1view [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "DATETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DATE          | Description |
      | Length                        | 0             | Statistics  |
      | Maximum value                 | 2017-07-07    | Statistics  |
      | Minimum value                 | 2013-03-03    | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMETYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1view [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMETYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TIME          | Description |
      | Length                        | 9             | Statistics  |
      | Maximum value                 | 00:45:00      | Statistics  |
      | Minimum value                 | 00:25:00      | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 40            | Statistics  |
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPLTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1view [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPLTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                 | widgetName  |
      | Data type                     | TIMESTAMP_LTZ                 | Description |
      | Length                        | 9                             | Statistics  |
      | Maximum value                 | 2017-07-07 00:00:00.000 -0700 | Statistics  |
      | Minimum value                 | 2013-03-03 00:00:00.000 -0800 | Statistics  |
      | Number of non null values     | 5                             | Statistics  |
      | Percentage of non null values | 100                           | Statistics  |
      | Number of null values         | 0                             | Statistics  |
      | Number of unique values       | 5                             | Statistics  |
      | Percentage of unique values   | 100                           | Statistics  |
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPNTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1view [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPNTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_NTZ           | Description |
      | Length                        | 9                       | Statistics  |
      | Maximum value                 | 2017-07-07 00:00:00.000 | Statistics  |
      | Minimum value                 | 2013-03-03 00:00:00.000 | Statistics  |
      | Number of non null values     | 5                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 5                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "TIMESTAMPTZTYPE" and clicks on search
    And user performs "facet selection" in "snowflakeTagExtMultipleTableView" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "snowflakecsvexttable1view [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TIMESTAMPTZTYPE" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue                 | widgetName  |
      | Data type                     | TIMESTAMP_TZ                  | Description |
      | Length                        | 9                             | Statistics  |
      | Maximum value                 | 2017-07-07 00:00:00.000 -0700 | Statistics  |
      | Minimum value                 | 2013-03-03 00:00:00.000 -0800 | Statistics  |
      | Number of non null values     | 5                             | Statistics  |
      | Percentage of non null values | 100                           | Statistics  |
      | Number of null values         | 0                             | Statistics  |
      | Number of unique values       | 5                             | Statistics  |
      | Percentage of unique values   | 100                           | Statistics  |
    And user "widget not present" on "Data Distribution" in Item view page

  @sanity @positive @regression @PIITag
  Scenario:SC#58-60_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer% | Analysis |       |       |
#
##################################################################################################################################################
##################################################################### PII TAGS VALIDATION  ####################################################################

  @MLP-20518 @sanity @positive @regression @snowflake @PIITag
  Scenario Outline:SC#62: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                    | path              | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                     | payloads/ida/snowflakePayloads/policyEngine/PIITags.json                    | $.SC62            | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               | payloads/ida/snowflakePayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               |                                                                             |                   | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger   |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 | payloads/ida/snowflakePayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig  | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 |                                                                             |                   | 200           | SnowflakeDBAnalyzer  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |

  @positve @regression @sanity  @PIITag
  Scenario:SC#62:Verify Tag is set for the column when match empty is true and all the column values in DB are empty.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                  | ServiceName | DatabaseName | SchemaName          | TableName/Filename                   | Column    | Tags                                              | Query                 | Action         |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY                  | EMAIL     | snowflakeTag,Snowflake,Snowflake_BA,EMAIL ADDRESS | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY                  | IPADDRESS | snowflakeTag,Snowflake,Snowflake_BA,IP ADDRESS    | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY                  | SSN       | snowflakeTag,Snowflake,Snowflake_BA,S S N         | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                  | SSN       | S S SN1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                  | EMAIL     | EMAIL ADDRESS1                                    | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                  | FULL_NAME | FULL NAME1                                        | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                  | GENDER    | GENDER1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                  | IPADDRESS | IP ADDRESS1                                       | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolessthan05EmptyFalse | SSN       | S S SN1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolessthan05EmptyFalse | EMAIL     | EMAIL ADDRESS1                                    | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolessthan05EmptyFalse | FULL_NAME | FULL NAME1                                        | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolessthan05EmptyFalse | GENDER    | GENDER1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolessthan05EmptyFalse | IPADDRESS | IP ADDRESS1                                       | ColumnQuerywithSchema | TagNotAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#62_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer% | Analysis |       |       |




#################################################################################################################################################################

  @MLP-20518 @sanity @positive @regression @snowflake @PIITag
  Scenario Outline:SC#63: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                    | path              | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                     | payloads/ida/snowflakePayloads/policyEngine/PIITags.json                    | $.SC63            | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               | payloads/ida/snowflakePayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               |                                                                             |                   | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger   |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 | payloads/ida/snowflakePayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig  | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 |                                                                             |                   | 200           | SnowflakeDBAnalyzer  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |

    # 7089397 #
  @positve @regression @sanity  @PIITag
  Scenario:SC#63: Verify Tag is set for the column when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the data in column in snowflake table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                  | ServiceName | DatabaseName | TableName/Filename                   | SchemaName          | Column    | Tags                                              | Query                 | Action         |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TAGDETAILS_Ratiolessthan05EmptyFalse | TEST_SNOWSchemaAuto | EMAIL     | snowflakeTag,Snowflake,Snowflake_BA,EMAIL ADDRESS | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TAGDETAILS_Ratiolessthan05EmptyFalse | TEST_SNOWSchemaAuto | GENDER    | snowflakeTag,Snowflake,Snowflake_BA,GENDER        | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TAGDETAILS_Ratiolessthan05EmptyFalse | TEST_SNOWSchemaAuto | IPADDRESS | snowflakeTag,Snowflake,Snowflake_BA,IP ADDRESS    | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TAGDETAILS_Ratiolessthan05EmptyFalse | TEST_SNOWSchemaAuto | SSN       | snowflakeTag,Snowflake,Snowflake_BA,S S N         | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TAGDETAILS_Ratiolessthan05EmptyFalse | TEST_SNOWSchemaAuto | FULL_NAME | snowflakeTag,Snowflake,Snowflake_BA,FULL NAME     | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TAGDETAILS_ALLMATCH                  | TEST_SNOWSchemaAuto | FULL_NAME | FULL NAME1                                        | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TAGDETAILS_ALLMATCH                  | TEST_SNOWSchemaAuto | GENDER    | GENDER1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TAGDETAILS_ALLMATCH                  | TEST_SNOWSchemaAuto | IPADDRESS | IP ADDRESS1                                       | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TAGDETAILS_ALLMATCH                  | TEST_SNOWSchemaAuto | SSN       | S S SN1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TAGDETAILS_ALLMATCH                  | TEST_SNOWSchemaAuto | EMAIL     | EMAIL ADDRESS1                                    | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TAGDETAILS_ALLEMPTY                  | TEST_SNOWSchemaAuto | FULL_NAME | FULL NAME1                                        | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TAGDETAILS_ALLEMPTY                  | TEST_SNOWSchemaAuto | GENDER    | GENDER1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TAGDETAILS_ALLEMPTY                  | TEST_SNOWSchemaAuto | IPADDRESS | IP ADDRESS1                                       | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TAGDETAILS_ALLEMPTY                  | TEST_SNOWSchemaAuto | EMAIL     | EMAIL ADDRESS1                                    | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TAGDETAILS_ALLEMPTY                  | TEST_SNOWSchemaAuto | SSN       | S S SN1                                           | ColumnQuerywithSchema | TagNotAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#63_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer% | Analysis |       |       |
##
##    ###############################################################################################################################################################
#
  @MLP-20518 @sanity @positive @regression @snowflake @PIITag
  Scenario Outline:SC#64: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                    | path              | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                     | payloads/ida/snowflakePayloads/policyEngine/PIITags.json                    | $.SC64            | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               | payloads/ida/snowflakePayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               |                                                                             |                   | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger   |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 | payloads/ida/snowflakePayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig  | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 |                                                                             |                   | 200           | SnowflakeDBAnalyzer  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |


  @positve @regression @sanity  @PIITag
  Scenario:SC#64: Verify Tag is set for the column when typePattern(String) and dataPattern/minimumRatio matches with the column type/value ratio
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                  | ServiceName | DatabaseName | SchemaName          | TableName/Filename                          | Column    | Tags                                              | Query                 | Action         |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_RatioEqualTo05EmptyFalse         | EMAIL     | snowflakeTag,Snowflake,Snowflake_BA,EMAIL ADDRESS | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_RatioEqualTo05EmptyFalse         | GENDER    | snowflakeTag,Snowflake,Snowflake_BA,GENDER        | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_RatioEqualTo05EmptyFalse         | IPADDRESS | snowflakeTag,Snowflake,Snowflake_BA,IP ADDRESS    | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_RatioEqualTo05EmptyFalse         | SSN       | snowflakeTag,Snowflake,Snowflake_BA,S S N         | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_RatioEqualTo05EmptyFalse         | FULL_NAME | snowflakeTag,Snowflake,Snowflake_BA,FULL NAME     | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                         | EMAIL     | snowflakeTag,Snowflake,Snowflake_BA,EMAIL ADDRESS | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                         | GENDER    | snowflakeTag,Snowflake,Snowflake_BA,GENDER        | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                         | IPADDRESS | snowflakeTag,Snowflake,Snowflake_BA,IP ADDRESS    | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                         | SSN       | snowflakeTag,Snowflake,Snowflake_BA,S S N         | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                         | FULL_NAME | snowflakeTag,Snowflake,Snowflake_BA,FULL NAME     | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | FULL NAME1                                        | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | GENDER1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | IP ADDRESS1                                       | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | S S SN1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | EMAIL ADDRESS1                                    | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY                         | FULL_NAME | FULL NAME1                                        | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY                         | GENDER    | GENDER1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY                         | SSN       | S S SN1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY                         | EMAIL     | EMAIL ADDRESS1                                    | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY                         | IPADDRESS | IP ADDRESS1                                       | ColumnQuerywithSchema | TagNotAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#64_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer% | Analysis |       |       |
##############################################################################################################################################################################


  @MLP-20518 @sanity @positive @regression @snowflake @PIITag
  Scenario Outline:SC#65: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                    | path              | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                     | payloads/ida/snowflakePayloads/policyEngine/PIITags.json                    | $.SC65            | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               | payloads/ida/snowflakePayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               |                                                                             |                   | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger   |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 | payloads/ida/snowflakePayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig  | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 |                                                                             |                   | 200           | SnowflakeDBAnalyzer  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |

  @positve @regression @sanity  @PIITag
  Scenario:SC#65: Verify Tag is set for the column when dataPattern and minimumRatio(1-full match) is passed which has a regexp that matches with the data in column in snowflake table.
  (Ex: 1 - all rows should match) - Match Empty is false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                  | ServiceName | DatabaseName | SchemaName          | TableName/Filename                          | Column    | Tags                                              | Query                 | Action         |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                         | EMAIL     | snowflakeTag,Snowflake,Snowflake_BA,EMAIL ADDRESS | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                         | GENDER    | snowflakeTag,Snowflake,Snowflake_BA,GENDER        | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                         | IPADDRESS | snowflakeTag,Snowflake,Snowflake_BA,IP ADDRESS    | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                         | SSN       | snowflakeTag,Snowflake,Snowflake_BA,S S N         | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                         | FULL_NAME | snowflakeTag,Snowflake,Snowflake_BA,FULL NAME     | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | FULL NAME1                                        | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | GENDER1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | IP ADDRESS1                                       | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | S S SN1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | EMAIL ADDRESS1                                    | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY                         | FULL_NAME | FULL NAME1                                        | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY                         | GENDER    | GENDER1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY                         | SSN       | S S SN1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY                         | EMAIL     | EMAIL ADDRESS1                                    | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY                         | IPADDRESS | IP ADDRESS1                                       | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolessthan05EmptyFalse        | FULL_NAME | FULL NAME1                                        | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolessthan05EmptyFalse        | GENDER    | GENDER1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | IP ADDRESS1                                       | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolessthan05EmptyFalse        | SSN       | S S SN1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolessthan05EmptyFalse        | EMAIL     | EMAIL ADDRESS1                                    | ColumnQuerywithSchema | TagNotAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#65_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer% | Analysis |       |       |
#
#    ###########################################################################################################################################
#
#
  @MLP-20518 @sanity @positive @regression @snowflake @PIITag
  Scenario Outline:SC#66: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                    | path              | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                     | payloads/ida/snowflakePayloads/policyEngine/PIITags.json                    | $.SC66            | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               | payloads/ida/snowflakePayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               |                                                                             |                   | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger   |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 | payloads/ida/snowflakePayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig  | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 |                                                                             |                   | 200           | SnowflakeDBAnalyzer  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |

  @positve @regression @sanity  @PIITag
  Scenario:SC#66: Verify Tag is set for the column when typePattern(String) and dataPattern/minimumRatio matches with the column type/value ratio
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                  | ServiceName | DatabaseName | SchemaName          | TableName/Filename                          | Column    | Tags                                              | Query                 | Action         |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                         | EMAIL     | snowflakeTag,Snowflake,Snowflake_BA,EMAIL ADDRESS | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                         | GENDER    | snowflakeTag,Snowflake,Snowflake_BA,GENDER        | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                         | IPADDRESS | snowflakeTag,Snowflake,Snowflake_BA,IP ADDRESS    | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                         | SSN       | snowflakeTag,Snowflake,Snowflake_BA,S S N         | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH                         | FULL_NAME | snowflakeTag,Snowflake,Snowflake_BA,FULL NAME     | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_RatioEqualTo05EmptyFalse         | EMAIL     | snowflakeTag,Snowflake,Snowflake_BA,EMAIL ADDRESS | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_RatioEqualTo05EmptyFalse         | GENDER    | snowflakeTag,Snowflake,Snowflake_BA,GENDER        | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_RatioEqualTo05EmptyFalse         | IPADDRESS | snowflakeTag,Snowflake,Snowflake_BA,IP ADDRESS    | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_RatioEqualTo05EmptyFalse         | SSN       | snowflakeTag,Snowflake,Snowflake_BA,S S N         | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_RatioEqualTo05EmptyFalse         | FULL_NAME | snowflakeTag,Snowflake,Snowflake_BA,FULL NAME     | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | snowflakeTag,Snowflake,Snowflake_BA,IP ADDRESS    | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolessthan05EmptyFalse        | GENDER    | snowflakeTag,Snowflake,Snowflake_BA,GENDER        | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolessthan05EmptyFalse        | EMAIL     | snowflakeTag,Snowflake,Snowflake_BA,EMAIL ADDRESS | ColumnQuerywithSchema | TagAssigned    |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY                         | FULL_NAME | FULL NAME1                                        | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY                         | GENDER    | GENDER1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY                         | SSN       | S S SN1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY                         | EMAIL     | EMAIL ADDRESS1                                    | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY                         | IPADDRESS | IP ADDRESS1                                       | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | FULL NAME1                                        | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | GENDER1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | IP ADDRESS1                                       | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | S S SN1                                           | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | EMAIL ADDRESS1                                    | ColumnQuerywithSchema | TagNotAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#66_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer% | Analysis |       |       |
###############################################################################################################################################################################
#
  @MLP-20518 @sanity @positive @regression @snowflake @PIITag
  Scenario Outline:SC#67: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                    | path              | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                     | payloads/ida/snowflakePayloads/policyEngine/PIITags.json                    | $.SC67            | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               | payloads/ida/snowflakePayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               |                                                                             |                   | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger   |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 | payloads/ida/snowflakePayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig  | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 |                                                                             |                   | 200           | SnowflakeDBAnalyzer  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |

  @positve @regression @sanity  @PIITag
  Scenario:SC#67: Verify Tag is set for the column when namePattern,typePattern,dataPattern and minimumRatio is passed which has a regexp and minimum ratio that matches with the data in column in snowflake table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                  | ServiceName | DatabaseName | SchemaName          | TableName/Filename                   | Column    | Tags                                              | Query                 | Action      |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolessthan05EmptyFalse | EMAIL     | snowflakeTag,Snowflake,Snowflake_BA,EMAIL ADDRESS | ColumnQuerywithSchema | TagAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolessthan05EmptyFalse | GENDER    | snowflakeTag,Snowflake,Snowflake_BA,GENDER        | ColumnQuerywithSchema | TagAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolessthan05EmptyFalse | IPADDRESS | snowflakeTag,Snowflake,Snowflake_BA,IP ADDRESS    | ColumnQuerywithSchema | TagAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolessthan05EmptyFalse | SSN       | snowflakeTag,Snowflake,Snowflake_BA,S S N         | ColumnQuerywithSchema | TagAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolessthan05EmptyFalse | FULL_NAME | snowflakeTag,Snowflake,Snowflake_BA,FULL NAME     | ColumnQuerywithSchema | TagAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#67_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer% | Analysis |       |       |
#################################################################################################################################################################
#
  @MLP-20518 @sanity @positive @regression @snowflake @PIITag
  Scenario Outline:SC#68: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                    | path              | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                     | payloads/ida/snowflakePayloads/policyEngine/PIITags.json                    | $.SC68            | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               | payloads/ida/snowflakePayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               |                                                                             |                   | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger   |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 | payloads/ida/snowflakePayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig  | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 |                                                                             |                   | 200           | SnowflakeDBAnalyzer  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |

  @positve @regression @sanity  @PIITag
  Scenario:SC#68: Verify Tag is set for the column when dataPattern and minimumRatio(equal to 0.5) is passed which has a regexp that matches with the data in column in snowflake table.
  (Ex: 0.5 - 5 or more rows should have matching column values) - Match Empty is false.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                  | ServiceName | DatabaseName | SchemaName          | TableName/Filename                  | Column    | Tags                                              | Query                 | Action      |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_RatioEqualTo05EmptyFalse | EMAIL     | snowflakeTag,Snowflake,Snowflake_BA,EMAIL ADDRESS | ColumnQuerywithSchema | TagAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_RatioEqualTo05EmptyFalse | GENDER    | snowflakeTag,Snowflake,Snowflake_BA,GENDER        | ColumnQuerywithSchema | TagAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_RatioEqualTo05EmptyFalse | IPADDRESS | snowflakeTag,Snowflake,Snowflake_BA,IP ADDRESS    | ColumnQuerywithSchema | TagAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_RatioEqualTo05EmptyFalse | SSN       | snowflakeTag,Snowflake,Snowflake_BA,S S N         | ColumnQuerywithSchema | TagAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_RatioEqualTo05EmptyFalse | FULL_NAME | snowflakeTag,Snowflake,Snowflake_BA,FULL NAME     | ColumnQuerywithSchema | TagAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#68_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer% | Analysis |       |       |


##    ##########################################################################################################################################################
#
  @MLP-20518 @sanity @positive @regression @snowflake @PIITag
  Scenario Outline:SC#69: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                    | path              | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                     | payloads/ida/snowflakePayloads/policyEngine/PIITags.json                    | $.SC69            | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               | payloads/ida/snowflakePayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               |                                                                             |                   | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger   |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 | payloads/ida/snowflakePayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig  | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 |                                                                             |                   | 200           | SnowflakeDBAnalyzer  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |

  @positve @regression @sanity  @PIITag
  Scenario:SC#69:Verify Tag is not set for the column when namePattern(does not match) and dataPattern/minimumRatio that does not matches with the column name/value ratio in snowflake table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                  | ServiceName | DatabaseName | SchemaName          | TableName/Filename  | Column    | Tags          | Query                 | Action         |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY | FULL_NAME | FULL NAME     | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY | GENDER    | GENDER1       | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY | SSN       | S S SN        | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY | EMAIL     | EMAIL ADDRESS | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLEMPTY | IPADDRESS | IP ADDRESS    | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH | FULL_NAME | FULL NAME     | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH | GENDER    | GENDER        | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH | SSN       | S S SN        | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH | EMAIL     | EMAIL ADDRESS | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_ALLMATCH | IPADDRESS | IP ADDRESS    | ColumnQuerywithSchema | TagNotAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#69_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer% | Analysis |       |       |


#
##    #######################################################################################################################################################3
#
  @MLP-20518 @sanity @positive @regression @snowflake @PIITag
  Scenario Outline:SC#70a: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                    | path              | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                     | payloads/ida/snowflakePayloads/policyEngine/PIITags.json                    | $.SC70a           | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               | payloads/ida/snowflakePayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               |                                                                             |                   | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger   |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 | payloads/ida/snowflakePayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig  | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 |                                                                             |                   | 200           | SnowflakeDBAnalyzer  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |

  @positve @regression @sanity  @PIITag
  Scenario:SC#70a: Verify Tag is not set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in snowflake table.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is False -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                  | ServiceName | DatabaseName | SchemaName          | TableName/Filename                          | Column    | Tags                                              | Query                 | Action         |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | FULL NAME                                         | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | GENDER                                            | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | S S N                                             | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | IP ADDRESS                                        | ColumnQuerywithSchema | TagNotAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | snowflakeTag,Snowflake,Snowflake_BA,EMAIL ADDRESS | ColumnQuerywithSchema | TagAssigned    |


  @MLP-20518 @sanity @positive @regression @snowflake @PIITag
  Scenario Outline:SC#70b: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                    | path              | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                     | payloads/ida/snowflakePayloads/policyEngine/PIITags.json                    | $.SC70b           | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |

  @positve @regression @sanity  @PIITag
  Scenario:SC#70b: Verify Tag is set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in snowflake table.
  (Ex: 0.6 - 6 or more rows should have matching column values including empty) - Match Empty is False -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                  | ServiceName | DatabaseName | SchemaName          | TableName/Filename                          | Column    | Tags                                              | Query                 | Action      |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | snowflakeTag,Snowflake,Snowflake_BA,EMAIL ADDRESS | ColumnQuerywithSchema | TagAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | snowflakeTag,Snowflake,Snowflake_BA,GENDER        | ColumnQuerywithSchema | TagAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | snowflakeTag,Snowflake,Snowflake_BA,IP ADDRESS    | ColumnQuerywithSchema | TagAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | snowflakeTag,Snowflake,Snowflake_BA,S S N         | ColumnQuerywithSchema | TagAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | snowflakeTag,Snowflake,Snowflake_BA,FULL NAME     | ColumnQuerywithSchema | TagAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#70b_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer% | Analysis |       |       |

###########################################################Scenario Outline: SC71#-MLP_24889_Verify ##################################

  #7241542
  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC71#-MLP_24889_Verify SnowflakeAnalyzer analyzes multiple DB when more than one DB is cataloged by Cataloger.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                      | bodyFile                                                                             | path                                        | response code | response message                                    | jsonPath                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBDataSource/SnowflakeDS1                                                    | payloads/ida/snowflakePayloads/DataSource/SnowflakeValidDataSourceConfig_DiffDB.json | $.SnowflakeDS1                              | 204           |                                                     |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBDataSource/SnowflakeDS1                                                    |                                                                                      |                                             | 200           | SnowflakeDS1                                        |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBDataSource/SnowflakeDS2                                                    | payloads/ida/snowflakePayloads/DataSource/SnowflakeValidDataSourceConfig_DiffDB.json | $.SnowflakeDS2                              | 204           |                                                     |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBDataSource/SnowflakeDS2                                                    |                                                                                      |                                             | 200           | SnowflakeDS2                                        |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBDataSource/SnowflakeValidDataSource_TEST_DEFAULT_CONFIGURATION             | payloads/ida/snowflakePayloads/DataSource/SnowflakeValidDataSourceConfig_DiffDB.json | $.DefaultTestConnectionConfig               | 204           |                                                     |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBDataSource/SnowflakeValidDataSource_TEST_DEFAULT_CONFIGURATION             |                                                                                      |                                             | 200           | SnowflakeValidDataSource_TEST_DEFAULT_CONFIGURATION |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/Snowflakew_TEST_DB                                               | payloads/ida/snowflakePayloads/DataSource/SnowflakeValidDataSourceConfig_DiffDB.json | $.SnowflakewPlugin_TEST_DB                  | 204           |                                                     |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/Snowflakew_TEST_DB                                               |                                                                                      |                                             | 200           | Snowflakew_TEST_DB                                  |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/Snowflakew_TEST_DB                  |                                                                                      |                                             | 200           | IDLE                                                | $.[?(@.configurationName=='Snowflakew_TEST_DB')].status                  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/Snowflakew_TEST_DB                   |                                                                                      |                                             | 200           |                                                     |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/Snowflakew_TEST_DB                  |                                                                                      |                                             | 200           | IDLE                                                | $.[?(@.configurationName=='Snowflakew_TEST_DB')].status                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/Snowflakew_SNOWFLAKE_SAMPLE_DATA_DB                              | payloads/ida/snowflakePayloads/DataSource/SnowflakeValidDataSourceConfig_DiffDB.json | $.SnowflakewPlugin_SNOWFLAKE_SAMPLE_DATA_DB | 204           |                                                     |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/Snowflakew_SNOWFLAKE_SAMPLE_DATA_DB                              |                                                                                      |                                             | 200           | Snowflakew_SNOWFLAKE_SAMPLE_DATA_DB                 |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/Snowflakew_SNOWFLAKE_SAMPLE_DATA_DB |                                                                                      |                                             | 200           | IDLE                                                | $.[?(@.configurationName=='Snowflakew_SNOWFLAKE_SAMPLE_DATA_DB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/Snowflakew_SNOWFLAKE_SAMPLE_DATA_DB  |                                                                                      |                                             | 200           |                                                     |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/Snowflakew_SNOWFLAKE_SAMPLE_DATA_DB |                                                                                      |                                             | 200           | IDLE                                                | $.[?(@.configurationName=='Snowflakew_SNOWFLAKE_SAMPLE_DATA_DB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer_DiffDatabase                                  | payloads/ida/snowflakePayloads/DataSource/SnowflakeValidDataSourceConfig_DiffDB.json | $.SnowflakeAnalyzerDiffDatabaseTableFilter  | 204           |                                                     |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer_DiffDatabase                                  |                                                                                      |                                             | 200           | SnowflakeDBAnalyzer_DiffDatabase                    |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer_DiffDatabase  |                                                                                      |                                             | 200           | IDLE                                                | $.[?(@.configurationName=='SnowflakeDBAnalyzer_DiffDatabase')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer_DiffDatabase   |                                                                                      |                                             | 200           |                                                     |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer_DiffDatabase  |                                                                                      |                                             | 200           | IDLE                                                | $.[?(@.configurationName=='SnowflakeDBAnalyzer_DiffDatabase')].status    |


  @positve @regression @sanity @webtest
  Scenario:SC71#Verify analyzer does analysis for multiple db Tables in catalog.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "snowflakeTag_DiffDatabase" and clicks on search
    And user performs "facet selection" in "snowflakeTag_DiffDatabase" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "SCHOOL" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then user performs click and verify in new window
      | Table   | value    | Action               | RetainPrevwindow | indexSwitch |
      | Columns | SCHOOLID | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Columns | SCHOOLNAME | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table | value                 | Action               | RetainPrevwindow | indexSwitch |
      | Table | snowflakecsvexttable1 | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch |
      | Columns | FLOATTYPE | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Columns | BOOLEANTYPE | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value    | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DATETYPE | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value        | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DATETIMETYPE | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value            | Action               | RetainPrevwindow | indexSwitch |
      | Columns | TIMESTAMPLTZTYPE | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value           | Action               | RetainPrevwindow | indexSwitch |
      | Columns | TIMESTAMPTZTYPE | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value    | Action               | RetainPrevwindow | indexSwitch |
      | Columns | TIMETYPE | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user navigates to the index "3" to perform actions
    Then user performs click and verify in new window
      | Table     | value                 | Action               | RetainPrevwindow | indexSwitch |
      | Databases | SNOWFLAKE_SAMPLE_DATA | click and switch tab | No               |             |
      | Schemas   | TPCH_SF001            | click and switch tab | No               |             |
      | Tables    | CUSTOMER              | click and switch tab | No               |             |
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch |
      | Columns | C_CUSTKEY | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value   | Action               | RetainPrevwindow | indexSwitch |
      | Columns | C_PHONE | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table  | value  | Action               | RetainPrevwindow | indexSwitch |
      | Tables | NATION | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |

     ########################################################Data Sample validation############################################################################

  Scenario Outline:SC71:user get the Dynamic ID's (Database ID) for the Schema "TEST_SNOWSchemaAuto,TPCH_SF001" and Table "NATION,CUSTOMER,SCHOOL and snowflakecsvexttable1"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type   | name                | asg_scopeid           | targetFile                                    | jsonpath                                 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | TPCH_SF001          | NATION                | payloads/ida/snowflakePayloads/API/items.json | $.Snowflake.Tables.NATION                |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | TPCH_SF001          | CUSTOMER              | payloads/ida/snowflakePayloads/API/items.json | $.Snowflake.Tables.CUSTOMER              |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | TEST_SNOWSchemaAuto | SCHOOL                | payloads/ida/snowflakePayloads/API/items.json | $.Snowflake.Tables.SCHOOL                |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | TEST_SNOWSchemaAuto | snowflakecsvexttable1 | payloads/ida/snowflakePayloads/API/items.json | $.Snowflake.Tables.snowflakecsvexttable1 |

  Scenario Outline: SC71:user hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                                | inputFile                                     | outPutFile                                                           | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Snowflake.Tables.NATION                | payloads/ida/snowflakePayloads/API/items.json | payloads\ida\snowflakePayloads\API\Actual\NATION.json                |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Snowflake.Tables.CUSTOMER              | payloads/ida/snowflakePayloads/API/items.json | payloads\ida\snowflakePayloads\API\Actual\CUSTOMER.json              |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Snowflake.Tables.SCHOOL                | payloads/ida/snowflakePayloads/API/items.json | payloads\ida\snowflakePayloads\API\Actual\SCHOOL.json                |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Snowflake.Tables.snowflakecsvexttable1 | payloads/ida/snowflakePayloads/API/items.json | payloads\ida\snowflakePayloads\API\Actual\snowflakecsvexttable1.json |            |

#7152591
  Scenario: SC#71 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\snowflakePayloads\API\Actual\NATION.json" should be same as the content in "ida\snowflakePayloads\API\Expected\NATION.json"
    Then file content in "ida\snowflakePayloads\API\Actual\CUSTOMER.json" should be same as the content in "ida\snowflakePayloads\API\Expected\CUSTOMER.json"
    Then file content in "ida\snowflakePayloads\API\Actual\SCHOOL.json" should be same as the content in "ida\snowflakePayloads\API\Expected\SCHOOL.json"
    Then file content in "ida\snowflakePayloads\API\Actual\snowflakecsvexttable1.json" should be same as the content in "ida\snowflakePayloads\API\Expected\snowflakecsvexttable1.json"


  @sanity @positive @regression
  Scenario:SC#71_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/%             | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SnowflakeDBAnalyzer/%           | Analysis |       |       |

#     #######################################################################################################################################################
#

  @MLP-20518 @sanity @positive @regression @snowflake @PIITag
  Scenario Outline:SC#71a: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                    | path              | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                     | payloads/ida/snowflakePayloads/policyEngine/PIITags.json                    | $.SC71a           | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               | payloads/ida/snowflakePayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               |                                                                             |                   | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger   |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 | payloads/ida/snowflakePayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig  | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 |                                                                             |                   | 200           | SnowflakeDBAnalyzer  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |

  @positve @regression @sanity  @PIITag
  Scenario:SC#71a: Verify Tag is not set for the column when MatchFull:true, dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the exact data in column in snowflake table.
  (Ex: 0.6 - 6 or more rows should have matcning column values - dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                  | ServiceName | DatabaseName | SchemaName          | TableName/Filename                         | Column   | Tags      | Query                 | Action         |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | COMMENTS | FullMatch | ColumnQuerywithSchema | TagNotAssigned |

  @MLP-20518 @sanity @positive @regression @snowflake @PIITag
  Scenario Outline:SC#71b: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                    | path              | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                     | payloads/ida/snowflakePayloads/policyEngine/PIITags.json                    | $.SC71b           | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |

  @positve @regression @sanity  @PIITag
  Scenario:SC#71b: Verify Tag is set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in snowflake table.
  (Ex: 0.6 - 6 or more rows should have matching column values including empty) - Match Empty is False -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                  | ServiceName | DatabaseName | SchemaName          | TableName/Filename                         | Column   | Tags                                          | Query                 | Action      |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | COMMENTS | snowflakeTag,Snowflake,Snowflake_BA,FullMatch | ColumnQuerywithSchema | TagAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#71b_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer% | Analysis |       |       |

#    ############################################################################################################################################################

  @MLP-20518 @sanity @positive @regression @snowflake @PIITag
  Scenario Outline:SC#72a: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                                    | path              | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                     | payloads/ida/snowflakePayloads/policyEngine/PIITags.json                    | $.SC72a           | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               | payloads/ida/snowflakePayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCataloger                               |                                                                             |                   | 200           | SnowflakeDBCataloger |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger   |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger  |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 | payloads/ida/snowflakePayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig  | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer                                 |                                                                             |                   | 200           | SnowflakeDBAnalyzer  |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                                             |                   | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                                             |                   | 200           | IDLE                 | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status  |

  @positve @regression @sanity  @PIITag
  Scenario:SC#72a: Verify Tag is not set for the column when MatchFull:true, dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the exact data in column in snowflake table.
  (Ex: 0.6 - 6 or more rows should have matcning column values - dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                  | ServiceName | DatabaseName | SchemaName          | TableName/Filename                        | Column   | Tags      | Query                 | Action         |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolesserthan05MatchFullTrue | COMMENTS | FullMatch | ColumnQuerywithSchema | TagNotAssigned |

  @MLP-20518 @sanity @positive @regression @snowflake @PIITag
  Scenario Outline:SC#72b: Create snowflake Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                 | path    | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                     | payloads/ida/snowflakePayloads/policyEngine/PIITags.json | $.SC72b | 204           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                          |         | 200           | IDLE             | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer  |                                                          |         | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer |                                                          |         | 200           | IDLE             | $.[?(@.configurationName=='SnowflakeDBAnalyzer')].status |

  @positve @regression @sanity  @PIITag
  Scenario:SC#72b: Verify Tag is set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in snowflake table.
  (Ex: 0.6 - 6 or more rows should have matching column values including empty) - Match Empty is False -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                  | ServiceName | DatabaseName | SchemaName          | TableName/Filename                        | Column   | Tags                                          | Query                 | Action      |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | TAGDETAILS_Ratiolesserthan05MatchFullTrue | COMMENTS | snowflakeTag,Snowflake,Snowflake_BA,FullMatch | ColumnQuerywithSchema | TagAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#72b_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | asg_partner.us-east-1.snowflakecomputing.com          | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCataloger%  | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/SnowflakeDBAnalyzer/SnowflakeDBAnalyzer% | Analysis |       |       |


  @sanity @positive @regression @PIITag
  Scenario Outline: SC#76 - Delete policy tags
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                        | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | policy/tagging/analysis?dataType=STRUCTURED&pluginName=SnowflakeDBAnalyzer |          |      | 204           |                  |          |


  @MLP-21661 @sanity @positive @regression @snowflake
  Scenario Outline: SC#76-Delete Credentials, Datasource ,cataloger and Analyzer config for SnowflakeDBCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                              | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidSnowflakeCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/InvalidSnowflakeCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EmptySnowflakeCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SnowflakeDBDataSource         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SnowflakeDBCataloger          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SnowflakeDBAnalyzer           |      | 204           |                  |          |
