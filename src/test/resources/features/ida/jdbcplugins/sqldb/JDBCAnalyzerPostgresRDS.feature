Feature:Postgres cataloger/analyzer testing in AWS
  Description: MLP-24830 - Postgres cataloger testing in AWS

  @precondition
  Scenario: MLP-24830:SC1#Update credential payload json for PostgressDB
    Given User update the below "Postgres AWS Credentials" in following files using json path
      | filePath                                                            | username    | password    |
      | ida/postgressPayloads/credentials/awspostgressValidCredentials.json | $..userName | $..password |

  @sanity @positive
  Scenario Outline: Configure the Credentials for PostgressDBDatasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                | body                                                                | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidPostgressCredentials     | ida/postgressPayloads/Credentials/awspostgressValidCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/IncorrectPostgressCredentials | ida/postgressPayloads/Credentials/postgressInvalidCredentials.json  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/EmptyPostgressCredentials     | ida/postgressPayloads/Credentials/postgressEmptyCredentials.json    | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidPostgressCredentials     |                                                                     | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/IncorrectPostgressCredentials |                                                                     | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/EmptyPostgressCredentials     |                                                                     | 200           |                  |          |


  @sanity @positive @regression
  Scenario Outline: Create BusinessApplication tag and run the plugin configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                            | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/postgressPayloads/BussinessApplication.json | 200           |                  |          |

  @positive @regression @sanity @webtest
  Scenario:SC01#Verify whether the background of the panel is displayed in green when connection is successful in Step1 pop up when user logs in for the first time in Local Node
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Settings Icon                                      |
      | click      | Manage Data Sources                                |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute              |
      | Data Source Type | PostgreSQLDBDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                                             |
      | Name      | PostgressDB_DataSource                                                                |
      | Label     | PostgressDB_DataSource                                                                |
      | URL       | jdbc:postgresql://ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com:5432/postgres |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                 |
      | Credential | ValidPostgressCredentials |
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute |
      | Node      | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
    And user "click" on "Save" button in "Add Data Sources Page"


  @webtest @negative @regression
  Scenario:SC02#Verify whether the background of the panel is displayed in red when connection is unsuccessful due to invalid / Empty credentials in Local Node
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Settings Icon                                      |
      | click      | Manage Data Sources                                |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute              |
      | Data Source Type | PostgreSQLDBDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                                             |
      | Name      | PostgresDB_InvalidDataSource                                                          |
      | Label     | PostgresDB_InvalidDataSource                                                          |
      | URL       | jdbc:postgresql://ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com:5432/postgres |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                     |
      | Credential | IncorrectPostgressCredentials |
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute |
      | Node      | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "No connection with data source - Password authentication failed for user" is "displayed" in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                 |
      | Credential | EmptyPostgressCredentials |
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute |
      | Node      | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "No connection with data source - Password authentication failed for user" is "displayed" in "Add Data Sources Page"


  @webtest @negative
  Scenario:SC03#Verify newly introduced fields in PostgressDBcataloger
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
      | fieldName   | attribute                     |
      | Type        | Cataloger                     |
      | Plugin      | PostgreSQLDBCataloger         |
      | Data Source | PostgressDB_DataSource        |
      | Credential  | IncorrectPostgressCredentials |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute           |
      | Name      | Postgress_Cataloger |

    ##6822671##
  @MLP-23777 @positive @sanity @webtest
  Scenario:SC04# Verify proper error message is shown if mandatory fields are not filled in PostgressDBDataSource plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Settings Icon                                      |
      | click      | Manage Data Sources                                |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute              |
      | Type      | PostgreSQLDBDataSource |
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
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  #6822672
  @MLP-23777 @positive @sanity @webtest
  Scenario:SC05# Verify error message is displayed when providing incorrect Postgress url in url field
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Settings Icon                                      |
      | click      | Manage Data Sources                                |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute              |
      | Type      | PostgreSQLDBDataSource |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Name      | /         |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                                                                                    |
      | URL       | jdbc1:redshift://redshift-cluster-1.cfemcchdhpao.us-east-2.redshift.amazonaws.com:5439/world |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage                                                                                     |
      | Name      | Invalid name. Leading/trailing blanks and special characters are forbidden                            |
      | URL       | UnSupported PosgreSQL JDBC URL Format. Sample Format : jdbc:postgresql://<hostname>:<port>/<database> |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


#6938866
  @MLP-23777 @webtest @positive @regression @sanity @IDA-10.3 @pluginManager
  Scenario: SC#06- Verify proper error message is shown if mandatory fields are not filled in PostgressDBCataloger configuration page
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
      | fieldName | attribute             |
      | Type      | Cataloger             |
      | Plugin    | PostgreSQLDBCataloger |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  @MLP-23777 @webtest @positive @regression @sanity
  Scenario: SC#07- Verify if all the mandatory fields (Name) are throwing with proper error message if they are left blank in PostgressDBDatasource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Settings Icon                                      |
      | click       | Settings Icon                                      |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute              |
      | Data Source Type | PostgreSQLDBDataSource |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @MLP-23777 @webtest @positive @regression @sanity
  Scenario: SC#08-Verify captions and tool tip text in PostgreSQLDBDataSource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Settings Icon                                      |
      | click       | Settings Icon                                      |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute              |
      | Data Source Type | PostgreSQLDBDataSource |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                 |
      | Label                 |
      | URL*                  |
      | Driver Bundle Name*   |
      | Driver Bundle Version |
      | Credential*           |
      | Node                  |


  @MLP-23777 @webtest @positive @regression @sanity
  Scenario: SC#09-Verify captions and tool tip text in PostgressSqlDBCataloger
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
      | fieldName | attribute             |
      | Type      | Cataloger             |
      | Plugin    | PostgreSQLDBCataloger |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                |
      | Label                |
      | Business Application |
      | Data Source*         |
      | Credential*          |


   #6822675
  Scenario Outline:MLP-23777:SC10#Run the Plugin configurations for DataSource and PostgresDBCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                       | response code | response message         | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBDataSource                                              | ida/postgressPayloads/DataSource/PostgressAWSValidDataSourceConfig.json    | 204           |                          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBDataSource                                              |                                                                            | 200           | PostgressValidDataSource |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger                                               | ida/postgressPayloads/PluginConfiguration/PostgressConfigWithNoFilter.json | 204           |                          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBCataloger                                               |                                                                            | 200           | PostgreCataloger         |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                            | 200           | IDLE                     | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                            | 200           |                          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                            | 200           | IDLE                     | $.[?(@.configurationName=='PostgreCataloger')].status |


    ##6501266##
  @webtest @MLP-23777 @sanity @positive @regression
  Scenario:SC#10: Verify the Database Name and Service should have the appropriate metadata information in IDC UI.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "postgres" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue  | widgetName  |
      | Storage type      | PostgreSQL12.3 | Description |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PostgreSQL" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute   | metaDataValue  | widgetName  |
      | Application Version | PostgreSQL12.3 | Description |


  @webtest @MLP-23777 @sanity @positive @regression
  Scenario: SC#11: Verify the Host should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Host" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                         | widgetName  |
      | Host name         | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | Description |
      | Number of cores   | 0                                                     | Statistics  |


  @webtest @MLP-23777 @sanity @positive @regression
  Scenario: SC#12: Verify the TableName should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CLASS" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |


  @webtest @MLP-23777 @sanity @positive @regression
  Scenario: SC#13: Verify the ColumnName should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user enters the search text "SCHOOL [Table]" and clicks on search
    And user performs "facet selection" in "SCHOOL [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "studentid" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | INTEGER       | Description |
      | Length            | 10            | Statistics  |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |

  @webtest @MLP-23777 @sanity @positive @regression
  Scenario: SC#14: Verify User defined data types will be cataloged as UDT and user defined type domain is cataloged as DISTINCT
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user enters the search text "userdefinedtypedomaintable [Table]" and clicks on search
    And user performs "facet selection" in "userdefinedtypedomaintable [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "first_name" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | DISTINCT      | Description |
      | Length            | 2147483647    | Statistics  |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user enters the search text "bug [Table]" and clicks on search
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "status" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | UDT           | Description |
      | Length            | 2147483647    | Statistics  |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |

  @webtest @MLP-23777 @sanity @positive @regression
  Scenario: SC#14: Verify the Constraint should have appropriate metadata information in IDC UI.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user enters the search text "SCHOOL [Table]" and clicks on search
    And user performs "facet selection" in "SCHOOL [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "pkey1" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Constraint Type   | PRIMARY_KEY   | Description |


  @webtest @MLP-23777 @sanity @positive @regression
  Scenario: SC#15: Verify the primary key,foreign key,Unique key,index constraint are getting collected properly.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user enters the search text "SCHOOL [Table]" and clicks on search
    And user performs "facet selection" in "SCHOOL [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "pkey1" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Constraint Type   | PRIMARY_KEY   | Description |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user enters the search text "SCHOOL [Table]" and clicks on search
    And user performs "facet selection" in "SCHOOL [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "fkey1" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Constraint Type   | FOREIGN_KEY   | Description |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user enters the search text "postgresstestschema [Schema]" and clicks on search
    And user performs "facet selection" in "employee [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ukey" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Constraint Type   | UNIQUE        | Description |
    And user enters the search text "table_primary [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "table_primary [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "postgres_testindex" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Constraint Type   | INDEX         | Description |


  @webtest @MLP-23777 @sanity @positive @regression
  Scenario: SC#16: Verify the Postgres Table should not have constraints window if the table is not having any constraints.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "country" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "country" item from search results
    Then user verify "catalog not contains" any "Constriant" attribute under "Type" facets


  @sanity @positive @webtest
  Scenario: SC17# Verify the technology tags got assigned to all PostgressDB items like Cluster,Service,Database...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "PostgreSQL,PostgressTag1,Postgress_BA" should get displayed for the column "cataloger/PostgreSQLDBCataloger"
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                   | fileName                                              | userTag      |
      | Default     | Cluster    | Metadata Type | PostgreSQL,PostgressTag1,Postgress_BA | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | Postgress_BA |
      | Default     | Host       | Metadata Type | PostgreSQL,PostgressTag1,Postgress_BA | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | Postgress_BA |
      | Default     | Column     | Metadata Type | PostgreSQL,PostgressTag1,Postgress_BA | first_name                                            | Postgress_BA |
      | Default     | Constraint | Metadata Type | PostgreSQL,PostgressTag1,Postgress_BA | employee_pkey                                         | Postgress_BA |
      | Default     | Database   | Metadata Type | PostgreSQL,PostgressTag1,Postgress_BA | postgres                                              | Postgress_BA |
      | Default     | Schema     | Metadata Type | PostgreSQL,PostgressTag1,Postgress_BA | postgresstestschema                                   | Postgress_BA |
      | Default     | Service    | Metadata Type | PostgreSQL,PostgressTag1,Postgress_BA | PostgreSQL                                            | Postgress_BA |
      | Default     | Table      | Metadata Type | PostgreSQL,PostgressTag1,Postgress_BA | employee                                              | Postgress_BA |


    ##6402492##6402626##
  @webtest @MLP-23777 @sanity @positive @regression
  Scenario:SC#18: Verify PostgressDBCataloger scans and collects data if schema name and table names are not provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "postgres" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage       | queryField          | columnName  | queryOperation   | storeResults  |
      | AWSPOSTGRES  | STRUCTURED   | json/IDA.json | postgresQueries | getPostgressSchemas | schema_name | returnstringlist | resultsInList |
    And user "verifies" the "Schemas" Item view page result "list" value with Postgres DB
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "postgresstestschema" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage       | queryField                 | columnName | queryOperation   | storeResults  |
      | AWSPOSTGRES  | STRUCTURED   | json/IDA.json | postgresQueries | getPostgressTablesInSchema | table_name | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB

    #6754453#
  @sanity @positive @MLP-23777 @webtest @IDA-1.1.0
  Scenario:SC19#Verify log entries/log enhancements(processed Items widget and Processed count) check for PostgressDBCataloger plugin logs.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/PostgreSQLDBCataloger/PostgreCataloger%"
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com |
      | PostgreSQL                                            |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/PostgreSQLDBCataloger/PostgreCataloger%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | logCode       | pluginName            | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0019 |                       |                |
      | INFO | Plugin Name:PostgreSQLDBCataloger, Plugin Type:cataloger, Plugin Version:1.1.0.SNAPSHOT, Node Name:AWS Node, Host Name:fac95ee5f67f, Plugin Configuration name:PostgreCataloger                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0071 | PostgreSQLDBCataloger | Plugin Version |
      | INFO | Plugin PostgreSQLDBCataloger Configuration: ---  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: name: "PostgreCataloger"  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: pluginVersion: "LATEST"  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: label:  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: : ""  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: catalogName: "Default"  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: eventClass: null  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: eventCondition: null  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: nodeCondition: null  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: maxWorkSize: 100  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: tags:  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: - "PostgressTag1"  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: pluginType: "cataloger"  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: dataSource: "PostgressValidDataSource"  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: credential: "ValidPostgressCredentials"  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: businessApplicationName: "Postgress_BA"  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: dryRun: false  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: schedule: null  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: filter: null  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: pluginName: "PostgreSQLDBCataloger"  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: schemas: []  2020-09-26 19:15:16.658 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: type: "Cataloger"  2020-09-26 19:15:16.659 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: properties: []  2020-09-26 19:15:16.659 | ANALYSIS-0073 | PostgreSQLDBCataloger |                |
      | INFO | Plugin PostgreSQLDBCataloger Start Time:2020-07-10 20:18:33.387, End Time:2020-07-10 20:18:34.196, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0072 | PostgreSQLDBCataloger |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:35.865)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0020 |                       |                |

  @positve @regression @sanity @webtest
  Scenario:SC20#Verify the breadcrumb hierarchy appears correctly when JDBC cataloger is ran for Postgress Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "customer [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "createdate" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com |
      | PostgreSQL                                            |
      | postgres                                              |
      | postgresstestschema                                   |
      | customer                                              |
      | createdate                                            |


    ##6501267##
  @webtest @MLP-23777 @sanity @positive @regression
  Scenario:SC#21: Verify the different types of Views should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DiffDataTypesMinimizedView" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
      | Created by        | postgres      | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "customerviewwithjoin" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
      | Created by        | postgres      | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user enters the search text "updatablecityview [Table]" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "updatablecityview" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
      | Created by        | postgres      | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "cityviewwithcheckoption" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
      | Created by        | postgres      | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "childcityview" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
      | Created by        | postgres      | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "childcityviewwithlocal" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
      | Created by        | postgres      | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "materializedviewwithdata" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | MATERIALIZED  | Description |
      | Created by        | postgres      | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "managertreerecursive" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
      | Created by        | postgres      | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |

##6501267##
  @webtest @MLP-23777 @sanity @positive @regression
  Scenario:SC#22: Verify Sql Source content should appear under Data widget under different Views collected by PostgressDBCataloger.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DiffDataTypesMinimizedView" item from search results
    Then user performs click and verify in new window
      | Table     | value                      | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | DiffDataTypesMinimizedView | click and switch tab | No               |             |
    Then sync the test execution for "10" seconds
    Then the "Data" metadata of item "DiffDataTypesMinimizedView" should be as expected
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "customerviewwithjoin" item from search results
    Then user performs click and verify in new window
      | Table     | value                | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | customerviewwithjoin | click and switch tab | No               |             |
    Then sync the test execution for "10" seconds
    Then the "Data" metadata of item "customerviewwithjoin" should be as expected
    And user enters the search text "updatablecityview [Table]" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "updatablecityview" item from search results
    Then user performs click and verify in new window
      | Table     | value             | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | updatablecityview | click and switch tab | No               |             |
    Then sync the test execution for "10" seconds
    Then the "Data" metadata of item "updatablecityview" should be as expected
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "cityviewwithcheckoption" item from search results
    Then user performs click and verify in new window
      | Table     | value                   | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | cityviewwithcheckoption | click and switch tab | No               |             |
    Then sync the test execution for "10" seconds
    Then the "Data" metadata of item "cityviewwithcheckoption" should be as expected
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "childcityview" item from search results
    Then user performs click and verify in new window
      | Table     | value         | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | childcityview | click and switch tab | No               |             |
    Then sync the test execution for "10" seconds
    Then the "Data" metadata of item "childcityview" should be as expected
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "childcityviewwithlocal" item from search results
    Then user performs click and verify in new window
      | Table     | value                  | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | childcityviewwithlocal | click and switch tab | No               |             |
    Then sync the test execution for "10" seconds
    Then the "Data" metadata of item "childcityviewwithlocal" should be as expected
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "materializedviewwithdata" item from search results
    Then user performs click and verify in new window
      | Table     | value                    | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | materializedviewwithdata | click and switch tab | No               |             |
    Then sync the test execution for "10" seconds
    Then the "Data" metadata of item "materializedviewwithdata" should be as expected
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "managertreerecursive" item from search results
    Then user performs click and verify in new window
      | Table     | value                | Action               | RetainPrevwindow | indexSwitch |
      | SQLSource | managertreerecursive | click and switch tab | No               |             |
    Then sync the test execution for "10" seconds
    Then the "Data" metadata of item "managertreerecursive" should be as expected


#    ##6549303##
#  @sanity @positive @webtest @edibus
#  Scenario:SC23#Verify the PostgresSQL items are replicated to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "POSTGRES CATALOG" catalog and search "POSTGRES CATALOG" items at top end
#    And user enters the search text "PostgreSQL" and clicks on search
#    And user performs "facet selection" in "PostgreSQL" attribute under "Tags" facets in Item Search results page
#    And user "verifies presence" for listed "Type" facet in Search results page
#      | Column     |
#      | Table      |
#      | Constraint |
#      | Analysis   |
#      | Cluster    |
#      | Service    |
#      | Host       |
#      | Database   |
#      | Schema     |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/EDIBusPostgresConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                 | body                                         | response code | response message | jsonPath                                            |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/EDIBusPostgresConfig.json | 204           |                  |                                                     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusPostgres |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusPostgres')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusPostgres  |                                              | 200           |                  |                                                     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusPostgres |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBusPostgres')].status |
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "POSTGRES CATALOG" catalog and search "POSTGRES CATALOG" items at top end
#    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
#    And user performs "dynamic item click" on "EDIBusPostgres" item from search results
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "POSTGRES CATALOG" catalog and search "POSTGRES CATALOG" items at top end
#    And user performs "facet selection" in "PostgreSQL" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                          | body | response code | response message | jsonPath |
#      |        |       |       | Get  | searches/POSTGRES%20CATALOG/list/Column?what=name&limit=1000 |      | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "POSTGRES CATALOG" catalog and search "POSTGRES CATALOG" items at top end
#    And user performs "facet selection" in "PostgreSQL" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                          |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW) |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                         | body | response code | response message | jsonPath |
#      |        |       |       | Get  | searches/POSTGRES%20CATALOG/list/Table?what=name&limit=1000 |      | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "POSTGRES CATALOG" catalog and search "POSTGRES CATALOG" items at top end
#    And user performs "facet selection" in "PostgreSQL" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Database" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                            | body | response code | response message | jsonPath |
#      |        |       |       | Get  | searches/POSTGRES%20CATALOG/list/Database?what=name&limit=1000 |      | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "POSTGRES CATALOG" catalog and search "POSTGRES CATALOG" items at top end
#    And user performs "facet selection" in "PostgreSQL" attribute under "Tags" facets in Item Search results page
#    And user checks the child checkbox "PostgreSQL" in Tags
#    And user performs "facet selection" in "Schema" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_SCHEMA ) |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                          | body | response code | response message | jsonPath |
#      |        |       |       | Get  | searches/POSTGRES%20CATALOG/list/Schema?what=name&limit=1000 |      | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_SCHEMA ) |
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "POSTGRES CATALOG" catalog and search "POSTGRES CATALOG" items at top end
#    And user performs "facet selection" in "PostgreSQL" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) |
#    And user connects Rochade Server and "verify itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemNames                                                                                                                                                                                            |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( TYPE = DWR_IDC ) | PostgreSQL@POSTGRES CATALOG.Column:::1,PostgreSQL@POSTGRES CATALOG.Table:::1,PostgreSQL@POSTGRES CATALOG.Database:::1,PostgreSQL@POSTGRES CATALOG.Service:::1,PostgreSQL@POSTGRES CATALOG.Schema:::1 |
#    And user clicks on logout button


  Scenario Outline: SC23#user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type | targetFile                               | jsonpath                    |
      | APPDBPOSTGRES | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com |      | response/postgressDB/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/PostgreSQLDBCataloger/%DYN                  |      | response/postgressDB/actual/itemIds.json | $..has_CatalogerAnalysis.id |

  Scenario Outline: SC23#user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/postgressDB/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/postgressDB/actual/itemIds.json |


#6822675
  Scenario Outline:MLP-23777:SC24#Run the Plugin configurations for DataSource and PostgresDBCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                       | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger                                               | ida/postgressPayloads/PluginConfiguration/PostgressConfigWithSchemaAndTableViewFilter.json | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBCataloger                                               |                                                                                            | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                            | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  | ida/postgressPayloads/empty.json                                                           | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                            | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |


  @webtest @MLP-23777 @sanity @positive @regression
  Scenario: SC#24: Verify JDBC cataloger scans and collects data if schema name and table/view name is provided in filters(Postgres DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Schema    | 1     |
      | Table     | 2     |
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | postgresstestschema |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | CLASS            |
      | simpleselectview |

  Scenario Outline: SC24#user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type | targetFile                               | jsonpath                    |
      | APPDBPOSTGRES | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com |      | response/postgressDB/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/PostgreSQLDBCataloger/%DYN                  |      | response/postgressDB/actual/itemIds.json | $..has_CatalogerAnalysis.id |

  Scenario Outline: SC24#user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/postgressDB/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/postgressDB/actual/itemIds.json |

    #6822675
  Scenario Outline:MLP-23777:SC25#Run the Plugin configurations for DataSource and PostgresDBCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                   | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger                                               | ida/postgressPayloads/PluginConfiguration/PostgressConfigWithMultipleSchemaFilter.json | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBCataloger                                               |                                                                                        | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  | ida/postgressPayloads/empty.json                                                       | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |

  @webtest @jdbc @MLP-23777
  Scenario: SC#25: Verify JDBC cataloger scans and collects data if multiple schema name alone is provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Schema    | 2     |
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | postgresstestschema |
      | public              |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "postgresstestschema" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage       | queryField                 | columnName | queryOperation   | storeResults  |
      | AWSPOSTGRES  | STRUCTURED   | json/IDA.json | postgresQueries | getPostgressTablesInSchema | table_name | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "public" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage       | queryField                  | columnName | queryOperation   | storeResults  |
      | AWSPOSTGRES  | STRUCTURED   | json/IDA.json | postgresQueries | getPostgressTablesInSchema1 | table_name | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB


  Scenario Outline: SC25#user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type | targetFile                               | jsonpath                    |
      | APPDBPOSTGRES | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com |      | response/postgressDB/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/PostgreSQLDBCataloger/%DYN                  |      | response/postgressDB/actual/itemIds.json | $..has_CatalogerAnalysis.id |

  Scenario Outline: SC25#user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/postgressDB/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/postgressDB/actual/itemIds.json |

#6822675
  Scenario Outline:MLP-23777:SC26#Run the Plugin configurations for DataSource and PostgresDBCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                  | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger                                               | ida/postgressPayloads/PluginConfiguration/PostgressConfigWithOnlyTableViewFilter.json | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBCataloger                                               |                                                                                       | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                       | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  | ida/postgressPayloads/empty.json                                                      | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                       | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |


  @webtest @jdbc @MLP-23777
  Scenario:SC#26:  Verify PostgressDBCataloger scans and collects data if table/view name alone is provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | public              |
      | postgresstestschema |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | employee      |
      | childcityview |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "public [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | employee |


  Scenario Outline: SC26#user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type | targetFile                               | jsonpath                    |
      | APPDBPOSTGRES | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com |      | response/postgressDB/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/PostgreSQLDBCataloger/%DYN                  |      | response/postgressDB/actual/itemIds.json | $..has_CatalogerAnalysis.id |

  Scenario Outline: SC26#user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/postgressDB/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/postgressDB/actual/itemIds.json |

#6822675
  Scenario Outline:MLP-23777:SC27#Run the Plugin configurations for DataSource and PostgresDBCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                                | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger                                               | ida/postgressPayloads/PluginConfiguration/PostgressConfigWithMultipleSchemaWithTableViewFilter.json | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBCataloger                                               |                                                                                                     | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  | ida/postgressPayloads/empty.json                                                                    | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |

  @webtest @jdbc @MLP-23777
  Scenario: SC#27: Verify JDBC cataloger scans and collects data if multiple schema names having table/view in it are provided in filters(Postgres DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | public              |
      | postgresstestschema |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | employee      |
      | childcityview |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "public [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | employee |

  Scenario Outline: SC27#user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type | targetFile                               | jsonpath                    |
      | APPDBPOSTGRES | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com |      | response/postgressDB/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/PostgreSQLDBCataloger/%DYN                  |      | response/postgressDB/actual/itemIds.json | $..has_CatalogerAnalysis.id |

  Scenario Outline: SC27#user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/postgressDB/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/postgressDB/actual/itemIds.json |


    #6822675
  Scenario Outline:MLP-23777:SC28#Run the Plugin configurations for DataSource and PostgresDBCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                              | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger                                               | ida/postgressPayloads/PluginConfiguration/PostgressConfigWithNonexistingSchemaAndTableFilter.json | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBCataloger                                               |                                                                                                   | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  | ida/postgressPayloads/empty.json                                                                  | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |


  @jdbc @MLP-23777 @webtest
  Scenario: SC#28:Verify PostgressDBCataloger scans and does not collects data if non existing schema name and table name are provided in filters(Postgres DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
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
    And user performs "latest analysis click" in Item Results page for "cataloger/PostgreSQLDBCataloger/PostgreCataloger%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/PostgreSQLDBCataloger/PostgreCataloger%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                  | logCode       | pluginName            | removableText |
      | INFO | 2020-06-15 23:14:05.417 INFO  - ANALYSIS-0072: Plugin PostgreSQLDBCataloger Start Time:2020-06-15 23:14:05.035, End Time:2020-06-15 23:14:05.417, Processed Count:0, Errors:0, Warnings:1 | ANALYSIS-0072 | PostgreSQLDBCataloger |               |
    And user clicks on logout button


  Scenario Outline: SC28#user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                 | type | targetFile                               | jsonpath                    |
      | APPDBPOSTGRES | Default | cataloger/PostgreSQLDBCataloger/%DYN |      | response/postgressDB/actual/itemIds.json | $..has_CatalogerAnalysis.id |

  Scenario Outline: SC28#user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/postgressDB/actual/itemIds.json |


  Scenario Outline:MLP-23777:SC29#Run the Plugin configurations for DataSource and PostgresDBCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                   | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger                                               | ida/postgressPayloads/PluginConfiguration/PostgressConfigWithSchemaAndTableFilter.json | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBCataloger                                               |                                                                                        | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  | ida/postgressPayloads/empty.json                                                       | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |


  Scenario Outline: SC#29-user retrieves the item ids of Column items of Table: DiffDataTypesMinimized and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name            | type | targetFile                                     | jsonpath      |
      | APPDBPOSTGRES | Default | biginttype      |      | response/postgressDB/actual/columnItemIds.json | $..Field1.id  |
      | APPDBPOSTGRES | Default | booleantype     |      | response/postgressDB/actual/columnItemIds.json | $..Field2.id  |
      | APPDBPOSTGRES | Default | charactertype   |      | response/postgressDB/actual/columnItemIds.json | $..Field3.id  |
      | APPDBPOSTGRES | Default | varchartype     |      | response/postgressDB/actual/columnItemIds.json | $..Field4.id  |
      | APPDBPOSTGRES | Default | datetype        |      | response/postgressDB/actual/columnItemIds.json | $..Field5.id  |
      | APPDBPOSTGRES | Default | floattype       |      | response/postgressDB/actual/columnItemIds.json | $..Field6.id  |
      | APPDBPOSTGRES | Default | integertype     |      | response/postgressDB/actual/columnItemIds.json | $..Field7.id  |
      | APPDBPOSTGRES | Default | numerictype     |      | response/postgressDB/actual/columnItemIds.json | $..Field8.id  |
      | APPDBPOSTGRES | Default | realtype        |      | response/postgressDB/actual/columnItemIds.json | $..Field9.id  |
      | APPDBPOSTGRES | Default | smallinttype    |      | response/postgressDB/actual/columnItemIds.json | $..Field10.id |
      | APPDBPOSTGRES | Default | texttype        |      | response/postgressDB/actual/columnItemIds.json | $..Field11.id |
      | APPDBPOSTGRES | Default | timetype        |      | response/postgressDB/actual/columnItemIds.json | $..Field12.id |
      | APPDBPOSTGRES | Default | timetztype      |      | response/postgressDB/actual/columnItemIds.json | $..Field13.id |
      | APPDBPOSTGRES | Default | timestamptype   |      | response/postgressDB/actual/columnItemIds.json | $..Field14.id |
      | APPDBPOSTGRES | Default | timestamptztype |      | response/postgressDB/actual/columnItemIds.json | $..Field15.id |


  Scenario Outline: SC#29-user retrieves the metadata of Column type for a Table: DiffDataTypes
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>" of "<responsePath>"
    Examples:
      | url                                             | responseCode | inputJson    | inputFile                                      | outPutFile                                      | outPutJson                                                 | responsePath                          |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field1.id  | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field1.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field1.id  | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field1.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field2.id  | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field2.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field2.id  | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field2.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field3.id  | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field3.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field3.id  | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field3.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field4.id  | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field4.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field4.id  | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field4.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field5.id  | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field5.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field5.id  | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field5.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field6.id  | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field6.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field6.id  | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field6.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field7.id  | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field7.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field7.id  | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field7.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field8.id  | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field8.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field8.id  | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field8.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field9.id  | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field9.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field9.id  | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field9.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field10.id | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field10.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field10.id | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field10.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field11.id | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field11.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field11.id | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field11.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field12.id | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field12.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field12.id | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field12.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field13.id | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field13.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field13.id | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field13.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field14.id | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field14.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field14.id | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field14.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field15.id | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field15.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field15.id | response/postgressDB/actual/columnItemIds.json | response/postgressDB/actual/columnMetadata.json | $..columnActualMetaData.Table1.field15.fieldActualDataType | $..[?(@.caption=='Data type')]..value |


  #6938862
  Scenario Outline: SC#29-Validate the column level metadata results for a Table: DiffDataTypesMinimized in IDC platform
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                 | actualValues                                    | valueType     | expectedJsonPath                               | actualJsonPath                                             |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field1.fieldName      | $..columnActualMetaData.Table1.field1.fieldActualName      |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field1.fieldDataType  | $..columnActualMetaData.Table1.field1.fieldActualDataType  |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field2.fieldName      | $..columnActualMetaData.Table1.field2.fieldActualName      |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field2.fieldDataType  | $..columnActualMetaData.Table1.field2.fieldActualDataType  |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field3.fieldName      | $..columnActualMetaData.Table1.field3.fieldActualName      |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field3.fieldDataType  | $..columnActualMetaData.Table1.field3.fieldActualDataType  |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field4.fieldName      | $..columnActualMetaData.Table1.field4.fieldActualName      |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field4.fieldDataType  | $..columnActualMetaData.Table1.field4.fieldActualDataType  |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field5.fieldName      | $..columnActualMetaData.Table1.field5.fieldActualName      |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field5.fieldDataType  | $..columnActualMetaData.Table1.field5.fieldActualDataType  |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field6.fieldName      | $..columnActualMetaData.Table1.field6.fieldActualName      |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field6.fieldDataType  | $..columnActualMetaData.Table1.field6.fieldActualDataType  |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field7.fieldName      | $..columnActualMetaData.Table1.field7.fieldActualName      |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field7.fieldDataType  | $..columnActualMetaData.Table1.field7.fieldActualDataType  |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field8.fieldName      | $..columnActualMetaData.Table1.field8.fieldActualName      |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field8.fieldDataType  | $..columnActualMetaData.Table1.field8.fieldActualDataType  |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field9.fieldName      | $..columnActualMetaData.Table1.field9.fieldActualName      |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field9.fieldDataType  | $..columnActualMetaData.Table1.field9.fieldActualDataType  |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field10.fieldName     | $..columnActualMetaData.Table1.field10.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field10.fieldDataType | $..columnActualMetaData.Table1.field10.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field11.fieldName     | $..columnActualMetaData.Table1.field11.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field11.fieldDataType | $..columnActualMetaData.Table1.field11.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field12.fieldName     | $..columnActualMetaData.Table1.field12.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field12.fieldDataType | $..columnActualMetaData.Table1.field12.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field13.fieldName     | $..columnActualMetaData.Table1.field13.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field13.fieldDataType | $..columnActualMetaData.Table1.field13.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field14.fieldName     | $..columnActualMetaData.Table1.field14.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field14.fieldDataType | $..columnActualMetaData.Table1.field14.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field15.fieldName     | $..columnActualMetaData.Table1.field15.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData.json | response/postgressDB/actual/columnMetadata.json | stringCompare | $..columnMetaData.Table1.field15.fieldDataType | $..columnActualMetaData.Table1.field15.fieldActualDataType |

  Scenario Outline: SC29#user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type | targetFile                               | jsonpath                    |
      | APPDBPOSTGRES | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com |      | response/postgressDB/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/PostgreSQLDBCataloger/%DYN                  |      | response/postgressDB/actual/itemIds.json | $..has_CatalogerAnalysis.id |

  Scenario Outline: SC29#user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/postgressDB/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/postgressDB/actual/itemIds.json |

  Scenario Outline:MLP-23777:SC29.1#Run the Plugin configurations for DataSource and PostgresDBCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                    | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger                                               | ida/postgressPayloads/PluginConfiguration/PostgressConfigWithSchemaAndTableFilter1.json | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBCataloger                                               |                                                                                         | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                         | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  | ida/postgressPayloads/empty.json                                                        | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                         | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |


  Scenario Outline: SC#29.1-user retrieves the item ids of Column items of Table: DiffDataTypes and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name             | type | targetFile                                      | jsonpath      |
      | APPDBPOSTGRES | Default | biginttype       |      | response/postgressDB/actual/columnItemIds1.json | $..Field1.id  |
      | APPDBPOSTGRES | Default | bigserialtype    |      | response/postgressDB/actual/columnItemIds1.json | $..Field2.id  |
      | APPDBPOSTGRES | Default | bittype          |      | response/postgressDB/actual/columnItemIds1.json | $..Field3.id  |
      | APPDBPOSTGRES | Default | varbittype       |      | response/postgressDB/actual/columnItemIds1.json | $..Field4.id  |
      | APPDBPOSTGRES | Default | booleantype      |      | response/postgressDB/actual/columnItemIds1.json | $..Field5.id  |
      | APPDBPOSTGRES | Default | boxtype          |      | response/postgressDB/actual/columnItemIds1.json | $..Field6.id  |
      | APPDBPOSTGRES | Default | byteatype        |      | response/postgressDB/actual/columnItemIds1.json | $..Field7.id  |
      | APPDBPOSTGRES | Default | charactertype    |      | response/postgressDB/actual/columnItemIds1.json | $..Field8.id  |
      | APPDBPOSTGRES | Default | varchartype      |      | response/postgressDB/actual/columnItemIds1.json | $..Field9.id  |
      | APPDBPOSTGRES | Default | cidrtype         |      | response/postgressDB/actual/columnItemIds1.json | $..Field10.id |
      | APPDBPOSTGRES | Default | circletype       |      | response/postgressDB/actual/columnItemIds1.json | $..Field11.id |
      | APPDBPOSTGRES | Default | datetype         |      | response/postgressDB/actual/columnItemIds1.json | $..Field12.id |
      | APPDBPOSTGRES | Default | floattype        |      | response/postgressDB/actual/columnItemIds1.json | $..Field13.id |
      | APPDBPOSTGRES | Default | inettype         |      | response/postgressDB/actual/columnItemIds1.json | $..Field14.id |
      | APPDBPOSTGRES | Default | integertype      |      | response/postgressDB/actual/columnItemIds1.json | $..Field15.id |
      | APPDBPOSTGRES | Default | intervaltype     |      | response/postgressDB/actual/columnItemIds1.json | $..Field16.id |
      | APPDBPOSTGRES | Default | jsontype         |      | response/postgressDB/actual/columnItemIds1.json | $..Field17.id |
      | APPDBPOSTGRES | Default | jsonbtype        |      | response/postgressDB/actual/columnItemIds1.json | $..Field18.id |
      | APPDBPOSTGRES | Default | linetype         |      | response/postgressDB/actual/columnItemIds1.json | $..Field19.id |
      | APPDBPOSTGRES | Default | lsegtype         |      | response/postgressDB/actual/columnItemIds1.json | $..Field20.id |
      | APPDBPOSTGRES | Default | macaddrtype      |      | response/postgressDB/actual/columnItemIds1.json | $..Field21.id |
      | APPDBPOSTGRES | Default | moneytype        |      | response/postgressDB/actual/columnItemIds1.json | $..Field22.id |
      | APPDBPOSTGRES | Default | numerictype      |      | response/postgressDB/actual/columnItemIds1.json | $..Field23.id |
      | APPDBPOSTGRES | Default | pathtype         |      | response/postgressDB/actual/columnItemIds1.json | $..Field24.id |
      | APPDBPOSTGRES | Default | pglsntype        |      | response/postgressDB/actual/columnItemIds1.json | $..Field25.id |
      | APPDBPOSTGRES | Default | pointtype        |      | response/postgressDB/actual/columnItemIds1.json | $..Field26.id |
      | APPDBPOSTGRES | Default | polygontype      |      | response/postgressDB/actual/columnItemIds1.json | $..Field27.id |
      | APPDBPOSTGRES | Default | realtype         |      | response/postgressDB/actual/columnItemIds1.json | $..Field28.id |
      | APPDBPOSTGRES | Default | smallinttype     |      | response/postgressDB/actual/columnItemIds1.json | $..Field29.id |
      | APPDBPOSTGRES | Default | smallserialtype  |      | response/postgressDB/actual/columnItemIds1.json | $..Field30.id |
      | APPDBPOSTGRES | Default | serialtype       |      | response/postgressDB/actual/columnItemIds1.json | $..Field31.id |
      | APPDBPOSTGRES | Default | texttype         |      | response/postgressDB/actual/columnItemIds1.json | $..Field32.id |
      | APPDBPOSTGRES | Default | timetype         |      | response/postgressDB/actual/columnItemIds1.json | $..Field33.id |
      | APPDBPOSTGRES | Default | timetztype       |      | response/postgressDB/actual/columnItemIds1.json | $..Field34.id |
      | APPDBPOSTGRES | Default | timestamptype    |      | response/postgressDB/actual/columnItemIds1.json | $..Field35.id |
      | APPDBPOSTGRES | Default | timestamptztype  |      | response/postgressDB/actual/columnItemIds1.json | $..Field36.id |
      | APPDBPOSTGRES | Default | tsquerytype      |      | response/postgressDB/actual/columnItemIds1.json | $..Field37.id |
      | APPDBPOSTGRES | Default | tsvectortype     |      | response/postgressDB/actual/columnItemIds1.json | $..Field38.id |
      | APPDBPOSTGRES | Default | txidsnapshottype |      | response/postgressDB/actual/columnItemIds1.json | $..Field39.id |
      | APPDBPOSTGRES | Default | uuidtype         |      | response/postgressDB/actual/columnItemIds1.json | $..Field40.id |
      | APPDBPOSTGRES | Default | xmltype          |      | response/postgressDB/actual/columnItemIds1.json | $..Field41.id |
      | APPDBPOSTGRES | Default | intarraytype     |      | response/postgressDB/actual/columnItemIds1.json | $..Field42.id |
      | APPDBPOSTGRES | Default | textarraytype    |      | response/postgressDB/actual/columnItemIds1.json | $..Field43.id |


  Scenario Outline: SC#29.1-user retrieves the metadata of Column type for a Table: DiffDataTypes
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>" of "<responsePath>"
    Examples:
      | url                                             | responseCode | inputJson    | inputFile                                       | outPutFile                                       | outPutJson                                                 | responsePath                          |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field1.id  | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field1.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field1.id  | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field1.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field2.id  | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field2.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field2.id  | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field2.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field3.id  | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field3.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field3.id  | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field3.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field4.id  | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field4.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field4.id  | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field4.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field5.id  | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field5.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field5.id  | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field5.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field6.id  | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field6.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field6.id  | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field6.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field7.id  | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field7.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field7.id  | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field7.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field8.id  | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field8.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field8.id  | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field8.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field9.id  | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field9.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field9.id  | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field9.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field10.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field10.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field10.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field10.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field11.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field11.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field11.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field11.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field12.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field12.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field12.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field12.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field13.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field13.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field13.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field13.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field14.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field14.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field14.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field14.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field15.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field15.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field15.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field15.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field16.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field16.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field16.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field16.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field17.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field17.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field17.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field17.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field18.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field18.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field18.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field18.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field19.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field19.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field19.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field19.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field20.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field20.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field20.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field20.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field21.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field21.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field21.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field21.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field22.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field22.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field22.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field22.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field23.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field23.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field23.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field23.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field24.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field24.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field24.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field24.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field25.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field25.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field25.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field25.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field26.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field26.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field26.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field26.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field27.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field27.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field27.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field27.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field28.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field28.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field28.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field28.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field29.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field29.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field29.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field29.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field30.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field30.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field30.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field30.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field31.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field31.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field31.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field31.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field32.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field32.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field32.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field32.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field33.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field33.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field33.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field33.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field34.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field34.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field34.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field34.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field35.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field35.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field35.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field35.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field36.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field36.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field36.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field36.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field37.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field37.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field37.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field37.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field38.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field38.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field38.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field38.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field39.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field39.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field39.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field39.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field40.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field40.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field40.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field40.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field41.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field41.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field41.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field41.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field42.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field42.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field42.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field42.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field43.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field43.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field43.id | response/postgressDB/actual/columnItemIds1.json | response/postgressDB/actual/columnMetadata1.json | $..columnActualMetaData.Table1.field43.fieldActualDataType | $..[?(@.caption=='Data type')]..value |


    #6938862
  Scenario Outline: SC#29.1-Validate the column level metadata results for a Table: DiffDataTypes in IDC platform
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                  | actualValues                                     | valueType     | expectedJsonPath                               | actualJsonPath                                             |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field1.fieldName      | $..columnActualMetaData.Table1.field1.fieldActualName      |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field1.fieldDataType  | $..columnActualMetaData.Table1.field1.fieldActualDataType  |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field2.fieldName      | $..columnActualMetaData.Table1.field2.fieldActualName      |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field2.fieldDataType  | $..columnActualMetaData.Table1.field2.fieldActualDataType  |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field3.fieldName      | $..columnActualMetaData.Table1.field3.fieldActualName      |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field3.fieldDataType  | $..columnActualMetaData.Table1.field3.fieldActualDataType  |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field4.fieldName      | $..columnActualMetaData.Table1.field4.fieldActualName      |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field4.fieldDataType  | $..columnActualMetaData.Table1.field4.fieldActualDataType  |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field5.fieldName      | $..columnActualMetaData.Table1.field5.fieldActualName      |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field5.fieldDataType  | $..columnActualMetaData.Table1.field5.fieldActualDataType  |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field6.fieldName      | $..columnActualMetaData.Table1.field6.fieldActualName      |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field6.fieldDataType  | $..columnActualMetaData.Table1.field6.fieldActualDataType  |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field7.fieldName      | $..columnActualMetaData.Table1.field7.fieldActualName      |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field7.fieldDataType  | $..columnActualMetaData.Table1.field7.fieldActualDataType  |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field8.fieldName      | $..columnActualMetaData.Table1.field8.fieldActualName      |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field8.fieldDataType  | $..columnActualMetaData.Table1.field8.fieldActualDataType  |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field9.fieldName      | $..columnActualMetaData.Table1.field9.fieldActualName      |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field9.fieldDataType  | $..columnActualMetaData.Table1.field9.fieldActualDataType  |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field10.fieldName     | $..columnActualMetaData.Table1.field10.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field10.fieldDataType | $..columnActualMetaData.Table1.field10.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field11.fieldName     | $..columnActualMetaData.Table1.field11.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field11.fieldDataType | $..columnActualMetaData.Table1.field11.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field12.fieldName     | $..columnActualMetaData.Table1.field12.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field12.fieldDataType | $..columnActualMetaData.Table1.field12.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field13.fieldName     | $..columnActualMetaData.Table1.field13.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field13.fieldDataType | $..columnActualMetaData.Table1.field13.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field14.fieldName     | $..columnActualMetaData.Table1.field14.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field14.fieldDataType | $..columnActualMetaData.Table1.field14.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field15.fieldName     | $..columnActualMetaData.Table1.field15.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field15.fieldDataType | $..columnActualMetaData.Table1.field15.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field16.fieldName     | $..columnActualMetaData.Table1.field16.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field16.fieldDataType | $..columnActualMetaData.Table1.field16.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field17.fieldName     | $..columnActualMetaData.Table1.field17.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field17.fieldDataType | $..columnActualMetaData.Table1.field17.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field18.fieldName     | $..columnActualMetaData.Table1.field18.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field18.fieldDataType | $..columnActualMetaData.Table1.field18.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field19.fieldName     | $..columnActualMetaData.Table1.field19.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field19.fieldDataType | $..columnActualMetaData.Table1.field19.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field20.fieldName     | $..columnActualMetaData.Table1.field20.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field20.fieldDataType | $..columnActualMetaData.Table1.field20.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field21.fieldName     | $..columnActualMetaData.Table1.field21.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field21.fieldDataType | $..columnActualMetaData.Table1.field21.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field22.fieldName     | $..columnActualMetaData.Table1.field22.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field22.fieldDataType | $..columnActualMetaData.Table1.field22.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field23.fieldName     | $..columnActualMetaData.Table1.field23.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field23.fieldDataType | $..columnActualMetaData.Table1.field23.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field24.fieldName     | $..columnActualMetaData.Table1.field24.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field24.fieldDataType | $..columnActualMetaData.Table1.field24.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field25.fieldName     | $..columnActualMetaData.Table1.field25.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field25.fieldDataType | $..columnActualMetaData.Table1.field25.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field26.fieldName     | $..columnActualMetaData.Table1.field26.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field26.fieldDataType | $..columnActualMetaData.Table1.field26.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field27.fieldName     | $..columnActualMetaData.Table1.field27.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field27.fieldDataType | $..columnActualMetaData.Table1.field27.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field28.fieldName     | $..columnActualMetaData.Table1.field28.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field28.fieldDataType | $..columnActualMetaData.Table1.field28.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field29.fieldName     | $..columnActualMetaData.Table1.field29.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field29.fieldDataType | $..columnActualMetaData.Table1.field29.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field30.fieldName     | $..columnActualMetaData.Table1.field30.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field30.fieldDataType | $..columnActualMetaData.Table1.field30.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field31.fieldName     | $..columnActualMetaData.Table1.field31.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field31.fieldDataType | $..columnActualMetaData.Table1.field31.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field32.fieldName     | $..columnActualMetaData.Table1.field32.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field32.fieldDataType | $..columnActualMetaData.Table1.field32.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field33.fieldName     | $..columnActualMetaData.Table1.field33.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field33.fieldDataType | $..columnActualMetaData.Table1.field33.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field34.fieldName     | $..columnActualMetaData.Table1.field34.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field34.fieldDataType | $..columnActualMetaData.Table1.field34.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field35.fieldName     | $..columnActualMetaData.Table1.field35.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field35.fieldDataType | $..columnActualMetaData.Table1.field35.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field36.fieldName     | $..columnActualMetaData.Table1.field36.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field36.fieldDataType | $..columnActualMetaData.Table1.field36.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field37.fieldName     | $..columnActualMetaData.Table1.field37.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field37.fieldDataType | $..columnActualMetaData.Table1.field37.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field38.fieldName     | $..columnActualMetaData.Table1.field38.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field38.fieldDataType | $..columnActualMetaData.Table1.field38.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field39.fieldName     | $..columnActualMetaData.Table1.field39.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field39.fieldDataType | $..columnActualMetaData.Table1.field39.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field40.fieldName     | $..columnActualMetaData.Table1.field40.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field40.fieldDataType | $..columnActualMetaData.Table1.field40.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field41.fieldName     | $..columnActualMetaData.Table1.field41.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field41.fieldDataType | $..columnActualMetaData.Table1.field41.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field42.fieldName     | $..columnActualMetaData.Table1.field42.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field42.fieldDataType | $..columnActualMetaData.Table1.field42.fieldActualDataType |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field43.fieldName     | $..columnActualMetaData.Table1.field43.fieldActualName     |
      | response/postgressDB/expected/postgressDBExpectedJsonData1.json | response/postgressDB/actual/columnMetadata1.json | stringCompare | $..columnMetaData.Table1.field43.fieldDataType | $..columnActualMetaData.Table1.field43.fieldActualDataType |

  Scenario Outline: SC29.1#user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type | targetFile                               | jsonpath                    |
      | APPDBPOSTGRES | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com |      | response/postgressDB/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/PostgreSQLDBCataloger/%DYN                  |      | response/postgressDB/actual/itemIds.json | $..has_CatalogerAnalysis.id |

  Scenario Outline: SC29.1#user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/postgressDB/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/postgressDB/actual/itemIds.json |

   #6822675
  Scenario Outline:MLP-23777:SC30#Run the Plugin configurations for DataSource and PostgresDBCataloger with dryRun as True.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                         | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger                                               | ida/postgressPayloads/PluginConfiguration/PostgressConfigWithDryRunTrue.json | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBCataloger                                               |                                                                              | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  | ida/postgressPayloads/empty.json                                             | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |


    #6936990
  @MLP-23777 @webtest @regression @sanity
  Scenario: SC#30- Verify PostgressDBCataloger doesn't collects Cluster,Service,Database,Table,Column,Constraint when PostgressDBCataloger is run with dryrun as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service    |
      | Cluster    |
      | Database   |
      | Table      |
      | Column     |
      | Constraint |
      | Schema     |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/PostgreSQLDBCataloger/PostgreCataloger%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | logCode       | pluginName            | removableText |
      | INFO | Plugin PostgreSQLDBCataloger running on dry run mode                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | ANALYSIS-0069 | PostgreSQLDBCataloger |               |
      | INFO | Plugin PostgreSQLDBCataloger processed 2 items on dry run mode and not written to the repository                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | ANALYSIS-0070 | PostgreSQLDBCataloger |               |
      | INFO | Plugin PostgreSQLDBCataloger Start Time:2020-06-15 23:31:07.702, End Time:2020-06-15 23:31:09.040, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ANALYSIS-0072 | PostgreSQLDBCataloger |               |
      | INFO | Plugin PostgreSQLDBCataloger Configuration: ---  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: name: "PostgreCataloger"  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: pluginVersion: "LATEST"  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: label:  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: : ""  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: catalogName: "Default"  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: eventClass: null  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: eventCondition: null  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: nodeCondition: null  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: maxWorkSize: 100  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: tags:  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: - "PostgressTag1"  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: pluginType: "cataloger"  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: dataSource: "PostgressValidDataSource"  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: credential: "ValidPostgressCredentials"  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: businessApplicationName: "Postgress_BA"  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: dryRun: true  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: schedule: null  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: filter: null  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: pluginName: "PostgreSQLDBCataloger"  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: schemas: []  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: type: "Cataloger"  2020-09-26 19:46:19.237 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBCataloger Configuration: properties: []  2020-09-26 19:46:19.237 | ANALYSIS-0073 | PostgreSQLDBCataloger |               |
    And user clicks on logout button

  Scenario Outline: SC30#user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                 | type | targetFile                               | jsonpath                    |
      | APPDBPOSTGRES | Default | cataloger/PostgreSQLDBCataloger/%DYN |      | response/postgressDB/actual/itemIds.json | $..has_CatalogerAnalysis.id |

  Scenario Outline: SC30#user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/postgressDB/actual/itemIds.json |

  @sanity @positive
  Scenario: SC#31-Configure the Postgress Datasource in internal node
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                       | body                                                                                | response code | response message | jsonPath                         |
      | application/json | raw   | false | Put  | settings/analyzers/PostgreSQLDBDataSource | ida/postgressPayloads/DataSource/PostgressAWSInternalNodeValidDataSourceConfig.json | 204           |                  |                                  |
      |                  |       |       | Get  | settings/analyzers/PostgreSQLDBDataSource |                                                                                     | 200           |                  | PostgressInternalValidDataSource |


  @MLP-23777 @sanity @positive @regression
  Scenario:SC#31: Create Postgress Plugin config and start it under internal node
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                                                                   | response code | response message | jsonPath                                              |
      | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger                                                  | ida/postgressPayloads/PluginConfiguration/PostgressConfigWithSchemaAndTableViewFilterInternalNode.json | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger                                                  |                                                                                                        | 200           | PostgreCataloger |                                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                                                        | 200           |                  |                                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |

    ##6501276##
  @webtest @MLP-23777 @sanity @positive @regression
  Scenario:SC#31: Verify PostgressDBCataloger works properly when ran in internal node.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Schema    | 1     |
      | Table     | 2     |
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | postgresstestschema |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | CLASS            |
      | simpleselectview |


  Scenario Outline:SC31#user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type | targetFile                               | jsonpath                    |
      | APPDBPOSTGRES | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com |      | response/postgressDB/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/PostgreSQLDBCataloger/%DYN                  |      | response/postgressDB/actual/itemIds.json | $..has_CatalogerAnalysis.id |

  Scenario Outline:SC31#user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/postgressDB/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/postgressDB/actual/itemIds.json |

# JDBC POSTGRESS RDS ANALYZER#
  #6822675
  @sanity @positive
  Scenario Outline:MLP-23777:SC32#Run the Plugin configurations for DataSource and PostgresDBCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                       | response code | response message         | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBDataSource                                              | ida/postgressPayloads/DataSource/PostgressAWSValidDataSourceConfig.json    | 204           |                          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBDataSource                                              |                                                                            | 200           | PostgressValidDataSource |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger                                               | ida/postgressPayloads/PluginConfiguration/PostgressConfigWithNoFilter.json | 204           |                          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBCataloger                                               |                                                                            | 200           | PostgreCataloger         |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                            | 200           | IDLE                     | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  | ida/postgressPayloads/empty.json                                           | 200           |                          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                            | 200           | IDLE                     | $.[?(@.configurationName=='PostgreCataloger')].status |


  @MLP-21007 @sanity @positive @regression
  Scenario:SC#32: Create PostgressDBAnalyzer Plugin config with only schema filter and start it
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                     | body                                                                                   | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBAnalyzer                                                 | ida/postgressPayloads/PluginConfiguration/PostgressAnalyzerConfigWithSchemaFilter.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer                                                 |                                                                                        | 200           | PostgreAnalyzer  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                                        | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status |



#6876628# Bug MLP-25218 raised for this scenario#
  @webtest @MLP-23727
  Scenario:SC#35_Verify the data sampling works fine for table/view(simple,recursive,materialized) if PostgressDBAnalyzer is run successfully
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DiffDataTypes" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | Biginttype | Bigserialtype | Bittype     | Varbittype  | Booleantype | Boxtype             | Byteatype   | Charactertype | Varchartype | Cidrtype        | Circletype        | Datetype   | Floattype | Inettype       | Integertype | Intervaltype          | Jsontype                                                         | Jsonbtype                                                                                       | Linetype       | Lsegtype                | Macaddrtype       | Moneytype | Numerictype | Pathtype                | Pglsntype   | Pointtype | Polygontype                      | Realtype | Smallinttype | Smallserialtype | Serialtype | Texttype      | Timetype | Timetztype | Timestamptype         | Timestamptztype       | Tsquerytype | Tsvectortype    | Txidsnapshottype | Uuidtype                             | Xmltype            | Intarraytype          | Textarraytype                             |
      | 1000       | 2000          | UNSUPPORTED | UNSUPPORTED | true        | (8.0,9.0),(1.0,3.0) | UNSUPPORTED | ch            | test        | 122.23.23.25/32 | <(10.0,4.0),10.0> | 2000-12-31 | 23.5      | 220.220.100.10 | 34567       | 1 year 2 mons 3 days  | { "customer": "John Doe", "items": {"product": "Beer","qty": 6}} | {"title": "Sleeping Beauties", "genres": ["Fiction", "Thriller", "Horror"], "published": false} | {3.0,-1.0,0.0} | [(3.0,3.0),(10.0,12.0)] | 08:00:2b:01:02:03 | $1,000.00 | 34.50       | ((3.0,3.0),(10.0,12.0)) | UNSUPPORTED | (1.0,2.0) | ((1.0,3.0),(4.0,12.0),(2.0,4.0)) | 234.5    | 2450         | 235             | 4567       | text string   | 22:10:10 | 02:10:25   | 2016-06-22 19:10:25.0 | 2016-06-23 02:10:25.0 | 'supernova' | 'fat':2 'rat':3 | UNSUPPORTED      | a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11 | <name>name1</name> | {1000,1001,1002,1003} | {{meeting,lunch},{training,presentation}} |
      | 2000       | 3000          | UNSUPPORTED | UNSUPPORTED | true        | (8.0,9.0),(1.0,3.0) | UNSUPPORTED | ch            | test1       | 120.21.22.25/32 | <(11.0,5.0),12.0> | 2000-12-31 | 33.5      | 210.210.105.20 | 34567       | 2 years 4 mons 5 days | { "customer": "John Doe", "items": {"product": "Beer","qty": 6}} | {"title": "Sleeping Beauties", "genres": ["Fiction", "Thriller", "Horror"], "published": false} | {3.0,-1.0,0.0} | [(3.0,3.0),(10.0,12.0)] | 08:00:2b:01:02:03 | $1,000.00 | 34.50       | ((3.0,3.0),(10.0,12.0)) | UNSUPPORTED | (1.0,2.0) | ((1.0,3.0),(4.0,12.0),(2.0,4.0)) | 334.5    | 5450         | 2350            | 5567       | text string   | 12:10:10 | 01:09:25   | 2017-07-20 19:10:25.0 | 2017-06-20 19:10:25.0 | 'supernova' | 'fat':2 'rat':3 | UNSUPPORTED      | a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11 | <name>name5</name> | {1000,1001,1002,1003} | {{meeting,lunch},{training,presentation}} |
      | 3235       | 3620          | UNSUPPORTED | UNSUPPORTED | true        | (8.0,9.0),(1.0,3.0) | UNSUPPORTED | Ah            | testABC     | 120.21.22.25/32 | <(11.0,5.0),12.0> | 1998-02-12 | 33.5      | 211.211.104.24 | 34567       | 2 years 4 mons 5 days | { "customer": "John Doe", "items": {"product": "Beer","qty": 6}} | {"title": "Sleeping Beauties", "genres": ["Fiction", "Thriller", "Horror"], "published": false} | {3.0,-1.0,0.0} | [(3.0,3.0),(10.0,12.0)] | 08:00:2b:01:02:03 | $1,000.00 | 34.50       | ((3.0,3.0),(10.0,12.0)) | UNSUPPORTED | (1.0,2.0) | ((1.0,3.0),(4.0,12.0),(2.0,4.0)) | 1034.5   | 2450         | 2150            | 2567       | text DIFFDATA | 02:20:20 | 16:04:22   | 2003-05-20 10:10:25.0 | 2005-12-20 19:10:25.0 | 'supernova' | 'fat':2 'rat':3 | UNSUPPORTED      | a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11 | <name>name2</name> | {1000,1001,1002,1003} | {{meeting,lunch},{training,presentation}} |
      | 8000       | 3600          | UNSUPPORTED | UNSUPPORTED | true        | (8.0,9.0),(1.0,3.0) | UNSUPPORTED | Ah            | test2       | 120.21.22.25/32 | <(11.0,5.0),12.0> | 2001-02-12 | 33.5      | 211.211.104.24 | 34567       | 2 years 4 mons 5 days | { "customer": "John Doe", "items": {"product": "Beer","qty": 6}} | {"title": "Sleeping Beauties", "genres": ["Fiction", "Thriller", "Horror"], "published": false} | {3.0,-1.0,0.0} | [(3.0,3.0),(10.0,12.0)] | 08:00:2b:01:02:03 | $1,000.00 | 34.50       | ((3.0,3.0),(10.0,12.0)) | UNSUPPORTED | (1.0,2.0) | ((1.0,3.0),(4.0,12.0),(2.0,4.0)) | 334.5    | 5450         | 2350            | 5567       | text string   | 18:20:20 | 01:09:25   | 2010-07-20 19:10:25.0 | 2010-06-20 19:10:25.0 | 'supernova' | 'fat':2 'rat':3 | UNSUPPORTED      | a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11 | <name>name4</name> | {1000,1001,1002,1003} | {{meeting,lunch},{training,presentation}} |
      | 8500       | 9600          | UNSUPPORTED | UNSUPPORTED | true        | (8.0,9.0),(1.0,3.0) | UNSUPPORTED | Ah            | testABC     | 120.21.22.25/32 | <(11.0,5.0),12.0> | 1999-02-12 | 33.5      | 211.211.104.24 | 34567       | 2 years 4 mons 5 days | { "customer": "John Doe", "items": {"product": "Beer","qty": 6}} | {"title": "Sleeping Beauties", "genres": ["Fiction", "Thriller", "Horror"], "published": false} | {3.0,-1.0,0.0} | [(3.0,3.0),(10.0,12.0)] | 08:00:2b:01:02:03 | $1,000.00 | 34.50       | ((3.0,3.0),(10.0,12.0)) | UNSUPPORTED | (1.0,2.0) | ((1.0,3.0),(4.0,12.0),(2.0,4.0)) | 1034.5   | 2450         | 2150            | 2567       | text DIFFDATA | 08:20:20 | 16:04:22   | 2005-05-20 10:10:25.0 | 2005-06-20 19:10:25.0 | 'supernova' | 'fat':2 'rat':3 | UNSUPPORTED      | a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11 | <name>name3</name> | {1000,1001,1002,1003} | {{meeting,lunch},{training,presentation}} |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DiffDataTypesMinimizedView" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | Biginttype | Booleantype | Charactertype | Varchartype | Datetype   | Floattype | Integertype | Numerictype | Realtype | Smallinttype | Texttype     | Timetype | Timetztype | Timestamptype         | Timestamptztype       |
      | 1000       | true        | ch            | test        | 2000-12-31 | 23.5      | 34567       | 34.50       | 234.5    | 245          | text string  | 22:10:10 | 02:10:25   | 2016-06-22 19:10:25.0 | 2016-06-23 02:10:25.0 |
      | 2000       | false       | eh            | data types1 | 2001-02-11 | 13.5      | 44567       | 44.50       | 134.5    | 235          | text string1 | 21:09:10 | 02:10:25   | 2013-06-22 19:10:25.0 | 2013-02-13 02:10:25.0 |
      | 3000       | false       | zh            | data types2 | 1998-03-11 | 33.5      | 46567       | 54.50       | 234.5    | 335          | text string2 | 15:09:10 | 02:10:25   | 2011-06-12 19:10:25.0 | 2011-02-12 20:10:25.0 |
      | 4000       | true        | xh            | data types3 | 1992-02-03 | 43.5      | 86567       | 64.50       | 2221.5   | 365          | text string3 | 15:19:20 | 23:15:15   | 1997-06-12 19:10:25.0 | 1977-02-13 19:09:23.0 |
      | 5000       | false       | gy            | data types4 | 1990-12-03 | 63.5      | 16567       | 84.50       | 1231.67  | 865          | text string4 | 05:19:20 | 23:15:15   | 1990-06-12 19:10:25.0 | 1990-02-13 19:09:23.0 |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "materializedviewwithdata" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    And sync the test execution for "40" seconds
    Then following "Data Sample" values should get displayed in item view page
      | Productname | Percentage         | Productid |
      | product 1   | 200.56             | 100       |
      | product 2   | 567.89             | 200       |
      | product 3   | 6001.5599999999995 | 1200      |
      | product 4   | 789.6              | 400       |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "managertreerecursive" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    And sync the test execution for "40" seconds
    Then following "Data Sample" values should get displayed in item view page
      | Id | Name  | Manager_id |
      | 2  | name2 | 30         |
      | 2  | name4 | 10         |
      | 2  | name5 | 50         |


  @positve @regression @sanity @webtest
  Scenario:SC36#Verify data profiling appears for string,numeric columns in recursive view and materialized views.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "managertreerecursive [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user enters the search text "managertreerecursive [Table]" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "manager_id" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | INTEGER       | Description |
      | Length                        | 10            | Statistics  |
      | Maximum value                 | 50            | Statistics  |
      | Minimum value                 | 10            | Statistics  |
      | Median                        | 30            | Statistics  |
      | Number of non null values     | 3             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 3             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 20            | Statistics  |
      | Variance                      | 400           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "managertreerecursive [Table]" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "name" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 10            | Statistics  |
      | Maximum length                | 5             | Statistics  |
      | Maximum value                 | name5         | Statistics  |
      | Minimum length                | 5             | Statistics  |
      | Minimum value                 | name2         | Statistics  |
      | Number of non null values     | 3             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 3             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user enters the search text "materializedviewwithdata [Table]" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "percentage" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue      | widgetName  |
      | Data type                     | DOUBLE             | Description |
      | Average                       | 1889.9             | Statistics  |
      | Length                        | 17                 | Statistics  |
      | Maximum value                 | 6001.5599999999995 | Statistics  |
      | Minimum value                 | 200.56             | Statistics  |
      | Median                        | 678.75             | Statistics  |
      | Number of non null values     | 4                  | Statistics  |
      | Percentage of non null values | 100                | Statistics  |
      | Number of null values         | 0                  | Statistics  |
      | Number of unique values       | 4                  | Statistics  |
      | Percentage of unique values   | 100                | Statistics  |
      | Standard deviation            | 2751.85            | Statistics  |
      | Variance                      | 7572662.71         | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "materializedviewwithdata [Table]" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "productname" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 10            | Statistics  |
      | Maximum length                | 9             | Statistics  |
      | Maximum value                 | product 4     | Statistics  |
      | Minimum length                | 9             | Statistics  |
      | Minimum value                 | product 1     | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page

  Scenario Outline:SC31#user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type | targetFile                               | jsonpath                    |
      | APPDBPOSTGRES | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com |      | response/postgressDB/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/PostgreSQLDBCataloger/%DYN                  |      | response/postgressDB/actual/itemIds.json | $..has_CatalogerAnalysis.id |

  Scenario Outline:SC31#user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/postgressDB/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/postgressDB/actual/itemIds.json |


  #6822675
  @sanity @positive
  Scenario Outline:MLP-23777:SC32#Run the Plugin configurations for DataSource and PostgresDBCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                       | response code | response message         | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBDataSource                                              | ida/postgressPayloads/DataSource/PostgressAWSValidDataSourceConfig.json    | 204           |                          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBDataSource                                              |                                                                            | 200           | PostgressValidDataSource |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger                                               | ida/postgressPayloads/PluginConfiguration/PostgressConfigWithNoFilter.json | 204           |                          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBCataloger                                               |                                                                            | 200           | PostgreCataloger         |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                            | 200           | IDLE                     | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  | ida/postgressPayloads/empty.json                                           | 200           |                          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                            | 200           | IDLE                     | $.[?(@.configurationName=='PostgreCataloger')].status |


  @MLP-21007 @sanity @positive @regression
  Scenario:SC#32: Create PostgressDBAnalyzer Plugin config and start it
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                     | body                                                                                            | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBAnalyzer                                                 | ida/postgressPayloads/PluginConfiguration/PostgressAnalyzerConfigWithSchemaTableViewFilter.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer                                                 |                                                                                                 | 200           | PostgreAnalyzer  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                                                 | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                                                 | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status |


 #6876628##
  @webtest @MLP-23727
  Scenario:SC#35_Verify the data sampling works fine for table/view if PostgressDBAnalyzer is run successfully
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DiffDataTypesMinimized" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | Biginttype | Booleantype | Charactertype | Varchartype | Datetype   | Floattype | Integertype | Numerictype | Realtype | Smallinttype | Texttype     | Timetype | Timetztype | Timestamptype         | Timestamptztype       |
      | 1000       | true        | ch            | test        | 2000-12-31 | 23.5      | 34567       | 34.50       | 234.5    | 245          | text string  | 22:10:10 | 02:10:25   | 2016-06-22 19:10:25.0 | 2016-06-23 02:10:25.0 |
      | 2000       | false       | eh            | data types1 | 2001-02-11 | 13.5      | 44567       | 44.50       | 134.5    | 235          | text string1 | 21:09:10 | 02:10:25   | 2013-06-22 19:10:25.0 | 2013-02-13 02:10:25.0 |
      | 3000       | false       | zh            | data types2 | 1998-03-11 | 33.5      | 46567       | 54.50       | 234.5    | 335          | text string2 | 15:09:10 | 02:10:25   | 2011-06-12 19:10:25.0 | 2011-02-12 20:10:25.0 |
      | 4000       | true        | xh            | data types3 | 1992-02-03 | 43.5      | 86567       | 64.50       | 2221.5   | 365          | text string3 | 15:19:20 | 23:15:15   | 1997-06-12 19:10:25.0 | 1977-02-13 19:09:23.0 |
      | 5000       | false       | gy            | data types4 | 1990-12-03 | 63.5      | 16567       | 84.50       | 1231.67  | 865          | text string4 | 05:19:20 | 23:15:15   | 1990-06-12 19:10:25.0 | 1990-02-13 19:09:23.0 |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DiffDataTypesMinimizedView" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | Biginttype | Booleantype | Charactertype | Varchartype | Datetype   | Floattype | Integertype | Numerictype | Realtype | Smallinttype | Texttype     | Timetype | Timetztype | Timestamptype         | Timestamptztype       |
      | 1000       | true        | ch            | test        | 2000-12-31 | 23.5      | 34567       | 34.50       | 234.5    | 245          | text string  | 22:10:10 | 02:10:25   | 2016-06-22 19:10:25.0 | 2016-06-23 02:10:25.0 |
      | 2000       | false       | eh            | data types1 | 2001-02-11 | 13.5      | 44567       | 44.50       | 134.5    | 235          | text string1 | 21:09:10 | 02:10:25   | 2013-06-22 19:10:25.0 | 2013-02-13 02:10:25.0 |
      | 3000       | false       | zh            | data types2 | 1998-03-11 | 33.5      | 46567       | 54.50       | 234.5    | 335          | text string2 | 15:09:10 | 02:10:25   | 2011-06-12 19:10:25.0 | 2011-02-12 20:10:25.0 |
      | 4000       | true        | xh            | data types3 | 1992-02-03 | 43.5      | 86567       | 64.50       | 2221.5   | 365          | text string3 | 15:19:20 | 23:15:15   | 1997-06-12 19:10:25.0 | 1977-02-13 19:09:23.0 |
      | 5000       | false       | gy            | data types4 | 1990-12-03 | 63.5      | 16567       | 84.50       | 1231.67  | 865          | text string4 | 05:19:20 | 23:15:15   | 1990-06-12 19:10:25.0 | 1990-02-13 19:09:23.0 |

  @positve @regression @sanity @webtest
  Scenario:SC36#Verify the data profiling metadata information for string datatype in Postgress table/view
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "DiffDataTypesMinimized [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimized [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "varchartype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 30            | Statistics  |
      | Maximum length                | 11            | Statistics  |
      | Maximum value                 | test          | Statistics  |
      | Minimum length                | 4             | Statistics  |
      | Minimum value                 | data types1   | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "varchartype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 30            | Statistics  |
      | Maximum length                | 11            | Statistics  |
      | Maximum value                 | test          | Statistics  |
      | Minimum length                | 4             | Statistics  |
      | Minimum value                 | data types1   | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page


  @positve @regression @sanity @webtest
  Scenario:SC38#Verify the data profiling metadata information for numeric datatypes in Postgress view.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "biginttype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | BIGINT        | Description |
      | Average                       | 3000          | Statistics  |
      | Length                        | 19            | Statistics  |
      | Maximum value                 | 5000          | Statistics  |
      | Median                        | 3000          | Statistics  |
      | Minimum value                 | 1000          | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 1581.14       | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 2500000       | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "integertype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | INTEGER       | Description |
      | Average                       | 45767         | Statistics  |
      | Length                        | 10            | Statistics  |
      | Maximum value                 | 86567         | Statistics  |
      | Median                        | 44567         | Statistics  |
      | Minimum value                 | 16567         | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 25713.81      | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 661200000     | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "floattype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DOUBLE        | Description |
      | Average                       | 35.5          | Statistics  |
      | Length                        | 17            | Statistics  |
      | Maximum value                 | 63.5          | Statistics  |
      | Median                        | 33.5          | Statistics  |
      | Minimum value                 | 13.5          | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 19.24         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 370           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "numerictype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMERIC       | Description |
      | Average                       | 56.5          | Statistics  |
      | Length                        | 5             | Statistics  |
      | Maximum value                 | 84.50         | Statistics  |
      | Median                        | 54.5          | Statistics  |
      | Minimum value                 | 34.50         | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 19.24         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 370           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "smallinttype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | SMALLINT      | Description |
      | Average                       | 409           | Statistics  |
      | Length                        | 5             | Statistics  |
      | Maximum value                 | 865           | Statistics  |
      | Median                        | 335           | Statistics  |
      | Minimum value                 | 235           | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 261.02        | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 68130         | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page


  @positve @regression @sanity @webtest
  Scenario:SC39#Verify the data profiling metadata information for Data,time and timestamp datatypes in postgress table.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "DiffDataTypesMinimized [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimized [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "datetype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DATE          | Description |
      | Length                        | 13            | Statistics  |
      | Maximum value                 | 2001-02-11    | Statistics  |
      | Minimum value                 | 1990-12-03    | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimized [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimized [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "timetype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TIME          | Description |
      | Length                        | 15            | Statistics  |
      | Maximum value                 | 22:10:10      | Statistics  |
      | Minimum value                 | 02:05:00      | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Percentage of unique values   | 80            | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimized [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimized [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "timetztype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TIME          | Description |
      | Length                        | 21            | Statistics  |
      | Maximum value                 | 19:10:25-07   | Statistics  |
      | Minimum value                 | 16:15:15-07   | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 40            | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimized [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimized [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "timestamptype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 29                  | Statistics  |
      | Maximum value                 | 2016-06-22 19:10:25 | Statistics  |
      | Minimum value                 | 1990-06-12 19:10:25 | Statistics  |
      | Number of non null values     | 5                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 5                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimized [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimized [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "timestamptztype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue          | widgetName  |
      | Data type                     | TIMESTAMP              | Description |
      | Length                        | 35                     | Statistics  |
      | Maximum value                 | 2016-06-23 02:10:25+00 | Statistics  |
      | Minimum value                 | 1977-02-13 19:09:23+00 | Statistics  |
      | Number of non null values     | 5                      | Statistics  |
      | Percentage of non null values | 100                    | Statistics  |
      | Number of null values         | 0                      | Statistics  |
      | Number of unique values       | 5                      | Statistics  |
      | Percentage of unique values   | 100                    | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page


  @positve @regression @sanity @webtest
  Scenario:SC40#Verify the data profiling metadata information for Data,time and timestamp datatypes in postgress view.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "datetype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DATE          | Description |
      | Length                        | 13            | Statistics  |
      | Maximum value                 | 2001-02-11    | Statistics  |
      | Minimum value                 | 1990-12-03    | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "timetype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TIME          | Description |
      | Length                        | 15            | Statistics  |
      | Maximum value                 | 22:10:10      | Statistics  |
      | Minimum value                 | 02:05:00      | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Percentage of unique values   | 80            | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "timetztype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TIME          | Description |
      | Length                        | 21            | Statistics  |
      | Maximum value                 | 19:10:25-07   | Statistics  |
      | Minimum value                 | 16:15:15-07   | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 40            | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "timestamptype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 29                  | Statistics  |
      | Maximum value                 | 2016-06-22 19:10:25 | Statistics  |
      | Minimum value                 | 1990-06-12 19:10:25 | Statistics  |
      | Number of non null values     | 5                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 5                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "timestamptztype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue          | widgetName  |
      | Data type                     | TIMESTAMP              | Description |
      | Length                        | 35                     | Statistics  |
      | Maximum value                 | 2016-06-23 02:10:25+00 | Statistics  |
      | Minimum value                 | 1977-02-13 19:09:23+00 | Statistics  |
      | Number of non null values     | 5                      | Statistics  |
      | Percentage of non null values | 100                    | Statistics  |
      | Number of null values         | 0                      | Statistics  |
      | Number of unique values       | 5                      | Statistics  |
      | Percentage of unique values   | 100                    | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget not present" on "Data Distribution" in Item view page


  Scenario Outline:SC40#user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type | targetFile                               | jsonpath                    |
      | APPDBPOSTGRES | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com |      | response/postgressDB/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/PostgreSQLDBCataloger/%DYN                  |      | response/postgressDB/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/PostgreSQLDBAnalyzer/%DYN                |      | response/postgressDB/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  Scenario Outline:SC40#user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/postgressDB/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/postgressDB/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/postgressDB/actual/itemIds.json |

#6822675
  @sanity @positive
  Scenario Outline:MLP-23777:SC41#Run the Plugin configurations for DataSource and PostgresDBCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                                      | response code | response message                 | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBDataSource                                                 | ida/postgressPayloads/DataSource/PostgressAWSInternalNodeValidDataSourceConfig.json       | 204           |                                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBDataSource                                                 |                                                                                           | 200           | PostgressInternalValidDataSource |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger                                                  | ida/postgressPayloads/PluginConfiguration/PostgressAWSConfigWithNoFilterInternalNode.json | 204           |                                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBCataloger                                                  |                                                                                           | 200           | PostgreCataloger                 |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                           | 200           | IDLE                             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  | ida/postgressPayloads/empty.json                                                          | 200           |                                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                           | 200           | IDLE                             | $.[?(@.configurationName=='PostgreCataloger')].status |


  @MLP-21007 @sanity @positive @regression
  Scenario:SC#41: Create PostgressDBAnalyzer Plugin config and start it
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                        | body                                                                                                    | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBAnalyzer                                                    | ida/postgressPayloads/PluginConfiguration/PostgressAnalyzerConfigWithMultipleSchemaTableViewFilter.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer                                                    |                                                                                                         | 200           | PostgreAnalyzer  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                                                         | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                                                         | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                                                         | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status |


    #6876628#Bug MLP-25148 raised for this scenario#
  @webtest @MLP-23727
  Scenario:SC#41_Verify the data sampling works fine for table/view if PostgressDBAnalyzer is run successfully with multiple schema table/view filters.(Run in Internal Node)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DiffDataTypesMinimized" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | Biginttype | Booleantype | Charactertype | Varchartype | Datetype   | Floattype | Integertype | Numerictype | Realtype | Smallinttype | Texttype     | Timetype | Timetztype | Timestamptype         | Timestamptztype       |
      | 1000       | true        | ch            | test        | 2000-12-31 | 23.5      | 34567       | 34.50       | 234.5    | 245          | text string  | 22:10:10 | 02:10:25   | 2016-06-22 19:10:25.0 | 2016-06-23 02:10:25.0 |
      | 2000       | false       | eh            | data types1 | 2001-02-11 | 13.5      | 44567       | 44.50       | 134.5    | 235          | text string1 | 21:09:10 | 02:10:25   | 2013-06-22 19:10:25.0 | 2013-02-13 02:10:25.0 |
      | 3000       | false       | zh            | data types2 | 1998-03-11 | 33.5      | 46567       | 54.50       | 234.5    | 335          | text string2 | 15:09:10 | 02:10:25   | 2011-06-12 19:10:25.0 | 2011-02-12 20:10:25.0 |
      | 4000       | true        | xh            | data types3 | 1992-02-03 | 43.5      | 86567       | 64.50       | 2221.5   | 365          | text string3 | 15:19:20 | 23:15:15   | 1997-06-12 19:10:25.0 | 1977-02-13 19:09:23.0 |
      | 5000       | false       | gy            | data types4 | 1990-12-03 | 63.5      | 16567       | 84.50       | 1231.67  | 865          | text string4 | 05:19:20 | 23:15:15   | 1990-06-12 19:10:25.0 | 1990-02-13 19:09:23.0 |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DiffDataTypesMinimizedView" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | Biginttype | Booleantype | Charactertype | Varchartype | Datetype   | Floattype | Integertype | Numerictype | Realtype | Smallinttype | Texttype     | Timetype | Timetztype | Timestamptype         | Timestamptztype       |
      | 1000       | true        | ch            | test        | 2000-12-31 | 23.5      | 34567       | 34.50       | 234.5    | 245          | text string  | 22:10:10 | 02:10:25   | 2016-06-22 19:10:25.0 | 2016-06-23 02:10:25.0 |
      | 2000       | false       | eh            | data types1 | 2001-02-11 | 13.5      | 44567       | 44.50       | 134.5    | 235          | text string1 | 21:09:10 | 02:10:25   | 2013-06-22 19:10:25.0 | 2013-02-13 02:10:25.0 |
      | 3000       | false       | zh            | data types2 | 1998-03-11 | 33.5      | 46567       | 54.50       | 234.5    | 335          | text string2 | 15:09:10 | 02:10:25   | 2011-06-12 19:10:25.0 | 2011-02-12 20:10:25.0 |
      | 4000       | true        | xh            | data types3 | 1992-02-03 | 43.5      | 86567       | 64.50       | 2221.5   | 365          | text string3 | 15:19:20 | 23:15:15   | 1997-06-12 19:10:25.0 | 1977-02-13 19:09:23.0 |
      | 5000       | false       | gy            | data types4 | 1990-12-03 | 63.5      | 16567       | 84.50       | 1231.67  | 865          | text string4 | 05:19:20 | 23:15:15   | 1990-06-12 19:10:25.0 | 1990-02-13 19:09:23.0 |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DiffDataTypesMinimized" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | Biginttype | Booleantype | Charactertype | Varchartype | Datetype   | Floattype | Integertype | Numerictype | Realtype | Smallinttype | Texttype     | Timetype | Timetztype | Timestamptype         | Timestamptztype       |
      | 1000       | true        | ch            | test        | 2000-12-31 | 23.5      | 34567       | 34.50       | 234.5    | 245          | text string  | 22:10:10 | 02:10:25   | 2016-06-22 19:10:25.0 | 2016-06-23 02:10:25.0 |
      | 2000       | false       | eh            | data types1 | 2001-02-11 | 13.5      | 44567       | 44.50       | 134.5    | 235          | text string1 | 21:09:10 | 02:10:25   | 2013-06-22 19:10:25.0 | 2013-02-13 02:10:25.0 |
      | 3000       | false       | zh            | data types2 | 1998-03-11 | 33.5      | 46567       | 54.50       | 234.5    | 335          | text string2 | 15:09:10 | 02:10:25   | 2011-06-12 19:10:25.0 | 2011-02-12 20:10:25.0 |
      | 4000       | true        | xh            | data types3 | 1992-02-03 | 43.5      | 86567       | 64.50       | 2221.5   | 365          | text string3 | 15:19:20 | 23:15:15   | 1997-06-12 19:10:25.0 | 1977-02-13 19:09:23.0 |
      | 5000       | false       | gy            | data types4 | 1990-12-03 | 63.5      | 16567       | 84.50       | 1231.67  | 865          | text string4 | 05:19:20 | 23:15:15   | 1990-06-12 19:10:25.0 | 1990-02-13 19:09:23.0 |
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DiffDataTypesMinimizedView" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | Biginttype | Booleantype | Charactertype | Varchartype | Datetype   | Floattype | Integertype | Numerictype | Realtype | Smallinttype | Texttype     | Timetype | Timetztype | Timestamptype         | Timestamptztype       |
      | 1000       | true        | ch            | test        | 2000-12-31 | 23.5      | 34567       | 34.50       | 234.5    | 245          | text string  | 22:10:10 | 02:10:25   | 2016-06-22 19:10:25.0 | 2016-06-23 02:10:25.0 |
      | 2000       | false       | eh            | data types1 | 2001-02-11 | 13.5      | 44567       | 44.50       | 134.5    | 235          | text string1 | 21:09:10 | 02:10:25   | 2013-06-22 19:10:25.0 | 2013-02-13 02:10:25.0 |
      | 3000       | false       | zh            | data types2 | 1998-03-11 | 33.5      | 46567       | 54.50       | 234.5    | 335          | text string2 | 15:09:10 | 02:10:25   | 2011-06-12 19:10:25.0 | 2011-02-12 20:10:25.0 |
      | 4000       | true        | xh            | data types3 | 1992-02-03 | 43.5      | 86567       | 64.50       | 2221.5   | 365          | text string3 | 15:19:20 | 23:15:15   | 1997-06-12 19:10:25.0 | 1977-02-13 19:09:23.0 |
      | 5000       | false       | gy            | data types4 | 1990-12-03 | 63.5      | 16567       | 84.50       | 1231.67  | 865          | text string4 | 05:19:20 | 23:15:15   | 1990-06-12 19:10:25.0 | 1990-02-13 19:09:23.0 |


  @positve @regression @sanity @webtest
  Scenario:SC41#Verify the data profiling metadata information for string datatype in Postgress table/view if postgressAnalyzer is ran with multiple schema/view filters.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "DiffDataTypesMinimized [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimized [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "varchartype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 30            | Statistics  |
      | Maximum length                | 11            | Statistics  |
      | Maximum value                 | test          | Statistics  |
      | Minimum length                | 4             | Statistics  |
      | Minimum value                 | data types1   | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user enters the search text "DiffDataTypesMinimized [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "varchartype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 30            | Statistics  |
      | Maximum length                | 11            | Statistics  |
      | Maximum value                 | test          | Statistics  |
      | Minimum length                | 4             | Statistics  |
      | Minimum value                 | data types1   | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user enters the search text "DiffDataTypesMinimized [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimized [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "varchartype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 30            | Statistics  |
      | Maximum length                | 11            | Statistics  |
      | Maximum value                 | test          | Statistics  |
      | Minimum length                | 4             | Statistics  |
      | Minimum value                 | data types1   | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "varchartype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 30            | Statistics  |
      | Maximum length                | 11            | Statistics  |
      | Maximum value                 | test          | Statistics  |
      | Minimum length                | 4             | Statistics  |
      | Minimum value                 | data types1   | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page

  @positve @regression @sanity @webtest
  Scenario:SC42#Verify the data profiling metadata information for numeric datatypes after PostgressAnalyzer is ran with multiple schema view filters.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "biginttype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | BIGINT        | Description |
      | Average                       | 3000          | Statistics  |
      | Length                        | 19            | Statistics  |
      | Maximum value                 | 5000          | Statistics  |
      | Median                        | 3000          | Statistics  |
      | Minimum value                 | 1000          | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 1581.14       | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 2500000       | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "integertype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | INTEGER       | Description |
      | Average                       | 45767         | Statistics  |
      | Length                        | 10            | Statistics  |
      | Maximum value                 | 86567         | Statistics  |
      | Median                        | 44567         | Statistics  |
      | Minimum value                 | 16567         | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 25713.81      | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 661200000     | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "floattype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DOUBLE        | Description |
      | Average                       | 35.5          | Statistics  |
      | Length                        | 17            | Statistics  |
      | Maximum value                 | 63.5          | Statistics  |
      | Median                        | 33.5          | Statistics  |
      | Minimum value                 | 13.5          | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 19.24         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 370           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "numerictype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMERIC       | Description |
      | Average                       | 56.5          | Statistics  |
      | Length                        | 5             | Statistics  |
      | Maximum value                 | 84.50         | Statistics  |
      | Median                        | 54.5          | Statistics  |
      | Minimum value                 | 34.50         | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 19.24         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 370           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "smallinttype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | SMALLINT      | Description |
      | Average                       | 409           | Statistics  |
      | Length                        | 5             | Statistics  |
      | Maximum value                 | 865           | Statistics  |
      | Median                        | 335           | Statistics  |
      | Minimum value                 | 235           | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 261.02        | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 68130         | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "biginttype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | BIGINT        | Description |
      | Average                       | 3000          | Statistics  |
      | Length                        | 19            | Statistics  |
      | Maximum value                 | 5000          | Statistics  |
      | Median                        | 3000          | Statistics  |
      | Minimum value                 | 1000          | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 1581.14       | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 2500000       | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "integertype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | INTEGER       | Description |
      | Average                       | 45767         | Statistics  |
      | Length                        | 10            | Statistics  |
      | Maximum value                 | 86567         | Statistics  |
      | Median                        | 44567         | Statistics  |
      | Minimum value                 | 16567         | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 25713.81      | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 661200000     | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "floattype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DOUBLE        | Description |
      | Average                       | 35.5          | Statistics  |
      | Length                        | 17            | Statistics  |
      | Maximum value                 | 63.5          | Statistics  |
      | Median                        | 33.5          | Statistics  |
      | Minimum value                 | 13.5          | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 19.24         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 370           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "numerictype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMERIC       | Description |
      | Average                       | 56.5          | Statistics  |
      | Length                        | 5             | Statistics  |
      | Maximum value                 | 84.50         | Statistics  |
      | Median                        | 54.5          | Statistics  |
      | Minimum value                 | 34.50         | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 19.24         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 370           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimizedView [Table]" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimizedView [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "smallinttype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | SMALLINT      | Description |
      | Average                       | 409           | Statistics  |
      | Length                        | 5             | Statistics  |
      | Maximum value                 | 865           | Statistics  |
      | Median                        | 335           | Statistics  |
      | Minimum value                 | 235           | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 261.02        | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 68130         | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page


  @positve @regression @sanity @webtest
  Scenario:SC43#Verify the data profiling metadata information for numeric datatypes after PostgressAnalyzer is ran with multiple schema table filters.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "DiffDataTypesMinimized [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimized [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "biginttype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | BIGINT        | Description |
      | Average                       | 3000          | Statistics  |
      | Length                        | 19            | Statistics  |
      | Maximum value                 | 5000          | Statistics  |
      | Median                        | 3000          | Statistics  |
      | Minimum value                 | 1000          | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 1581.14       | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 2500000       | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimized [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimized [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "integertype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | INTEGER       | Description |
      | Average                       | 45767         | Statistics  |
      | Length                        | 10            | Statistics  |
      | Maximum value                 | 86567         | Statistics  |
      | Median                        | 44567         | Statistics  |
      | Minimum value                 | 16567         | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 25713.81      | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 661200000     | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimized [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimized [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "floattype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DOUBLE        | Description |
      | Average                       | 35.5          | Statistics  |
      | Length                        | 17            | Statistics  |
      | Maximum value                 | 63.5          | Statistics  |
      | Median                        | 33.5          | Statistics  |
      | Minimum value                 | 13.5          | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 19.24         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 370           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimized [Table]" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimized [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "numerictype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMERIC       | Description |
      | Average                       | 56.5          | Statistics  |
      | Length                        | 5             | Statistics  |
      | Maximum value                 | 84.50         | Statistics  |
      | Median                        | 54.5          | Statistics  |
      | Minimum value                 | 34.50         | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 19.24         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 370           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimized [Table]" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimized [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "smallinttype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | SMALLINT      | Description |
      | Average                       | 409           | Statistics  |
      | Length                        | 5             | Statistics  |
      | Maximum value                 | 865           | Statistics  |
      | Median                        | 335           | Statistics  |
      | Minimum value                 | 235           | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 261.02        | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 68130         | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimized [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimized [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "biginttype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | BIGINT        | Description |
      | Average                       | 3000          | Statistics  |
      | Length                        | 19            | Statistics  |
      | Maximum value                 | 5000          | Statistics  |
      | Median                        | 3000          | Statistics  |
      | Minimum value                 | 1000          | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 1581.14       | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 2500000       | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimized [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimized [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "integertype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | INTEGER       | Description |
      | Average                       | 45767         | Statistics  |
      | Length                        | 10            | Statistics  |
      | Maximum value                 | 86567         | Statistics  |
      | Median                        | 44567         | Statistics  |
      | Minimum value                 | 16567         | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 25713.81      | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 661200000     | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimized [Table]" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimized [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "floattype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DOUBLE        | Description |
      | Average                       | 35.5          | Statistics  |
      | Length                        | 17            | Statistics  |
      | Maximum value                 | 63.5          | Statistics  |
      | Median                        | 33.5          | Statistics  |
      | Minimum value                 | 13.5          | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 19.24         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 370           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimized [Table]" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimized [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "numerictype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMERIC       | Description |
      | Average                       | 56.5          | Statistics  |
      | Length                        | 5             | Statistics  |
      | Maximum value                 | 84.50         | Statistics  |
      | Median                        | 54.5          | Statistics  |
      | Minimum value                 | 34.50         | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 19.24         | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 370           | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page
    And user enters the search text "DiffDataTypesMinimized [Table]" and clicks on search
    And user performs "facet selection" in "postgresstestschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DiffDataTypesMinimized [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "smallinttype" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | SMALLINT      | Description |
      | Average                       | 409           | Statistics  |
      | Length                        | 5             | Statistics  |
      | Maximum value                 | 865           | Statistics  |
      | Median                        | 335           | Statistics  |
      | Minimum value                 | 235           | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Standard deviation            | 261.02        | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 68130         | Statistics  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "widget presence" on "Data Distribution" in Item view page


    #6754453#
  @sanity @positive @MLP-20518 @webtest @IDA-1.1.0
  Scenario:SC43#Verify log entries/log enhancements(processed Items widget and Processed count) check for PostgressDBAnalyzer plugin logs.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    And user performs "facet selection" in "PostgressTag1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%"
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com |
      | PostgreSQL                                            |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | logCode       | pluginName           | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0019 |                      |                |
      | INFO | Plugin Name:postgresqldbanalyzer, Plugin Type:dataanalyzer, Plugin Version:1.1.0.SNAPSHOT, Node Name:internal, Host Name:0beb65172009, Plugin Configuration name:"PostgreAnalyzer"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ANALYSIS-0071 | PostgreSQLDBAnalyzer | Plugin Version |
      | INFO | Plugin PostgreSQLDBAnalyzer Configuration: ---  2020-09-26 20:00:24.893 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: name: "PostgreAnalyzer"  2020-09-26 20:00:24.893 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: pluginVersion: "LATEST"  2020-09-26 20:00:24.893 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: label:  2020-09-26 20:00:24.893 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: : ""  2020-09-26 20:00:24.893 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: catalogName: "Default"  2020-09-26 20:00:24.893 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: eventClass: null  2020-09-26 20:00:24.893 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: eventCondition: null  2020-09-26 20:00:24.893 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: nodeCondition: "type=='internal'"  2020-09-26 20:00:24.893 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: maxWorkSize: 100  2020-09-26 20:00:24.893 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: tags:  2020-09-26 20:00:24.893 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: - "PostgressTag1"  2020-09-26 20:00:24.893 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: pluginType: "dataanalyzer"  2020-09-26 20:00:24.893 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: dataSource: null  2020-09-26 20:00:24.893 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: credential: null  2020-09-26 20:00:24.893 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: businessApplicationName: "PostgressBA"  2020-09-26 20:00:24.893 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: dryRun: false  2020-09-26 20:00:24.893 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: schedule: null  2020-09-26 20:00:24.893 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: filter: null  2020-09-26 20:00:24.894 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: histogramBuckets: 100  2020-09-26 20:00:24.894 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: database: "postgres"  2020-09-26 20:00:24.894 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: pluginName: "PostgreSQLDBAnalyzer"  2020-09-26 20:00:24.894 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: queryBatchSize: 1  2020-09-26 20:00:24.894 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: sampleDataCount: 10  2020-09-26 20:00:24.894 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: schemas:  2020-09-26 20:00:24.894 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: - schema: "postgresstestschema"  2020-09-26 20:00:24.894 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: tables:  2020-09-26 20:00:24.894 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: - table: "DiffDataTypesMinimized"  2020-09-26 20:00:24.894 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: - table: "DiffDataTypesMinimizedView"  2020-09-26 20:00:24.894 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: - schema: "postgrestest"  2020-09-26 20:00:24.894 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: tables:  2020-09-26 20:00:24.894 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: - table: "DiffDataTypesMinimizedView"  2020-09-26 20:00:24.894 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: - table: "DiffDataTypesMinimized"  2020-09-26 20:00:24.894 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: type: "Dataanalyzer"  2020-09-26 20:00:24.894 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: topValues: 10  2020-09-26 20:00:24.894 | ANALYSIS-0073 | PostgreSQLDBAnalyzer |                |
      | INFO | plugin postgresqldbanalyzer Start Time:2020-04-15 18:17:09.422, End Time:2020-04-15 18:20:42.938, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0072 | PostgreSQLDBAnalyzer |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:35.865)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0020 |                      |                |

  Scenario Outline:SC43#user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                  | type | targetFile                               | jsonpath                    |
      | APPDBPOSTGRES | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com |      | response/postgressDB/actual/itemIds.json | $..Cluster.id               |
      | APPDBPOSTGRES | Default | cataloger/PostgreSQLDBCataloger/%DYN                  |      | response/postgressDB/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/PostgreSQLDBAnalyzer/%DYN                |      | response/postgressDB/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  Scenario Outline:SC43#user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                |
      | items/Default/Default.Cluster:::dynamic  | 204          | $..Cluster.id               | response/postgressDB/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/postgressDB/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/postgressDB/actual/itemIds.json |

#6938866
  @MLP-21007 @webtest @positive @regression @sanity
  Scenario: SC#44- Verify proper error message is shown if mandatory fields are not filled in PostgressDBAnalyzer configuration page
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
      | fieldName | attribute            |
      | Type      | Dataanalyzer         |
      | Plugin    | PostgreSQLDBAnalyzer |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @webtest @jdbc @MLP-23727
  Scenario:SC#45_Verify proper error message is thrown in UI if Sample Data count/Top Values/Histogram Buckets values are not provided within valid range in PostgressDBAnalyzer
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
      | fieldName | attribute            |
      | Type      | Dataanalyzer         |
      | Plugin    | PostgreSQLDBAnalyzer |
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


    #6822675
  @sanity @positive
  Scenario Outline:MLP-23777:SC44#Run the Plugin configurations for DataSource and PostgresDBCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                              | response code | response message         | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBDataSource                                              | ida/postgressPayloads/DataSource/PostgressAWSValidDataSourceConfig.json                           | 204           |                          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBDataSource                                              |                                                                                                   | 200           | PostgressValidDataSource |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger                                               | ida/postgressPayloads/PluginConfiguration/PostgressConfigWithNonexistingSchemaAndTableFilter.json | 204           |                          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBCataloger                                               |                                                                                                   | 200           | PostgreCataloger         |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                                   | 200           | IDLE                     | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  | ida/postgressPayloads/empty.json                                                                  | 200           |                          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                                   | 200           | IDLE                     | $.[?(@.configurationName=='PostgreCataloger')].status |


  @MLP-21007 @sanity @positive @regression
  Scenario:SC#44: Create PostgressDBAnalyzer Plugin config and start it
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                     | body                                                                                         | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBAnalyzer                                                 | ida/postgressPayloads/PluginConfiguration/PostgressAnalyzerConfigNonExistingSchemaTable.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer                                                 |                                                                                              | 200           | PostgreAnalyzer  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                                              | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status |

    #6936990
  @MLP-20518 @webtest @aws @regression @sanity
  Scenario:SC44#Validate analyzer does not do any analysis and log throws proper message when non existing schema/Table are passed in postgressDBanalyzer configuration.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
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
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%" should display below info/error/warning
      | type | logValue                                                                                          | logCode            | pluginName           | removableText |
      | INFO | 2020-06-23 21:29:11.328 WARN  - ANALYSIS-JDBC-0053:  Database [postgres] not found in the Catalog | ANALYSIS-JDBC-0053 | PostgreSQLDBAnalyzer |               |
    And user clicks on logout button

  Scenario Outline:SC43#user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                   | type | targetFile                               | jsonpath                    |
      | APPDBPOSTGRES | Default | cataloger/PostgreSQLDBCataloger/%DYN   |      | response/postgressDB/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/PostgreSQLDBAnalyzer/%DYN |      | response/postgressDB/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  Scenario Outline:SC43#user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/postgressDB/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/postgressDB/actual/itemIds.json |

      #6822675
  @sanity @positive
  Scenario Outline:MLP-23777:SC44#Run the Plugin configurations for DataSource and PostgresDBCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                                              | response code | response message         | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBDataSource                                              | ida/postgressPayloads/DataSource/PostgressAWSValidDataSourceConfig.json                           | 204           |                          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBDataSource                                              |                                                                                                   | 200           | PostgressValidDataSource |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger                                               | ida/postgressPayloads/PluginConfiguration/PostgressConfigWithNonexistingSchemaAndTableFilter.json | 204           |                          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBCataloger                                               |                                                                                                   | 200           | PostgreCataloger         |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                                   | 200           | IDLE                     | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  | ida/postgressPayloads/empty.json                                                                  | 200           |                          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                                                   | 200           | IDLE                     | $.[?(@.configurationName=='PostgreCataloger')].status |


  @MLP-21007 @sanity @positive @regression
  Scenario:SC#44: Create PostgressDBAnalyzer Plugin config and start it
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                     | body                                                                                | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBAnalyzer                                                 | ida/postgressPayloads/PluginConfiguration/PostgressAnalyzerConfigNonExistingDB.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer                                                 |                                                                                     | 200           | PostgreAnalyzer  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                                     | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status |


    #6936990
  @MLP-20518 @webtest @aws @regression @sanity
  Scenario:SC44#Validate analyzer does not do any analysis and log throws proper message when non existing DB is passed in postgressDBanalyzer configuration.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
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
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%" should display below info/error/warning
      | type | logValue                                                                                          | logCode            | pluginName           | removableText |
      | INFO | 2020-06-23 21:29:11.328 WARN  - ANALYSIS-JDBC-0053:  Database [postgres] not found in the Catalog | ANALYSIS-JDBC-0053 | PostgreSQLDBAnalyzer |               |
    And user clicks on logout button


  Scenario Outline:SC43#user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                   | type | targetFile                               | jsonpath                    |
      | APPDBPOSTGRES | Default | cataloger/PostgreSQLDBCataloger/%DYN   |      | response/postgressDB/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/PostgreSQLDBAnalyzer/%DYN |      | response/postgressDB/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  Scenario Outline:SC43#user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/postgressDB/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/postgressDB/actual/itemIds.json |

#6822675
  @sanity @positive
  Scenario Outline:MLP-23777:SC44#Run the Plugin configurations for DataSource and PostgresDBCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | body                                                                         | response code | response message         | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBDataSource                                              | ida/postgressPayloads/DataSource/PostgressAWSValidDataSourceConfig.json      | 204           |                          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBDataSource                                              |                                                                              | 200           | PostgressValidDataSource |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger                                               | ida/postgressPayloads/PluginConfiguration/PostgressConfigWithDryRunTrue.json | 204           |                          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBCataloger                                               |                                                                              | 200           | PostgreCataloger         |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                              | 200           | IDLE                     | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  | ida/postgressPayloads/empty.json                                             | 200           |                          |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger |                                                                              | 200           | IDLE                     | $.[?(@.configurationName=='PostgreCataloger')].status |


  @MLP-21007 @sanity @positive @regression
  Scenario:SC#44: Create PostgressDBAnalyzer Plugin config and start it
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                     | body                                                                                 | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBAnalyzer                                                 | ida/postgressPayloads/PluginConfiguration/PostgressAnalyzerConfigWithDryRunTrue.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer                                                 |                                                                                      | 200           | PostgreAnalyzer  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                                      | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status |


#6936990
  @MLP-23777 @webtest @regression @sanity
  Scenario: SC#30- Verify PostgressDBAnalyzer doesn't collects Cluster,Service,Database,Table,Column,Constraint when PostgressDBAanlyzer is run with dryrun as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PostgressTag1" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service    |
      | Cluster    |
      | Database   |
      | Table      |
      | Column     |
      | Constraint |
      | Schema     |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | logCode       | pluginName           | removableText |
      | INFO | Plugin started2020-09-26 20:14:26.113                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | ANALYSIS-0019 | PostgreSQLDBAnalyzer |               |
      | INFO | Plugin Name:PostgreSQLDBAnalyzer, Plugin Type:dataanalyzer, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:62ee4a6f17ab, Plugin Configuration name:PostgreAnalyzer2020-09-26 20:14:26.356                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ANALYSIS-0071 | PostgreSQLDBAnalyzer |               |
      | INFO | Plugin PostgreSQLDBAnalyzer Configuration: ---  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: name: "PostgreAnalyzer"  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: pluginVersion: "LATEST"  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: label:  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: : ""  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: catalogName: "Default"  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: eventClass: null  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: eventCondition: null  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: nodeCondition: null  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: maxWorkSize: 100  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: tags:  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: - "PostgressTag1"  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: pluginType: "dataanalyzer"  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: dataSource: null  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: credential: null  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: businessApplicationName: "PostgressBA"  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: dryRun: false  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: schedule: null  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: filter: null  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: histogramBuckets: 100  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: database: "postgres"  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: pluginName: "PostgreSQLDBAnalyzer"  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: queryBatchSize: 1  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: sampleDataCount: 10  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: schemas:  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: - schema: "postgresstestschema"  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: tables:  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: - table: "DiffDataTypesMinimized"  2020-09-26 20:14:26.113 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: - table: "DiffDataTypesMinimizedView"  2020-09-26 20:14:26.114 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: type: "Dataanalyzer"  2020-09-26 20:14:26.114 INFO  - ANALYSIS-0073: Plugin PostgreSQLDBAnalyzer Configuration: topValues: 10  2020-09-26 20:14:26.114 | ANALYSIS-0073 | PostgreSQLDBAnalyzer |               |
      | INFO | Plugin PostgreSQLDBAnalyzer Start Time:2020-09-26 20:14:26.112, End Time:2020-09-26 20:14:26.356, Processed Count:0, Errors:0, Warnings:12020-09-26 20:14:26.356                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0072 | PostgreSQLDBAnalyzer |               |
    And user clicks on logout button

  Scenario Outline:SC43#user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                   | type | targetFile                               | jsonpath                    |
      | APPDBPOSTGRES | Default | cataloger/PostgreSQLDBCataloger/%DYN   |      | response/postgressDB/actual/itemIds.json | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | dataanalyzer/PostgreSQLDBAnalyzer/%DYN |      | response/postgressDB/actual/itemIds.json | $..has_AnalyzerAnalysis.id  |

  Scenario Outline:SC43#user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                   | inputFile                                |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_CatalogerAnalysis.id | response/postgressDB/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_AnalyzerAnalysis.id  | response/postgressDB/actual/itemIds.json |

################################################################### TAGS VALIDATION  ####################################################################

  @PIITag
  Scenario Outline: SC62#-create PIItags with respect to postgress DB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                                     | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | tags/Default/structures | ida/postgressPayloads/policyengine/PostgressPIItags.json | 200           |                  |          |


  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#62: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path             | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.MatchEmptyTag  | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig  | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                  | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                  | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                  | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                  | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                  | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                  | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                  | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                  | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |


    # 7089401 #
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#62:Verify Tag is not set for the column when Ignore empty and null is true and all the column values in DB are blank/null.(dataPattern/minimumRatio/MatchEmpty:True/MatchFull:False)
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename  | Column    | Tags                                                | Query                 | Action      |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY | email     | PostgressTag1,Postgress_BA,PostgreSQL,Email Address | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY | ipaddress | PostgressTag1,Postgress_BA,PostgreSQL,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY | ssn       | PostgressTag1,Postgress_BA,PostgreSQL,SSN           | ColumnQuerywithSchema | TagAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#62_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | SingleItemDelete | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/PostgreSQLDBCataloger/PostgreCataloger%     | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%    | Analysis |       |       |

#####################################################################################################################################


  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#63: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path                   | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.MatchRatiolessthan05 | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig        | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                        | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                        | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig       | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                        | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                        | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |


    # 7089401 #
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#63: Verify Tag is set for the column when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the data in column in postgress table.
  (Ex: 0.2 - 2 or more rows should have matcning column values)- Match Empty is False
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename                   | Column    | Tags                                                | Query                 | Action      |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiolessthan05EmptyFalse | email     | PostgressTag1,Postgress_BA,PostgreSQL,Email Address | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiolessthan05EmptyFalse | ipaddress | PostgressTag1,Postgress_BA,PostgreSQL,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiolessthan05EmptyFalse | ssn       | PostgressTag1,Postgress_BA,PostgreSQL,SSN           | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiolessthan05EmptyFalse | full_name | PostgressTag1,Postgress_BA,PostgreSQL,Full Name     | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiolessthan05EmptyFalse | gender    | PostgressTag1,Postgress_BA,PostgreSQL,Gender        | ColumnQuerywithSchema | TagAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#63_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | SingleItemDelete | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/PostgreSQLDBCataloger/PostgreCataloger%     | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%    | Analysis |       |       |
##########################################################################################################################
  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#64: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path                   | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.Typedataratiopattern | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig        | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                        | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                        | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig       | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                        | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                        | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |


    # 7089401 #
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#64: Verify Tag is set for the column when typePattern(String) and dataPattern/minimumRatio matches with the column type/value ratio
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename                  | Column    | Tags                                                | Query                 | Action      |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | email     | PostgressTag1,Postgress_BA,PostgreSQL,Email Address | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | ipaddress | PostgressTag1,Postgress_BA,PostgreSQL,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | ssn       | PostgressTag1,Postgress_BA,PostgreSQL,SSN           | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | full_name | PostgressTag1,Postgress_BA,PostgreSQL,Full Name     | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | gender    | PostgressTag1,Postgress_BA,PostgreSQL,Gender        | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | email     | PostgressTag1,Postgress_BA,PostgreSQL,Email Address | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | ipaddress | PostgressTag1,Postgress_BA,PostgreSQL,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | ssn       | PostgressTag1,Postgress_BA,PostgreSQL,SSN           | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | full_name | PostgressTag1,Postgress_BA,PostgreSQL,Full Name     | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | gender    | PostgressTag1,Postgress_BA,PostgreSQL,Gender        | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | email     | PostgressTag1,Postgress_BA,PostgreSQL,Email Address | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | ipaddress | PostgressTag1,Postgress_BA,PostgreSQL,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | ssn       | PostgressTag1,Postgress_BA,PostgreSQL,SSN           | ColumnQuerywithSchema | TagAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#64_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | SingleItemDelete | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/PostgreSQLDBCataloger/PostgreCataloger%     | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%    | Analysis |       |       |

###################################################################################################################################


  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#65: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path                 | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.dataratiofullmatch | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig      | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                      | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                      | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                      | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                      | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig     | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                      | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                      | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                      | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                      | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |


    # 7089401 #
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#65: Verify Tag is set for the column when dataPattern and minimumRatio(1-full match) is passed which has a regexp that matches with the data in column in postgress table.
  (Ex: 1 - all rows should match) - Match Empty is false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename  | Column    | Tags                                                | Query                 | Action      |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH | email     | PostgressTag1,Postgress_BA,PostgreSQL,Email Address | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH | ipaddress | PostgressTag1,Postgress_BA,PostgreSQL,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH | ssn       | PostgressTag1,Postgress_BA,PostgreSQL,SSN           | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH | full_name | PostgressTag1,Postgress_BA,PostgreSQL,Full Name     | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH | gender    | PostgressTag1,Postgress_BA,PostgreSQL,Gender        | ColumnQuerywithSchema | TagAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#65_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | SingleItemDelete | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/PostgreSQLDBCataloger/PostgreCataloger%     | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%    | Analysis |       |       |


    #####################################################################################################################################

  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#66: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path                   | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.namedataratiopattern | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig        | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                        | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                        | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig       | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                        | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                        | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |


    # 7089401 #
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#66: Verify Tag is set for the column when namePattern(String) and dataPattern/minimumRatio matches with the column type/value ratio
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename                  | Column    | Tags                                                | Query                 | Action      |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | email     | PostgressTag1,Postgress_BA,PostgreSQL,Email Address | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | ipaddress | PostgressTag1,Postgress_BA,PostgreSQL,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | ssn       | PostgressTag1,Postgress_BA,PostgreSQL,SSN           | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | full_name | PostgressTag1,Postgress_BA,PostgreSQL,Full Name     | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | gender    | PostgressTag1,Postgress_BA,PostgreSQL,Gender        | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | email     | PostgressTag1,Postgress_BA,PostgreSQL,Email Address | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | ipaddress | PostgressTag1,Postgress_BA,PostgreSQL,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | ssn       | PostgressTag1,Postgress_BA,PostgreSQL,SSN           | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | full_name | PostgressTag1,Postgress_BA,PostgreSQL,Full Name     | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | gender    | PostgressTag1,Postgress_BA,PostgreSQL,Gender        | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | email     | PostgressTag1,Postgress_BA,PostgreSQL,Email Address | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | ipaddress | PostgressTag1,Postgress_BA,PostgreSQL,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | ssn       | PostgressTag1,Postgress_BA,PostgreSQL,SSN           | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | full_name | PostgressTag1,Postgress_BA,PostgreSQL,Full Name     | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | gender    | PostgressTag1,Postgress_BA,PostgreSQL,Gender        | ColumnQuerywithSchema | TagAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#66_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | SingleItemDelete | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/PostgreSQLDBCataloger/PostgreCataloger%     | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%    | Analysis |       |       |

#####################################################################################################################################

  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#67: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path                       | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.nametypedataratiopattern | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig            | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                            | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                            | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                            | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                            | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig           | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                            | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                            | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                            | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                            | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |


    # 7089401 #
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#67: Verify Tag is set for the column when namePattern(String) and dataPattern/minimumRatio matches with the column type/value ratio
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename                   | Column    | Tags                                                | Query                 | Action      |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiolessthan05EmptyFalse | email     | PostgressTag1,Postgress_BA,PostgreSQL,Email Address | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiolessthan05EmptyFalse | ipaddress | PostgressTag1,Postgress_BA,PostgreSQL,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiolessthan05EmptyFalse | ssn       | PostgressTag1,Postgress_BA,PostgreSQL,SSN           | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiolessthan05EmptyFalse | full_name | PostgressTag1,Postgress_BA,PostgreSQL,Full Name     | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiolessthan05EmptyFalse | gender    | PostgressTag1,Postgress_BA,PostgreSQL,Gender        | ColumnQuerywithSchema | TagAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#67_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | SingleItemDelete | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/PostgreSQLDBCataloger/PostgreCataloger%     | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%    | Analysis |       |       |

#####################################################################################################################################

  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#68: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path                        | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.dataratiopatternequalto05 | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig             | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                             | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                             | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                             | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                             | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig            | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                             | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                             | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                             | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                             | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |


    # 7089401 #
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#68: Verify Tag is set for the column when dataPattern and minimumRatio(equal to 0.5) is passed which has a regexp that matches with the data in column in Postgress table.
  (Ex: 0.5 - 5 or more rows should have matching column values) - Match Empty is false.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename                  | Column    | Tags                                                | Query                 | Action      |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | email     | PostgressTag1,Postgress_BA,PostgreSQL,Email Address | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | ipaddress | PostgressTag1,Postgress_BA,PostgreSQL,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | ssn       | PostgressTag1,Postgress_BA,PostgreSQL,SSN           | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | full_name | PostgressTag1,Postgress_BA,PostgreSQL,Full Name     | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | gender    | PostgressTag1,Postgress_BA,PostgreSQL,Gender        | ColumnQuerywithSchema | TagAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#68_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | SingleItemDelete | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/PostgreSQLDBCataloger/PostgreCataloger%     | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%    | Analysis |       |       |

    #####################################################################################################################################

  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#69: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path                              | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.typedataratiotypepatternnomatch | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig                   | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                                   | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                                   | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                                   | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                                   | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig                  | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                                   | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                                   | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                                   | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                                   | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |


    # 7089401 #
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#69: Verify Tag is not set for the column when typePattern(other than String) and dataPattern/minimumRatio matches with the column type/value ratio in postgress table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename                  | Column    | Tags          | Query                 | Action         |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | email     | Email Address | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | ipaddress | IP Address    | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | ssn       | SSN           | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | full_name | Full Name     | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | gender    | Gender        | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | email     | Email Address | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | ipaddress | IP Address    | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | ssn       | SSN           | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | full_name | Full Name     | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | gender    | Gender        | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | email     | Email Address | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | ipaddress | IP Address    | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | ssn       | SSN           | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | full_name | Full Name     | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | gender    | Gender        | ColumnQuerywithSchema | TagNotAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#69_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | SingleItemDelete | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/PostgreSQLDBCataloger/PostgreCataloger%     | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%    | Analysis |       |       |

    #####################################################################################################################################

  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#70: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path                        | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.namedatarationamenotmatch | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig             | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                             | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                             | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                             | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                             | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig            | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                             | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                             | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                             | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                             | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |


    # 7089401 #
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#70: Verify Tag is not set for the column when namePattern(does not match) and dataPattern/minimumRatio that does not matches with the column name/value ratio in postgress table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename                  | Column    | Tags          | Query                 | Action         |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | email     | Email Address | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | ipaddress | IP Address    | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | ssn       | SSN           | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | full_name | Full Name     | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | gender    | Gender        | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | email     | Email Address | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | ipaddress | IP Address    | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | ssn       | SSN           | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | full_name | Full Name     | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | gender    | Gender        | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | email     | Email Address | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | ipaddress | IP Address    | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | ssn       | SSN           | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | full_name | Full Name     | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | gender    | Gender        | ColumnQuerywithSchema | TagNotAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#70_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | SingleItemDelete | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/PostgreSQLDBCataloger/PostgreCataloger%     | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%    | Analysis |       |       |

######################################################################################################################################


  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#71: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path                                    | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.dataratiomatchemptyfalsegreaterthan05 | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig                         | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                                         | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                                         | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                                         | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                                         | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig                        | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                                         | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                                         | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                                         | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                                         | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |


    # 7089401 #
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#71a: Verify Tag is not set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in postgress table.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is False -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename                          | Column    | Tags                                                | Query                 | Action         |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | ssn       | SSN                                                 | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | full_name | Full Name                                           | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | gender    | Gender                                              | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | email     | PostgressTag1,Postgress_BA,PostgreSQL,Email Address | ColumnQuerywithSchema | TagAssigned    |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | ipaddress | PostgressTag1,Postgress_BA,PostgreSQL,IP Address    | ColumnQuerywithSchema | TagAssigned    |


  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#71b: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path                                   | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.dataratiomatchemptytruegreaterthan05 | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig                        | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                                        | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                                        | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig                       | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                                        | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                                        | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |


    # 7089401 #
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#71.b: Verify Tag is set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in snowflake table.
  (Ex: 0.6 - 6 or more rows should have matching column values including empty) - Match Empty is False -10 rows , 3 rows empty, 4 rows match,3 rows does not match.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename                          | Column    | Tags                                                | Query                 | Action      |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | ssn       | PostgressTag1,Postgress_BA,PostgreSQL,SSN           | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | full_name | PostgressTag1,Postgress_BA,PostgreSQL,Full Name     | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | gender    | PostgressTag1,Postgress_BA,PostgreSQL,Gender        | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | email     | PostgressTag1,Postgress_BA,PostgreSQL,Email Address | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | ipaddress | PostgressTag1,Postgress_BA,PostgreSQL,IP Address    | ColumnQuerywithSchema | TagAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#71.b_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | SingleItemDelete | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/PostgreSQLDBCataloger/PostgreCataloger%     | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%    | Analysis |       |       |

#####################################################################################################################################

  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#72: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path                               | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.namedatarationamepatternnotmatch | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig                    | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                                    | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                                    | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                                    | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                                    | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig                   | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                                    | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                                    | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                                    | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                                    | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |


    # 7089401 #
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#72: Verify Tag is not set for the column when namePattern(does not match) and dataPattern/minimumRatio that does not matches with the column name/value ratio in postgress table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename                  | Column    | Tags          | Query                 | Action         |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | ssn       | SSN           | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | full_name | Full Name     | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | gender    | Gender        | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | email     | Email Address | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | ipaddress | IP Address    | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | ssn       | SSN           | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | full_name | Full Name     | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | gender    | Gender        | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | email     | Email Address | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | ipaddress | IP Address    | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | ssn       | SSN           | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | full_name | Full Name     | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | gender    | Gender        | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | email     | Email Address | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | ipaddress | IP Address    | ColumnQuerywithSchema | TagNotAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#72_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | SingleItemDelete | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/PostgreSQLDBCataloger/PostgreCataloger%     | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%    | Analysis |       |       |

    #####################################################################################################################################

  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#73: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path                                   | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.nametypedataratiotypepatternnotmatch | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig                        | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                                        | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                                        | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig                       | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                                        | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                                        | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |


    # 7089401 #
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#73: Verify Tag is not set for the column when namePattern,typePattern(does not match),dataPattern,minimumRatio is passed which has any of the regexp and ratio that does not matches with the data in column in postgress table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename                  | Column    | Tags          | Query                 | Action         |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | ssn       | SSN           | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | full_name | Full Name     | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | gender    | Gender        | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | email     | Email Address | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | ipaddress | IP Address    | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | ssn       | SSN           | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | full_name | Full Name     | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | gender    | Gender        | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | email     | Email Address | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | ipaddress | IP Address    | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | ssn       | SSN           | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | full_name | Full Name     | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | gender    | Gender        | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | email     | Email Address | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | ipaddress | IP Address    | ColumnQuerywithSchema | TagNotAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#73_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | SingleItemDelete | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/PostgreSQLDBCataloger/PostgreCataloger%     | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%    | Analysis |       |       |

#####################################################################################################################################

  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#74: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path                                   | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.nametypedataratiodatapatternnotmatch | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig                        | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                                        | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                                        | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig                       | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                                        | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                                        | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |


    # 7089401 #
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#74: Verify Tag is not set for the column when namePattern,typePattern,dataPattern and minimumRatio(does not match) is passed which has any of the regexp and ratio that does not matches with the data in column in postgress table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename                  | Column    | Tags          | Query                 | Action         |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | ssn       | SSN           | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | full_name | Full Name     | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | gender    | Gender        | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | email     | Email Address | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLMATCH                 | ipaddress | IP Address    | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | ssn       | SSN           | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | full_name | Full Name     | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | gender    | Gender        | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | email     | Email Address | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_ALLEMPTY                 | ipaddress | IP Address    | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | ssn       | SSN           | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | full_name | Full Name     | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | gender    | Gender        | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | email     | Email Address | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_RatioEqualTo05EmptyFalse | ipaddress | IP Address    | ColumnQuerywithSchema | TagNotAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#74_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | SingleItemDelete | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/PostgreSQLDBCataloger/PostgreCataloger%     | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%    | Analysis |       |       |


 #####################################################################################################################################

  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#75.a: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path                         | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.MatchFullTruegreaterthan05 | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig              | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                              | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                              | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                              | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                              | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig             | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                              | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                              | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                              | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                              | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |


  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#75.a: Verify Multiple Tag is not set for the column when Whole word Match:true and Tag is set when reran with Whole word Match:false when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the exact data in column in redshift table.
  (Ex: 0.6 - 6 or more rows should have matcning column values - dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename                         | Column   | Tags                         | Query                 | Action         |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | comments | Fullmatch PII,Fullmatch PII1 | ColumnQuerywithSchema | TagNotAssigned |


  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#75.b: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path                          | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.MatchFullFalsegreaterthan05 | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig               | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                               | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                               | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                               | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                               | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig              | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                               | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                               | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                               | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                               | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |

  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#75.b: Verify Multiple Tag is not set for the column when Whole word Match:true and Tag is set when reran with Whole word Match:false when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the exact data in column in Postgress table.
  (Ex: 0.6 - 6 or more rows should have matcning column values - dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename                         | Column   | Tags                                                               | Query                 | Action      |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | comments | PostgressTag1,PostgreSQL,Postgress_BA,Fullmatch PII,Fullmatch PII1 | ColumnQuerywithSchema | TagAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#75.b_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | SingleItemDelete | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/PostgreSQLDBCataloger/PostgreCataloger%     | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%    | Analysis |       |       |


    #####################################################################################################################################

  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#76.a: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path                        | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.MatchFullTruelesserthan05 | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig             | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                             | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                             | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                             | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                             | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig            | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                             | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                             | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                             | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                             | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |


  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#76.a: Verify Multiple Tag is not set for the column when Whole word Match:true and Tag is set when reran with Whole word Match:false when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the exact data in column in redshift table.
  (Ex: 0.2 - 2 or more rows should have matcning column values - namePattern,typePattern,dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename                        | Column   | Tags                         | Query                 | Action         |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiolesserthan05MatchFullTrue | comments | Fullmatch PII,Fullmatch PII1 | ColumnQuerywithSchema | TagNotAssigned |


  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#76.b: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path                         | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.MatchFullFalselesserthan05 | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig              | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                              | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                              | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                              | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                              | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig             | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                              | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                              | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                              | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                              | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |

  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#76.b: Verify Multiple Tag is not set for the column when Whole word Match:true and Tag is set when reran with Whole word Match:false when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the exact data in column in postgress table.
  (Ex: 0.2 - 2 or more rows should have matcning column values - namePattern,typePattern,dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename                         | Column   | Tags                                                               | Query                 | Action      |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | comments | PostgressTag1,PostgreSQL,Postgress_BA,Fullmatch PII,Fullmatch PII1 | ColumnQuerywithSchema | TagAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#76.b_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | SingleItemDelete | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/PostgreSQLDBCataloger/PostgreCataloger%     | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%    | Analysis |       |       |

#######################################################################################################################################

  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#77: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path                                    | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.dataratiomatchemptyfalsegreaterthan05 | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig                         | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                                         | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                                         | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                                         | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                                         | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig                        | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                                         | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                                         | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                                         | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                                         | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |


    # 7089401 #
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#77a: Verify Tag is not set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in postgress table.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is False -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename                              | Column    | Tags                                                | Query                 | Action         |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrueView | email     | PostgressTag1,Postgress_BA,PostgreSQL,Email Address | ColumnQuerywithSchema | TagAssigned    |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrueView | ipaddress | PostgressTag1,Postgress_BA,PostgreSQL,IP Address    | ColumnQuerywithSchema | TagAssigned    |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrueView | ssn       | SSN                                                 | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrueView | full_name | Full Name                                           | ColumnQuerywithSchema | TagNotAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrueView | gender    | Gender                                              | ColumnQuerywithSchema | TagNotAssigned |


  @MLP-20518 @sanity @positive @regression @postgress @PIITag
  Scenario Outline:SC#77.b: Create Postgress Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | bodyFile                                                                    | path                                   | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                  | payloads/ida/postgressPayloads/policyEngine/Tags.json                       | $.dataratiomatchemptytruegreaterthan05 | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               | payloads/ida/postgressPayloads/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogConfig                        | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreCataloger                               |                                                                             |                                        | 200           | PostgreCataloger |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger   |                                                                             |                                        | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreCataloger  |                                                                             |                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 | payloads/ida/postgressPayloads/PluginConfiguration/TagsAnalyzerConfig.json  | $.AnalyzerConfig                       | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/PostgreSQLDBAnalyzer/PostgreAnalyzer                                 |                                                                             |                                        | 200           | PostgreAnalyzer  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer  |                                                                             |                                        | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer |                                                                             |                                        | 200           | IDLE             | $.[?(@.configurationName=='PostgreAnalyzer')].status  |


    # 7089401 #
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#77.b: Verify Tag is set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in postgress view.
  (Ex: 0.6 - 6 or more rows should have matching column values including empty) - Match Empty is False -10 rows , 3 rows empty, 4 rows match,3 rows does not match.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                           | ServiceName | DatabaseName | SchemaName | TableName/Filename                              | Column    | Tags                                                | Query                 | Action      |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrueView | email     | PostgressTag1,Postgress_BA,PostgreSQL,Email Address | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrueView | ipaddress | PostgressTag1,Postgress_BA,PostgreSQL,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrueView | ssn       | PostgressTag1,Postgress_BA,PostgreSQL,SSN           | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrueView | full_name | PostgressTag1,Postgress_BA,PostgreSQL,Full Name     | ColumnQuerywithSchema | TagAssigned |
      | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | PostgreSQL  | postgres     | tagschema  | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrueView | gender    | PostgressTag1,Postgress_BA,PostgreSQL,Gender        | ColumnQuerywithSchema | TagAssigned |


  @sanity @positive @regression @PIITag
  Scenario:SC#77.b_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | SingleItemDelete | Default | ddpostgresql.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/PostgreSQLDBCataloger/PostgreCataloger%     | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/PostgreSQLDBAnalyzer/PostgreAnalyzer%    | Analysis |       |       |